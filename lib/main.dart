
import 'package:dual_difficulty/screens/LevelSelectorScreen.dart';

import 'screens/LoadingScreen.dart';
import 'map_builder.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.green,
      ),
      home: const LoadingScreen(),
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
                    builder: (context) => const LevelSelector(),
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
                    builder: (context) => MapEditorWidget(),
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

class MapEditorWidget extends StatelessWidget {
  final game = MapEditor();

  MapEditorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Editor'),
        actions: [
          Padding(
            // Add padding to position the buttons
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: game.zoomIn,
                ),
                IconButton(
                  icon: Icon(Icons.zoom_out),
                  onPressed: game.zoomOut,
                ),
              ],
            ),
          ),
        ],
      ),
      body: GameWidget(game: game),
    );
  }
}

