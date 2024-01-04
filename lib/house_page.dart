import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/utils.dart';

class HousePage extends StatelessWidget {

  const HousePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('House Page')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(pagePadding),
        child: const PaintHouse(),
      ),
    );
  }

}

class PaintHouse extends StatelessWidget {

  const PaintHouse({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustomPaint(
            painter: HousePainter(
              title: 'Dash',
              color: Theme.of(context).colorScheme.primary
            ),
            size: const Size(200, 250),
          ),
        ),
        const Positioned(
          top: 350,
          left: 0,
          child: CustomPaint(
            painter: HousePainter(
                title: 'Tintin',
                color: Colors.redAccent
            ),
            size: Size(200, 220),
          ),
        ),
        const Positioned(
          top: 200,
          right: 0,
          child: CustomPaint(
            painter: HousePainter(
                title: 'Milou',
                color: Colors.green
            ),
            size: Size(200, 220),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: CustomPaint(
            painter: HousePainter(
                title: 'Flutter',
                color: Theme.of(context).colorScheme.secondary
            ),
            size: const Size(200, 250),
          ),
        ),
      ],
    );
  }
}

class HousePainter extends CustomPainter {

  final String title;
  final Color color;
  
  const HousePainter({required this.title, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // the roof
    final paintRoof = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double roofHeight = size.height / 3;
    final path = Path()
      ..moveTo(0, roofHeight)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, roofHeight)
      ..close();

    canvas.drawPath(path, paintRoof);

    // the chimney (la cheminée)
    final paintChimney = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double chimneyWidth = size.width / 10;
    double chimneyHeight = size.height / 4;
    double chimneyCenterX = size.width / 1.2;
    double chimneyCenterY = roofHeight / 2;

    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(chimneyCenterX, chimneyCenterY),
          width: chimneyWidth,
          height: chimneyHeight,
        ),
        paintChimney
    );

    // the house
    final paintHouse = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double paddingFromRoof = size.width / 10;
    final pathHouse = Path()
      ..moveTo(paddingFromRoof, roofHeight)
      ..lineTo(paddingFromRoof, size.height)
      ..lineTo(size.width - paddingFromRoof, size.height)
      ..lineTo(size.width - paddingFromRoof, roofHeight)
      ..close();

    canvas.drawPath(pathHouse, paintHouse);

    // the door
    final paintDoor = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double doorWidth = size.width / 3.5;
    double doorHeight = size.height / 2.8;
    double doorCenterX = size.width / 2;
    double doorCenterY = size.height - doorHeight / 2;

    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(doorCenterX, doorCenterY),
          width: doorWidth,
          height: doorHeight,
        ),
        paintDoor
    );

    // the door knob (la poignée de la porte)
    final paintDoorKnob = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    double doorKnobRadius = 10;
    canvas.drawCircle(Offset(size.width / 2 + doorWidth / 2 - (doorKnobRadius + 8), size.height - doorHeight / 2), doorKnobRadius, paintDoorKnob);

    // write "DevFest Lubumbashi 2023" on the door
    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      text: title,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height - doorHeight / 1.2 - tp.height / 2));

    // the window
    final paintWindow = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    double windowWidth = size.width / 4.5;
    double windowHeight = size.height / 5.5;

    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2), roofHeight + 20 + (windowHeight / 2)),
          width: windowWidth,
          height: windowHeight,
        ),
        paintWindow
    );

    // the window panes (les carreaux de la fenêtre)
    final paintWindowPanes = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2), roofHeight + 20),
        Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2), roofHeight + 20 + windowHeight),
        paintWindowPanes
    );

    canvas.drawLine(
        Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2) - (windowWidth / 2), roofHeight + 20 + (windowHeight / 2)),
        Offset(size.width - paddingFromRoof - 20 - (windowWidth / 2) + (windowWidth / 2), roofHeight + 20 + (windowHeight / 2)),
        paintWindowPanes
    );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}