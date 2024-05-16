// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizData {
  String question = '';
  String correctAnswer = '';
  List answers = [];

  QuizData({
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  QuizData.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    this.answers = map["answers"];
    this.correctAnswer = map["correctAnswer"];
    this.question = map["question"];
  }

  factory QuizData.fromJson(json) {
    print('hh $json');
    return QuizData(
        question: json['question'],
        correctAnswer: json['correctAnswer'],
        answers: json['answers']);
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        "correctAnswer": correctAnswer,
        "answers": answers
      };
}
