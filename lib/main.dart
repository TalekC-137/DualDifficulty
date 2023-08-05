
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_upward),
                    onPressed: game.moveUp,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: game.moveLeft,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_downward),
                    onPressed: game.moveDown,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: game.moveRight,
                  ),
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
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('red'),
              onTap: () {
                game.changeColor(Colors.red);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('green'),
              onTap: () {
                game.changeColor(Colors.green);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('purple'),
              onTap: () {
                game.changeColor(Colors.purple);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: GameWidget(game: game),
    );
  }
}




