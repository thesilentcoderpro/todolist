import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final controller = TextEditingController();

  void submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form Submitted: ${controller.text}'),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 600, left: 20, right: 20),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Form')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter Name'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}