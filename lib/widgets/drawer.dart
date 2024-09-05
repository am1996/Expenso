import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/expenses_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensesController c = Get.find();
    return Drawer(
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
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Get.toNamed("/home");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Preferences'),
            onTap: () {
              Get.toNamed("/home/preferences");
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete and Restore'),
            onTap: () {
              Get.toNamed("/home/deleterestore");
            },
          )
        ],
      ),
    );
  }
}
