import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/models/leaderboard_model.dart';
import 'package:quiz_app/utils/firebase_utils.dart';

//events
abstract class LeaderEvent {}

class OnLeaderBoard extends LeaderEvent {}

//states
abstract class LeaderState {}

class LoadLeaderBoard extends LeaderState {
  final List<LeaderBoardModel> data;

  LoadLeaderBoard({required this.data});
}

class LoadingState extends LeaderState {}

//bloc

class LeaderAuth extends Bloc<LeaderEvent, LeaderState> {
  LeaderAuth() : super(LoadingState()) {
    on<OnLeaderBoard>((event, emit) async {
      final data = await FirebaseUtils.readLeaderBoard();
      print(data);
      emit(LoadLeaderBoard(data: data));
    });
  }
}
