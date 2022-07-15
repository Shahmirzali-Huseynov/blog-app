import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/core/utils/ui/loading_dialog.dart';
import 'package:blog_app/core/utils/ui/snack_bar.dart';
import 'package:blog_app/model/response_model/posts/post_model.dart';
import 'package:blog_app/service/blog_posts_service/blog_posts_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updatePostViewModelProvider = ChangeNotifierProvider((ref) => UpdatePostViewModel());

class UpdatePostViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  ViewState viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> fetchUpdatePostService(PostModel requestModel, int id) async {
    _setViewState(ViewState.loading());
    final closeDialog = showLoadingScreen(context: scaffoldMessengerKey.currentContext!);

    final response = await PostsServices().updatePost(
      requestModel,
      id,
    );

    if (response is DataSuccess) {
      closeDialog();

      Navigator.pop(scaffoldMessengerKey.currentContext!);
      ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!).showSnackBar(
        snackBar(
          "Post Updated",
          scaffoldMessengerKey.currentContext!,
        ),
      );
      _setViewState(ViewState.complete(response.data));
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
