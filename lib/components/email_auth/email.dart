import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/components/quiz_page/landing_page.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
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
      body: Padding(
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LandingPage()));
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
      ),
    );
  }
}
