import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class PlaceClock {

  final String name;
  final String flag;
  String timeZone;
  Color color;

  PlaceClock({
    required this.name,
    required this.flag,
    required this.timeZone,
    required this.color,
  });

  DateTime get dateTime {
    tz.Location location = tz.getLocation(timeZone);
    return tz.TZDateTime.now(location);
  }

}