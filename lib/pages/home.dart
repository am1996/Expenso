import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/expenses_controller.dart';
import 'package:myapp/widgets/drawer.dart';
import 'package:myapp/db/expenses_db.dart';

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
              onPressed: () async {
                DB db = DB();
                Get.snackbar("title", await db.getNotes(),
                    snackPosition: SnackPosition.BOTTOM);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Obx(
          () => Text("${c.count}", style: const TextStyle(fontSize: 50.4)),
        ),
      ),
    );
  }
}
