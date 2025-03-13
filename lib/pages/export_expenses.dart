import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:expense/controllers/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:xml/xml.dart' as xml;

class ExportExpenses extends StatelessWidget {
  const ExportExpenses({super.key});
  // TODO(1): Implement Validation so that fromDate can't be higher than toDate
  // TODO(2): Enable user to enter filename for exportCSV, exportJSON
  Future<void> requestStoragePermission() async {
    // Check & request storage permission
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }

    // Request Manage External Storage for Android 11+
    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
    if (await Permission.storage.isPermanentlyDenied) {
      await openAppSettings();
    }

  }
  Future<void> exportXML(String fromDate, String toDate) async {
    requestStoragePermission();
    ExpensesController c = Get.find();
    final builder = xml.XmlBuilder();
    List<Map<String,dynamic>> maps= <Map<String,dynamic>>[];
    if(fromDate =="0000-00-00" || toDate == "0000-00-00") {
      for(var q in await c.fetchExpenses()){
        maps.add(q.toMap());
      }
    }else{
      maps = await c.findInDateRange(fromDate, toDate);
    }
    builder.processing("xml", 'version="1.0" encoding="UTF-8"');
    builder.element("expenses",nest:(){
      for(var item in maps) {
        builder.element("expense", nest: () {
          item.forEach((key, value) => builder.element(key, nest: value));
        });
      }
    });

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if(selectedDirectory != null){
      String filePath = '$selectedDirectory/fff.xml';
      File file = File(filePath);
      await file.writeAsString(builder.buildDocument().toXmlString());
      Get.snackbar("XML Written Successfully", "Path $filePath");
    }
  }
  Future<void> exportCSV(String fromDate, String toDate) async {
    requestStoragePermission();
    ExpensesController c = Get.find();
    List<List> data=<List>[];
    data.add(["id","name","amount","currency","paymentMethod","date","time","createdAt"]);
    List<Map<String,dynamic>> maps = <Map<String,dynamic>>[];
    if(fromDate =="0000-00-00" || toDate == "0000-00-00") {
      for(var q in await c.fetchExpenses()){
        maps.add(q.toMap());
      }
      for(var item in maps){
        data.add(item.entries.map((d) => d.value).toList());
      }
    }else{
      final maps = await c.findInDateRange(fromDate, toDate);
      for(var item in maps){
        data.add(item.entries.map((d) => d.value).toList());
      }
    }

    var d = const ListToCsvConverter().convert(data);
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if(selectedDirectory != null){
      String filePath = '$selectedDirectory/fff.csv';
      File file = File(filePath);
      await file.writeAsString(d);
      Get.snackbar("CSV Written Successfully", "Path $filePath");
    }
  }
  @override
  Widget build(BuildContext context) {
    Rx<String>? fromDate = "0000-00-00".obs;
    Rx<String>? toDate = "0000-00-00".obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export Expenses"),
      ),
      drawer: DrawerWidget(key: key),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Table(
            children: [
              TableRow(children: [
                const Text("From Date: "),
                ElevatedButton(onPressed: () async {
                  DateTime? dateChosen = await showDatePicker(context: context,
                      firstDate: DateTime(1900,01,01), lastDate: DateTime(3000,01,01));
                  if(dateChosen != null){
                    fromDate.value = "${dateChosen.year}-${dateChosen.month.toString().padLeft(2,'0')}-${dateChosen.day.toString().padLeft(2,'0')}";
                  }
                }, child: Obx(() => Text(fromDate.value)))
              ],),
              TableRow(children: [
                const Text("To Date: "),
                ElevatedButton(onPressed: () async {
                  DateTime? dateChosen = await showDatePicker(context: context,
                      firstDate: DateTime(1900,01,01), lastDate: DateTime(3000,01,01));
                  if(dateChosen != null){
                    toDate.value = "${dateChosen.year}-${dateChosen.month.toString().padLeft(2,'0')}-${dateChosen.day.toString().padLeft(2,'0')}";
                  }
                }, child: Obx(() => Text(toDate.value)))
              ],),
              TableRow(children: [
                ElevatedButton(onPressed: (){
                  exportCSV(fromDate.value, toDate.value);
                }, child: const Text("Export To CSV")),
                ElevatedButton(onPressed: (){
                  exportXML(fromDate.value, toDate.value);
                }, child: const Text("Export To XML")),
              ],),
            ],
          )
        )
      ),
    );
  }
}
