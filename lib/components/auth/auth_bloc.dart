import 'package:flutter_bloc/flutter_bloc.dart';

//events
abstract class AuthEvent {}

class OnAuthClicked extends AuthEvent {}

//states
abstract class AuthState {}

class AuthLoading extends AuthState {}

class AuthLoadingSuccess extends AuthState {}

class AuthError extends AuthState {}

//bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {}
}
