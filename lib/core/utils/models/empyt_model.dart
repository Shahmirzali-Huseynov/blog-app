import 'package:blog_app/core/model/base_model.dart';

class EmptyModel extends BaseModel<EmptyModel> {
  String? name;

  EmptyModel({
    this.name,
  });

  factory EmptyModel.fromJson(Map<String, dynamic> json) => EmptyModel(
        name: json["name"],
      );

  @override
  Map<String, dynamic>? toJson() => {
        "name": name,
      };

  @override
  EmptyModel fromJson(Map<String, dynamic> json) {
    return EmptyModel.fromJson(json);
  }
}
