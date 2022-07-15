import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/model/response_model/posts/post_detial_model.dart';
import 'package:blog_app/service/blog_posts_service/blog_posts_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailViewModelProvider = ChangeNotifierProvider((ref) => PostDetailViewModel());

class PostDetailViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  ViewState<PostDetailModel> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<PostDetailModel> viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> fetchPostService(int id) async {
    _setViewState(ViewState.loading());

    final response = await PostsServices().getPost(id);
    if (response is DataSuccess) {
      _setViewState(ViewState.complete(response.data!));
      titleController.text = response.data!.title!;
      bodyController.text = response.data!.body!;
    }
    if (response is DataFailed) {
      if (kDebugMode) {
        print(response.error);
      }
      _setViewState(ViewState.error(response.error.toString()));
    }
  }
}
