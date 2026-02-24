import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool lightOn = false;
  bool acOn = false;
  int temperature = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Smart Home - 3 Gestures"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔆 LIGHT - TAP
            GestureDetector(
              onTap: () {
                setState(() {
                  lightOn = !lightOn;
                });
              },
              child: buildCard(
                title: "Light (Tap)",
                icon: Icons.lightbulb,
                active: lightOn,
              ),
            ),

            // ❄ AC - LONG PRESS
            GestureDetector(
              onLongPress: () {
                setState(() {
                  acOn = !acOn;
                });
              },
              child: buildCard(
                title: "AC (Long Press)",
                icon: Icons.ac_unit,
                active: acOn,
              ),
            ),

            // 🌡 TEMPERATURE - SWIPE
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  if (details.delta.dx > 0 && temperature < 30) {
                    temperature++;
                  } else if (details.delta.dx < 0 && temperature > 16) {
                    temperature--;
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(20),
                width: 260,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8)
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.thermostat,
                        size: 50, color: Colors.deepOrange),
                    const SizedBox(height: 10),
                    const Text(
                      "Temperature (Swipe)",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$temperature °C",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Swipe → Increase\nSwipe ← Decrease",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required String title,
    required IconData icon,
    required bool active,
  }) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      width: 260,
      decoration: BoxDecoration(
        color: active ? Colors.amber.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8)
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 50,
            color: active ? Colors.deepPurple : Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            active ? "ON" : "OFF",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: active ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}