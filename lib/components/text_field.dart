import 'package:flutter/material.dart';

class Amount extends StatefulWidget {
  const Amount({super.key});

  @override
  State<Amount> createState() => _Amount();
}

class _Amount extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Amount",
            labelStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
            prefixText: "Rp ",
            suffixIcon: Icon(
              Icons.attach_money_outlined,
              color: Colors.grey[600],
            ),
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
        ),
      ],
    );
  }
}

class dropDown extends StatefulWidget {
  const dropDown({super.key});

  @override
  State<dropDown> createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {
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
          onChanged: (newValue) {
            print("Kategori dipilih: $newValue");
          },
        ),
      ],
    );
  }
}

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Note",
            labelStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
            suffixIcon: Icon(
              Icons.comment_outlined,
              color: Colors.grey[600],
            ),
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
        ),
      ],
    );
  }
}
