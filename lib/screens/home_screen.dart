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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: onPageChanged,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'PAGE1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'PAGE2',
          ),
        ],
      ),
    );
  }
}
