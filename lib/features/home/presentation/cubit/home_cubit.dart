import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;

  static const int pageSize = 10;
  int _offset = 0;
  bool _isFetchingMore = false;

  HomeCubit(this.getProductsUseCase) : super(HomeInitialState());

  Future<void> getProducts({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(HomeLoadingState());
    }
    _offset = 0;

    final result = await getProductsUseCase(offset: 0, limit: pageSize);
    result.fold(
      (error) => emit(HomeErrorState(error)),
      (products) {
        _offset = products.length;
        emit(
          HomeSuccessState(
            products: products,
            hasReachedMax: products.length < pageSize,
          ),
        );
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (_isFetchingMore) return;

    final currentState = state;
    if (currentState is! HomeSuccessState) return;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;

    _isFetchingMore = true;
    emit(currentState.copyWith(isLoadingMore: true, paginationError: null));

    final result = await getProductsUseCase(offset: _offset, limit: pageSize);

    result.fold(
      (error) {
        emit(
          currentState.copyWith(
            isLoadingMore: false,
            paginationError: error,
          ),
        );
      },
      (newProducts) {
        if (newProducts.isEmpty) {
          emit(
            currentState.copyWith(
              isLoadingMore: false,
              hasReachedMax: true,
            ),
          );
        } else {
          _offset += newProducts.length;
          emit(
            currentState.copyWith(
              products: [...currentState.products, ...newProducts],
              isLoadingMore: false,
              hasReachedMax: newProducts.length < pageSize,
            ),
          );
        }
      },
    );

    _isFetchingMore = false;
  }
}
