import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
    required this.endTime,
    required this.onTimerComplete,
  });

  final DateTime endTime;
  final VoidCallback onTimerComplete;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TimerCountdown(
        format: CountDownTimerFormat.secondsOnly,
        timeTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50,
          color: Colors.blue,
        ),
        endTime: endTime,
        onEnd: onTimerComplete,
      ),
    );
  }
}
