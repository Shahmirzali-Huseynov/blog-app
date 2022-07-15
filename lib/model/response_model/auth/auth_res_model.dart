import 'package:blog_app/core/model/base_model.dart';

class AuthResponseModel extends BaseModel {
  AuthResponseModel({
    this.token,
    this.email,
  });

  String? token;
  String? email;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
        token: json["idToken"],
        email: json["email"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idToken": token,
        "email": email,
      };

  @override
  AuthResponseModel fromJson(Map<String, dynamic> json) {
    return AuthResponseModel.fromJson(json);
  }
}
