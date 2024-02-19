import 'package:flutter/material.dart';
import 'package:rando_app/src/random_dog/random_dog.dart';
import 'package:rando_app/src/random_dog/random_dog_service.dart';
import 'package:rando_app/src/random_selection/selection_item.dart';
import 'package:rando_app/src/video_player/video_player_view.dart';

/// Displays detailed information about a SampleItem.
class RandomDogDetailsView extends StatefulWidget {
  const RandomDogDetailsView({super.key});

  static const routeName = '/randomdog';

  @override
  State<RandomDogDetailsView> createState() => _RandomDogDetailsViewState();
}

class _RandomDogDetailsViewState extends State<RandomDogDetailsView> {
  @override
  void initState() {
    super.initState();

    getRandomDog();
  }

  Future<RandomDog> getRandomDog() async {
    return await randomDogService.fetchRandomDog();
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
        future: getRandomDog(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RandomDog? randomDog = snapshot.data;
            if (randomDog!.isVideo) {
              return VideoPlayerView(url: randomDog.url);
            } else {
              return Image(image: NetworkImage(randomDog.url));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Regenerate',
        child: const Icon(Icons.replay),
      ),
    );
  }
}
