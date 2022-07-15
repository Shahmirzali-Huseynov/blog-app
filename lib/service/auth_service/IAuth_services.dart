// ignore_for_file: file_names

import 'dart:io';

import 'package:blog_app/core/model/status_model.dart';
import 'package:blog_app/core/service/dio/network_dio_manager.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/utils/constants/api_constants.dart';
import 'package:blog_app/model/request_model/auth/auth_req_model.dart';
import 'package:blog_app/model/response_model/auth/auth_res_model.dart';
import 'package:dio/dio.dart';

mixin IAuthServices {
  final Dio dio = NetworkDioManager()
      .addBaseUrl(ApiUrlPathConstants.firebaseAuthMainUrl.path)
      .addLoggerRequest()
      .addTimeout(2000)
      .addStatusModels(StatusModels(minumumValue: HttpStatus.ok, maximumValue: HttpStatus.unauthorized))
      .build();

  Future<DataState<AuthResponseModel>> signUp(AuthRequestModel requestModel);
  Future<DataState<AuthResponseModel>> signIn(AuthRequestModel requestModel);
}
