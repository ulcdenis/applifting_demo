import 'package:applifting_demo/screens/home_screen.dart';
import 'package:applifting_demo/services/filter_provider.dart';
import 'package:applifting_demo/services/launches_provider.dart';
import 'package:applifting_demo/services/timeline_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LaunchesProvider()..getLaunches()),
          ChangeNotifierProvider(create: (context) => TimelineProvider()..getTimeline()),
          ChangeNotifierProvider(create: (context) => FilterProvider()..init()),
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                primary: const Color(0xFF005288),
                seedColor: const Color(0xFFA7A9AC),
              ),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF005288),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
                  iconTheme: IconThemeData(color: Colors.white)),
            ),
            home: const HomeScreen(),
          );
        });
  }
}
