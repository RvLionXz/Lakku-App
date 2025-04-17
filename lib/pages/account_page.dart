import 'package:flutter/material.dart';
import 'package:lakku_app/models/users_model.dart';
import 'package:lakku_app/services/user_service.dart';

class AccountPages extends StatefulWidget {
  const AccountPages({super.key});

  @override
  State<AccountPages> createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  String username = "";

  void loadUsername() async {
    UserService userService = UserService();

    final userData = await userService.getUsername();
    setState(() {
      username = userData ?? "Guest";
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.face, size: 100, color: Colors.grey.shade400),
              Text("Username"),
              Text(
                username,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
