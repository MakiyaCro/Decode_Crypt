import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PuzzleListScreen extends StatefulWidget {
  @override
  _PuzzleListScreenState createState() => _PuzzleListScreenState();
}

class _PuzzleListScreenState extends State<PuzzleListScreen> {
  List<dynamic> puzzles = [];

  @override
  void initState() {
    super.initState();
    fetchPuzzles();
  }

  Future<void> fetchPuzzles() async {
    final response = await http.get(Uri.parse('https://your-heroku-app.herokuapp.com/puzzles'));
    if (response.statusCode == 200) {
      setState(() {
        puzzles = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load puzzles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Puzzles')),
      body: ListView.builder(
        itemCount: puzzles.length,
        itemBuilder: (context, index) {
          final puzzle = puzzles[index];
          return ListTile(
            title: Text('Puzzle ${puzzle['id']}'),
            subtitle: Text('Type: ${puzzle['type']} - Difficulty: ${puzzle['difficulty']}'),
            onTap: () {
              Navigator.pushNamed(context, '/solve', arguments: puzzle);
            },
          );
        },
      ),
    );
  }
}