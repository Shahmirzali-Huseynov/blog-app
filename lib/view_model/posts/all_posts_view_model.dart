import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/service/state/view_state.dart';
import 'package:blog_app/model/response_model/posts/post_model.dart';
import 'package:blog_app/service/blog_posts_service/blog_posts_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allPostsViewModelProvider = ChangeNotifierProvider((ref) => AllPostsViewModel());

class AllPostsViewModel extends ChangeNotifier {
  ViewState<List<PostModel>> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<List<PostModel>> viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  Future<void> fetchAllPostsService() async {
    _setViewState(ViewState.loading());

    final response = await PostsServices().getAllPosts();

    if (response is DataSuccess) {
      _setViewState(ViewState.complete(response.data!));
    }
    if (response is DataFailed) {
      if (kDebugMode) {
        print(response.error);
      }
      _setViewState(ViewState.error(response.error.toString()));
    }
  }
}
