import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(Icons.arrow_right_alt_sharp),
            title: const Text("Income"),
            onTap: () {
              if(Get.currentRoute != "/income"){
                Get.toNamed("/income");
              }else{
                Get.back();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_export),
            title: const Text("Export Income"),
            onTap: (){
              if(Get.currentRoute != "/income/export") {
                Get.toNamed("/income/export");
              } else{
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }
}
