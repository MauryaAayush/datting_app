import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          color: Colors.red,
          child: Image.asset(
            'assets/onboarding_1.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
