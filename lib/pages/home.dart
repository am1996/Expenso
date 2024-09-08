import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/expenses_controller.dart';
import 'package:myapp/widgets/drawer.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:354612783.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpensesController c = Get.find();
    return Scaffold(
      drawer: DrawerWidget(key: key),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed("/home/add"),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.snackbar("title", "hello world",
                    snackPosition: SnackPosition.BOTTOM);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Obx(
          () => Text(
            "${c.count}",
            style: const TextStyle(fontSize: 50.4),
          ),
        ),
      ),
    );
  }
}
