import 'package:blog_app/core/model/base_model.dart';
import 'package:blog_app/model/response_model/comment/comment_model.dart';

class PostDetailModel extends BaseModel {
  PostDetailModel({
    this.title,
    this.body,
    this.id,
    this.comments,
  });

  String? title;
  String? body;
  int? id;
  List<CommentModel>? comments;

  factory PostDetailModel.fromJson(Map<String, dynamic> json) => PostDetailModel(
        title: json["title"],
        body: json["body"],
        id: json["id"],
        comments: List<CommentModel>.from(json["comments"].map((x) => CommentModel.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "id": id,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };

  @override
  PostDetailModel fromJson(Map<String, dynamic> json) {
    return PostDetailModel.fromJson(json);
  }
}
