import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/core/utils/ui/loading_dialog.dart';
import 'package:blog_app/core/utils/ui/snack_bar.dart';
import 'package:blog_app/model/response_model/posts/post_model.dart';
import 'package:blog_app/service/blog_posts_service/blog_posts_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPostViewModelProvider = ChangeNotifierProvider((ref) => CreatePostViewModel());

class CreatePostViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  ViewState viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> fetchCreatePostService() async {
    _setViewState(ViewState.loading());
    final closeDialog = showLoadingScreen(context: scaffoldMessengerKey.currentContext!);

    final response = await PostsServices().createPost(
      PostModel(
        title: titleController.text,
        body: bodyController.text,
      ),
    );

    if (response is DataSuccess) {
      closeDialog();

      Navigator.pop(scaffoldMessengerKey.currentContext!);
      ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!).showSnackBar(
        snackBar(
          "Post Created",
          scaffoldMessengerKey.currentContext!,
        ),
      );
      _setViewState(ViewState.complete(response.data));

      titleController.clear();
      bodyController.clear();
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
