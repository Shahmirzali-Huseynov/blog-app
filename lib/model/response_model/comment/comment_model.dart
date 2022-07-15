import 'package:blog_app/core/model/base_model.dart';

class CommentModel extends BaseModel {
  CommentModel({
    this.postId,
    this.body,
    this.id,
  });

  int? postId;
  String? body;
  int? id;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        body: json["body"],
        id: json["id"],
      );
  @override
  Map<String, dynamic> toJson() => {
        "postId": postId,
        "body": body,
        "id": id,
      };

  @override
  CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel.fromJson(json);
  }
}
