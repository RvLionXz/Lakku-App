import 'package:flutter/material.dart';
import 'package:lakku_app/models/expenses_model.dart';
import 'package:lakku_app/services/expense_service.dart';
import 'package:lakku_app/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:lakku_app/pages/home_page.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<Expenses> historyList = [];
  bool isLoading = false;
  bool isButtonPress = false;

  ExpenseService expenseService = ExpenseService();
  UserService userService = UserService();

  void getHistory() async {
    isLoading = true;

    final idUser = await userService.getUserId();

    if (idUser != null) {
      final expenses = await expenseService.getExpenses(idUser);

      if (mounted) {
        setState(() {
          final expensesReversed = expenses.reversed.toList();
          historyList = expensesReversed;
          isLoading = false;
        });
      }
    } else {
      print("History tidak ditemukan.");
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("History", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(
                    height: 440,
                    child: ListView.builder(
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        var item = historyList[index];
                        Icon categoryIcon;
                        switch (item.category.toLowerCase()) {
                          case 'makanan':
                            categoryIcon = Icon(
                              Icons.food_bank,
                              size: 50,
                              color: Color(0xFF6665E7),
                            );
                            break;
                          case 'transportasi':
                            categoryIcon = Icon(
                              Icons.directions_car,
                              size: 50,
                              color: Color(0xFF6665E7),
                            );
                            break;
                          case 'lainnya':
                            categoryIcon = Icon(
                              Icons.other_houses,
                              size: 50,
                              color: Color(0xFF6665E7),
                            );
                            break;
                          default:
                            categoryIcon = Icon(
                              Icons.help,
                              size: 50,
                              color: Color(0xFF6665E7),
                            );
                            break;
                        }

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
                                categoryIcon,
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.category,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(item.description),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formatRupiah(item.amount),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      DateFormat(
                                        'dd MMMM yyyy, HH:mm',
                                      ).format(item.date),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () async {
                                    // if(isButtonPress) return;
                                    setState(() {
                                      isButtonPress = true;
                                    });
                                    await expenseService.deleteExpenses(
                                      item.id,
                                    );
                                    getHistory();
                                    setState(() {
                                      userService.fetchUser();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const HomePage(),
                                        ),
                                      );
                                    });
                                  },
                                  icon: Icon(Icons.delete),
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
