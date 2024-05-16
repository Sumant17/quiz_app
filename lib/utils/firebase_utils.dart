import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz_data.dart';

class FirebaseUtils {
  static const collectionName = "quizdata";

  // write to collection

  static Future<void> writeData(List<Map<String, dynamic>> data) async {
    try {
      final quizData = FirebaseFirestore.instance.collection(collectionName);

      data.forEach((element) async {
        await quizData
            .add(element)
            .then((v) => print("Data added"))
            .catchError((error) => print("Failed to add user: $error"));
      });

      /* await quizData
          .add(data)
          .then((v) => print("Data added"))
          .catchError((error) => print("Failed to add user: $error")); */

      //  DatabaseReference ref = FirebaseDatabase.instance.ref();
      // await FirebaseFirestore.instance.collection(collectionName).add(data);
    } catch (e) {
      print(e);
    }
  }

  // read from collection

  static Future<List<QuizData>> readData() async {
    List<QuizData> quiz = [];
    await FirebaseFirestore.instance
        .collection(collectionName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final data = QuizData.fromDocument(doc);
        // print(doc["question"]);
        /* final data = JsonEncoder(
          (object) => doc.data(),
        );
        // doc.data();
        print(data.toString()); */
        // final quizData = QuizData.fromJson(data);
        quiz.add(data);
      });
    });
    return quiz;
  }
}
