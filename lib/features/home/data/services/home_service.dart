import 'package:dio/dio.dart';
import '../models/product_model.dart';

class HomeService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/'));

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get('products');
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print('Fetch Products Error: $e');
      return [];
    }
  }
}