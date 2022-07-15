import 'package:blog_app/core/service/dio/request_services.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/utils/constants/api_constants.dart';
import 'package:blog_app/core/utils/models/empyt_model.dart';
import 'package:blog_app/model/response_model/posts/post_detial_model.dart';
import 'package:blog_app/model/response_model/posts/post_model.dart';
import 'package:blog_app/service/blog_posts_service/IBlog_posts_services.dart';

class PostsServices extends RequestServices with IPostsServices {
  @override
  Future<DataState<PostModel>> createPost(PostModel requestModel) async {
    return await postRequest<PostModel>(
      dio: dio,
      path: ApiUrlPathConstants.post.path,
      parserModel: PostModel(),
      data: requestModel.toJson(),
    );
  }

  @override
  Future<DataState<void>> deletePost(int id) async {
    return await deleteRequest<EmptyModel>(
      dio: dio,
      path: ApiUrlPathConstants.post.withId(id),
      parserModel: EmptyModel(),
    );
  }

  @override
  Future<DataState<List<PostModel>>> getAllPosts() async {
    return await getListRequest<PostModel>(
      dio: dio,
      path: ApiUrlPathConstants.post.path,
      parserModel: PostModel(),
    );
  }

  @override
  Future<DataState<PostDetailModel>> getPost(int id) async {
    return await getRequest<PostDetailModel>(
      dio: dio,
      path: ApiUrlPathConstants.post.withId(id),
      parserModel: PostDetailModel(),
      queryParameters: {'_embed': 'comments'},
    );
  }

  @override
  Future<DataState<PostModel>> updatePost(PostModel requestModel, int id) async {
    return await putRequest<PostModel>(
      dio: dio,
      path: ApiUrlPathConstants.post.withId(id),
      parserModel: PostModel(),
      data: requestModel.toJson(),
    );
  }
}
