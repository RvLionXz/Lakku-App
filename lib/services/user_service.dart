import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lakku_app/models/users_model.dart';
import 'package:lakku_app/pages/home_page.dart';

class UserService {
  final String baseUrl = "http://47.250.187.233:80";

  //Get data from API
  Future<List<User>> fetchUser() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  //Register Service
  Future<String> userRegister(
    String username,
    String password,
    String email,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "email": email,
      }),
    );

    if (response.statusCode == 200) {
      return "Registrasi berhasil!";
    } else if (response.statusCode == 400) {
      return "Gagal Registrasi, periksa kembali form registrasi!";
    } else {
      print(response.statusCode);
      return "Registrasi gagal!";
    }
  }

  //Login Service
  Future<User?> userLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      return User.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
