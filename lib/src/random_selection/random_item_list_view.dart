import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'selection_item.dart';
// import '../components/login_button.dart';

/// Displays a list of SampleItems.
class RandomItemListView extends StatelessWidget {
  const RandomItemListView({
    super.key,
    this.items = const [
      SelectionItem(1, "Random Number", 'Get Random Number', '/randomnumber'),
      SelectionItem(
          2, "Random Dog Video/Image", 'Get Random Dog', '/randomdog'),
      SelectionItem(3, "Random Cat Image", 'Get Random Cat', '/randomcat')
    ],
  });

  static const routeName = '/';

  final List<SelectionItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Things'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'itemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.details),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.pushNamed(context, item.routeName, arguments: item);
              });
        },
      ),
    );
  }
}
