import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("Welcome to Profile Page!", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
