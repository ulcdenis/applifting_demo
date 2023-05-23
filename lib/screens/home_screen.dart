import 'package:applifting_demo/screens/launches_screen.dart';
import 'package:applifting_demo/screens/timeline_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  List<Widget> pages = [const LaunchesScreen(), const TimelineScreen()];

  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFA7A9AC),
        currentIndex: currentPageIndex,
        onTap: onPageChanged,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.launch),
            label: 'LAUNCHES',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'TIMELINE',
          ),
        ],
      ),
    );
  }
}
