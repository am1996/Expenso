// ignore: file_names
class Expense {
  int id;
  String title;
  double expense;
  DateTime createdAt;
  Expense({
    required this.id,
    required this.title,
    required this.expense,
    required this.createdAt,
  });

  Map<String, Object> toMap() {
    return {
      "id": id,
      "title": title,
      "expense": expense,
      "created_at": createdAt.toString(),
    };
  }
}
