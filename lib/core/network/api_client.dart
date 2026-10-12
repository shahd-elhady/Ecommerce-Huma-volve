// import 'dart:convert';
//
// class ApiClient {
//   Dio dio;
//   ApiClient():dio=Dio(baseOptions(base64Url:"https://api.escuelajs.co/api/v1/"))
//
//
//
//   baseOptions({required String base64Url}) {}}
// //https://api.escuelajs.co/api/v1/auth/login
import 'package:dio/dio.dart';
import '../../features/auth/sign_up/user_model.dart';
import '../../../features/auth/sign_up/user_model.dart';
class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/'));


  Future< UserModel?> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return  UserModel.fromJson(response.data);
      }
    } catch (e) {
      print('Login Error: $e');
    }
    return null;
  }


  Future<UserModel?> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('users/', data: {
        'name': name,
        'email': email,
        'password': password,
        'avatar': 'https://picsum.photos/800',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      print('Register Error: $e');
    }
    return null;
  }
}
