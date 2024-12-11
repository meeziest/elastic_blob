import 'dart:math';

import 'package:flutter/material.dart';

const foregroundWaveColor = Color(0xFF0073E6);
const backgroundWaveColor = Color(0xFFE0F7FA);

class WavePainter extends CustomPainter {
  final ValueNotifier<double> progress;
  final Animation<double> waveAnimation;
  final double circleRadius;

  WavePainter({
    required this.progress,
    required this.waveAnimation,
    required this.circleRadius,
  }) : super(repaint: Listenable.merge([progress, waveAnimation]));

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    _drawWaves(canvas);
  }

  /// Draws the wave fill inside the clipped circle area.
  void _drawWaves(Canvas canvas) {
    // canvas.clipPath(
    //   Path()
    //     ..addOval(
    //       Rect.fromCircle(
    //         center: Offset.zero,
    //         radius: circleRadius,
    //       ),
    //     ),
    // );

    canvas.save();

    // /// Draw the background wave first
    // _drawSineWave(canvas, backgroundWaveColor);

    /// Draw the foreground wave with shifting and mirror it
    _drawSineWave(canvas, foregroundWaveColor, mirror: true, shift: circleRadius / 2);

    canvas.restore();
  }

  /// Draws a single sine wave inside the clipped area.
  /// sine wave explanation -> https://mathematicalmysteries.org/sine-wave/
  void _drawSineWave(Canvas canvas, Color waveColor, {double shift = 0.0, bool mirror = false}) {
    if (mirror) {
      canvas.save();
      canvas.transform(Matrix4.rotationY(pi).storage);
    }

    double startX = -circleRadius;
    double endX = circleRadius;
    double startY = circleRadius;
    double endY = -circleRadius;

    double amplitude = 15.0;
    double angularVelocity = pi / circleRadius;
    double delta = Curves.slowMiddle.transform(progress.value);

    double offsetX = 2 * circleRadius * waveAnimation.value + shift;
    double offsetY = startY + (endY - startY - amplitude) * progress.value;

    Paint wavePaint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..isAntiAlias = true;

    Path path = Path();

    for (double x = startX; x <= endX; x++) {
      /// y = A * sin(ωx + φ) wave function itself, where A is amplitude, ω is angular velocity, φ is phase shift
      double y = amplitude * sin(angularVelocity * (x + offsetX));
      if (x == startX) {
        path.moveTo(x, y + offsetY);
      } else {
        path.lineTo(x, y + offsetY);
      }
    }

    // path.lineTo(endX, startY);
    // path.lineTo(startX, startY);
    // path.close();

    canvas.drawPath(path, wavePaint);
    if (mirror) canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
