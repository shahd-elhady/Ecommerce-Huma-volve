import 'package:dio/dio.dart';

import '../models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get('products');
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .whereType<Map<String, dynamic>>()
          .map(ProductModel.fromJson)
          .toList();
    }
    throw Exception('فشل جلب المنتجات');
  }
}
