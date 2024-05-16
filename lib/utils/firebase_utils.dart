import 'package:cloud_firestore/cloud_firestore.dart';

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
  // List<QuizData>
  // static Future<List<QuizData>> readData() async {}
}
