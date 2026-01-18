import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth; // For Authentication
import 'package:cloud_firestore/cloud_firestore.dart';    // For Database
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
            onPressed: () async {
              try {
                // 1. Create the user in Firebase Auth [cite: 104, 105]
                auth.UserCredential credential = await auth.FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: email.text.trim(),
                  password: password.text.trim(),
                );

                // 2. Create the User object using the Firebase UID [cite: 104, 105]
                User newUser = User(
                  userId: credential.user!.uid, 
                  name: name.text,
                  studentId: studentId.text,
                  nic: nic.text,
                  contact: contact.text,
                  email: email.text.trim(),
                );

                // 3. Save profile to Firestore 'users' collection [cite: 104, 105]
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(credential.user!.uid)
                    .set(newUser.toMap());

                // 4. Set the global session and navigate [cite: 106]
                CurrentUser.user = newUser;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${e.toString()}")),
                );
              }
            },
            child: const Text("Create Account"),
          ),
        ],
      ),
    );
  }
}