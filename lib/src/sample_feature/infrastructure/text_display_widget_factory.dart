import 'package:flutter/material.dart';
import 'package:party_games/src/first_game/Servicies/local_text_service.dart';
import 'package:party_games/src/first_game/Servicies/text_service_interface.dart';
import 'package:party_games/src/sample_feature/domain/text_widget.dart';
import 'package:party_games/src/sample_feature/domain/view_model.dart'; // Import if you're using LocalTextService

class TextDisplayWidgetFactory {
  static Widget create() {
    // Create an instance of your ViewModel here. If your ViewModel requires a text service or other dependencies, instantiate them as well.
    TextService service = LocalTextService();
    GameTextViewModel viewModel = GameTextViewModel(service);

    // Return an instance of your View, passing in the ViewModel.
    return TextDisplayWidget(viewModel: viewModel);
  }
}

