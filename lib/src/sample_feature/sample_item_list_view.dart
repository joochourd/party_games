import 'package:flutter/material.dart';
import 'package:party_games/src/sample_feature/text_widget.dart';
import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';


/// Displays a list of SampleItems plus an entry for the game.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3), SampleItem(4)], // Assume 4th item is the game
  });

  static const routeName = '/';

  final List<SampleItem> items;

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
            title: Text(index == items.length - 1 ? 'Party Game' : 'SampleItem ${item.id}'),
            leading: const CircleAvatar(
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () {
              if (index == items.length - 1) {
                // Navigate to the game
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TextDisplayWidget()));
              } else {
                // Navigate to the details page for other items
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                );
              }
            },
          );
        },
      ),
    );
  }
}
