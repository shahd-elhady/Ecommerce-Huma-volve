import 'package:dio/dio.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      'auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('فشل تسجيل الدخول');
    }

    final data = Map<String, dynamic>.from(response.data as Map);
    final accessToken = data['access_token']?.toString() ?? '';
    final refreshToken = data['refresh_token']?.toString() ?? '';

    if (accessToken.isEmpty) {
      throw Exception('لم يتم استلام رمز الدخول');
    }

    try {
      final profile = await dio.get(
        'auth/profile',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (profile.data is Map<String, dynamic>) {
        return UserModel.fromJson(
          profile.data as Map<String, dynamic>,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }
    } catch (_) {
      // Login still succeeds if profile fetch fails.
    }

    return UserModel.fromTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      'users/',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'avatar': 'https://picsum.photos/800',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('فشل إنشاء الحساب');
    }

    return UserModel.fromJson(Map<String, dynamic>.from(response.data as Map));
  }
}
