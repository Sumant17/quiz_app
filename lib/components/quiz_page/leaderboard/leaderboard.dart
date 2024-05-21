import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/components/quiz_page/leaderboard/leaderboard_bloc.dart';

class LeaderBoard extends StatelessWidget {
  late LeaderAuth leaderBloc;
  LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('LeaderBoard'),
      ),
      body: BlocProvider(
        create: (context) => LeaderAuth()..add(OnLeaderBoard()),
        child: BlocConsumer<LeaderAuth, LeaderState>(
          listener: (context, state) {},
          builder: (context, state) {
            leaderBloc = BlocProvider.of<LeaderAuth>(context);

            if (state is LoadLeaderBoard) {
              final dataList = state.data;

              return SingleChildScrollView(
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
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListView(
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
                                  child: Text(
                                    '${dataList[index].id}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                                title: Text(
                                  dataList[index].name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${dataList[index].points} + pts',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
