import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/clock_page.dart';
import 'package:flutter_custom_painter/custom_forms.dart';
import 'package:flutter_custom_painter/house_page.dart';
import 'package:flutter_custom_painter/predefined_forms.dart';
import 'package:flutter_custom_painter/utils.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Painter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Custom Painter'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(pagePadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                child: const Text('Predefined forms'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PredefinedForms(),
                    )
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Custom forms with Path'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CustomForms(),
                      )
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Draw a house'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HousePage(),
                      )
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Draw a clock'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ClockPage(),
                      )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
