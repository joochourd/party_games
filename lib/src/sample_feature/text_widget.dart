import 'package:flutter/material.dart';
import 'package:party_games/src/first_game/Servicies/game_sentence.dart';
import 'package:party_games/src/first_game/Servicies/local_text_service.dart';

class TextDisplayWidget extends StatefulWidget {
  final LocalTextService textService;

  const TextDisplayWidget({super.key, required this.textService});

  @override
  _TextDisplayWidgetState createState() => _TextDisplayWidgetState();
}

class _TextDisplayWidgetState extends State<TextDisplayWidget> with SingleTickerProviderStateMixin {
  List<GameSentence> _texts = [];
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;


  Future<void> _loadTexts() async {
    try {
      _texts = await widget.textService.fetchTexts();
      setState(() {});
    } catch (e) {
      print(e);
      // Handle errors or show a message to the user
    }
  }

  Color _getBackgroundColorForSentenceType() {
    if (_currentIndex == 0) {
      return Colors.white;
    }
    var text = _texts[_currentIndex];
    switch (text.type) {
      case SentenceType.virus:
        return Colors.redAccent; // Example color for 'virus' type
      case SentenceType.text:
        return Colors.white; // Example color for 'text' type
      case SentenceType.challenge:
        return Colors.blueAccent; // Example color for 'challenge' type
      default:
        return Colors.white; // Default color
    }
  }
  @override
  void initState() {
    super.initState();
    _loadTexts();

    // Shorten the duration to speed up the vibration
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50), // Shorter duration for a quicker vibration
      vsync: this,
    );

    // Define the Tween for the vibration range
    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Set up the animation to repeat
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  void _vibrateText() {
    _controller.forward(from: 0.0); // Start the vibration
    // Stop the animation after a short duration
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _controller.stop(); // Stop the vibration
    });
  }

  void _showNextText() {
    setState(() {
      if (_currentIndex < _texts.length - 1) {
        _currentIndex++;
        _vibrateText(); // Trigger the vibration
      }
    });
  }

  void _showPreviousText() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _vibrateText(); // Trigger the vibration
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColorForSentenceType(),
      body: Stack(
        children: [
          _texts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(_animation.value, 0), // Apply the vibration effect
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _texts[_currentIndex].text,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
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
                    Positioned(
             // Adjust for the status bar height.
            right: 0, // Align to the right side of the screen.
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.close, size: 30.0), // X icon.
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
