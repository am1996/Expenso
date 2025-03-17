import 'package:expense/db/expenses_db.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpensesController extends GetxController {
  var expenses = <Expense>[].obs;
  Rx<String> date = DateFormat('MM-yyyy').format(DateTime.now()).obs;
  Rx<String> chosenFilter = "Month".obs;
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
    List<Expense> data = await DB.searchDBForExpenses(searched,query);
    expenses.value = data;
    return data;
  }
  Future<List<Map<String,dynamic>>> findInDateRange(String fromDate, String toDate) async {
    final data = await DB.findExpensesInDateRange(fromDate, toDate);
    return data;
  }
  Future<void> addExpense(Expense expense) async {
    await DB.insertExpense(expense);
  }

  Future<void> deleteExpense(Expense e) async{
    await DB.deleteExpense(e);
  }
}
