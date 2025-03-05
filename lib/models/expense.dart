// ignore: file_names
import 'package:intl/intl.dart';

class Expense {
  String id;
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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'currency': currency,
      'paymentMethod': paymentMethod,
      'date': date,
      'time': time,
      'createdAt': createdAt.toString(),
    };
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "currency": currency,
      "paymentMethod": paymentMethod,
      "date": date,
      "time": time,
      "createdAt": createdAt.toString(),
    };
  }
  factory Expense.fromMap(Map<String, dynamic> data) {
    return Expense(
      id: data["id"] as String,
      name: data["name"] as String,
      amount: data["amount"] as double,
      currency: data["currency"] as String,
      paymentMethod: data["paymentMethod"] as String,
      date: data["date"] as String,
      time: data["time"] as String,
      createdAt: DateFormat("yyyy-MM-dd").parse(data["createdAt"] as String),
    );
  }
}
