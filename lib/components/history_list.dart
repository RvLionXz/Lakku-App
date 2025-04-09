import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [Text("History", style: TextStyle(fontSize: 18))],
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.food_bank, size: 50, color: Color(0xFF6665E7)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Makanan",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Text("Note untuk makanan"),
                          ],
                        ),
                      ),
                      Text("Rp. 100.000", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
