import 'package:flutter/material.dart';

class NotechedRoundedPainter extends CustomClipper<Path> {
  NotechedRoundedPainter(
    this.color,
    this.allowShadow,
    this.shadowColor,
    this.hasCenterButton,
      this.x,
      this.y
  );
  
  final double x;
  final double y;
  final Color color;
  final Color shadowColor;

  final bool allowShadow;
  final bool hasCenterButton;

  // @override
  // void paint(Canvas canvas, Size size) {
  //
  // }

  // @override
  // bool shouldRepaint(covariant CustomPainter oldDelegate) {
  //   return true;
  // }

  @override
  getClip(Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // double zero = 0,
    //     x1 = size.width * 0.01,
    //     x2 = size.width * 0.1,
    //     x3 = size.width * 0.4,
    //     x4 = size.width * 0.6,
    //     x5 = size.width * 0.65,
    //     x6 = size.width * 0.9,
    //     x7 = size.width * 0.99,
    //     y1 = notchHeight * 0.3,
    //     y2 = notchHeight * 0.5;
    //
    // Path path = Path()..moveTo(zero, y2);

    double notchHeight = 72;

    double v1 = 0.42,
        v2 = 0.407,
        v3 = 0.3,
        v4 = 0.35,
        v5 = 0.4,
        v6 = 0.2,
        v7 = 0.68;
    double v1R = 1 - v1,
        v2R = 1 - v2,
        v3R = 1 - v3,
        v4R = 1 - v4,
        v5R = 1 - v5;


    Path path0 = Path();
    path0.moveTo(0,notchHeight);
    path0.lineTo(0,0);
    path0.quadraticBezierTo(0,0,size.width*v3,0);
    path0.cubicTo(size.width*v4,0,size.width*v5,0,size.width*v2,notchHeight*v6);
    path0.cubicTo(size.width*v1,notchHeight*v7,size.width*v1R,notchHeight*v7,size.width*v2R,notchHeight*v6);
    path0.cubicTo(size.width*v5R,0,size.width*v4R,0,size.width*v3R,0);
    path0.quadraticBezierTo(0,0,size.width,0);
    path0.lineTo(size.width,size.height);
    path0.lineTo(0,size.height);
    path0.close();
    return path0;






    // path.quadraticBezierTo(x1, zero, x2, zero);
    // path.lineTo(size.width * 0.35, zero);
    // path.quadraticBezierTo(x3, zero, x3, hasCenterButton ? y2 : zero);
    //
    // if (hasCenterButton) {
    //   path.arcToPoint(Offset(x4, y1),
    //       radius: const Radius.circular(10), clockwise: false);
    // }
    //
    // path.quadraticBezierTo(x4, zero, x5, zero);
    // path.lineTo(x6, zero);
    // path.quadraticBezierTo(x7, zero, size.width, y2);
    //
    // path.lineTo(size.width, notchHeight);
    // path.lineTo(zero, notchHeight);
    //
    // path.close();
    //
    // canvas.drawPath(path, paint);

  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
