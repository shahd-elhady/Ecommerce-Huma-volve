import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/home_service.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitialState());

  void getProducts() async {
    emit(HomeLoadingState());
    try {
      final products = await homeService.fetchProducts();
      emit(HomeSuccessState(products));
    } catch (e) {
      emit(HomeErrorState('فشل جلب المنتجات'));
    }
  }
}