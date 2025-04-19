import 'package:flutter/material.dart';

class NormalForm extends StatelessWidget {
  final String label;
  final String prefixText;
  final IconData suffixIcon;
  final TextEditingController controller;
  final bool obscureText;

  const NormalForm({
    super.key,
    required this.label,
    this.prefixText = '',
    this.suffixIcon = Icons.attach_money_outlined,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
        prefixText: prefixText,
        suffixIcon: Icon(suffixIcon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16, color: Colors.black),
      
    );
  }
}
class NumberForm extends StatelessWidget {
  final String label;
  final String prefixText;
  final IconData suffixIcon;
  final TextEditingController controller;
  final bool obscureText;

  const NumberForm({
    super.key,
    required this.label,
    this.prefixText = '',
    this.suffixIcon = Icons.attach_money_outlined,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
        prefixText: prefixText,
        suffixIcon: Icon(suffixIcon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}

class DropDown extends StatelessWidget {
  final String label;
  final String prefixText;
  final IconData suffixIcon;
  final bool obscureText;
  final String? value;
  final ValueChanged<String?> onChanged;
  

  const DropDown({
    super.key,
    required this.label,
    this.prefixText = '',
    this.suffixIcon = Icons.attach_money_outlined,
    required this.obscureText,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "Category",
            labelStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
          value: null,
          items:
              ['Makanan', 'Transportasi', 'Lainnya'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: onChanged
        ),
      ],
    );
  }
}
