class UserEntity {
  final int id;
  final String email;
  final String name;
  final String role;
  final String avatar;
  final String accessToken;
  final String refreshToken;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.avatar,
    required this.accessToken,
    required this.refreshToken,
  });
}
