import 'package:flutter/material.dart';
import 'package:tech_trivia_app/core/logics.dart';
import 'package:tech_trivia_app/presentation/widgets/button.dart';
import 'package:tech_trivia_app/presentation/widgets/timer.dart';

class PortraitScreen extends StatefulWidget {
  final TriviaLogic trivia;
  final List<Map<String, dynamic>> questionsList;
  final DateTime endTime;
  final VoidCallback onNextQuestion;
  final VoidCallback onPrevQuestion;
  final VoidCallback onSubmit;

  const PortraitScreen({
    super.key,
    required this.trivia,
    required this.questionsList,
    required this.endTime,
    required this.onNextQuestion,
    required this.onPrevQuestion,
    required this.onSubmit,
  });

  @override
  State<PortraitScreen> createState() => _PortraitScreenState();
}

class _PortraitScreenState extends State<PortraitScreen> {
  @override
  Widget build(BuildContext context) {
    final trivia = widget.trivia;
    final questionsList = widget.questionsList;
    final currentQuestion = questionsList[trivia.questionCounter];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timer and question counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    TimerWidget(
                      key: ValueKey(widget.endTime),
                      endTime: widget.endTime,
                      onTimerComplete: () {
                        trivia.questionCounter < questionsList.length - 1
                            ? widget.onNextQuestion()
                            : widget.onSubmit();
                      },
                    ),
                    const Expanded(child: SizedBox(width: 20)),
                    Text(
                      '${trivia.questionCounter + 1}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 40),

                // Question text
                Text(
                  currentQuestion['question'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                // Options
                ...List.generate(
                  currentQuestion['options'].length,
                  (optIndex) => ListTile(
                    splashColor: Colors.blue,
                    onTap: () {
                      setState(() {
                        trivia.selectedIndex = optIndex;
                      });
                    },
                    leading: Icon(
                      trivia.selectedIndex == optIndex
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      color: trivia.selectedIndex == optIndex
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    title: Text(currentQuestion['options'][optIndex]),
                  ),
                ),
              ],
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!trivia.lockedPreviews.contains(trivia.questionCounter) &&
                    trivia.questionCounter > 0 &&
                    trivia.showPreview)
                  CustomButton(text: 'Prev', onPressed: widget.onPrevQuestion),
                const SizedBox(width: 30),
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
              ],
            ),
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
