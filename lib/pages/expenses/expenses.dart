import 'package:expense/controllers/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/drawer.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});
  void modDay(Rx<String> date, String sign, int n) {
    DateTime d = DateFormat("dd-MM-yyyy").parse(date.value);
    if (sign == "-") {
      d = d.subtract(const Duration(days: 1));
    } else {
      d = d.add(const Duration(days: 1));
    }
    int days = d.day;
    int months = d.month;
    int year = d.year;
    date.value =
        "${days.toString().padLeft(2, '0')}-${months.toString().padLeft(2, '0')}-${year.toString()}";
  }

  void modYear(Rx<String> date, String sign, int n) {
    DateTime d = DateFormat("yyyy").parse(date.value);
    int year = d.year;
    if (sign == "-") {
      year -= 1;
    } else {
      year += 1;
    }
    date.value = year.toString();
  }

  void modMonth(Rx<String> date, String sign, int n) {
    DateTime d = DateFormat("MM-yyyy").parse(date.value);
    int year = d.year;
    int months = d.month;
    if (sign == "-") {
      months = d.month - 1 == 0 ? 12 : d.month - 1;
      if (months == 12) year -= 1;
    } else {
      months = d.month + 1 == 13 ? 1 : d.month + 1;
      if (months == 1) year += 1;
    }
    date.value = "${months.toString().padLeft(2, '0')}-${year.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    ExpensesController c = Get.find();
    TextEditingController searchController = TextEditingController();

    Rx<bool> isSearching = false.obs;
    return Scaffold(
      drawer: DrawerWidget(key: key),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed("/expenses/add"),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: [
            AppBar(
              title: Obx(() => isSearching.isTrue
                  ? TextField(
                      controller: searchController,
                      autofocus: true,
                      onSubmitted: (String a) {
                        final query = searchController.text.toString();
                        c.searchExpense("name", query);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                      ),
                    )
                  : const Text("Expenses")),
              actions: <Widget>[
                Obx(() => isSearching.isTrue
                    ? IconButton(
                        onPressed: () async {
                          isSearching.value = false;
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        onPressed: () async {
                          isSearching.value = true;
                        },
                        icon: const Icon(Icons.search)))
              ],
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (c.chosenFilter.value == "Year") {
                          modYear(c.date, "-", 1);
                          c.searchExpense("date", c.date.value);
                        } else if (c.chosenFilter.value == "Month") {
                          modMonth(c.date, "-", 1);
                          DateTime ddd =
                              DateFormat("MM-yyyy").parse(c.date.value);
                          c.searchExpense("date",
                              "${ddd.year}-${ddd.month.toString().padLeft(2, '0')}");
                        } else if (c.chosenFilter.value == "Day") {
                          modDay(c.date, "-", 1);
                          DateTime ddd =
                              DateFormat("dd-MM-yyyy").parse(c.date.value);
                          c.searchExpense("date",
                              "${ddd.year}-${ddd.month.toString().padLeft(2, '0')}-${ddd.day.toString().padLeft(2, '0')}");
                        }
                      },
                      icon: const Icon(Icons.arrow_circle_left)),
                  const Spacer(),
                  Obx(() => Text(c.date.value,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold))),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        if (c.chosenFilter.value == "Year") {
                          modYear(c.date, "+", 1);
                          c.searchExpense("date", c.date.value);
                        } else if (c.chosenFilter.value == "Month") {
                          modMonth(c.date, "+", 1);
                          DateTime ddd =
                              DateFormat("MM-yyyy").parse(c.date.value);
                          c.searchExpense("date",
                              "${ddd.year}-${ddd.month.toString().padLeft(2, '0')}");
                        } else if (c.chosenFilter.value == "Day") {
                          modDay(c.date, "+", 1);
                          DateTime ddd =
                              DateFormat("dd-MM-yyyy").parse(c.date.value);
                          c.searchExpense("date",
                              "${ddd.year}-${ddd.month.toString().padLeft(2, '0')}-${ddd.day.toString().padLeft(2, '0')}");
                        }
                      },
                      icon: const Icon(Icons.arrow_circle_right)),
                  Obx(
                    () => DropdownButton(
                        items: const [
                          DropdownMenuItem(value: "All", child: Text("All")),
                          DropdownMenuItem(value: "Day", child: Text("Day")),
                          DropdownMenuItem(
                              value: "Month", child: Text("Month")),
                          DropdownMenuItem(value: "Year", child: Text("Year")),
                        ],
                        value: c.chosenFilter.value,
                        onChanged: (String? value) {
                          c.chosenFilter.value = value ?? "Month";
                          if (c.chosenFilter.value == "Month") {
                            DateTime ddd = DateTime.now();
                            c.date.value =
                                DateFormat('MM-yyyy').format(ddd).toString();
                            c.searchExpense("date",
                                "${ddd.year}-${ddd.month.toString().padLeft(2, '0')}");
                          } else if (c.chosenFilter.value == "Year") {
                            c.date.value = DateFormat('yyyy')
                                .format(DateTime.now())
                                .toString();
                            c.searchExpense("date", c.date.value);
                          } else if (c.chosenFilter.value == "Day") {
                            DateTime ddd = DateTime.now();
                            c.date.value =
                                DateFormat('dd-MM-yyyy').format(ddd).toString();
                            c.searchExpense("date",
                                "${ddd.year}-${ddd.month.toString().padLeft(2, '0')}-${ddd.day.toString().padLeft(2, '0')}");
                          } else {
                            c.date.value = "00-00-0000";
                            c.fetchExpenses();
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
        if (c.expenses.isEmpty) {
          return const Center(
            child: Text(
              "No expenses found",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          );
        }
        return ListView.builder(
            itemCount: c.expenses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(c.expenses[index].name),
                onTap: () {
                  Get.toNamed("/expenses/details",
                      arguments: {"e": c.expenses[index]});
                },
                trailing: IconButton(
                  onPressed: () {
                    c.deleteExpense(c.expenses[index]);
                    if(c.date.value == "00-00-0000") {
                      c.fetchExpenses();
                    } else {
                      c.searchExpense("date", c.date.value);
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            });
      }),
    );
  }
}
