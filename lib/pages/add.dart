import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/db/expenses_db.dart';
import 'package:myapp/models/expense.dart';

class Add extends StatelessWidget {
  final RxString time = "Choose Time".obs;
  final RxString date = "Choose Date".obs;
  final RxString paymentCategory = "Choose Payment Category".obs;
  final RxString currency = "Choose Currency".obs;
  final RxString amount = "".obs;
  final RxString name = "".obs;

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
                                      initialDate:
                                          DateTime(DateTime.now().year),
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
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (text) {
                  name.value = text;
                },
              ),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      decoration: const InputDecoration(labelText: "Amount"),
                      onChanged: (text) {
                        amount.value = text;
                      },
                    ),
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
                      child: Obx(() => Text(currency.value)),
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
                onPressed: () {
                  Expense e = Expense(
                      id: 1,
                      name: name.value,
                      amount: double.parse(amount.value),
                      currency: currency.value,
                      paymentMethod: paymentCategory.value,
                      date: date.value,
                      time: time.value,
                      createdAt: DateTime.now());
                  DB db = DB();
                  db.insertOne(e);
                  Get.toNamed("/home");
                },
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
                  trailing: const Icon(Icons.currency_exchange_rounded),
                  leading: const Text("Dollar"),
                  onTap: () {
                    currency.value = "Dollar";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing:
                      const Icon(IconData(0xe23b, fontFamily: 'MaterialIcons')),
                  leading: const Text("Euro"),
                  onTap: () {
                    currency.value = "Euro";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.currency_franc),
                  leading: const Text("Franc"),
                  onTap: () {
                    currency.value = "Franc";
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.currency_rupee),
                  leading: const Text("Rupee"),
                  onTap: () {
                    currency.value = "Rupee";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.currency_ruble),
                  leading: const Text("Ruble"),
                  onTap: () {
                    currency.value = "Ruble";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(
                      IconData(0xf04e3, fontFamily: 'MaterialIcons')),
                  leading: const Text("Yuan"),
                  onTap: () {
                    currency.value = "Yuan";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(
                      IconData(0xf04df, fontFamily: 'MaterialIcons')),
                  leading: const Text("Pound"),
                  onTap: () {
                    currency.value = "Pound";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(
                      IconData(0xf04e2, fontFamily: 'MaterialIcons')),
                  leading: const Text("Yen"),
                  onTap: () {
                    currency.value = "Yen";
                    Navigator.pop(context);
                  },
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
