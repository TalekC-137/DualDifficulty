import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../helpers/map_data.dart';
import '../main.dart';

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
    } else {
      navigateToMainScreen();
    }
  }

  Future loadMapData(Box<dynamic> box) async {
    List<BlockData> map1 = [

      //players position


      BlockData(3, 1, "PlayerOne"),
      BlockData(11, 1, "PlayerTwo"),
      //map size
      BlockData(10, 10, "mapSize"),

      //puzzle
      BlockData(2, 1, "GroundBlock"),
      BlockData(3, 2, "GroundBlock"),
      BlockData(3, 3, "GroundBlock"),
      BlockData(3, 4, "GroundBlock"),
      BlockData(3, 5, "GroundBlock"),
      BlockData(3, 6, "GroundBlock"),
      //second part:
      BlockData(13, 1, "GroundBlock"),
      BlockData(13, 2, "GroundBlock"),
      BlockData(13, 3, "GroundBlock"),
      BlockData(13, 4, "GroundBlock"),
      BlockData(13, 5, "GroundBlock"),
      BlockData(13, 6, "GroundBlock"),
    ];

    await box.put("testMap", MapData(mapName: "level one", blocks: map1));
    await box.put('hasLoaded', true);

    box.close();
    // Once finished with all the loading tasks, navigate to main screen.
    navigateToMainScreen();
  }
}