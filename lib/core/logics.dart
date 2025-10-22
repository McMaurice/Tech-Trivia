import '../data/questions_list.dart';

class TriviaLogic {
  int selectedIndex = -1;
  int point = 0;
  int questionCounter = 0;
  Map<int, int> answers = {};
  bool showPreview = true;
  int duration = 16;
  Set<int> lockedPreviews = {};

  void nextQuestion() {
    showPreview = true;
    duration = 16;
    // CHECK FOR SELECTIONS AND KEEPS TRACK
    if (selectedIndex != -1) {
      answers[questionCounter] = selectedIndex;
      if (selectedIndex == questionsList[questionCounter]['answer']) {
        point += 2;
      }
      showPreview = false;
      lockedPreviews.add(questionCounter);
    }
    // CHECKS FOR MORE QUESTIONS AND KEEPS TRACK
    if (questionCounter < questionsList.length - 1) {
      questionCounter++;
      selectedIndex = -1;
    }
  }

  void prevQuestion() {
    if (!lockedPreviews.contains(questionCounter) && questionCounter > 0) {
      lockedPreviews.add(questionCounter);
      duration = 6;
      showPreview = false;
      questionCounter--;
      selectedIndex = -1;
    }
  }

  void resetTrivia() {
    selectedIndex = -1;
    point = 0;
    questionCounter = 0;
    answers.clear();
  }
}
