import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: const Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(),
            TextField(),
          ],
        ),
      ),
    );
  }
}
