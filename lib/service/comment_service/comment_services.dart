import 'package:blog_app/core/service/dio/request_services.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/utils/constants/api_constants.dart';
import 'package:blog_app/model/response_model/comment/comment_model.dart';
import 'package:blog_app/service/comment_service/IComment_services.dart';

class CommentsServices extends RequestServices with ICommentsServices {
  @override
  Future<DataState<CommentModel>> addCommentToPost(CommentModel requestModel) async {
    return await postRequest<CommentModel>(
      dio: dio,
      path: ApiUrlPathConstants.comment.path,
      parserModel: CommentModel(),
      data: requestModel.toJson(),
    );
  }
}
