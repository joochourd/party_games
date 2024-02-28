
import 'package:flutter/material.dart';
import 'package:party_games/src/global/app_path.dart';

class AppRouterDelegate extends RouterDelegate<AppPath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // Your application state and logic goes here

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppPath get currentConfiguration {
    // Return the current path in the form of AppPath
  }

  @override
  Future<void> setNewRoutePath(AppPath path) async {
    // Update your app state according to the path
  }

  @override
  Widget build(BuildContext context) {
    // Build your Navigator with the current app state
  }

  // Add methods to manipulate the navigation stack or app state
}
