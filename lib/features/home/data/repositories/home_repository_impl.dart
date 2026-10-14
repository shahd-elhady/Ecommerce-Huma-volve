import 'package:dartz/dartz.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<ProductEntity>>> getProducts() async {
    try {
      final products = await remoteDataSource.fetchProducts();
      return Right(products);
    } catch (e) {
      return Left(ApiClient.mapError(e));
    }
  }
}
