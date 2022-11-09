import 'package:flutter/material.dart';

import '../Screen/screen1.dart';
import '../Screen/screen2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<StatefulWidget> pages = [
    const Screen1(),
    const Screen2(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home')),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.screenshot_monitor_outlined),
            label: 'Screen 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.screenshot_monitor_outlined),
            label: 'Screen 2',
          ),
        ],
      ),
      body: pages[_selectedIndex],
    );
  }
}
