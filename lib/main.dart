import 'package:flutter/material.dart';
import 'package:hang_man/screens/high_scores_screen.dart';
import 'package:hang_man/screens/play_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        PlayScreen.routeName: (context) => PlayScreen(),
        HighScoreScreen.routeName: (context) => const HighScoreScreen(),
      },
    );
  }
}

