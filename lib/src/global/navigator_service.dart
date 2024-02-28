import 'package:flutter/material.dart';
import 'package:party_games/src/sample_feature/domain/player.dart';
import 'package:party_games/src/sample_feature/infrastructure/feature_factory.dart';
import 'package:party_games/src/sample_feature/sample_item_list_view.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget_view_model.dart';

class NavigationService extends ChangeNotifier{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<Page> _pages = [
    const MaterialPage(child: SampleItemListView(), key: ValueKey('Home')),
  ];
  List<Page> get pages => _pages;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }


  void navigateToGameText(List<Player> playerNames) {
    // Create the GameTextViewModel with the player names
    GameTextViewModel gameTextViewModel = FeatureFactory.gameTextViewModel();
    gameTextViewModel.players = playerNames;
    
    // Create the TextDisplayWidget with the GameTextViewModel
    Page gameTextPage = MaterialPage(
      key: const ValueKey('GameTextPage'),
      child: GameTextWidget(viewModel: gameTextViewModel),
    );

    // Update the navigation stack
    _pages.add(gameTextPage);
    notifyListeners(); // This would usually call `notifyListeners` on a ChangeNotifier to rebuild the UI
  }

    void pop() {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
      notifyListeners();
    }
  }
}
