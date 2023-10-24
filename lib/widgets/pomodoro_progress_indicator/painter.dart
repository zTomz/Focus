import 'dart:math' as math;

import 'package:flutter/material.dart';

class PomodoroProgressIndicatorPainter extends CustomPainter {
  final double strokeWidth;
  final double pointRadius;
  final double progress;
  final Color color;

  const PomodoroProgressIndicatorPainter({
    required this.progress,
    this.strokeWidth = 10,
    this.pointRadius = 15,
    this.color = Colors.green,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(
      const Offset(0, 0),
      Offset(size.width, size.height),
    );

    final double sweepAngle = 2 * progress * math.pi;

    final pointX = (size.width / 2) +
        (size.width / 2) * math.cos(sweepAngle + (3 * math.pi / 2));
    final pointY = (size.height / 2) +
        (size.height / 2) * math.sin(sweepAngle + (3 * math.pi / 2));

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(0.3),
          color,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(rect)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, 3 * math.pi / 2, sweepAngle, false, paint);

    canvas.drawCircle(
      Offset(pointX, pointY),
      pointRadius,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color,
    );

    canvas.drawCircle(
      Offset(pointX, pointY),
      pointRadius - 5,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(PomodoroProgressIndicatorPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PomodoroProgressIndicatorPainter oldDelegate) =>
      false;
}
