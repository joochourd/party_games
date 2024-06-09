import 'package:flutter/material.dart';
import 'package:party_games/src/Picolo/game_list_view.dart'; // Ensure this import is correct
import 'package:party_games/src/sample_feature/domain/player.dart';
import 'package:party_games/src/sample_feature/infrastructure/feature_factory.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget_view_model.dart';

class NavigationService extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<Page> _pages = [];
  List<Page> get pages => _pages;

  // Private constructor
  NavigationService._privateConstructor();

  // Private static instance
  static final NavigationService _instance = NavigationService._privateConstructor();

  // Public static method to access the instance
  static NavigationService get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void goToGameListView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GamesListView())); // Ensure GamesListView() is defined somewhere
    notifyListeners();
  }

  void navigateToGameText(BuildContext context, List<Player> playerNames) {
    GameTextViewModel gameTextViewModel = FeatureFactory.gameTextViewModel(); // Ensure this method is defined and works as expected
    gameTextViewModel.players = playerNames;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameTextWidget(viewModel: gameTextViewModel))); // Ensure GameTextWidget accepts viewModel in constructor
  }
}
