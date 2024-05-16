import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/components/email_auth/email_bloc.dart';
import 'package:quiz_app/components/quiz_page/landing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Email extends StatelessWidget {
  late SignInAuthBloc signInAuthBloc;
  Email({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => SignInAuthBloc()..add(OnSignIn()),
        child: BlocConsumer<SignInAuthBloc, SignInState>(
          listener: (context, state) {
            if (state is LoadingSignInSuccess) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LandingPage()));
            }
          },
          builder: (context, state) {
            signInAuthBloc = BlocProvider.of<SignInAuthBloc>(context);
            if (state is LoadSignIn) {
              final isSignIn = state.isSignIn;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          signInAuthBloc.add(OnSignInClicked(
                              isSignIn: isSignIn,
                              email: emailController,
                              passowrd: passwordController));
                          // signInAuthBloc.add(OnSignInClicked(
                          //     isSignIn: isSignIn,
                          //     email: emailController,
                          //     password: passwordController));
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
