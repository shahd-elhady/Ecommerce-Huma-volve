import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({int offset = 0, int limit = 10});
  Future<ProductModel> fetchProductById(int id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts({
    int offset = 0,
    int limit = 10,
  }) async {
    final response = await dio.get(
      'products',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .whereType<Map<String, dynamic>>()
          .map(ProductModel.fromJson)
          .toList();
    }
    throw Exception('فشل جلب المنتجات');
  }

  @override
  Future<ProductModel> fetchProductById(int id) async {
    final response = await dio.get('products/$id');
    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception('فشل جلب تفاصيل المنتج');
  }
}
