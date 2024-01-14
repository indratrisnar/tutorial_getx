import 'dart:convert';

import 'package:fetch_api_getx/models/game.dart';
import 'package:http/http.dart' as http;

class GameSource {
  static Future<List<Game>?> getLiveGames() async {
    String url = 'https://www.freetogame.com/api/games';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List resBody = jsonDecode(response.body);
        return resBody.map((e) => Game.fromJson(Map.from(e))).toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
