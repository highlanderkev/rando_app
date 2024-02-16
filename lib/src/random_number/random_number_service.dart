import 'dart:convert';

import 'package:http/http.dart' as http;

import 'random_number.dart';

class RandomNumberService {
  RandomNumberService();

  Future<RandomNumber> fetchRandomNumber() async {
    final headers = {'Access-Control-Allow-Origin': '*'};
    final uri = Uri.https('csrng.net', '/csrng/csrng.php');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return RandomNumber.fromJson(jsonDecode(response.body) as List<dynamic>);
    } else {
      throw Exception('Failed to load Random Number');
    }
  }
}

final RandomNumberService randomNumberService = RandomNumberService();
