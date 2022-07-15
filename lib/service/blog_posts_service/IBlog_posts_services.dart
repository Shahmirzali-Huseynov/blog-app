// ignore_for_file: file_names

import 'dart:io';

import 'package:blog_app/core/model/status_model.dart';
import 'package:blog_app/core/service/dio/network_dio_manager.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/utils/constants/api_constants.dart';
import 'package:blog_app/model/response_model/posts/post_detial_model.dart';
import 'package:blog_app/model/response_model/posts/post_model.dart';
import 'package:dio/dio.dart';

mixin IPostsServices {
  final Dio dio = NetworkDioManager()
      .addBaseUrl(ApiUrlPathConstants.mainUrl.path)
      .addLoggerRequest()
      .addTimeout(2000)
      .addStatusModels(StatusModels(minumumValue: HttpStatus.ok, maximumValue: HttpStatus.found))
      .build();

  Future<DataState<List<PostModel>>> getAllPosts();
  Future<DataState<PostDetailModel>> getPost(int id);
  Future<DataState<PostModel>> createPost(PostModel requestModel);
  Future<DataState<PostModel>> updatePost(PostModel requestModel, int id);
  Future<DataState<void>> deletePost(int id);
}
