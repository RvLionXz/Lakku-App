import 'package:flutter/material.dart';
import 'package:lakku_app/components/text_field.dart';
import 'login_page.dart';
import 'package:lakku_app/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = "";

  void handleRegister() async {
    UserService userService = UserService();
    String response = await userService.userRegister(
      usernameController.text,
      emailController.text,
      passwordController.text,
    );

    if (response == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else if (response == 400) {
      message = "Email sudah terdaftar!";
    } else {
      message = "Gagal Registrasi!";
    }

    setState(() {
      message = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Lakku Logo.png", width: 200),
                SizedBox(height: 30),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                NormalForm(
                  label: "Username",
                  prefixText: "",
                  suffixIcon: Icons.login_outlined,
                  controller: usernameController,
                  obscureText: false,
                ),
                SizedBox(height: 10),
                NormalForm(
                  label: "Email",
                  prefixText: "",
                  suffixIcon: Icons.email_outlined,
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
                    onPressed: handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6665E7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Register',
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Sudah Punya Akun?, Login Disini",
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
