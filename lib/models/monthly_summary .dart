class MonthlySummary {
  final int year;
  final int month;
  final String monthName;
  final double totalAmount;

  MonthlySummary({
    required this.year,
    required this.month,
    required this.monthName,
    required this.totalAmount,
  });

  factory MonthlySummary.fromJson(Map<String, dynamic> json) {
    return MonthlySummary(
      year: json['year'],
      month: json['month'],
      monthName: json['month_name'] ?? '',
      totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0.0,
    );
  }
}
