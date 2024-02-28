import 'package:flutter/material.dart';
import 'package:party_games/src/first_game/Servicies/local_text_service.dart';
import 'package:party_games/src/first_game/Servicies/text_service_interface.dart';
import 'package:party_games/src/global/navigator_service.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget.dart';
import 'package:party_games/src/sample_feature/views/game_text_widget_view_model.dart';
import 'package:party_games/src/sample_feature/views/player_view.dart';
import 'package:party_games/src/sample_feature/views/player_view_model.dart'; // Import if you're using LocalTextService

class FeatureFactory {
  static Widget create() {
    // Create an instance of your ViewModel here. If your ViewModel requires a text service or other dependencies, instantiate them as well.
    TextService service = LocalTextService();
    GameTextViewModel viewModel = GameTextViewModel(service);

    // Return an instance of your View, passing in the ViewModel.
    return GameTextWidget(viewModel: viewModel);
  }
  static Widget createPlayersViewModel() {
    // Create an instance of your ViewModel here. If your ViewModel requires a text service or other dependencies, instantiate them as well.
    NavigationService navigationService = getNavigationService();
    PlayersViewModel viewModel = PlayersViewModel(navigationService: navigationService);

    // Return an instance of your View, passing in the ViewModel.
    return PlayersView(viewModel: viewModel);
  }
  static GameTextViewModel gameTextViewModel() {
    // Create an instance of your ViewModel here. If your ViewModel requires a text service or other dependencies, instantiate them as well.
    TextService service = LocalTextService();
    GameTextViewModel viewModel = GameTextViewModel(service);

    // Return an instance of your View, passing in the ViewModel.
    return viewModel;
  }

  static NavigationService getNavigationService(){
    return NavigationService();
  }
}

