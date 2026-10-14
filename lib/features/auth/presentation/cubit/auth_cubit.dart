import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitialState());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await loginUseCase(email: email, password: password);
    result.fold(
      (error) => emit(AuthErrorState(error)),
      (user) => emit(AuthAuthenticatedState(user)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (error) => emit(AuthErrorState(error)),
      (user) => emit(AuthRegisteredState(user)),
    );
  }

  void reset() => emit(AuthInitialState());
}
