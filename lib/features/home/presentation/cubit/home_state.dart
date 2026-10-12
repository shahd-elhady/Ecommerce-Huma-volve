import '../../data/models/product_model.dart';
import '../../data/models/product_model.dart';
abstract class HomeState {}

class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeSuccessState extends HomeState {
  final List<ProductModel> products;
  HomeSuccessState(this.products);
}
class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState(this.errorMessage);
}