import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/utils.dart';

class CustomForms extends StatelessWidget {

  const CustomForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Forms'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(pagePadding),
        child: const PaintCustomForms(),
      ),
    );
  }
}

class PaintCustomForms extends StatelessWidget {

  const PaintCustomForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomFormsPainter(),
    );
  }
}

class CustomFormsPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final path = Path();

    // Define the shapes using path commands
    path.moveTo(100, 100);
    path.lineTo(200, 50);
    path.quadraticBezierTo(300, 150, 250, 250);
    path.arcToPoint(Offset(150, 200), radius: Radius.circular(40), clockwise: false);
    path.cubicTo(100, 200, 50, 150, 100, 100);
    // Close the path to create a continuous shape
    path.close();

    // Set up paint properties for the path
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Draw the path on the canvas
    canvas.drawPath(path, paint);

    // draw a triangle
    final paintTriangle = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final pathTriangle = Path();
    pathTriangle.moveTo(100, 550);
    pathTriangle.lineTo(200, 550);
    pathTriangle.lineTo(150, 450);
    pathTriangle.close();

    canvas.drawPath(pathTriangle, paintTriangle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}