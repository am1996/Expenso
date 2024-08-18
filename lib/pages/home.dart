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
            const ListTile(
              title: Text("Expense"),
              trailing: Text("1.0.0"),
              shape: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            const ListTile(
              title: Text(
                "Management",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12),
              ),
              textColor: Colors.black54,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Preferences'),
              onTap: () {
                debugPrint("hello world");
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete & Restore'),
              onTap: () {
                debugPrint("hello world");
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                debugPrint("tabbed");
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Feedback'),
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
