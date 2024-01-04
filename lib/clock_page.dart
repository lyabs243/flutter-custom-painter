import 'dart:math';

import 'package:flutter/material.dart';

class ClockPage extends StatelessWidget {

  const ClockPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double squareSize = MediaQuery.of(context).size.height / 1.8;

    return Scaffold(
      appBar: AppBar(title: const Text('Clock Page')),
      body: Center(
        child: Container(
          width: squareSize,
          height: squareSize,
          padding: const EdgeInsets.all(16),
          child: const PaintClock(),
        ),
      ),
    );
  }

}

class PaintClock extends StatefulWidget {

  const PaintClock({Key? key,}) : super(key: key);

  @override
  State<PaintClock> createState() => _PaintClockState();
}

class _PaintClockState extends State<PaintClock> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
      painter: ClockPainter(color: Theme.of(context).colorScheme.primary),
    );

  }

}

class ClockPainter extends CustomPainter {

  final Color color;

  const ClockPainter({
    this.color = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {

    // a square container
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // add some style by drawing  circles
    int lineIndex = 0, columnIndex = 0;
    while (lineIndex < 5) {

      while (columnIndex < 5) {
        _drawStyleCircle(canvas:  canvas, size: const Size(100, 100),
            lineIndex: lineIndex, columnIndex: columnIndex);
        columnIndex++;
      }
      columnIndex = 0;
      lineIndex++;
    }

    // draw the clock
    final radius = size.width / 2;

    final paintClockCircle = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paintClockCircle);

    // draw the clock numbers
    canvas.translate(size.width / 2, size.height / 2);

    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 1; i <= 12; i++) {

      int index = (i + 3) % 12;
      if (index == 0) index = 12;

      textPainter.text = TextSpan(
        text: '$index',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      double angle = i * 30.0;
      double x = cos(_getRadians(angle)) * (radius - 30) - textPainter.width / 2;
      double y = sin(_getRadians(angle)) * (radius - 30) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(x, y));
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  //draw a circle
  void _drawStyleCircle({
    required Canvas canvas,
    required Size size,
    required int lineIndex,
    required int columnIndex}) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Offset point = Offset(columnIndex * size.width, lineIndex * size.height);
    canvas.drawCircle(point, size.width / 2, paint);

  }

  double _getRadians(double angle) {
    return angle * pi / 180;
  }

}