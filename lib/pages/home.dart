import 'dart:convert';
import 'dart:developer';
import 'package:expense/controllers/expenses_controller.dart';
import 'package:expense/db/expenses_db.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    Rx<String> text = "".obs;
    Rx<bool> isSearching = false.obs;
    return Scaffold(
      drawer: DrawerWidget(key: key),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed("/home/add"),
      ),
      appBar: AppBar(
        title: Obx(() => isSearching.isTrue ? TextField(
            controller: searchController,
            autofocus: true,
            onSubmitted: (String a){
              final query = searchController.text.toString();
              Get.toNamed("/home/search",arguments: {
                "query":query
              });
            },
            decoration: const InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
            ),
        ) : const Text("Home")),
        actions: <Widget>[
          Obx(() => isSearching.isTrue ?
          IconButton(
              onPressed: () async {
                isSearching.value = false;
              },
              icon: const Icon(Icons.close))
              :
          IconButton(
              onPressed: () async {
                isSearching.value = true;
              },
              icon: const Icon(Icons.search)))
        ],
      ),
      body: const FutureList(),
    );
  }
}
class FutureList extends StatelessWidget {
  const FutureList({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesController c = Get.find();
    return FutureBuilder<List<Expense>>(
        future: c.fetchExpenses(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text("Error occurred!", style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700
        )));
      }
      return Obx(() {
        if (c.expenses.isEmpty) {
          return const Center(child: Text("No Expenses Found!"),);
        }
        return ListView.builder(itemCount: c.expenses.length,itemBuilder: (context, index) {
          return ListTile(title: Text(c.expenses[index].name),onTap: (){
            Get.toNamed("/home/details",arguments: {
              "e": c.expenses[index]
            });
          },trailing: IconButton(onPressed: (){
            c.deleteExpense(c.expenses[index]);
          },icon: const Icon(Icons.delete),),);
        });
      });
    });
  }
}