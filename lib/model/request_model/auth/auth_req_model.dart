class AuthRequestModel {
  AuthRequestModel({
    required this.email,
    required this.password,
  });

  String password;
  String email;

  factory AuthRequestModel.fromJson(Map<String, dynamic> json) => AuthRequestModel(
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
      };
}
