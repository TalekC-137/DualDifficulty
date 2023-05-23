import 'dart:io';

import 'package:hive/hive.dart';

import 'map_builder.dart';
import 'package:flame/game.dart';
import 'mainGame.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}


@HiveType(typeId: 0)
class MapData extends HiveObject {
  @HiveField(0)
  String mapName;

  @HiveField(1)
  List<BlockData> blocks;

  MapData(this.mapName, this.blocks);
}

@HiveType(typeId: 1)
class BlockData extends HiveObject {
  @HiveField(0)
  String xValue;

  @HiveField(1)
  int yValue;

  @HiveField(2)
  Type blockType;

  BlockData(this.xValue, this.yValue, this.blockType);
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DualDifficultyGamePage(),
                  ),
                );
              },
              child: const Text('Dual Difficulty Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapBuilderGamePage(),
                  ),
                );
              },
              child: const Text('Map Builder Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class DualDifficultyGamePage extends StatelessWidget {
  const DualDifficultyGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dual Difficulty Game'),
      ),
      body: const GameWidget<DualDifficulty>.controlled(
        gameFactory: DualDifficulty.new,
      ),
    );
  }
}

class MapBuilderGamePage extends StatelessWidget {
  const MapBuilderGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Builder Game'),
      ),
      body: const GameWidget<MapBuilder>.controlled(
        gameFactory: MapBuilder.new,
      ),
    );
  }
}

