class AppPath {
  final String? id;
  final bool isHomePage;

  AppPath.home() : isHomePage = true, id = null;
  AppPath.details(this.id) : isHomePage = false;

  bool get isDetailsPage => id != null;
}
