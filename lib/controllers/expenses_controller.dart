import 'package:expense/db/expenses_db.dart';
import 'package:get/get.dart';

import '../models/expense.dart';

class ExpensesController extends GetxController {
  var expenses = <Expense>[].obs;
  Rx<double> total = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    DateTime ddd = DateTime.now();
    searchExpense("date", "${ddd.year}-${ddd.month.toString().padLeft(2,'0')}");
  }
  Future<List<Expense>> fetchExpenses() async{
    List<Expense> data = await DB.getExpenses();
    expenses.value = data;
    return data;
  }
  Future<List<Expense>> searchExpense(String searched,String query) async{
    List<Expense> data = await DB.searchDB(searched,query);
    expenses.value = data;
    return data;
  }
  Future<List<Map<String,dynamic>>> findInDateRange(String fromDate, String toDate) async {
    final data = await DB.findInDateRange(fromDate, toDate);
    return data;
  }
  Future<void> addExpense(Expense expense) async {
    await DB.insertExpense(expense);
    DateTime ddd = DateTime.now();
    searchExpense("date", "${ddd.year}-${ddd.month.toString().padLeft(2,'0')}");
  }

  Future<void> deleteExpense(Expense e) async{
    await DB.deleteExpense(e);
  }
}
