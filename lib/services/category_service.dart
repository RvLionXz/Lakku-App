import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lakku_app/models/category_model.dart';

class CategoryService {
  final String baseUrl = "http://47.250.187.233:80";

  //Get data from API
  Future<List<Category>> fetchUser() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load category");
    }
  }
}
