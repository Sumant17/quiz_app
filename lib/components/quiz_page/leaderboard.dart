import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('LeaderBoard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/trophy.jpg',
              width: 181,
              height: 169,
            ),
            const SizedBox(
              height: 50,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff041E3C),
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(08),
                  ),
                  width: 326,
                  height: 67,
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffFF9051),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      width: 38,
                      height: 38,
                      child: const Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                    title: const Text(
                      'Sumant',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      '100pts',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff041E3C),
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(08),
                  ),
                  width: 326,
                  height: 67,
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffFF9051),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      width: 38,
                      height: 38,
                      child: const Text(
                        '2',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                    title: const Text(
                      'Sumant',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      '80pts',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff041E3C),
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(08),
                  ),
                  width: 326,
                  height: 67,
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffFF9051),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      width: 38,
                      height: 38,
                      child: const Text(
                        '3',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                    title: const Text(
                      'Sumant',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      '50pts',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
