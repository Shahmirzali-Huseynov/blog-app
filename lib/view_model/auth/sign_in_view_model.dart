import 'package:blog_app/core/cache/locale_manager.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/core/utils/enums/preferences_keys_enum.dart';
import 'package:blog_app/core/utils/ui/loading_dialog.dart';
import 'package:blog_app/core/utils/ui/snack_bar.dart';
import 'package:blog_app/model/request_model/auth/auth_req_model.dart';
import 'package:blog_app/service/auth_service/auth_services.dart';
import 'package:blog_app/view/posts/posts_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInViewModelProvider = ChangeNotifierProvider((ref) => SignInViewModel());

class SignInViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ViewState viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> fetchSignInService() async {
    _setViewState(ViewState.loading());
    final closeDialog = showLoadingScreen(context: scaffoldMessengerKey.currentContext!);

    final response = await AuthServices().signIn(AuthRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text,
    ));

    if (response is DataSuccess) {
      closeDialog();
      await LocaleManager.instance.setStringValue(PreferencesKeys.TOKEN, response.data!.token!);
      Navigator.pushReplacement(
          scaffoldMessengerKey.currentContext!, MaterialPageRoute(builder: (context) => const PostsPage()));

      _setViewState(ViewState.complete(response.data));
      emailController.clear();
      passwordController.clear();
    }
    if (response is DataFailed) {
      closeDialog();
      scaffoldMessengerKey.currentState!.showSnackBar(
        snackBar(
          "Error ${response.error}",
          scaffoldMessengerKey.currentContext!,
        ),
      );
      if (kDebugMode) {
        print(response.error);
      }
      _setViewState(ViewState.error(response.error.toString()));
    }
  }
}
