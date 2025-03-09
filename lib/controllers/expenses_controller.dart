import 'package:expense/db/expenses_db.dart';
import 'package:get/get.dart';

import '../models/expense.dart';

class ExpensesController extends GetxController {
  var expenses = <Expense>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
  }
  Future<List<Expense>> fetchExpenses() async{
    List<Expense> data = await DB.getExpenses();
    expenses.value = data;
    return data;
  }
  Future<List<Expense>> searchExpense(String query) async{
    List<Expense> data = await DB.searchDB(query);
    expenses.value = data;
    return data;
  }
  Future<void> addExpense(Expense expense) async {
    await DB.insertExpense(expense);
    fetchExpenses();
  }
  Future<void> deleteExpense(Expense e) async{
    await DB.deleteExpense(e);
    fetchExpenses();
  }
}
