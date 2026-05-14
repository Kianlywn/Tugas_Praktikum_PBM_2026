import 'user_model.dart';

class AuthResponseModel {
  final bool success;
  final String message;
  final String token;
  final UserModel user;

  AuthResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['data']['token'],
      user: UserModel.fromJson(json['data']['user']),
    );
  }
}