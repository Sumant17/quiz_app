import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

//SIGN-UP
//events
abstract class EmailAuthEvent {}

class OnAuthEmailSignUp extends EmailAuthEvent {}

class OnEmailAuthClickedSignUp extends EmailAuthEvent {
  final bool isSignIn;
  final TextEditingController emailAddress;
  final TextEditingController password;

  OnEmailAuthClickedSignUp(
      {required this.isSignIn,
      required this.emailAddress,
      required this.password});
}

//state

abstract class EmailAuthState {}

class LoadEmailAuthSignUp extends EmailAuthState {
  final bool isSignIn;

  LoadEmailAuthSignUp({this.isSignIn = false});
}

class LoadingEmailAuthSignUp extends EmailAuthState {}

class EmailAuthSuccessSignUp extends EmailAuthState {}

class EmailAuthErrSignUp extends EmailAuthState {}

//bloc
class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  EmailAuthBloc() : super(LoadingEmailAuthSignUp()) {
    on<OnAuthEmailSignUp>((event, emit) {
      emit(LoadEmailAuthSignUp(isSignIn: true));
    });

    on<OnEmailAuthClickedSignUp>((event, emit) async {
      emit(LoadingEmailAuthSignUp());
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.emailAddress.text, password: event.password.text);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isUserLoggedIn', true);

        emit(EmailAuthSuccessSignUp());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    });
  }
}

//SIGN-IN
//events
abstract class SignInEvent {}

class OnSignIn extends SignInEvent {}

class OnSignInClicked extends SignInEvent {
  final bool isSignIn;
  final TextEditingController email;
  final TextEditingController passowrd;

  OnSignInClicked(
      {required this.isSignIn, required this.email, required this.passowrd});
}

//states
abstract class SignInState {}

class LoadSignIn extends SignInState {
  final bool isSignIn;

  LoadSignIn({this.isSignIn = false});
}

class LoadingSignIn extends SignInState {}

class LoadingSignInSuccess extends SignInState {}

class SignInErr extends SignInState {}

//bloc

class SignInAuthBloc extends Bloc<SignInEvent, SignInState> {
  SignInAuthBloc() : super(LoadingSignIn()) {
    on<OnSignIn>((event, emit) {
      emit(LoadSignIn(isSignIn: true));
    });

    on<OnSignInClicked>((event, emit) async {
      emit(LoadingSignIn());
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email.text, password: event.passowrd.text);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isUserLoggedIn', true);

        emit(LoadingSignInSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    });
  }
}
