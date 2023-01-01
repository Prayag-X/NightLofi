import 'package:flutter/material.dart';

class RoundedCurvedPainter extends CustomPainter {
  RoundedCurvedPainter(
    this.color,
    this.allowShadow,
    this.shadowColor,
    this.hasCenterButton,
  );

  final Color color;
  final Color shadowColor;

  final bool allowShadow;
  final bool hasCenterButton;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double zero = 0,
        x1 = size.width * 0.01,
        x2 = size.width * 0.1,
        x3 = size.width * 0.5,
        x4 = size.width * 0.9,
        x5 = size.width * 0.99,
        y1 = size.height * 0.5,
        y2 = size.height * 0.45;

    Path path = Path()..moveTo(zero, y1);

    path.quadraticBezierTo(x1, zero, x2, zero);

    path.quadraticBezierTo(x3, y2, x4, zero);

    path.quadraticBezierTo(x5, zero, size.width, y1);

    path.lineTo(size.width, size.height);
    path.lineTo(zero, size.height);

    path.close();

    canvas.drawPath(path, paint);

    if (allowShadow) canvas.drawShadow(path, color, 5, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
