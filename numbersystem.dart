import 'package:flutter/material.dart';

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
  String binary = '', octal = '', hex = '';

  void convert(String value){
    int num = int.tryParse(value) ?? 0;
    setState(() {
      binary = num.toRadixString(2);
      octal = num.toRadixString(8);
      hex = num.toRadixString(16).toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Decimal'),
              onChanged: convert,
            ),
            const SizedBox(height: 30),
            Text('Binary: $binary'),
            Text('Octal: $octal'),
            Text('Hex: $hex'),
          ],
        ),
      ),
    );
  }
}
