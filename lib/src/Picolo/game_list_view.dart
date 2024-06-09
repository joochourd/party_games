
import 'package:flutter/material.dart';
import 'package:party_games/src/Picolo/game_mode.dart';

class GamesListView extends StatelessWidget {
  GamesListView({super.key});

  static const routeName = '/';
  final List<GameMode> gameModes = GameModeDefaultExtension.getDefaultModes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your game'),
        backgroundColor: const Color.fromARGB(255, 64, 103, 129)
      ),
      body: Container(
        color: Color.fromARGB(255, 64, 103, 129), // Set a light background color for the list
        child: ListView.separated(
          restorationId: 'sampleItemListView',
          itemCount: gameModes.length,
          itemBuilder: (BuildContext context, int index) {
            final gameMode = gameModes[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0), // Padding inside the list tile
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(gameMode.imagePath, width: 56, height: 56),
              ),
              title: Text(
                gameMode.title,
                style: const TextStyle(
                  color: Colors.black, // Set your color for text
                  fontWeight: FontWeight.bold, // Bold text for the title
                ),
              ),
              subtitle: Text(
                gameMode.description,
                style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Grey color for subtitle
              ),
              onTap: () {
                // Handle navigation or action when a game mode is tapped
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50.0), // Centralize and reduce width of the divider
                child: Divider(
                  color: Colors.grey[400], // Light grey color for the divider
                  thickness: 0.5, // Make the divider less thick
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
