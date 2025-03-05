import 'package:expense/controllers/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesController c = Get.find();
    final Map<String, dynamic> data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
          onPressed: () => Get.toNamed("/home"),
        ),
      ),
      body: Center(child: Text(data["e"].title),),
    );
  }
}
