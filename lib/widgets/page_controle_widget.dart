import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer/pages/HomePage/home_page.dart';
import 'package:pomodoro_timer/pages/HomePage/todo_page.dart';
import 'package:pomodoro_timer/pages/long_break_page.dart';
import 'package:pomodoro_timer/pages/short_break_page.dart';
import 'package:pomodoro_timer/provider/pomodoro_mode.dart';
import 'package:pomodoro_timer/provider/stop_watch_timer.dart';
import 'package:provider/provider.dart';

class PageControleWidget extends StatelessWidget {
  final PomodoroModeProvider pomodoroMode;

  const PageControleWidget({
    super.key,
    required this.pomodoroMode,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pomodoroMode.pageController,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.invertedStylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
        },
      ),
      onPageChanged: (value) {
        final timer = context.read<StopWatchTimer>();

        timer.stopTimer();

        switch (value) {
          case 0:
            timer.changeTimerDuration(const Duration(minutes: 25));
            pomodoroMode.pomodoroMode = PomodoroMode.pomodoro;
            break;
          case 1:
            timer.changeTimerDuration(const Duration(minutes: 5));
            pomodoroMode.pomodoroMode = PomodoroMode.shortBreak;
            break;
          case 2:
            timer.changeTimerDuration(const Duration(minutes: 15));
            pomodoroMode.pomodoroMode = PomodoroMode.longBreak;
            break;
          default:
            timer.changeTimerDuration(const Duration(minutes: 25));
            pomodoroMode.pomodoroMode = PomodoroMode.pomodoro;
        }
      },
      children: [
        PageView(
          controller: pomodoroMode.homePageController,
          onPageChanged: (value) {
            switch (value) {
              case 0:
                pomodoroMode.pomodoroMode = PomodoroMode.pomodoro;
                break;
              case 1:
                pomodoroMode.pomodoroMode = PomodoroMode.todos;
                break;
              default:
                break;
            }
          },
          scrollDirection: Axis.vertical,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.invertedStylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.stylus,
              PointerDeviceKind.trackpad,
            },
          ),
          children: const [
            HomePage(),
            TodoPage(),
          ],
        ),
        const ShortBreakPage(),
        const LongBreakPage(),
      ],
    );
  }
}
