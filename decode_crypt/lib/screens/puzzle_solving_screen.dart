import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PuzzleSolvingScreen extends StatefulWidget {
  @override
  _PuzzleSolvingScreenState createState() => _PuzzleSolvingScreenState();
}

class _PuzzleSolvingScreenState extends State<PuzzleSolvingScreen> {
  final _solutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final puzzle = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Solve Puzzle')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Puzzle Type: ${puzzle['type']}'),
            SizedBox(height: 16),
            Text('Encrypted Text: ${puzzle['text']}'),
            SizedBox(height: 32),
            TextField(
              controller: _solutionController,
              decoration: InputDecoration(labelText: 'Enter your solution'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Submit Solution'),
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('https://your-heroku-app.herokuapp.com/check-solution/${puzzle['id']}'),
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({'solution': _solutionController.text}),
                );
                if (response.statusCode == 200) {
                  final result = json.decode(response.body);
                  if (result['correct']) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Correct solution!'),
                      backgroundColor: Colors.green,
                    ));
                    // TODO: Update local progress
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Incorrect solution. Try again!'),
                      backgroundColor: Colors.red,
                    ));
                  }
                } else {
                  // Handle error
                  print('Failed to check solution');
                }
              },
            ),
            Spacer(),
            ElevatedButton(
              child: Text('Learn about ${puzzle['type']} cipher'),
              onPressed: () => _launchURL('https://example.com/${puzzle['type']}_cipher'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
      print('Could not launch $url');
    }
  }
}