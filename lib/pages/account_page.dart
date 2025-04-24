import 'package:flutter/material.dart';
import 'package:lakku_app/services/user_service.dart';
import 'package:lakku_app/pages/login_page.dart';
import 'package:lakku_app/components/mountly_history.dart';

class AccountPages extends StatefulWidget {
  const AccountPages({super.key});

  @override
  State<AccountPages> createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  String username = "";
  String email = "";
  UserService userService = UserService();

  void loadUsername() async {
    final userName = await userService.getUsername();
    setState(() {
      username = userName ?? "Guest";
    });
  }

  void loadEmail() async {
    final userEmail = await userService.getEmail();
    setState(() {
      email = userEmail ?? "no email";
    });
  }

  void handleLogout() async {
    userService.logout();
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadEmail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.face, size: 150, color: Colors.grey.shade400),
                Text("User Information"),
                Text(
                  username,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(email),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF6665E7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Ringkasan Pengeluaran Bulanan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MountlyHistory(),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleLogout,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: Color(0xFF6665E7)),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6665E7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
