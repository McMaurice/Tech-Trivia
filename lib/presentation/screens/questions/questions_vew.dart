import 'package:flutter/material.dart';
import 'package:tech_trivia_app/core/logics.dart';
import 'package:tech_trivia_app/data/questions_list.dart';
import 'package:tech_trivia_app/presentation/screens/questions/landscape.dart';
import 'package:tech_trivia_app/presentation/screens/questions/portrait.dart';
import 'package:tech_trivia_app/presentation/screens/summary_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late bool  isDesktop;
  final TriviaLogic trivia = TriviaLogic();
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    startTimer(trivia.duration);
  }

  void startTimer(int seconds) {
    setState(() {
      endTime = DateTime.now().add(Duration(seconds: seconds));
    });
  }

  void onNextQuestion() {
    setState(() {
      trivia.nextQuestion();
      startTimer(trivia.duration); // restart timer for next question
    });
  }

  void onPrevQuestion() {
    setState(() {
      trivia.prevQuestion();
      startTimer(trivia.duration); // restart timer for previous question
    });
  }

  void onSubmit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SummaryScreen(points: trivia.point, answers: trivia.answers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width > 600;
    isDesktop = screenSize;

    return Scaffold(
      appBar: AppBar(title: const Text('HNG Tech Trivia'), centerTitle: true),
      body: isDesktop
          ? LandscapeScreen(
              trivia: trivia,
              questionsList: questionsList,
              endTime: endTime,
              onNextQuestion: onNextQuestion,
              onPrevQuestion: onPrevQuestion,
              onSubmit: onSubmit,
            )
          : PortraitScreen(
              trivia: trivia,
              questionsList: questionsList,
              endTime: endTime,
              onNextQuestion: onNextQuestion,
              onPrevQuestion: onPrevQuestion,
              onSubmit: onSubmit,
            ),
    );
  }
}
