class UserModel {
  final int id;
  final String email;
  final String name;
  final String role;
  final String avatar;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.avatar,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}