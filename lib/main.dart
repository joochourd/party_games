import 'package:flutter/material.dart';
import 'package:party_games/src/global/app_router_delegate.dart';
import 'package:party_games/src/global/navigator_service.dart';

import 'src/app.dart';
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
  final routerDelegate = AppRouterDelegate(navigationService);
  
  runApp(MaterialApp.router(
    routerDelegate: routerDelegate,
    // Define RouteInformationParser if needed
  ));

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(MyApp(settingsController: settingsController));
    runApp(MaterialApp.router(
    routerDelegate: routerDelegate,
    // Define RouteInformationParser if needed
  ));
}
