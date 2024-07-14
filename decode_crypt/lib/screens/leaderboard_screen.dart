import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cryptography Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Puzzles'),
              onPressed: () => Navigator.pushNamed(context, '/puzzles'),
            ),
            ElevatedButton(
              child: Text('Monthly Challenge'),
              onPressed: () => Navigator.pushNamed(context, '/monthly'),
            ),
            ElevatedButton(
              child: Text('Profile'),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
            ElevatedButton(
              child: Text('Leaderboard'),
              onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
            ),
          ],
        ),
      ),
    );
  }
}