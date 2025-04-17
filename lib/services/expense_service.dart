import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lakku_app/models/expenses_model.dart';
import 'package:lakku_app/services/user_service.dart';

class ExpenseService {
  final String baseUrl = "http://47.250.187.233:80";

  //Get data from API
  Future<List<Expenses>> fetchExpenses() async {
    final response = await http.get(Uri.parse('$baseUrl/expenses'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // print(data);
      return data.map((json) => Expenses.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load expenses");
    }
  }

  //get total saldo
  Future<double?> getTotalExpenses(int userId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/expenses/total/$userId"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Response JSON: $data");

      return double.tryParse(data["total"].toString()) ?? 0.0;
    } else {
      print("Failed to load total expenses: ${response.statusCode}");
      throw Exception("Failed to load total expenses");
    }
  }

  //add expenses
  Future<void> addExpenses(Expenses expense) async {
    final response = await http.post(
      Uri.parse("$baseUrl/expenses"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(expense.toJson()),
    );

    if (response != 200) {
      throw Exception("Failed to add expenses");
    }
  }

  //get expenses
}
