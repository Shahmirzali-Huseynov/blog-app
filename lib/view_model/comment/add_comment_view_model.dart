import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/core/utils/ui/loading_dialog.dart';
import 'package:blog_app/model/response_model/comment/comment_model.dart';
import 'package:blog_app/service/comment_service/comment_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCommentViewModelProvider = ChangeNotifierProvider((ref) => AddToCommentViewModel());

class AddToCommentViewModel extends ChangeNotifier {
  final TextEditingController bodyController = TextEditingController();

  ViewState viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> fetchAddCommentsService(int postId, BuildContext context) async {
    _setViewState(ViewState.loading());
    final closeDialog = showLoadingScreen(context: context);

    final response = await CommentsServices().addCommentToPost(
      CommentModel(
        postId: postId,
        body: bodyController.text,
      ),
    );

    if (response is DataSuccess) {
      closeDialog();

      _setViewState(ViewState.complete(response.data));

      bodyController.clear();
    }
    if (response is DataFailed) {
      closeDialog();

      if (kDebugMode) {
        print(response.error);
      }
      _setViewState(ViewState.error(response.error.toString()));
    }
  }
}
