import 'package:flutter/material.dart';
import 'package:lakku_app/components/text_field.dart';

class AddPages extends StatefulWidget {
  const AddPages({super.key});

  @override
  State<AddPages> createState() => _AddPagesState();
}

class _AddPagesState extends State<AddPages> {
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
              Amount(),
              SizedBox(height: 15),
              dropDown(),
              SizedBox(height: 15),
              Note(),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("Tombol ditekan!");
                  },
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
