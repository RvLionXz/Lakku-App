import 'package:flutter/material.dart';
import 'package:lakku_app/components/text_field.dart';
import 'package:lakku_app/services/expense_service.dart';
import 'package:lakku_app/services/user_service.dart';
import 'package:lakku_app/pages/home_page.dart';

class AddPages extends StatefulWidget {
  const AddPages({super.key});

  @override
  State<AddPages> createState() => _AddPagesState();
}

class _AddPagesState extends State<AddPages> {
  TextEditingController amountController = TextEditingController();
  String? selectedCategory; // Menyimpan kategori yang dipilih
  TextEditingController noteController = TextEditingController();
  bool isButtonPress = false;

  void getUserId() async {}

  void addExpenses() async {
    UserService userService = UserService();
    final idUser = await userService.getUserId();
    if (isButtonPress) return;

    setState(() {
      isButtonPress = true;
    });

    final amountString = amountController.text;
    final category = selectedCategory;
    final note = noteController.text;

    final amount = double.tryParse(amountString);
    if (amount != null && category != null && note.isNotEmpty) {
      ExpenseService serviceExpense = ExpenseService();
      serviceExpense.addExpenses(idUser!, amount, category, note);
      setState(() {
        isButtonPress = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data berhasil ditambahkan!"),
            backgroundColor: Color(0xFF6665E7),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    } else {
      // print(category);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Periksa kembali kolom inputan anda"),
          backgroundColor: Color(0xFF6665E7),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              NormalForm(
                label: "Amount",
                controller: amountController,
                obscureText: false,
              ),
              SizedBox(height: 15),
              DropDown(
                label: "Category",
                value: selectedCategory,
                obscureText: false,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                  print("Kategori dipilih: $newValue");
                },
              ),
              SizedBox(height: 15),
              NormalForm(
                label: "Deskripsi",
                controller: noteController,
                obscureText: false,
                suffixIcon: Icons.comment_outlined,
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: addExpenses,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6665E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
