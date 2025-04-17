import 'package:flutter/material.dart';
import 'package:lakku_app/components/charts_card.dart';
import 'package:lakku_app/components/history_list.dart';
import 'package:lakku_app/pages/account_page.dart';
import 'add_expanses.dart';
import 'package:lakku_app/services/expense_service.dart';
import 'package:lakku_app/services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? totalBalance = 0;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void getBalance() async {
    ExpenseService expenseService = ExpenseService();
    UserService userService = UserService();

    final idUser = await userService.getUserId();
    // print("User ID: $idUser");

    if (idUser != null) {
      double? balance = await expenseService.getTotalExpenses(idUser);
      setState(() {
        totalBalance = balance;
      });
    } else {
      // print("User ID tidak ditemukan.");
    }
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

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
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            RefreshIndicator(
              onRefresh: () async {
                getBalance();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                              "Rp. ${totalBalance?.toStringAsFixed(2)}",
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
            AddPages(),
            AccountPages(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF6665E7),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
