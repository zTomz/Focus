import 'package:flutter/material.dart';
import 'package:pomodoro_timer/extensions/build_context_ext.dart';
import 'package:pomodoro_timer/widgets/pomodoro_progress_indicator/painter.dart';

class PomodoroProgressIndicator extends StatelessWidget {
  final double progress;
  final double size;

  final Widget? child;
  final Color color;

  const PomodoroProgressIndicator({
    super.key,
    required this.progress,
    required this.size,
    this.child,
    this.color = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: PomodoroProgressIndicatorPainter(
          progress: progress,
          color: color,
        ),
        child: child,
      ),
    );
  }
}
