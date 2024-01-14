import 'package:fetch_api_getx/controllers/genre_controller.dart';
import 'package:fetch_api_getx/controllers/live_game_controller.dart';
import 'package:fetch_api_getx/models/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_image/extended_image.dart';

class LiveGamePage extends StatefulWidget {
  const LiveGamePage({super.key});

  @override
  State<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends State<LiveGamePage> {
  final liveGameController = Get.put(LiveGameController());
  final genreController = Get.put(GenreController());
  List<String> genres = [
    'Shooter',
    'MMOARPG',
    'ARPG',
    'Strategy',
    'Fighting',
  ];

  @override
  void initState() {
    liveGameController.fetcLiveGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Game'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(() {
            String genreSelected = liveGameController.selected;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: genres.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        onPressed: () {
                          liveGameController.selected = e;
                        },
                        backgroundColor: genreSelected == e
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        label: Text(e),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(
              () {
                if (liveGameController.status == '') {
                  return const SizedBox.shrink();
                }
                if (liveGameController.status == 'loading') {
                  return const Center(child: CircularProgressIndicator());
                }
                if (liveGameController.status != 'success') {
                  return Center(
                    child: Text(liveGameController.status),
                  );
                }
                List<Game> games = liveGameController.gamesSelected;
                // List<Game> games = list
                //     .where((e) => e.genre == liveGameController.selected)
                //     .toList();
                if (games.isEmpty) {
                  return const Center(child: Text('Empty'));
                }
                return GridView.builder(
                  itemCount: games.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    Game game = games[index];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ExtendedImage.network(
                            game.thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          height: 60,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black54,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              liveGameController.updateIsSaved(
                                game.copyWith(isSaved: !game.isSaved),
                              );
                            },
                            icon: game.isSaved
                                ? const Icon(
                                    Icons.bookmark,
                                    color: Colors.blue,
                                  )
                                : Icon(
                                    Icons.bookmark_border,
                                    color: Colors.grey[300],
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
