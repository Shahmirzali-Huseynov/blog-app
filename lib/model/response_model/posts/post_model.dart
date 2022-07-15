import 'package:blog_app/core/model/base_model.dart';

class PostModel extends BaseModel {
  PostModel({
    this.title,
    this.body,
    this.id,
  });

  String? title;
  String? body;
  int? id;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        title: json["title"],
        body: json["body"],
        id: json["id"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "id": id,
      };

  @override
  PostModel fromJson(Map<String, dynamic> json) {
    return PostModel.fromJson(json);
  }
}
