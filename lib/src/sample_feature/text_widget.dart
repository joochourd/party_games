import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextDisplayWidget extends StatefulWidget {
  @override
  _TextDisplayWidgetState createState() => _TextDisplayWidgetState();
}

class _TextDisplayWidgetState extends State<TextDisplayWidget> {
  List<String> _texts = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTexts();
  }

  Future<void> _loadTexts() async {
    final jsonString = await rootBundle.loadString('assets/json/texts.json');
    final jsonResponse = json.decode(jsonString);
    setState(() {
      _texts = List<String>.from(jsonResponse['texts']);
    });
  }

  void _showNextText() {
    setState(() {
      if (_currentIndex < _texts.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _showPreviousText() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Party Game'), // Provides a title for your game page
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
              .pop(), // Ensures back navigation is possible
        ),
      ),
      backgroundColor: Colors.white,
      body: _texts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _texts[_currentIndex],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _showPreviousText,
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: _showNextText,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
