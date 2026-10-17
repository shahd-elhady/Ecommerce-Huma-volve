import 'package:dartz/dartz.dart';

import '../entities/product_entity.dart';
import '../repositories/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<String, List<ProductEntity>>> call({
    int offset = 0,
    int limit = 10,
  }) {
    return repository.getProducts(offset: offset, limit: limit);
  }
}
