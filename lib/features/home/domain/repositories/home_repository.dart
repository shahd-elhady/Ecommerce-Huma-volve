import 'package:dartz/dartz.dart';

import '../entities/product_entity.dart';

abstract class HomeRepository {
  Future<Either<String, List<ProductEntity>>> getProducts();
}
