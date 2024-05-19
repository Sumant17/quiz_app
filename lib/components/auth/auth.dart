import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/components/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/components/email_auth/email.dart';
import 'package:quiz_app/components/email_auth/email_signup.dart';
import 'package:quiz_app/components/quiz_page/landing_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Auth extends StatefulWidget {
  Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late AuthBloc authBloc;
  late int _secondsRemaining = 60;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState

    // start timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(OnAuth()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoadAuth) {
            initialiseFirebaseMessaging(context);
          }
          if (state is EmailNavigate) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Email()));
          } else if (state is EmailNavigateSignUp) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EmailSignUp()));
          }
        },
        builder: (context, state) {
          authBloc = BlocProvider.of<AuthBloc>(context);
          if (state is LoadAuth) {
            final isSignIn = state.isSigin;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Quiz App'),
                actions: [
                  Row(
                    children: [
                      Icon(Icons.timer),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('$_secondsRemaining'),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
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
                          onPressed: () {
                            // authBloc.add(OnAuthClicked);
                            // razorpay
                            Razorpay razorpay = Razorpay();
                            var options = {
                              'key': 'rzp_test_dcpEg18EO9ge1q',
                              'amount': 20000,
                              'name': 'ABC Corp.',
                              'description': 'Fine T-Shirt',
                              'retry': {'enabled': true, 'max_count': 1},
                              'send_sms_hash': true,
                              'external': {
                                'wallets': ['paytm']
                              }
                            };
                            // _timer.cancel();

                            razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                handlePaymentErrorResponse);
                            razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                handlePaymentSuccessResponse);
                            razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                handleExternalWalletSelected);

                            razorpay.open(options);
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

  void initialiseFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // termited
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        _onNotificationMessage(context, value);
      }
    });
    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onNotificationMessage(context, message);
    });

    //background
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

  handlePaymentErrorResponse() {
    print("Payment error");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.data.toString());
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  handleExternalWalletSelected() {}

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
