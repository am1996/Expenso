import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';

class ExportIncome extends StatelessWidget {
  const ExportIncome({super.key});
  // TODO(1): Implement Validation so that fromDate can't be higher than toDate
  Future<void> exportCSV() async {

  }
  @override
  Widget build(BuildContext context) {
    Rx<String>? fromDate = "00-00-0000".obs;
    Rx<String>? toDate = "00-00-0000".obs;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                debugPrint("Done");
              },
              icon: const Icon(Icons.search))
        ],
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
                    fromDate.value = "${dateChosen.day.toString().padLeft(2,'0')}-${dateChosen.month.toString().padLeft(2,'0')}-${dateChosen.year}";
                  }
                }, child: Obx(() => Text(fromDate.value)))
              ],),
              TableRow(children: [
                const Text("To Date: "),
                ElevatedButton(onPressed: () async {
                  DateTime? dateChosen = await showDatePicker(context: context,
                      firstDate: DateTime(1900,01,01), lastDate: DateTime(3000,01,01));
                  if(dateChosen != null){
                    toDate.value = "${dateChosen.day.toString().padLeft(2,'0')}-${dateChosen.month.toString().padLeft(2,'0')}-${dateChosen.year}";
                  }
                }, child: Obx(() => Text(toDate.value)))
              ],),
              TableRow(children: [
                ElevatedButton(onPressed: (){}, child: const Text("Export To CSV")),
                ElevatedButton(onPressed: (){}, child: const Text("Export To XML")),
              ],),
            ],
          )
        )
      ),
    );
  }
}
