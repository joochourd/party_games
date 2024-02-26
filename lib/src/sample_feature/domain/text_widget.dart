import 'dart:async';

import 'package:flutter/material.dart';
import 'package:party_games/src/first_game/Servicies/game_sentence.dart';
import 'package:party_games/src/sample_feature/domain/view_model.dart'; // If needed

class TextDisplayWidget extends StatefulWidget {
  final GameTextViewModel viewModel;
  String? _previousText;

  TextDisplayWidget({super.key, required this.viewModel});

  @override
  _TextDisplayWidgetState createState() => _TextDisplayWidgetState();
}

class _TextDisplayWidgetState extends State<TextDisplayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.viewModel.dispose(); // Dispose of the ViewModel
    super.dispose();
  }

  void _vibrateText() {
    _controller.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 200))
        .then((_) => _controller.stop());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameTextViewModelInformationStream>(
      stream: widget.viewModel.combinedStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final GameTextViewModelInformationStream informationStream =
            snapshot.data!;
        final GameSentence? currentText = informationStream.sentence;
        final Color currentBackgroundColor = informationStream.color; 
       WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget._previousText != currentText?.text) {
          _vibrateText();
          widget._previousText = currentText?.text;  // Update the previous text for the next comparison
        }
      });

        return Scaffold(
          backgroundColor: currentBackgroundColor,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        informationStream.sentence?.text ??
                            'No text available',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: widget.viewModel.previousText,
                        child: const Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed:
                            (widget.viewModel.nextText), 
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                right: 0,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 30.0),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
