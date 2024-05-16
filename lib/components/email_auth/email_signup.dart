import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/components/auth/auth_bloc.dart';
import 'package:quiz_app/components/email_auth/email_bloc.dart';
import 'package:quiz_app/components/quiz_page/landing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailSignUp extends StatelessWidget {
  late EmailAuthBloc emailAuthBloc;
  EmailSignUp({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => EmailAuthBloc()..add(OnAuthEmailSignUp()),
        child: BlocConsumer<EmailAuthBloc, EmailAuthState>(
          listener: (context, state) {
            if (state is EmailAuthSuccessSignUp) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LandingPage()));

              print('Account created Successfully');
            }
          },
          builder: (context, state) {
            emailAuthBloc = BlocProvider.of<EmailAuthBloc>(context);
            if (state is LoadEmailAuthSignUp) {
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
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    ),
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
                          emailAuthBloc.add(OnEmailAuthClickedSignUp(
                              isSignIn: isSignIn,
                              emailAddress: emailController,
                              password: passwordController));
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
                          'Sign Up',
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
