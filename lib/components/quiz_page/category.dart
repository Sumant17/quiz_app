import 'package:flutter/material.dart';
import 'package:quiz_app/components/quiz_page/q&a/q&a_page.dart';

class Catogories extends StatelessWidget {
  const Catogories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Center(
          child: Text(
            'Choose Category',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuestionAnswerPage()));
                // print('hello');
              },
              child: Container(
                padding: const EdgeInsets.all(40),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff041E3C),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 244,
                height: 238,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/flutter_logo.png',
                        width: 89,
                        height: 95,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Flutter',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // print('React');
              },
              child: Container(
                padding: const EdgeInsets.all(40),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff041E3C),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 244,
                height: 238,
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/react_logo.png',
                      width: 106,
                      height: 92,
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'React',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
