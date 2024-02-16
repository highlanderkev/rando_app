import 'package:flutter/material.dart';
import 'package:rando_app/src/random_number/random_number_service.dart';
import 'package:rando_app/src/random_selection/selection_item.dart';

import 'random_number.dart';

/// Displays detailed information about a SampleItem.
class RandomNumberDetailsView extends StatefulWidget {
  const RandomNumberDetailsView({super.key});

  static const routeName = '/randomnumber';

  @override
  State<RandomNumberDetailsView> createState() =>
      _RandomNumberDetailsViewState();
}

class _RandomNumberDetailsViewState extends State<RandomNumberDetailsView> {
  @override
  void initState() {
    super.initState();

    getRandomNumber();
  }

  Future<RandomNumber> getRandomNumber() async {
    return await randomNumberService.fetchRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as SelectionItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.details),
      ),
      body: Center(
          child: FutureBuilder(
        future: getRandomNumber(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RandomNumber? randomNumber = snapshot.data;
            return Center(child: Text(randomNumber!.random.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
