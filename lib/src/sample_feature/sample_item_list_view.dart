import 'package:flutter/material.dart';
import 'package:party_games/src/Picolo/game_mode.dart';
import 'package:party_games/src/first_game/Servicies/local_text_service.dart';
import 'package:party_games/src/global/navigator_service.dart';
import 'package:party_games/src/sample_feature/infrastructure/feature_factory.dart';
import '../settings/settings_view.dart';
import 'sample_item.dart';


/// Displays a list of SampleItems plus an entry for the game.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3), SampleItem(4), SampleItem(5)], required this.navigationService, // Assume 4th item is the game
  });

  String getName(int id){
    switch(id) {
      case 0: return "id of the row 0";
      case 1: return "id of the row 1";
      case 2: return "id of the row 2";
      case 3: return "Player name loading screen";
      case 4: return "Picolo";
      case 5: return "Game List";
      default: break;
    }
    return "empty";
  }
  static const routeName = '/';
  static var localTextSevice = LocalTextService();
  final List<SampleItem> items;
  static var gameModes = GameModeDefaultExtension.getDefaultModes();
  final NavigationService navigationService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text(getName(item.id)),
            leading: const CircleAvatar(
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () {
              if (item.id == 5) {
                navigationService.goToGameListView(context);
              }
              if (item.id == 4) {
                // Navigate to the game
                // navigationService.navigateToGameText(context);
              }
              if (item.id == 3) {
                // Navigate to the game
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureFactory.createPlayersViewModel()));
              }
            }
          );
        },
      ),
    );
  }
}
