import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                debugPrint("Done");
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: DrawerWidget(key: key),
      body: const Center(
        child: Text("Preferences"),
      ),
    );
  }
}
