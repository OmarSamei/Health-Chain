import 'package:flutter/material.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors Page"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("Welcome to Doctors Page!", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
