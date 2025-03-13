import 'package:expense/controllers/expenses_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class Add extends StatelessWidget {
  final RxString time = "Choose Time".obs;
  final RxString date = "Choose Date".obs;
  final RxString paymentMethod = "Cash".obs;
  final RxString unit = "Dollar".obs;
  final RxString name = "".obs;
  final RxString amount = "".obs;

  Add({super.key});

  @override
  Widget build(BuildContext context) {
    ExpensesController c = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
          onPressed: () => Get.toNamed("/expenses"),
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
                                      initialDate: DateTime(DateTime.now().year),
                                      firstDate: DateTime(1800),
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
                  onChanged: (text) {
                    name.value = text;
                  },
                  decoration: const InputDecoration(labelText: "Expense Name")),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                        onChanged: (value) => amount.value = value,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]*'))
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(labelText: "Amount")),
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
                child: Obx(() => Text(paymentMethod.value)),
              ),
              const SizedBox(width: 10, height: 10),
              TextButton(
                onPressed: () {
                  const Uuid uuid = Uuid();
                  if (name.value.isEmpty ||
                      amount.value.isEmpty ||
                      paymentMethod.value.isEmpty ||
                      unit.value.isEmpty ||
                      date.value.isEmpty ||
                      time.value.isEmpty) {
                    Get.snackbar("Error", "Please fill all the fields");
                    return;
                  }
                  Expense e = Expense(
                      id: uuid.v4().toString(),
                      amount: double.parse(amount.value),
                      paymentMethod: paymentMethod.value,
                      createdAt: DateTime.now(),
                      currency: unit.value,
                      date: date.value,
                      time: time.value,
                      name: name.value);
                    c.addExpense(e);
                  Navigator.pop(context);
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
    if(tod != null){
      time.value = formatTimeOfDay(tod);
    }
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
                  trailing: const Icon(Icons.euro),
                  leading: const Text("Euro"),
                  onTap: () {
                    unit.value = "EURO";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.currency_exchange),
                  leading: const Text("USD"),
                  onTap: () {
                    unit.value = "USD";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.currency_yen),
                  leading: const Text("YEN"),
                  onTap: () {
                    unit.value = "YEN";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.currency_franc),
                  leading: const Text("FRANC"),
                  onTap: () {
                    unit.value = "FRANC";
                    Navigator.pop(context);
                  },
                ),
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
                    paymentMethod.value = "Cash";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card_outlined),
                  title: const Text("Card"),
                  onTap: () {
                    paymentMethod.value = "Card";
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
