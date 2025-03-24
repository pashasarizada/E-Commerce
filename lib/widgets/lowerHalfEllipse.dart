import 'package:flutter/material.dart';

class LowerHalfEllipse extends StatelessWidget {
  final double width;
  final double height;
  final Gradient gradient;

  const LowerHalfEllipse({
    super.key,
    required this.width,
    required this.height,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        size: Size(width, height),
        painter: _LowerHalfEllipsePainter(gradient),
      ),
    );
  }
}

class _LowerHalfEllipsePainter extends CustomPainter {
  final Gradient gradient;

  _LowerHalfEllipsePainter(this.gradient);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      -0.2 * size.width,
      -1 * size.height,
      size.width * 2,
      size.height * 2,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawArc(rect, 0, 3.14, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
