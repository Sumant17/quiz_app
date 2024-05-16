import 'package:flutter/material.dart';

import 'package:quiz_app/components/quiz_page/category.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 400,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff041E3C),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 327,
                height: 319,
                child: Column(
                  children: [
                    const Text(
                      'Welcome to Quizzy',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'A fun app to test your\nskills on various Tech!',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Catogories()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          elevation: 3,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Positioned(
            //   top: 550,
            //   left: 0,
            //   right: 0,

            // ),
            Positioned(
              top: 120,
              left: (MediaQuery.of(context).size.width - 80) / 2,
              child: const Row(
                children: [
                  Text(
                    '?',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '?',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
