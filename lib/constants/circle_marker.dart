import 'package:flutter/material.dart';

class ConcentricCirclesPainter extends CustomPainter {
  final bool isSingle;
  final Color? innerColor;
  final Color? outerColor;

  // Constructor to initialize the properties
  ConcentricCirclesPainter({this.isSingle = false, this.innerColor, this.outerColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the outer circle
    final paint1 = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.fill;

    // Paint for the inner circle
    final paint2 = Paint()
      ..color = innerColor ?? Colors.red
      ..style = PaintingStyle.fill;

    // Center point for the circles
    final center = Offset(size.width / 2, size.height / 2);

    // Radius for the outer circle
    final outerRadius = size.width / 2;
    // Radius for the inner circle
    final innerRadius = size.width / 5.5;

    // Draw the outer circle only if isSingle is false
    if (!isSingle) {
      canvas.drawCircle(center, outerRadius, paint1);
    }

    // Draw the inner circle
    canvas.drawCircle(center, innerRadius, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // No need to repaint since there are no dynamic properties
    return false;
  }
}
