// ignore: file_names
import 'package:intl/intl.dart';

class Expense {
  int id;
  String name;
  double amount;
  String currency;
  String paymentMethod;
  String date;
  String time;
  DateTime createdAt;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.date,
    required this.time,
    required this.createdAt,
  });

  Map<String, Object> toMap() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "currency": currency,
      "paymentMethod": paymentMethod,
      "date": date,
      "time": time,
      "created_at": createdAt.toString(),
    };
  }

  Expense fromMap(Map<String, Object> data) {
    return Expense(
      id: data["id"] as int,
      name: data["name"] as String,
      amount: data["amount"] as double,
      currency: data["currency"] as String,
      paymentMethod: data["paymentMethod"] as String,
      date: data["date"] as String,
      time: data["time"] as String,
      createdAt: DateFormat("yyyy-MM-dd").parse(data["created_at"] as String),
    );
  }
}
