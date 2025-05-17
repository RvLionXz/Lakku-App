import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lakku_app/models/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrl = "http://47.250.187.233:3000";

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

    if (response.statusCode == 201 || response.statusCode == 200) {
      return "Registrasi berhasil!";
    } else if (response.statusCode == 400) {
      return "Email sudah terdaftar!";
    } else {
      print(response.statusCode);
      return "Gagal Registrasi, periksa kembali form registrasi!";
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
      int id = responseData['user']['id_user'] ?? "no id";
      String email = responseData['user']['email'] ?? "no email";

      // print("Username dari server: $username");
      await saveUserData(username, id, email);

      return User.fromJson(responseData['user']);
    } else {
      // print("Login gagal. Status code: ${response.statusCode}");
      return null;
    }
  }

  //save data user
  Future<void> saveUserData(String username, int id, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await prefs.setInt("id_user", id);
    await prefs.setString("email", email);
  }

  //get username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    // print("username nya adalah $username");
    return username;
  }

  //get user id
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt("id_user");
    // print("user id nya adalah $idUser");
    return idUser;
  }

  //remove user id
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("id_user");
  }

  //get user email
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString("email");
    print("USER EMAIL IS $userEmail");
    return userEmail;
  }
}
