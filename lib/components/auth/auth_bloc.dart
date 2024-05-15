import 'package:flutter_bloc/flutter_bloc.dart';

//events
abstract class AuthEvent {}

class OnAuth extends AuthEvent {}

class OnGoogleAuth extends AuthEvent {}

class OnAuthMethodChanged extends AuthEvent {
  final bool isSigin;
  OnAuthMethodChanged({this.isSigin = false});
}

class OnEmailAuth extends AuthEvent {}

//states
abstract class AuthState {}

class LoadAuth extends AuthState {
  final bool isSigin;
  LoadAuth({this.isSigin = false});
}

class AuthLoading extends AuthState {}

class AuthLoadingSuccess extends AuthState {}

class AuthError extends AuthState {}

class EmailNavigate extends AuthState {}

//bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    on<OnAuth>((event, emit) {
      emit(LoadAuth(isSigin: true));
    });

    on<OnAuthMethodChanged>((event, emit) {
      final method = event.isSigin;
      emit(LoadAuth(isSigin: method));
    });

    on<OnEmailAuth>((event, emit) {
      print('email sign in clicked');
      emit(EmailNavigate());
    });
  }
}
