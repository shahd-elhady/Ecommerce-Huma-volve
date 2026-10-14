import 'package:dio/dio.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/usecases/get_products_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../network/api_client.dart';

class AppInjector {
  AppInjector._();

  static late final Dio dio;
  static late final AuthCubit Function() createAuthCubit;
  static late final HomeCubit Function() createHomeCubit;

  static void init() {
    dio = ApiClient.create();

    final authRepository = AuthRepositoryImpl(AuthRemoteDataSourceImpl(dio));
    final homeRepository = HomeRepositoryImpl(HomeRemoteDataSourceImpl(dio));

    createAuthCubit = () => AuthCubit(
          loginUseCase: LoginUseCase(authRepository),
          registerUseCase: RegisterUseCase(authRepository),
        );

    createHomeCubit = () => HomeCubit(GetProductsUseCase(homeRepository));
  }
}
