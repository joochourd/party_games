
import 'package:flutter/material.dart';
import 'package:party_games/src/global/app_state.dart';
import 'package:party_games/src/global/navigator_service.dart';

class AppRouterDelegate extends RouterDelegate<AppState> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppState> {
  final NavigationService navigationService;
  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigationService.navigatorKey; // Implement the navigatorKey getter

  AppRouterDelegate(this.navigationService) {
    // navigatorKey = GlobalKey<NavigatorState>();
    navigationService.addListener(() {notifyListeners();});
  }  

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator(
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
    return navigator;
  }
  
  
@override
Future<void> setNewRoutePath(AppState configuration) async {
  // Assuming your AppState can provide a route name
  if (configuration.isHomePage) {
    // Use your navigationService to navigate to the route
    navigationService.navigateTo(configuration.currentRoute);
  }
}


  // Other RouterDelegate methods...
}


// class BookRouterDelegate extends RouterDelegate<BookRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  
// final GlobalKey<NavigatorState> navigatorKey;
// Book? _selectedBook;
// bool show404 = false;
// List<Book> books = [ Book('Stranger in a Istrange Land', 'Robert A. Heinlein'),
//                     Book('Foundation', 'Isaac Asimov'),
//                      Book('Fahrenheit 451', 'Ray Bradbury')];
                      
//   BookRoutePath get currentConfiguration {
//       if (show404) {
//           return BookRoutePath. unknown);
//       }
//         return _selectedBook = null 
//         ? BookRoutePath. home (
//         : BookRoutePath.details(books.index0f(_selectedBook!));