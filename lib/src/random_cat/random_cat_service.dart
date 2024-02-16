import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rando_app/src/random_cat/random_cat.dart';

class RandomCatService {
  RandomCatService();

  Future<RandomCat> fetchRandomCat() async {
    final response =
        await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

    if (response.statusCode == 200) {
      return RandomCat.fromJson(jsonDecode(response.body) as List<dynamic>);
    } else {
      throw Exception('Failed to load Random Dog');
    }
  }
}

final RandomCatService randomCatService = RandomCatService();
