import 'dart:async';
import 'package:flutter/material.dart';
import 'package:party_games/src/first_game/Servicies/game_sentence.dart';
import 'package:party_games/src/first_game/Servicies/text_service_interface.dart';
import 'package:party_games/src/sample_feature/domain/player.dart';

class GameTextViewModel {
  List<Player> players = [];
  final List<GameSentence> _texts = [];
  final TextService textService;
  final Color backgroundColor = Colors.white;

  int _currentIndex = 0;

  final _combinedStreamController = StreamController<GameTextViewModelInformationStream>();
  Stream<GameTextViewModelInformationStream> get combinedStream => _combinedStreamController.stream;
  

  GameTextViewModel(this.textService) {
    _fetchTexts(); // Initial fetch of texts
  }

  void _fetchTexts() async {
    // Simulate a fetch operation with a delay
    await Future.delayed(const Duration(seconds: 1));
    var newTexts = await textService.fetchTexts(); 
    _texts.addAll(newTexts);
    _updateStreams();
  }

  void nextText() {
    if (_currentIndex < _texts.length - 1) {
      _currentIndex++;
      _updateStreams();
    }
  }

  void previousText() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _updateStreams();
    }
  }

  void _updateStreams() {
    var color = getBackgroundColorForSentenceType();
    var text = _texts[_currentIndex];
    if (_texts.isEmpty) {
      //_combinedStreamController.add(null); // No texts available
    } else {
      _combinedStreamController.add(GameTextViewModelInformationStream(color: color, sentence: text));
    }
  }

  void dispose() {
    _combinedStreamController.close();
  }
  
  Color getBackgroundColorForSentenceType() {
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
}


class GameTextViewModelInformationStream {
  final GameSentence? sentence;
  final Color color;

  GameTextViewModelInformationStream({required this.sentence, required this.color});
}
