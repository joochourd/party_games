import 'package:flutter/material.dart';
import 'package:party_games/src/sample_feature/views/player_view_model.dart';
import 'package:provider/provider.dart';

class PlayersView extends StatelessWidget {
  final PlayersViewModel viewModel;

  // The constructor expects a pre-constructed viewModel
  PlayersView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use 'Provider.value' to provide an existing instance of PlayersViewModel
    return ChangeNotifierProvider<PlayersViewModel>.value(
      value: viewModel, // Use the provided viewModel
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Players')),
        body: Consumer<PlayersViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.players.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(viewModel.players[index].name));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (value) {
                      viewModel.addPlayer(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Player Name',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Add logic to get text from controller and add player
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => viewModel.playGame(context),
                  child: const Text('Play Game'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
