import 'package:flutter/material.dart';

class ClockPage extends StatelessWidget {

  const ClockPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clock Page')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: const PaintClock(),
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
      painter: ClockPainter(),
    );

  }

}

class ClockPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}