import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/utils.dart';

class PredefinedForms extends StatelessWidget {

  const PredefinedForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predefined Forms')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(pagePadding),
        child: const PaintForms(),
      ),
    );
  }

}

class PaintForms extends StatelessWidget {

  const PaintForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FormsPainter(),
    );
  }
}

class FormsPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    // a line
    final paintLine = Paint()
      ..color = Colors.green
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      Offset(0, 20),
      Offset(size.width, 20),
      paintLine,
    );

    // the circle
    final paintCircle = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 1.5, size.height / 2),
      size.height / 6,
      paintCircle,
    );

    // the rectangle
    final paintRectangle = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(0, size.height / 2),
        width: size.width / 2,
        height: size.height / 2,
      ),
      paintRectangle,
    );

    // a square from the circle
    final paintSquare = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCircle(
        center: Offset(size.width / 1.5, size.height / 2),
        radius: size.height / 9,
      ),
      paintSquare,
    );

    // the oval
    final paintOval = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width / 2,
        height: size.height / 2,
      ),
      paintOval,
    );

    // an arc
    final paintArc = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(40, 40),
        width: size.width / 2,
        height: size.height / 5,
      ),
      0,
      3.14,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
