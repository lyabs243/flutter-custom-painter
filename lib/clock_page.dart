import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/model/place_clock.dart';

class ClockPage extends StatelessWidget {

  const ClockPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Clock Page')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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

  Timer? _timer;
  int _index = 0;
  List<PlaceClock> places = [
    const PlaceClock(
      flag: '🇨🇩',
      color: Color(0xFF0087FF),
      name: 'Lubumbashi',
      timeZone: 'Africa/Lubumbashi',
    ),
    const PlaceClock(
      flag: '🇺🇸',
      color: Color(0xFFB2293B),
      name: 'New York',
      timeZone: 'America/New_York',
    ),
    const PlaceClock(
      flag: '🇳🇬',
      color: Color(0xFF00814D),
      name: 'Lagos',
      timeZone: 'Africa/Lagos',
    ),
    const PlaceClock(
      flag: '🇪🇬',
      color: Color(0xFFCD1329),
      name: 'Cairo',
      timeZone: 'Africa/Cairo',
    ),
    const PlaceClock(
      flag: '🇫🇷',
      color: Color(0xFF002996),
      name: 'Paris',
      timeZone: 'Europe/Paris',
    ),
    const PlaceClock(
      flag: '🇨🇳',
      color: Color(0xFFD8230E),
      name: 'Shanghai',
      timeZone: 'Asia/Shanghai',
    ),
    const PlaceClock(
      flag: '🇧🇷',
      color: Color(0xFF009B39),
      name: 'Sao Paulo',
      timeZone: 'America/Sao_Paulo',
    ),
    const PlaceClock(
      flag: '🇬🇧',
      color: Color(0xFF00358D),
      name: 'London',
      timeZone: 'Europe/London',
    ),
    const PlaceClock(
      flag: '🇯🇵',
      color: Color(0xFFBC002C),
      name: 'Tokyo',
      timeZone: 'Asia/Tokyo',
    ),
    const PlaceClock(
      flag: '🇦🇺',
      color: Color(0xFF000082),
      name: 'Sydney',
      timeZone: 'Australia/Sydney',
    ),
    const PlaceClock(
      flag: '🇮🇳',
      color: Color(0xFFFF9932),
      name: 'New Delhi',
      timeZone: 'Asia/Kolkata',
    ),
    const PlaceClock(
      flag: '🇷🇺',
      color: Color(0xFFCC2116),
      name: 'Moscow',
      timeZone: 'Europe/Moscow',
    ),
    const PlaceClock(
      flag: '🇨🇦',
      color: Color(0xFFFF0000),
      name: 'Toronto',
      timeZone: 'America/Toronto',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // update the clock every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    PlaceClock place = places[_index];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                //mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.3,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: index == _index ? places[_index].color : Colors.grey[300],
                      foregroundColor: index == _index ? Colors.white : places[index].color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('${places[index].flag} ${places[index].name}'),
                    onPressed: () {
                      setState(() {
                        _index = index;
                      });
                    },
                  ),
                );
              },
            ),
          )
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.height / 1.8,
          height: MediaQuery.of(context).size.height / 1.8,
          child: CustomPaint(
            painter: ClockPainter(place: place),
          ),
        )
      ],
    );

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}

class ClockPainter extends CustomPainter {

  final PlaceClock place;

  ClockPainter({
    required this.place,
  });

  @override
  void paint(Canvas canvas, Size size) {

    // a square container
    final paint = Paint()
      ..color = place.color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // add some style by drawing  circles
    int lineIndex = 0, columnIndex = 0;
    while (lineIndex < 6) {

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

    double maxRadius = 150;
    double maxStroke = 6;
    _paintHourHand(canvas, maxRadius / 2.5, maxStroke);
    _paintMinuteHand(canvas, maxRadius / 1.5, maxStroke / 1.4);
    _paintSecondHand(canvas, maxRadius / 1.2, maxStroke / 3);

    //drawing center point
    Paint centerPointPaint = Paint()
      ..strokeWidth = (radius / 12)
      ..strokeCap = StrokeCap.round
      ..color = Colors.black;
    canvas.drawPoints(ui.PointMode.points, const [Offset(0, 0)], centerPointPaint);

    // write the country emoji flag at the top under the clock numbers
    TextSpan span = TextSpan(
      text: place.flag,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(-tp.width / 2, -radius + 50));

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

  /// drawing hour hand
  void _paintHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = place.dateTime.hour % 12 + place.dateTime.minute / 60.0 - 3;
    Offset handOffset = Offset(cos(_getRadians(angle * 30)) * radius,
        sin(_getRadians(angle * 30)) * radius);
    final handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, handPaint);
  }

  /// drawing minute hand
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = place.dateTime.minute - 15.0;
    Offset handOffset = Offset(cos(_getRadians(angle * 6.0)) * radius,
        sin(_getRadians(angle * 6.0)) * radius);
    final handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, handPaint);
  }

  /// drawing second hand
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {

    double angle = place.dateTime.second - 15.0;
    Offset handOffset = Offset(cos(_getRadians(angle * 6.0)) * radius,
        sin(_getRadians(angle * 6.0)) * radius);
    final handPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth;
    canvas.drawLine(const Offset(0, 0), handOffset, handPaint);
  }

}