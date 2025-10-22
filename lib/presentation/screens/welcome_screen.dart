import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tech_trivia_app/presentation/screens/questions/questions_vew.dart';
import 'package:tech_trivia_app/presentation/widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HNG Tech Trivia ✌🏾'.toUpperCase(),
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 50.h, child: Icon(Icons.menu)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rulesText('Each question is worth 2 point'),
                  _rulesText('You have 15 seconds for each question'),
                  _rulesText('Stay sharp and think fast!'),
                  _rulesText("Good luck fam!, Let's see how tecky you are 😜"),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'Start',
              buttonColor: Colors.red,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _rulesText(String rule) {
  return Row(
    children: [
      Icon(Icons.code, color: Colors.blue),
      SizedBox(width: 5),
      Text(rule, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    ],
  );
}
