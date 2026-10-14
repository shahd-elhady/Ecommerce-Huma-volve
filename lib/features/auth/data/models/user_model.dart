import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.role,
    required super.avatar,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    String accessToken = '',
    String refreshToken = '',
  }) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
      accessToken: json['access_token'] ?? accessToken,
      refreshToken: json['refresh_token'] ?? refreshToken,
    );
  }

  factory UserModel.fromTokens({
    required String accessToken,
    required String refreshToken,
  }) {
    return UserModel(
      id: 0,
      email: '',
      name: '',
      role: '',
      avatar: '',
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
