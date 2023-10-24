import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchTimer extends ChangeNotifier {
  Duration presetTime;
  Duration updateInterval;
  CountMode countMode;
  void Function(Duration timerDuration)? onChange;

  bool isRunning = false;
  Timer? _timer;
  Duration _timerDuration = Duration.zero;

  StopWatchTimer({
    required this.presetTime,
    this.updateInterval = const Duration(milliseconds: 100),
    this.countMode = CountMode.countUp,
    this.onChange,
  }) : super() {
    _timerDuration = presetTime;
  }

  Duration get duration => _timerDuration;

  void startTimer() {
    debugPrint("Start timer");

    if (isRunning) {
      return;
    }
    isRunning = true;

    notifyListeners();

    _timer = Timer.periodic(updateInterval, (timer) {
      if (countMode == CountMode.countUp) {
        _timerDuration += updateInterval;
      }
      if (countMode == CountMode.countDown) {
        _timerDuration -= updateInterval;
      }

      if (onChange != null) onChange!(_timerDuration);

      notifyListeners();
    });
  }

  void stopTimer() {
    debugPrint("Stop timer");

    if (!isRunning) {
      return;
    }

    _timer?.cancel();
    isRunning = false;

    notifyListeners();
  }

  void resetTimer() {
    debugPrint("Reset timer");

    _timerDuration = presetTime;

    notifyListeners();
  }

  void changeTimerDuration(Duration duration) {
    _timerDuration = duration;
    presetTime = duration;

    notifyListeners();
  }

  void changeTimerMode(CountMode mode) {
    countMode = mode;

    notifyListeners();
  }

  void changeTimerInterval(Duration interval) {
    updateInterval = interval;

    notifyListeners();
  }

  @override
  void dispose() {
    if (isRunning) {
      stopTimer();
    }
    _timer?.cancel();

    super.dispose();
  }
}

enum CountMode {
  countUp,
  countDown,
}
