import 'package:expense/controllers/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesController c = Get.find();
    final data = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_sharp),
            onPressed: () => Get.toNamed("/expenses"),
          ),
        ),
        body: Column(
            children: [
              const Text("Details",style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30
              ),),
              Padding(
                padding: const EdgeInsets.all(30),
                child: data != null ? Table(children: [
                  TableRow(children: [
                    const Text("ID",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(data["e"].id),
                  ]),
                  TableRow(children: [
                    const Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(data["e"].name),
                  ]),
                  TableRow(children: [
                    const Text("Amount: ",style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${data["e"].amount} ${data['e'].currency}"),
                  ]),
                  TableRow(children: [
                    const Text("Date: ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("${data["e"].date}"),
                  ]),
                  TableRow(children: [
                    const Text("Time: ",style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${data["e"].time}"),
                  ]),
                  TableRow(children: [
                    const Text("Created At: ",style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${data["e"].createdAt}"),
                  ]),
                  TableRow(children: [
                    const Text(""),
                    IconButton(onPressed: (){
                      c.deleteExpense(data['e']);
                      Get.back();
                    }, icon: const Icon(Icons.delete))
                  ]),
                ],) : const Text("No data or details"),
              ),]
        )
    );
  }
}
