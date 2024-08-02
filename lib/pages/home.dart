import 'package:flutter/material.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:354612783.
class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('This is the home page.'),
      ),
    );
  }
}
