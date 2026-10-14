import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;

  HomeCubit(this.getProductsUseCase) : super(HomeInitialState());

  Future<void> getProducts() async {
    emit(HomeLoadingState());
    final result = await getProductsUseCase();
    result.fold(
      (error) => emit(HomeErrorState(error)),
      (products) => emit(HomeSuccessState(products)),
    );
  }
}
