import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Add extends StatelessWidget {
  final RxString time = "Choose Time".obs;
  final RxString date = "Choose Date".obs;
  final RxString paymentCategory = "Choose Payment Category".obs;
  final RxString unit = "Choose Currency".obs;

  Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
          onPressed: () => Get.toNamed("/home"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CalendarDatePicker(
                                      initialDate: DateTime(2024),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(3000),
                                      onDateChanged: (DateTime ddd) {
                                        date.value = DateFormat("yyyy-MM-dd")
                                            .format(ddd);
                                        Get.back();
                                      }),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Close"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          Obx(() => Text(date.value))
                        ],
                      )),
                  TextButton(
                      onPressed: () {
                        _showTime(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.timer_sharp),
                          Obx(() => Text(time.value))
                        ],
                      ))
                ],
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Expense Name"),
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 7,
                    child: TextField(
                        decoration: InputDecoration(labelText: "Amount")),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      onPressed: () {
                        _showBottomSheetToChooseCurrency(context);
                      },
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      child: Obx(() => Text(unit.value)),
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  _showBottomSheetToChoosePaymentMethod(context);
                },
                style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: Obx(() => Text(paymentCategory.value)),
              ),
              const SizedBox(width: 10, height: 10),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Add Expense"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showTime(BuildContext context) async {
    TimeOfDay? tod = await showTimePicker(
        context: context, initialTime: const TimeOfDay(hour: 12, minute: 00));
    time.value = formatTimeOfDay(tod as TimeOfDay);
  }

  void _showBottomSheetToChooseCurrency(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const ListTile(
                  trailing: Text("Currency"),
                ),
                ListTile(
                  trailing: const Icon(Icons.abc),
                  onTap: () {},
                )
              ],
            ),
          );
        });
  }

  void _showBottomSheetToChoosePaymentMethod(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const ListTile(
                  trailing: Text("Categories"),
                ),
                ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text("Cash"),
                  onTap: () {
                    paymentCategory.value = "Cash";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card_outlined),
                  title: const Text("Card"),
                  onTap: () {
                    paymentCategory.value = "Card";
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }

  String formatTimeOfDay(TimeOfDay timeOfDay, {String format = 'hh:mm a'}) {
    final formatter = DateFormat(format);
    return formatter
        .format(DateTime(1970, 1, 1, timeOfDay.hour, timeOfDay.minute));
  }
}
