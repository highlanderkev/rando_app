import 'package:flutter/material.dart';
import 'package:rando_app/src/random_cat/random_cat.dart';
import 'package:rando_app/src/random_cat/random_cat_service.dart';
import 'package:rando_app/src/random_selection/selection_item.dart';

/// Displays detailed information about a SampleItem.
class RandomCatDetailsView extends StatefulWidget {
  const RandomCatDetailsView({super.key});

  static const routeName = '/randomcat';

  @override
  State<RandomCatDetailsView> createState() => _RandomCatDetailsViewState();
}

class _RandomCatDetailsViewState extends State<RandomCatDetailsView> {
  @override
  void initState() {
    super.initState();

    getRandomCat();
  }

  Future<RandomCat> getRandomCat() async {
    return await randomCatService.fetchRandomCat();
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
        future: getRandomCat(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RandomCat? randomCat = snapshot.data;
            return Image(image: NetworkImage(randomCat!.url));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
