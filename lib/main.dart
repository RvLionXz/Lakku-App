import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_expanses.dart';
import 'pages/login_page.dart';
import 'package:lakku_app/services/user_service.dart';

Future<bool> checkLoginStatus() async {
  UserService userService = UserService();
  final idUser = await userService.getUserId();
  return idUser != null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await checkLoginStatus();

  runApp(MaterialApp(home: isLoggedIn ? HomePage() : LoginPage()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {'/add': (context) => AddPages()},
    );
  }
}
