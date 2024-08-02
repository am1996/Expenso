import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
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
