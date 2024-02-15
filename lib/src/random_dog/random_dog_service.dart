import 'dart:convert';

import 'package:http/http.dart' as http;

import 'random_dog.dart';

class RandomDogService {
  RandomDogService();

  Future<RandomDog> fetchRandomDog() async {
    final response = await http.get(Uri.parse('https://random.dog/woof.json'));

    if (response.statusCode == 200) {
      return RandomDog.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Random Dog');
    }
  }
}

final RandomDogService randomDogService = RandomDogService();
