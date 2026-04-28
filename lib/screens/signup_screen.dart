import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth; 
import 'package:cloud_firestore/cloud_firestore.dart';    
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Join Freecycle Corner",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Fill in your details to get started",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Personal Information",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: name, 
                        decoration: const InputDecoration(labelText: "Full Name", prefixIcon: Icon(Icons.person_outline)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: studentId, 
                        decoration: const InputDecoration(labelText: "Student ID", prefixIcon: Icon(Icons.badge_outlined)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: nic, 
                        decoration: const InputDecoration(labelText: "NIC", prefixIcon: Icon(Icons.credit_card_outlined)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: contact, 
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(labelText: "Contact Number", prefixIcon: Icon(Icons.phone_outlined)),
                      ),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(),
                      ),
                      
                      const Text(
                        "Account Information",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: email, 
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: "Email Address", prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: password, 
                        obscureText: true,
                        decoration: const InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.lock_outline)),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () async {
                          if (email.text.trim().isEmpty || password.text.trim().isEmpty || name.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please fill in required fields")),
                            );
                            return;
                          }
                          try {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(child: CircularProgressIndicator()),
                            );

                            //Create the user in Firebase Auth 
                            auth.UserCredential credential = await auth.FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );

                            //Create the User object using the Firebase UID
                            User newUser = User(
                              userId: credential.user!.uid, 
                              name: name.text,
                              studentId: studentId.text,
                              nic: nic.text,
                              contact: contact.text,
                              email: email.text.trim(),
                            );

                            //Save profile to Firestore 'users' collection
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(credential.user!.uid)
                                .set(newUser.toMap());

                            //Set the global session and navigate
                            CurrentUser.user = newUser;

                            Navigator.pop(context); // Close loading dialog

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          } catch (e) {
                            Navigator.pop(context); // Close loading dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        },
                        child: const Text("Create Account"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}