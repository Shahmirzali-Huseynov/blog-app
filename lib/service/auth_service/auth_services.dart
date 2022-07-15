import 'package:blog_app/core/service/dio/request_services.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/utils/constants/api_constants.dart';
import 'package:blog_app/core/utils/constants/app_constants.dart';
import 'package:blog_app/model/request_model/auth/auth_req_model.dart';
import 'package:blog_app/model/response_model/auth/auth_res_model.dart';
import 'package:blog_app/service/auth_service/IAuth_services.dart';

class AuthServices extends RequestServices with IAuthServices {
  @override
  Future<DataState<AuthResponseModel>> signUp(AuthRequestModel requestModel) async {
    return await postRequest<AuthResponseModel>(
        dio: dio,
        path: ApiUrlPathConstants.signUp.path,
        parserModel: AuthResponseModel(),
        data: requestModel.toJson(),
        queryParameters: {'key': firebaseWebApiKey});
  }

  @override
  Future<DataState<AuthResponseModel>> signIn(AuthRequestModel requestModel) async {
    return await postRequest<AuthResponseModel>(
        dio: dio,
        path: ApiUrlPathConstants.signIn.path,
        parserModel: AuthResponseModel(),
        data: requestModel.toJson(),
        queryParameters: {'key': firebaseWebApiKey});
  }
}
