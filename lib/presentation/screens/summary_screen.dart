import 'package:flutter/material.dart';
import 'package:tech_trivia_app/core/logics.dart';
import 'package:tech_trivia_app/data/questions_list.dart';
import 'package:tech_trivia_app/presentation/screens/welcome_screen.dart';
import 'package:tech_trivia_app/presentation/widgets/button.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key, required this.points, required this.answers});
  final int points;
  final Map<int, int> answers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 30),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '"Boom!💥"',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          points > 1
                              ? 'You got $points points'
                              : 'You got $points point',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      text: 'Try Again!',
                      buttonColor: Colors.green,
                      onPressed: () {
                        TriviaLogic().resetTrivia();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: questionsList.length,
                itemBuilder: (context, questionIndex) {
                  final question = questionsList[questionIndex];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${questionIndex + 1}. ${question['question']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          !answers.containsKey(questionIndex)
                              ? 'Missed Question'
                              : '',
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(question['options'].length, (
                          optIndex,
                        ) {
                          final isCorrect = optIndex == question['answer'];
                          final isUserChoice =
                              optIndex == answers[questionIndex];
                          final isWrong = isUserChoice != isCorrect;
                          return ListTile(
                            leading: Icon(
                              isCorrect
                                  ? Icons.check_circle_outline
                                  : (isWrong
                                        ? Icons.highlight_off
                                        : Icons.circle_outlined),
                              color: isCorrect
                                  ? Colors.green
                                  : (isWrong ? Colors.red : Colors.black),
                            ),
                            title: Text(
                              question['options'][optIndex],
                              style: TextStyle(
                                color: isCorrect
                                    ? Colors.green
                                    : (isWrong ? Colors.red : Colors.black),
                                fontWeight: isCorrect || isWrong
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
