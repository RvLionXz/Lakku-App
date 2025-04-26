import 'package:flutter/material.dart';
import 'package:lakku_app/models/monthly_summary%20.dart';
import 'package:lakku_app/services/expense_service.dart';
import 'package:lakku_app/services/user_service.dart';
import 'package:intl/intl.dart';

class MountlyHistory extends StatefulWidget {
  const MountlyHistory({super.key});

  @override
  State<MountlyHistory> createState() => _MountlyHistoryState();
}

class _MountlyHistoryState extends State<MountlyHistory> {
  List<MonthlySummary> historyList = [];
  bool isLoading = false;
  bool isButtonPress = false;

  ExpenseService expenseService = ExpenseService();
  UserService userService = UserService();

  void getHistory() async {
    isLoading = true;

    final idUser = await userService.getUserId();

    if (idUser != null) {
      final expenses = await expenseService.getMountlyExpenses(idUser);

      if (mounted) {
        setState(() {
          final expensesReversed = expenses.reversed.toList();
          historyList = expensesReversed;
          isLoading = false;
        });
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  //Format ke Rupiah
  String formatRupiah(dynamic amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(double.tryParse(amount.toString()) ?? 0);
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          isLoading
              ? Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              )
              : Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        var item = historyList[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.monthName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formatRupiah(item.totalAmount.toInt()),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
