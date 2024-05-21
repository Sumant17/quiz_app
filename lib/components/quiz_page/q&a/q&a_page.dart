import 'package:flutter/material.dart';
import 'package:quiz_app/components/quiz_page/finish.dart';
import 'package:quiz_app/components/quiz_page/q&a/q&a_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionAnswerPage extends StatefulWidget {
  QuestionAnswerPage({super.key});

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  late QABloc qaBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Flutter'),
      ),
      body: BlocProvider(
        create: (context) => QABloc()..add(OnQAPage()),
        child: BlocConsumer<QABloc, QAState>(
          listener: (context, state) {
            if (state is EndQuizState) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Finish()));
            }
          },
          builder: (context, state) {
            qaBloc = BlocProvider.of<QABloc>(context);
            if (state is LoadPage) {
              final dataList = state.data;
              final index = state.index;
              final selectedAnsIndex = state.selectedAnsIndex;
              final isCorrect = state.isCorrect;
              print('state index = $index');
              final data = dataList[index];
              return SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: LinearProgressIndicator(
                      value: (index + 1) / dataList.length,
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
                        child: Text(
                          data.question,
                          style: const TextStyle(
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
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.answers.length,
                      itemBuilder: (context, index) {
                        final option = data.answers[index];
                        final correctAns = data.correctAnswer;
                        Color buttonColor = Colors.purple;

                        if (state.isCorrect &&
                            index == state.selectedAnsIndex) {
                          buttonColor = Colors.green;
                        } else if (!state.isCorrect &&
                            index == state.selectedAnsIndex) {
                          buttonColor = Colors.red;
                        }

                        // if (option == correctAns) {
                        //   buttonColor = Colors.orange;
                        // } else if (index == selectedAnsIndex) {
                        //   buttonColor = Colors.red;
                        // }

                        return ElevatedButton(
                          onPressed: () {
                            qaBloc.add(OnAnswersClicked(index));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              side: BorderSide(color: Colors.black)),
                          child: Text(
                            option,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Navigator.of(context).push(MaterialPageRoute(
                  //       //     builder: (context) => const Finish()));
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Color(0xffff9051),
                  //         side: const BorderSide(color: Colors.black)),
                  //     child: Text(
                  //       data[index].answers[1],
                  //       style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.purple,
                  //         side: const BorderSide(color: Colors.black)),
                  //     child: Text(
                  //       data[index].answers[2],
                  //       style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
                ],
              ));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
