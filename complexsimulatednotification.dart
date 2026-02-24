import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const AdvancedFormPage(),
    );
  }
}

class AdvancedFormPage extends StatefulWidget {
  const AdvancedFormPage({super.key});

  @override
  State<AdvancedFormPage> createState() => _AdvancedFormPageState();
}

class _AdvancedFormPageState extends State<AdvancedFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  String gender = "Male";
  String selectedCity = "Chennai";

  void submit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text("🎉 Form Submitted"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${nameController.text}"),
              Text("Email: ${emailController.text}"),
              Text("Phone: ${phoneController.text}"),
              Text("Gender: $gender"),
              Text("City: $selectedCity"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetForm();
                showSnack();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  void showSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Notification: Your data was saved successfully"),
        behavior: SnackBarBehavior.floating,
        margin:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    setState(() {
      gender = "Male";
      selectedCity = "Chennai";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Advanced Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "User Registration",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Enter your name" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (v) =>
                        !v!.contains("@") ? "Enter valid email" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (v) =>
                        v!.length < 10 ? "Enter valid phone" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: addressController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: "Address",
                      prefixIcon: Icon(Icons.home),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Text("Gender: "),
                      Radio(
                          value: "Male",
                          groupValue: gender,
                          onChanged: (v) =>
                              setState(() => gender = v!)),
                      const Text("Male"),
                      Radio(
                          value: "Female",
                          groupValue: gender,
                          onChanged: (v) =>
                              setState(() => gender = v!)),
                      const Text("Female"),
                    ],
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField(
                    value: selectedCity,
                    items: ["Chennai", "Mumbai", "Delhi"]
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => selectedCity = v!),
                    decoration:
                        const InputDecoration(labelText: "City"),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}