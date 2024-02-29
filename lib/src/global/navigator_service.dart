import 'package:flutter/material.dart';
import 'package:party_games/src/Picolo/picolo.dart';
import 'package:party_games/src/sample_feature/domain/player.dart';
import 'package:party_games/src/sample_feature/infrastructure/feature_factory.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget_view_model.dart';

class NavigationService extends ChangeNotifier{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final List<Page> _pages = [

  ];
  List<Page> get pages => _pages;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
  void goToGameListView() {
    Page gameListViewPage = MaterialPage(key: const ValueKey('GameListView'), child: GamesListView());
    _pages.add(gameListViewPage); 
    notifyListeners();
  }


  void navigateToGameText(List<Player> playerNames) {
    GameTextViewModel gameTextViewModel = FeatureFactory.gameTextViewModel();
    gameTextViewModel.players = playerNames;
    
    Page gameTextPage = MaterialPage(
      key: const ValueKey('GameTextWidget'),
      child: GameTextWidget(viewModel: gameTextViewModel),
    );

    _pages.add(gameTextPage);
    notifyListeners(); 
  }

    void pop() {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
      notifyListeners();
    }
  }
}
