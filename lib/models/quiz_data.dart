// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuizData {
  final String question;
  final String correctAnswer;
  final List<String> answers;

  QuizData({
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  // factory QuizData.fromJson(Map<String,dynamic> json) => QuizData(
  //   question: json[], correctAnswer: correctAnswer, answers: answers)
}
