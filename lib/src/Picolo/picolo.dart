import 'package:flutter/material.dart';
import 'package:party_games/src/Picolo/game_mode.dart';

class GamesListView extends StatelessWidget{
  GamesListView({
    super.key,
    //  required gameModes,
    // required this.gameModes,
  });

  static const routeName = '/';
  // final List<SampleItem> items;
  final List<GameMode> gameModes = GameModeDefaultExtension.getDefaultModes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your game'),
        actions: const [
          // ... existing actions
        ],
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: gameModes.length, // Update the count
        itemBuilder: (BuildContext context, int index) {
            // Game mode list item
            final gameMode = gameModes[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(gameMode.imagePath, width: 56, height: 56),
              ),
              title: Text(gameMode.title),
              subtitle: Text(gameMode.descsription),
              tileColor: Colors.white, // Set your desired color or gradient here
              onTap: () {
                // Handle navigation or action when a game mode is tapped
              },
            );
          }
      ),
    );
  }
}
