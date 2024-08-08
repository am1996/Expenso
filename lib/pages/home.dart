import 'package:flutter/material.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:354612783.
class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/pattern.jpg"),
                ),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                debugPrint("hello world");
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                debugPrint("tabbed");
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('This is the home page.'),
      ),
    );
  }
}
