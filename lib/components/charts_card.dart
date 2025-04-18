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
  bool isLoading = false;
  double makanan = 0;
  double transportasi = 0;
  double lainnya = 0;

  double makananPercent = 0;
  double transportasiPercent = 0;
  double lainnyaPercent = 0;
  double total = 0;

  void showCharts() async {
    ExpenseService expenseService = ExpenseService();
    UserService userService = UserService();

    isLoading = true;
    final idUser = await userService.getUserId();

    if (idUser != null) {
      final expensesCategory = await expenseService.getExpenses(idUser);

      makanan = 0;
      transportasi = 0;
      lainnya = 0;

      for (var expense in expensesCategory) {
        double amount = expense.amount ?? 0;

        if (expense.category == "Makanan") {
          makanan += amount;
        } else if (expense.category == "Transportasi") {
          transportasi += amount;
        } else {
          lainnya += amount;
        }
      }
      total = makanan + transportasi + lainnya;
      makananPercent = (makanan / total) * 100;
      transportasiPercent = (transportasi / total) * 100;
      lainnyaPercent = (lainnya / total) * 100;

      setState(() {
        isLoading = false;
      });
    } else {
      print("User ID tidak ditemukan.");
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    showCharts();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
          isLoading
              ? Expanded(
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                ),
              )
              : Container(
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
                              value: makanan,
                              title: "${makananPercent.toStringAsFixed(2)}%",
                              radius: 50,
                            ),
                            PieChartSectionData(
                              color: Colors.yellow,
                              value: transportasi,
                              title:
                                  "${transportasiPercent.toStringAsFixed(2)}%",
                              radius: 50,
                            ),
                            PieChartSectionData(
                              color: Colors.red,
                              value: lainnya,
                              title: "${lainnyaPercent.toStringAsFixed(2)} %",
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
                        Text("Rp. ${makanan.toStringAsFixed(0)}"),
                        Text("Rp. ${transportasi.toStringAsFixed(0)}"),
                        Text("Rp. ${lainnya.toStringAsFixed(0)}"),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}
