import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'random_number.dart';

class RandomNumberService {
  RandomNumberService();

  Future<RandomNumber> fetchRandomNumber() async {
    final headers = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers':
          'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
    };
    // final uri = Uri.https('csrng.net', '/csrng/csrng.php');
    final uri = Uri.http('www.randomnumberapi.com', '/api/v1.0/random');
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return RandomNumber.fromJson(jsonDecode(response.body) as List<dynamic>);
    } else {
      throw Exception('Failed to load Random Number');
    }
  }

  int generateRandomNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(10000000);
    return randomNumber;
  }
}

final RandomNumberService randomNumberService = RandomNumberService();
