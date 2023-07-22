import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'helpers/map_data.dart';
import 'main.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadDataOnce();
  }

  void navigateToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Loading indicator
      ),
    );
  }

  Future loadDataOnce() async {
    Hive.registerAdapter(MapDataAdapter());
    Hive.registerAdapter(BlockDataAdapter());

    var box = await Hive.openBox('Box');
    bool hasLoaded = box.get('hasLoaded', defaultValue: false);

    if (!hasLoaded) {
      loadMapData(box);
      print("load");
    } else {
      navigateToMainScreen();
      print("main");
    }
  }


  Future loadMapData(Box<dynamic> box) async {
    // Initialize your Hive here.

    List<BlockData> map1 = [
      BlockData(0, 0, "WallBlock"),
      BlockData(0, 1, "WallBlock"),
      BlockData(0, 2, "WallBlock"),
      BlockData(0, 3, "GroundBlock"),
      BlockData(0, 4, "WallBlock"),
      BlockData(0, 5, "WallBlock"),
      BlockData(0, 6, "GroundBlock"),
      BlockData(0, 7, "GroundBlock"),
      BlockData(0, 8, "GroundBlock"),
      BlockData(0, 9, "WallBlock"),
      BlockData(0, 10, "WallBlock"),
      //right wall
      BlockData(10, 0, "WallBlock"),
      BlockData(10, 1, "WallBlock"),
      BlockData(10, 2, "WallBlock"),
      BlockData(10, 3, "WallBlock"),
      BlockData(10, 4, "WallBlock"),
      BlockData(10, 5, "WallBlock"),
      BlockData(10, 6, "WallBlock"),
      BlockData(10, 7, "WallBlock"),
      BlockData(10, 8, "WallBlock"),
      BlockData(10, 9, "WallBlock"),
      BlockData(10, 10, "WallBlock"),
      //bottom wall
      BlockData(1, 0, "WallBlock"),
      BlockData(2, 0, "WallBlock"),
      BlockData(3, 0, "WallBlock"),
      BlockData(4, 0, "WallBlock"),
      BlockData(5, 0, "WallBlock"),
      BlockData(6, 0, "WallBlock"),
      BlockData(7, 0, "WallBlock"),
      BlockData(8, 0, "WallBlock"),
      BlockData(9, 0, "WallBlock"),
      //top wall
      BlockData(1, 10, "WallBlock"),
      BlockData(2, 10, "WallBlock"),
      BlockData(3, 10, "WallBlock"),
      BlockData(4, 10, "WallBlock"),
      BlockData(5, 10, "WallBlock"),
      BlockData(6, 10, "WallBlock"),
      BlockData(7, 10, "WallBlock"),
      BlockData(8, 10, "WallBlock"),
      BlockData(9, 10, "WallBlock"),
      //puzzle
      BlockData(2, 0, "WallBlock"),
      BlockData(2, 1, "WallBlock"),
      BlockData(3, 2, "WallBlock"),
      BlockData(3, 3, "WallBlock"),
      BlockData(3, 4, "WallBlock"),
      BlockData(3, 5, "WallBlock"),
      BlockData(3, 6, "WallBlock"),

      //second part:
      //right wall
      BlockData(20, 0, "WallBlock"),
      BlockData(20, 1, "WallBlock"),
      BlockData(20, 2, "WallBlock"),
      BlockData(20, 3, "WallBlock"),
      BlockData(20, 4, "WallBlock"),
      BlockData(20, 5, "WallBlock"),
      BlockData(20, 6, "WallBlock"),
      BlockData(20, 7, "WallBlock"),
      BlockData(20, 8, "WallBlock"),
      BlockData(20, 9, "WallBlock"),
      BlockData(20, 10, "WallBlock"),
//bottom wall
      BlockData(11, 0, "WallBlock"),
      BlockData(12, 0, "WallBlock"),
      BlockData(13, 0, "WallBlock"),
      BlockData(14, 0, "WallBlock"),
      BlockData(15, 0, "WallBlock"),
      BlockData(16, 0, "WallBlock"),
      BlockData(17, 0, "WallBlock"),
      BlockData(18, 0, "WallBlock"),
      BlockData(19, 0, "WallBlock"),
//top wall
      BlockData(11, 10, "WallBlock"),
      BlockData(12, 10, "WallBlock"),
      BlockData(13, 10, "WallBlock"),
      BlockData(14, 10, "WallBlock"),
      BlockData(15, 10, "WallBlock"),
      BlockData(16, 10, "WallBlock"),
      BlockData(17, 10, "WallBlock"),
      BlockData(18, 10, "WallBlock"),
      BlockData(19, 10, "WallBlock"),
//puzzle
      BlockData(13, 0, "WallBlock"),
      BlockData(13, 1, "WallBlock"),
      BlockData(13, 2, "WallBlock"),
      BlockData(13, 3, "WallBlock"),
      BlockData(13, 4, "WallBlock"),
      BlockData(13, 5, "WallBlock"),
      BlockData(13, 6, "WallBlock"),
    ];

    await box.put("testMap", MapData(mapName: "level one", blocks: map1));
    await box.put('hasLoaded', true);

    box.close();
    // Once finished with all the loading tasks, navigate to main screen.
    navigateToMainScreen();
  }
}