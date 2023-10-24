import 'package:flutter/material.dart';
import 'package:pomodoro_timer/provider/stop_watch_timer.dart';

class TimerControleButton extends StatelessWidget {
  final StopWatchTimer timer;

  const TimerControleButton({
    super.key,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        timer.isRunning ? timer.stopTimer() : timer.startTimer();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150, 50),
      ),
      icon: Icon(
        timer.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
        size: 26,
      ),
      label: Text(
        timer.isRunning ? "Stop" : "Start",
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
