import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer/extensions/build_context_ext.dart';
import 'package:pomodoro_timer/provider/stop_watch_timer.dart';
import 'package:pomodoro_timer/widgets/pomodoro_progress_indicator/progress_indicator.dart';
import 'package:pomodoro_timer/widgets/timer_controle_button.dart';
import 'package:provider/provider.dart';

class ShortBreakPage extends StatelessWidget {
  const ShortBreakPage({super.key});

  @override
  Widget build(BuildContext context) {
    final timer = context.watch<StopWatchTimer>();

    return Scaffold(
      floatingActionButton: TimerControleButton(
        timer: timer,
      ),
      body: Center(
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "Short Break",
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            PomodoroProgressIndicator(
              // Calculate progress from timer duration it should show how many time is left
              progress:
                  (timer.presetTime.inSeconds - timer.duration.inSeconds) /
                      timer.presetTime.inSeconds,
              color: context.colorScheme.primary,
              size: min(MediaQuery.of(context).size.width * 0.8, 350),
              child: Center(
                child: Text(
                  "${timer.duration.inMinutes.toString().padLeft(2, '0')}:${(timer.duration.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
