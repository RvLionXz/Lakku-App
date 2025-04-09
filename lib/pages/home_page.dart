import 'package:flutter/material.dart';
import 'package:lakku_app/components/charts_card.dart';
import 'package:lakku_app/components/history_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text("Lakku"),
          backgroundColor: Color(0xFFF5F5F5),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Pengeluaran",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Rp. 100.000",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ChartsCard(),
                SizedBox(height: 10),
                HistoryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}