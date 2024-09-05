import 'package:get/get.dart';

class ExpensesController extends GetxController {
  var count = 0.obs;

  increment() => count++;

  decrement() => count--;
}
