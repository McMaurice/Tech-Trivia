import 'package:flutter/material.dart';
import 'package:tech_trivia_app/core/logics.dart';
import 'package:tech_trivia_app/presentation/widgets/button.dart';
import 'package:tech_trivia_app/presentation/widgets/timer.dart';

class LandscapeScreen extends StatefulWidget {
  final TriviaLogic trivia;
  final List<Map<String, dynamic>> questionsList;
  final DateTime endTime;
  final VoidCallback onNextQuestion;
  final VoidCallback onPrevQuestion;
  final VoidCallback onSubmit;

  const LandscapeScreen({
    super.key,
    required this.trivia,
    required this.questionsList,
    required this.endTime,
    required this.onNextQuestion,
    required this.onPrevQuestion,
    required this.onSubmit,
  });

  @override
  State<LandscapeScreen> createState() => _LandscapeScreenState();
}

class _LandscapeScreenState extends State<LandscapeScreen> {
  @override
  Widget build(BuildContext context) {
    final trivia = widget.trivia;
    final questionsList = widget.questionsList;
    final currentQuestion = questionsList[trivia.questionCounter];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // LEFT SIDE — Question + Options
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question text
                      Text(
                        currentQuestion['question'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Options list
                      ...List.generate(
                        currentQuestion['options'].length,
                        (optIndex) => ListTile(
                          dense: true,
                          splashColor: Colors.blue.withAlpha(
                            (0.5 * 150).toInt(),
                          ),
                          onTap: () => setState(() {
                            trivia.selectedIndex = optIndex;
                          }),
                          leading: Icon(
                            trivia.selectedIndex == optIndex
                                ? Icons.check_circle_outline
                                : Icons.circle_outlined,
                            color: trivia.selectedIndex == optIndex
                                ? Colors.blue
                                : Colors.grey,
                          ),
                          title: Text(
                            currentQuestion['options'][optIndex],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // RIGHT SIDE — Timer, Counter, Buttons
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Timer + Counter
                    Column(
                      children: [
                        TimerWidget(
                          key: ValueKey(widget.endTime),
                          endTime: widget.endTime,
                          onTimerComplete: () {
                            trivia.questionCounter < questionsList.length - 1
                                ? widget.onNextQuestion()
                                : widget.onSubmit();
                          },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '${trivia.questionCounter + 1}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // Navigation buttons
                    Row(
                      children: [
                        if (trivia.questionCounter > 0 && trivia.showPreview)
                          Expanded(
                            child: CustomButton(
                              text: 'Prev',
                              onPressed: widget.onPrevQuestion,
                            ),
                          ),
                        if (trivia.questionCounter > 0 &&
                            trivia.showPreview) ...[
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          child:
                              trivia.questionCounter < questionsList.length - 1
                              ? CustomButton(
                                  text: 'Next',
                                  onPressed: widget.onNextQuestion,
                                )
                              : CustomButton(
                                  text: 'Submit',
                                  buttonColor: Colors.green,
                                  onPressed: widget.onSubmit,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
