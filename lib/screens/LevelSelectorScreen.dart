import 'package:flutter/material.dart';

import 'package:flame/game.dart';

import 'gameScreen.dart';

class DualDifficultyGamePage extends StatelessWidget {
  final int mapSize;

  const DualDifficultyGamePage({Key? key, this.mapSize = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dual Difficulty Game'),
      ),
      body: GameWidget<DualDifficulty>.controlled(
        gameFactory: () => DualDifficulty(mapSize: mapSize),
      ),
    );
  }
}

class LevelSelector extends StatelessWidget {
  const LevelSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select your level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DualDifficultyGamePage(mapSize: 5),
                  ),
                );
              },
              child: const Text('Dual Difficulty Game 5'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DualDifficultyGamePage(),
                  ),
                );
              },
              child: const Text('Dual Difficulty Game 10'),
            ),
          ],
        ),
      ),
    );
  }
}