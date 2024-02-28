import 'package:flutter/material.dart';
import 'package:party_games/src/sample_feature/infrastructure/text_display_widget_factory.dart';

class Routes {
  static const String home = '/';
  static const String details = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => FeatureFactory.createPlayersViewModel());
      case details:
        return MaterialPageRoute(builder: (_) => FeatureFactory.create());
      default:
        return MaterialPageRoute(builder: (_) => FeatureFactory.create());
    }
  }
}
