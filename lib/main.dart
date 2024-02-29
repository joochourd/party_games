import 'package:flutter/material.dart';
import 'package:party_games/src/Picolo/picolo.dart';
import 'package:party_games/src/global/app_router_delegate.dart';
import 'package:party_games/src/global/navigator_service.dart';
import 'package:party_games/src/global/route_information_parser.dart';
import 'package:party_games/src/sample_feature/sample_item_list_view.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final navigationService = NavigationService();
  final firstWidget = SampleItemListView(navigationService: navigationService);
  final firstPage = MaterialPage(child: firstWidget, key: const ValueKey('SampleItemListView'));
  final secondPage = MaterialPage(child: GamesListView(), key: const ValueKey('GameListView'));
  navigationService.pages.add(firstPage);
  navigationService.pages.add(secondPage);
  final routerDelegate = AppRouterDelegate(navigationService);
  final routerInformationParser = RouterInformationParser();
  
  runApp(MaterialApp.router(
    routerDelegate: routerDelegate,
    // routeInformationParser: routerInformationParser,
  ));
}
