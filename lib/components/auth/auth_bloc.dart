import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//events
abstract class AuthEvent {}

class OnAuth extends AuthEvent {}

class OnGoogleAuth extends AuthEvent {}

class OnAuthMethodChanged extends AuthEvent {
  final bool isSigin;
  OnAuthMethodChanged({this.isSigin = false});
}

class OnEmailAuthSignIn extends AuthEvent {}

class OnEmailAuthSignUp extends AuthEvent {}

//states
abstract class AuthState {}

class LoadAuth extends AuthState {
  final bool isSigin;

  LoadAuth({this.isSigin = false});
}

class SkipAuth extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoadingSuccess extends AuthState {}

class AuthError extends AuthState {}

class EmailNavigate extends AuthState {}

class EmailNavigateSignUp extends AuthState {}

//bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoading()) {
    on<OnAuth>((event, emit) async {
      final token = await FirebaseMessaging.instance.getToken();
      print(token);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
      if (isUserLoggedIn) {
        emit(SkipAuth());
        return;
      }
      emit(LoadAuth(isSigin: true));
    });

    on<OnAuthMethodChanged>((event, emit) {
      final method = event.isSigin;
      emit(LoadAuth(isSigin: method));
    });

    on<OnEmailAuthSignIn>((event, emit) {
      // print('email sign in clicked');
      emit(EmailNavigate());
    });

    on<OnEmailAuthSignUp>((event, emit) {
      emit(EmailNavigateSignUp());
    });
  }
}
