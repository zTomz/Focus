import 'package:flutter/material.dart';

class PomodoroModeProvider extends ChangeNotifier {
  PomodoroMode _pomodoroMode = PomodoroMode.pomodoro;
  PageController pageController = PageController();
  PageController homePageController = PageController();

  PomodoroMode get pomodoroMode => _pomodoroMode;

  set pomodoroMode(PomodoroMode newPomodoroMode) {
    _pomodoroMode = newPomodoroMode;

    notifyListeners();
  }

  void changePage(PomodoroMode newPomodoroMode) {
    if (newPomodoroMode == _pomodoroMode) {
      return;
    }

    _pomodoroMode = newPomodoroMode;

    pageController.animateToPage(
      newPomodoroMode.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void changeHomePageState(PomodoroMode newPomodoroMode) {
    if (newPomodoroMode == _pomodoroMode) {
      return;
    }
    
    _pomodoroMode = newPomodoroMode;

    homePageController.animateToPage(
      newPomodoroMode == PomodoroMode.todos ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    notifyListeners();
  }

  (Color, Color) getColors() {
    switch (pomodoroMode) {
      case PomodoroMode.pomodoro:
        return (AppColors.green, AppColors.secondaryGreen);
      case PomodoroMode.shortBreak:
        return (AppColors.orange, AppColors.secondaryOrange);
      case PomodoroMode.longBreak:
        return (AppColors.red, AppColors.secondaryRed);
      case PomodoroMode.todos:
        return (AppColors.green, AppColors.secondaryGreen);
    }
  }

  String getTitle() {
    switch (pomodoroMode) {
      case PomodoroMode.pomodoro:
        return "Pomodoro";
      case PomodoroMode.shortBreak:
        return "Short Break";
      case PomodoroMode.longBreak:
        return "Long Break";
      case PomodoroMode.todos:
        return "Todos";
    }
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}

class AppColors {
  static const Color green = Color(0xFF33C16C);
  static const Color orange = Color(0xFFF2A541);
  static const Color red = Color(0xFFDE4F3F);

  static const Color secondaryGreen = Color(0xFF2BA15A);
  static const Color secondaryOrange = Color(0xFFEF931A);
  static const Color secondaryRed = Color(0xFFD13523);
}

enum PomodoroMode {
  pomodoro,
  shortBreak,
  longBreak,
  todos,
}
