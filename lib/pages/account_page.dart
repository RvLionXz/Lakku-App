import 'package:flutter/material.dart';
import 'package:lakku_app/services/user_service.dart';
import 'package:lakku_app/pages/login_page.dart';

class AccountPages extends StatefulWidget {
  const AccountPages({super.key});

  @override
  State<AccountPages> createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  String username = "";
  UserService userService = UserService();

  void loadUsername() async {
    final userData = await userService.getUsername();
    setState(() {
      username = userData ?? "Guest";
    });
  }

  void handleLogout() async {
    userService.logout();
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()) 
      );
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
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.face, size: 150, color: Colors.grey.shade400),
                Text("Username"),
                Text(
                  username,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleLogout,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 2,
                        color: Color(0xFF6665E7)
                      ),
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
