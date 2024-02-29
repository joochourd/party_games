class AppState {
  String currentRoute;
  int? selectedItemId;

  AppState(this.currentRoute, {this.selectedItemId});

  AppState.home() : currentRoute = '/home';
  AppState.GameTextView() : currentRoute = '/home';
  AppState.PlayerView() : currentRoute = '/home';

  bool get isHomePage => currentRoute == '/home';
  bool get isDetailsPage => currentRoute == '/details';
}
