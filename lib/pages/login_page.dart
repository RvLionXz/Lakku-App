import 'package:flutter/material.dart';
import 'package:lakku_app/components/text_field.dart';
import 'package:lakku_app/models/users_model.dart';
import 'package:lakku_app/services/user_service.dart';
import 'register_page.dart';
import 'package:lakku_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = "";

  void handleLogin() async {
    UserService userService = UserService();
    User? response = await userService.userLogin(
      emailController.text,
      passwordController.text,
    );

    if (response != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        message = "Login gagal, periksa Email dan Password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Lakku Logo.png", width: 200),
                SizedBox(height: 30),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                NormalForm(
                  label: "Username",
                  prefixText: "",
                  suffixIcon: Icons.login_outlined,
                  controller: emailController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                NormalForm(
                  label: "Password",
                  prefixText: "",
                  suffixIcon: Icons.password,
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Text(message),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6665E7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Belum Punya Akun?, Daftar Disini",
                    style: TextStyle(decoration: TextDecoration.underline),
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
