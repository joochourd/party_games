import 'dart:convert';

import 'package:party_games/src/first_game/Servicies/game_sentence.dart';
import 'package:party_games/src/first_game/Servicies/text_service_interface.dart';

class RemoteTextService implements TextService {
  final String apiUrl; // URL of your remote API

  RemoteTextService(this.apiUrl);
  
  get http => null;

  @override
  Future<List<GameSentence>> fetchTexts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return List<GameSentence>.from(jsonResponse['texts']);
    } else {
      throw Exception('Failed to load texts from API');
    }
  }
}
