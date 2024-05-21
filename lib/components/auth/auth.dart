import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/components/email_auth/email.dart';
import 'package:quiz_app/components/email_auth/email_signup.dart';
import 'package:quiz_app/components/quiz_page/landing_page.dart';
import 'package:quiz_app/utils/firebase_utils.dart';

class Auth extends StatelessWidget {
  late AuthBloc authBloc;
  Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(OnAuth()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoadAuth) {
            initializeFirebaseMessaging(context);
          }
          if (state is EmailNavigate) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Email()));
          } else if (state is EmailNavigateSignUp) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EmailSignUp()));
          }

          if (state is SkipAuth) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LandingPage()));
          }
        },
        builder: (context, state) {
          //final data = [];
          // final data = [
          //   {"id": 1, "name": "Alice Johnson", "point_score": 9.2},
          //   {"id": 2, "name": "Bob Smith", "point_score": 9.5},
          //   {"id": 3, "name": "Charlie Brown", "point_score": 9.0},
          //   {"id": 4, "name": "David Wilson", "point_score": 8.9}
          // ];
          authBloc = BlocProvider.of<AuthBloc>(context);
          if (state is LoadAuth) {
            final isSignIn = state.isSigin;
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            isSignIn
                                ? authBloc.add(OnEmailAuthSignIn())
                                : authBloc.add(OnEmailAuthSignUp());
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          ),
                          child: Text(
                            isSignIn ? 'Sign in with Email' : 'Sign Up',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(isSignIn
                              ? 'Dont have an account'
                              : 'Do you have an account'),
                          TextButton(
                              onPressed: () {
                                authBloc.add(
                                    OnAuthMethodChanged(isSigin: !isSignIn));
                              },
                              child: Text(
                                isSignIn
                                    ? 'Click here to sign up'
                                    : 'Click here to sign in',
                                style: const TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                      const Center(
                        child: Text('OR'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            // await FirebaseUtils.writeleaderboard(data);
                            // authBloc.add(OnAuthClicked);
                            // final data = await FirebaseUtils.readData();
                            // print(data[0].answers);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          ),
                          child: const Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                // Image.asset(''),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Continue with Google',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
  }

  void initializeFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        _onNotificationMessage(context, value);
      }
    });

    //foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onNotificationMessage(context, message);
    });

    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _onNotificationMessage(context, message);
    });
  }

  void _onNotificationMessage(BuildContext context, RemoteMessage value) {
    print(value.notification!.title);
    print(value.notification!.body);

    print(value.data);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LandingPage()));
  }
}
