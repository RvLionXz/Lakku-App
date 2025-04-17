class Expenses {
  final int id;
  final int userId;
  final int categoryId;
  final String description;
  final double amount;
  final DateTime date;

  Expenses({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id_expenses'],
      userId: json['id_user'],
      categoryId: json['id_category'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Object? toJson() {}
}
