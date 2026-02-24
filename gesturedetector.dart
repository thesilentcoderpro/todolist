import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Number System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool lightOn = false;
  bool fanOn = false;
  double temperature = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Automation')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: () => setState(() => lightOn = !lightOn),
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: lightOn ? Colors.yellow : Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  lightOn ? 'Light ON' : 'Light OFF',
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onDoubleTap: () => setState(() => fanOn = !fanOn),
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: fanOn ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  fanOn ? 'Fan ON (Double Tap)' : 'Fan OFF (Double Tap)',
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text('Drag to Control AC Temperature', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  temperature += details.delta.dx * 0.05;
                  temperature = temperature.clamp(16, 30);
                });
              },
              child: Container(
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'AC Temp: ${temperature.toStringAsFixed(1)} °C',
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}