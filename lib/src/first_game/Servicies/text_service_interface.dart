
import 'package:party_games/src/first_game/Servicies/game_sentence.dart';

abstract class TextService {
  Future<List<GameSentence>> fetchTexts();
}
