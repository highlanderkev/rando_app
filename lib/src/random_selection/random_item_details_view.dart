import 'package:flutter/material.dart';
import 'package:rando_app/src/random_selection/selection_item.dart';

/// Displays detailed information about a SampleItem.
class RandomItemDetailsView extends StatelessWidget {
  const RandomItemDetailsView({super.key});

  static const routeName = '/item';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as SelectionItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.details),
      ),
      body: Center(
        child: Text(item.info),
      ),
    );
  }
}
