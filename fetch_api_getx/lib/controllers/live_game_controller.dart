import 'package:fetch_api_getx/models/game.dart';
import 'package:fetch_api_getx/source/game_source.dart';
import 'package:get/get.dart';

class LiveGameController extends GetxController {
  final _selected = 'Shooter'.obs;
  String get selected => _selected.value;
  set selected(String n) => _selected.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  final _games = <Game>[].obs;
  List<Game> get games => _games;
  List<Game> get gamesSelected =>
      games.where((e) => e.genre == selected).toList();

  fetcLiveGame() async {
    status = 'loading';
    final list = await GameSource.getLiveGames();
    if (list == null) {
      status = 'Something went wrong';
      return;
    }

    status = 'success';
    _games.value = list;
  }

  updateIsSaved(Game game) {
    List<Game> newGames = [...games];
    int index = newGames.indexWhere((e) => e.id == game.id);
    if (index < 0) return;

    newGames[index] = game;
    _games.value = List.from(newGames);
  }
}
