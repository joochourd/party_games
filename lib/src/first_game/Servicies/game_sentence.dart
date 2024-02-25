class GameSentence {
  String text;
  SentenceType type;
  GameSentence(this.text, this.type);

    factory GameSentence.fromJson(Map<String, dynamic> json) {
    return GameSentence(
      json['text'],
      SentenceType.values.firstWhere(
        (e) => e.toString().split('.')[1] == json['type'],
        orElse: () => SentenceType.text, // Default to 'text' if type is not found
      ),
    );
    }
}

enum SentenceType { virus, text, challenge }

