import 'package:dartz/dartz.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<ProductEntity>>> getProducts({
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final products = await remoteDataSource.fetchProducts(
        offset: offset,
        limit: limit,
      );
      return Right(products);
    } catch (e) {
      return Left(ApiClient.mapError(e));
    }
  }

  @override
  Future<Either<String, ProductEntity>> getProductById(int id) async {
    try {
      final product = await remoteDataSource.fetchProductById(id);
      return Right(product);
    } catch (e) {
      return Left(ApiClient.mapError(e));
    }
  }
}
