
import 'package:flutter/material.dart';
import 'package:party_games/src/global/app_state.dart';
import 'package:party_games/src/global/navigator_service.dart';

class AppRouterDelegate extends RouterDelegate<AppState> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppState> {
  final NavigationService navigationService;

  AppRouterDelegate(this.navigationService) {
    navigationService.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey, // Use the navigatorKey from NavigationService
      pages: navigationService.pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        navigationService.pop();
        return true;
      },
    );
  }
  
  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigationService.navigatorKey; // Implement the navigatorKey getter
  
  @override
  Future<void> setNewRoutePath(configuration) async {
    // Implement based on your AppState
    // For example, if configuration is a route path, navigate to that path
    // navigationService.navigateTo(configuration);
  }

  // Other RouterDelegate methods...
}
