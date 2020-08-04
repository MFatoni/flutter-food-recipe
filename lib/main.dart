import 'package:flutter/material.dart';
import 'package:foodrecipes_flutter/view/detail_breakfast.dart';
import 'package:foodrecipes_flutter/view/detail_desert.dart';

void main() {
  runApp(MaterialApp(
    title: "My Apps",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State {
  int _selectedIndex = 0;

  final _widgetOptions = [
    BreakfastPage(),
    DesertPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.grey[100],
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            indicatorColor: Colors.grey,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            onTap: _onItemTapped,
            tabs: [
              Tab(
                text: 'Breakfast',
              ),
              Tab(
                text: 'Dessert',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
