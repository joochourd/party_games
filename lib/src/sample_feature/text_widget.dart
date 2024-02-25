import 'package:flutter/material.dart';
import 'package:party_games/src/first_game/Servicies/game_sentence.dart';
import 'package:party_games/src/first_game/Servicies/local_text_service.dart';


class TextDisplayWidget extends StatefulWidget {
  final LocalTextService textService;

  const TextDisplayWidget({super.key, required this.textService});

  @override
  _TextDisplayWidgetState createState() => _TextDisplayWidgetState();
}

class _TextDisplayWidgetState extends State<TextDisplayWidget> {
  List<GameSentence> _texts = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTexts();
  }

  Future<void> _loadTexts() async {
    try {
      _texts = await  widget.textService.fetchTexts();
      setState(() {});
    } catch (e) {
      print(e);
      // Handle errors or show a message to the user
    }
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
        title: const Text('Party Game'), // Provides a title for your game page
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                    _texts[_currentIndex].text,
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