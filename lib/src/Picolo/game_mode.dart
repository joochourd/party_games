class GameMode {
  String name;
  String title;
  String description;
  String imagePath;

  GameMode(this.name, this.title, this.description, this.imagePath);
}

extension GameModeDefaultExtension on GameMode {
  static List<GameMode> getDefaultModes() {
    return [
      GameMode("DefaultName1", "DefaultTitle1", "DefaultDescription1", "assets/images/party.png"),
      GameMode("DefaultName2", "DefaultTitle2", "DefaultDescription2", "assets/images/pre_party.png"),
      GameMode("DefaultName3", "DefaultTitle3", "DefaultDescription3", "assets/images/cat.png"),
      GameMode("DefaultName4", "DefaultTitle4", "DefaultDescription4", "assets/images/pigeon.png"),
      GameMode("DefaultName5", "DefaultTitle5", "DefaultDescription5", "assets/images/pug.png"),
      // Add other default game modes as needed
    ];
  }
}