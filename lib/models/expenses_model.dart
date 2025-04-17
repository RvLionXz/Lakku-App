class Expenses {
  final int id;
  final int userId;
  final String category;
  final String description;
  final double? amount;
  final DateTime date;

  Expenses({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id_expenses'],
      userId: json['id_user'],
      category: json['category'],
      description: json['description'],
      amount:
          json['amount'] != null
              ? double.tryParse(json['amount'].toString())
              : null,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': userId,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
