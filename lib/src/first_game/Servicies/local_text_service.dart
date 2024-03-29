import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:party_games/src/first_game/Servicies/game_sentence.dart';
import 'package:party_games/src/first_game/Servicies/text_service_interface.dart';

class LocalTextService implements TextService {
  @override
  Future<List<GameSentence>> fetchTexts() async {
    final jsonString = await rootBundle.loadString('assets/json/texts.json');
    final jsonResponse = json.decode(jsonString);
    final textsJson = jsonResponse['texts'] as List;
    return textsJson.map((textJson) => GameSentence.fromJson(textJson)).toList();
  }
}
