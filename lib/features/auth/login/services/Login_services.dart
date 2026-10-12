import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/'));

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio.post('auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } catch (e) {
      print('Login Error: $e');
    }
    return null;
  }
}