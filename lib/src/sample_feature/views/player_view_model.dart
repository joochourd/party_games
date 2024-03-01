import 'package:flutter/material.dart';
import 'package:party_games/src/global/navigator_service.dart';
import 'package:party_games/src/sample_feature/domain/player.dart';

class PlayersViewModel extends ChangeNotifier {
  List<Player> players = [];
  final NavigationService navigationService;

  PlayersViewModel({required this.navigationService});
  
  void addPlayer(String playerName) {
    players.add(Player(playerName));
    notifyListeners();
  }

  void playGame(BuildContext context) {
    navigationService.navigateToGameText(context, players);
  }
}
