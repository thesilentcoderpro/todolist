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
  String input = '';
  String output = '';

  void evaluate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() => output = result.toString());
    } catch (e) {
      setState(() => output = 'Error');
    }
  }

  Widget button(String text) => Expanded(
    child: ElevatedButton(
      onPressed: () {
        if (text == '=') {
          evaluate();
        } else if (text == 'C') {
          setState(() {
            input = '';
            output = '';
          });
        } else {
          setState(() => input += text);
        }
      },
      child: Text(text),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scientific Calculator')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(input, style: const TextStyle(fontSize: 22)),
          Text(output, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 20),
          Row(children: [button('7'), button('8'), button('9'), button('/')]),
          Row(children: [button('4'), button('5'), button('6'), button('*')]),
          Row(children: [button('1'), button('2'), button('3'), button('-')]),
          Row(children: [button('0'), button('.'), button('+'), button('=')]),
          Row(children: [button('sin('), button('cos('), button('sqrt('), button('C')]),
        ],
      ),
    );
  }
}