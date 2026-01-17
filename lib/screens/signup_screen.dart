import 'package:flutter/material.dart';
import '../classes/user.dart';
import '../auth/current_user.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final name = TextEditingController();
  final studentId = TextEditingController();
  final nic = TextEditingController();
  final contact = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: "Full Name")),
          TextField(controller: studentId, decoration: const InputDecoration(labelText: "Student ID")),
          TextField(controller: nic, decoration: const InputDecoration(labelText: "NIC")),
          TextField(controller: contact, decoration: const InputDecoration(labelText: "Contact Number")),
          TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
          TextField(controller: password, decoration: const InputDecoration(labelText: "Password"), obscureText: true),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              // Create user
              CurrentUser.user = User(
                userId: DateTime.now().millisecondsSinceEpoch,
                name: name.text,
                studentId: studentId.text,
                nic: nic.text,
                contact: contact.text,
                email: email.text,
                password: password.text,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: const Text("Create Account"),
          ),
        ],
      ),
    );
  }
}
