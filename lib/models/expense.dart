// ignore: file_names
import 'package:intl/intl.dart';

class Expense {
  int? id;
  String name;
  double amount;
  String currency;
  String paymentMethod;
  String date;
  String time;
  DateTime createdAt;

  Expense({
    this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.date,
    required this.time,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "amount": amount.toString(),
      "currency": currency,
      "paymentMethod": paymentMethod,
      "date": date,
      "time": time,
      "created_at": createdAt.toString(),
    };
  }

  Expense fromMap(Map<String, dynamic> data) {
    return Expense(
      id: data["id"],
      name: data["name"],
      amount: data["amount"],
      currency: data["currency"],
      paymentMethod: data["paymentMethod"],
      date: data["date"],
      time: data["time"],
      createdAt: DateFormat("yyyy-MM-dd").parse(data["created_at"]),
    );
  }
}
