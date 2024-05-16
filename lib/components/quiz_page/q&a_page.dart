import 'package:flutter/material.dart';
import 'package:quiz_app/components/quiz_page/finish.dart';

class QuestionAnswerPage extends StatelessWidget {
  const QuestionAnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Flutter'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: LinearProgressIndicator(
                // value: 05,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                backgroundColor: Colors.purpleAccent,
                // color: Colors.orange,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff041E3C),
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 327,
                  height: 231,
                  child: const Text(
                    'How do Flutter Identify\nlocation of widget?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Positioned(
                  top: 05,
                  left: 155,
                  right: 154,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffffb184),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12)),
                    width: 69,
                    height: 60,
                    child: const Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 34),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'BuildContext',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    side: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Finish()));
                },
                child: const Text(
                  'MediaQuery',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffff9051),
                    side: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'RenderBox',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    side: BorderSide(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
