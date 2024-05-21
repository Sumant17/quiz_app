//events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/models/quiz_data.dart';
import 'package:quiz_app/utils/firebase_utils.dart';

abstract class QAEvent {}

class OnQAPage extends QAEvent {}

class OnAnswersClicked extends QAEvent {
  final int selectedIndex;

  OnAnswersClicked(this.selectedIndex);
}

//state

abstract class QAState {}

class LoadPage extends QAState {
  final List<QuizData> data;
  final int index;
  final int selectedAnsIndex;
  final bool isCorrect;

  LoadPage(
      {required this.data,
      this.index = 0,
      this.selectedAnsIndex = 0,
      this.isCorrect = false});
}

class LoadingState extends QAState {}

class LoadingSuccess extends QAState {}

class EndQuizState extends QAState {}

class ErrState extends QAState {}

//bloc
class QABloc extends Bloc<QAEvent, QAState> {
  QABloc() : super(LoadingState()) {
    late List<QuizData> data;
    int index = 0;
    int selectedAnsIndex = 0;
    bool isCorrect = false;
    //curreny
    on<OnQAPage>((event, emit) async {
      data = await FirebaseUtils.readData();
      emit(LoadPage(
          data: data,
          index: index,
          selectedAnsIndex: selectedAnsIndex,
          isCorrect: isCorrect));
    });

    on<OnAnswersClicked>((event, emit) async {
      // final currentIndex = LoadPage(data: data).index;
      final quizData = data[index];
      final correctAns = quizData.correctAnswer;
      final answers = quizData.answers;
      final selectedIndex = event.selectedIndex;

      final isCorrectAns = answers[selectedIndex] == correctAns;

      // answer
      final isCorrect = data[index].correctAnswer == correctAns;
      index += 1;
      if (index < data.length) {
        emit(LoadPage(
            data: data,
            index: index,
            selectedAnsIndex: selectedIndex,
            isCorrect: isCorrectAns));
      } else {
        emit(EndQuizState());
      }
    });
  }
}
