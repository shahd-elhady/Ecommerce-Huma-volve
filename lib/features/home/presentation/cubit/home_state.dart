import '../../domain/entities/product_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? paginationError;

  HomeSuccessState({
    required this.products,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.paginationError,
  });

  HomeSuccessState copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? paginationError,
  }) {
    return HomeSuccessState(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      paginationError: paginationError,
    );
  }
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}
