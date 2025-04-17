import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lakku_app/models/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return "Registrasi berhasil!";
    } else if (response.statusCode == 400) {
      return "Gagal Registrasi, periksa kembali form registrasi!";
    } else {
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
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String username = responseData['user']['username'] ?? "Guest";
      int id = responseData['user']['id_user'] ?? "Guest";

      // print("Username dari server: $username");
      await saveUserData(username, id);

      return User.fromJson(responseData['user']);
    } else {
      // print("Login gagal. Status code: ${response.statusCode}");
      return null;
    }
  }

  //save username
  Future<void> saveUserData(String username, int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await prefs.setInt("id_user", id);
    // print("USER NAME TERSIMPAN : $username");
  }

  //get username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    print("username nya adalah $username");
    return username;
  }

  //get user id
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt("id_user");
    // print("user id nya adalah $idUser");
    return idUser;
  }

}
