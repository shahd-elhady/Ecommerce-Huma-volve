import '../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final UserEntity user;

  AuthAuthenticatedState(this.user);
}

class AuthRegisteredState extends AuthState {
  final UserEntity user;

  AuthRegisteredState(this.user);
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState(this.errorMessage);
}
