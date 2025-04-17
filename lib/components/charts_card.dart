import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lakku_app/services/expense_service.dart';
import 'package:lakku_app/services/user_service.dart';

class ChartsCard extends StatefulWidget {
  const ChartsCard({super.key});

  @override
  State<ChartsCard> createState() => _ChartsCardState();
}

class _ChartsCardState extends State<ChartsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 130,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 10,
                      title: 'a%',
                      radius: 50,
                    ),
                    PieChartSectionData(
                      color: Colors.yellow,
                      value: 10,
                      title: 'a%',
                      radius: 50,
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: 10,
                      title: 'a%',
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Grafik Pengeluaran",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text("Makanan"),
                Text("Transportasi"),
                Text("Lainnya"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(""),
                SizedBox(height: 10),
                Text("Rp. "),
                Text("Rp. "),
                Text("Rp. "),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
