import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lakku_app/models/expenses_model.dart';

class ExpenseService {
  final String baseUrl = "http://47.250.187.233:80";

  // Get data from API
  Future<List<Expenses>> fetchExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/expenses'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((json) => Expenses.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load expenses");
    }
  }

  //get expenses
  Future<List<Expenses>> getExpenses(int userId) async {
    final response = await http.get(Uri.parse("$baseUrl/expenses/$userId"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Expenses.fromJson(json)).toList();
    } else {
      print("GAGAL TES : $response.statusCode");
      throw Exception("Gagal");
    }
  }

  // Get total saldo
  Future<double?> getTotalExpenses(int userId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/expenses/total/$userId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return double.tryParse(data["total"].toString()) ?? 0.0;
    } else {
      throw Exception("Failed to load total expenses");
    }
  }

  // Add expenses
  Future<void> addExpenses(Expenses expense) async {
    final response = await http.post(
      Uri.parse("$baseUrl/expenses"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(expense.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add expense");
    }
  }
}
