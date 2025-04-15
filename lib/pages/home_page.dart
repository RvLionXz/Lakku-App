import 'package:flutter/material.dart';
import 'package:lakku_app/components/charts_card.dart';
import 'package:lakku_app/components/history_list.dart';
import 'package:lakku_app/pages/account_pages.dart';
import 'package:lakku_app/services/data_service.dart';
import 'add_expanses.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
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
            Padding(
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
                            "Rp. $saldo",
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
            AddPages(),
            AccountPages()
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
