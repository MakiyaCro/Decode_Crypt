import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/puzzle_list_screen.dart';
import 'screens/puzzle_solving_screen.dart';
import 'screens/monthly_challenge_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/leaderboard_screen.dart';

void main() {
  runApp(CryptographyGameApp());
}

class CryptographyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptography Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/puzzles': (context) => PuzzleListScreen(),
        '/solve': (context) => PuzzleSolvingScreen(),
        '/monthly': (context) => MonthlyChallengeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
      },
    );
  }
}