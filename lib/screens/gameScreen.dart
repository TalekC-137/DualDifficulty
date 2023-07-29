import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:hive/hive.dart';
import '../CheckerboardBackground.dart';
import '../actors/player.dart';
import '../../helpers/enums.dart';
import '../main.dart';
import '../managers/segmentManager.dart';
import '../objects.dart';
import '../helpers/map_data.dart';
import 'package:flutter/material.dart';

class DualDifficulty extends FlameGame with HorizontalDragDetector, VerticalDragDetector,
    HasCollisionDetection, TapCallbacks {
  late int mapSize;

  DualDifficulty({this.mapSize = 10});

  late Player player;
  late Player player2;
  late CheckerboardBackground background;
  final someVector = Vector2(100, 100);
  Direction? direction;
  late final World cameraWorld;
  bool playerMoving = false;
  bool player2Moving = false;
  bool playerFinished = false;
  bool player2Finished = false;

  late Vector2 finish1Position;
  late Vector2 finish2Position;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'crate.png',
      'ember.png',
      'plank.png',
      '1.png',
      '2.png',
      'coins.png',
      'spikes.png',
    ]);
    cameraWorld = World();
    add(cameraWorld);

    background = CheckerboardBackground();
    cameraWorld.add(background);
    initializeGame();

  }

  Future<void> initializeGame() async {
    var box = await Hive.openBox('Box');

    MapData myData = box.get('testMap');
    //generating puzzle
    late Vector2 playerOne;
    late  Vector2 playerTwo;

    for (var block in myData.blocks) {

      Vector2 blockPosition = Vector2(block.gridPositionX, block.gridPositionY);

      switch (block.blockType) {
        case "PlayerOne":
          playerOne = blockPosition;
          break;
        case "mapSize":
          mapSize = blockPosition.x as int;
          break;
        case "PlayerTwo":
          playerTwo = blockPosition;
          break;
        case "GroundBlock":
          cameraWorld.add(GroundBlock(
            gridPosition: blockPosition,
            xOffset: 0,
          ));
          break;
        case "WallBlock":
          cameraWorld.add(WallBlock(
            gridPosition: blockPosition,
            xOffset: 0,
          ));
          break;
        case "FinishBlock1":
          cameraWorld.add(FinishBlock(
            gridPosition: blockPosition,
            xOffset: 0,
          ));
          finish1Position = blockPosition;
          break;
        case "FinishBlock2":
          cameraWorld.add(FinishBlock(
            gridPosition: blockPosition,
            xOffset: 0,
          ));
          finish2Position = blockPosition;
          break;
      }
    }
    // generating outer border
    for(var i = 0; i < 3; i++){
      for(var j = 0; j <= mapSize*2; j++){
        if(j<mapSize) {
          Vector2 verticalWallPosition = Vector2(i * mapSize as double, j as double);
          cameraWorld.add(WallBlock(
            gridPosition: verticalWallPosition,
            xOffset: 0,
          ));
        }

        if(i<2){
          Vector2 horizontalWallPosition = Vector2(j as double, i*mapSize as double);
          cameraWorld.add(WallBlock(
            gridPosition: horizontalWallPosition,
            xOffset: 0,
          ));
        }
      }
    }

    addPlayers(playerOne, playerTwo);
    box.close();
  }

  void addPlayers(Vector2 p1, Vector2 p2){
    final isHorizontal = canvasSize.x > canvasSize.y;
    Vector2 alignedVector({
      required double longMultiplier,
      double shortMultiplier = 1.0,
    }) {
      return Vector2(
        isHorizontal
            ? canvasSize.x * longMultiplier
            : canvasSize.x * shortMultiplier,
        !isHorizontal
            ? canvasSize.y * longMultiplier
            : canvasSize.y * shortMultiplier,
      );
    }
    final viewportSize = alignedVector(longMultiplier:0.5);

    RectangleComponent viewportRimGenerator() =>
        RectangleComponent(size: viewportSize, anchor: Anchor.topLeft)
          ..paint.strokeWidth = 5.0
          ..paint.style = PaintingStyle.stroke;

    final cameras = List.generate(2, (i) {
      return CameraComponent(
        world: cameraWorld,
        viewport: FixedSizeViewport(viewportSize.x, viewportSize.y)
          ..position = alignedVector(
            longMultiplier: i == 0 ? 0.0 : 1 / (2),
            shortMultiplier: 0.0,
          )
          ..add(viewportRimGenerator()),
      )
        ..viewfinder.anchor = Anchor.center
        ..viewfinder.zoom = 1.0;
    });

    addAll(cameras);
    player = Player(
        gridPosition: p1,
        cameraComponent: cameras[0], onPlayerStopped: () {
        playerMoving = false;

        Vector2 checkPosition = Vector2((player.position.x / 64).round() as double,
          ((player.position.y /player.size.y) * -1).round() as double,
        );

        if(checkPosition == finish1Position){
          playerFinished = true;
          hasGameFinished();
        }else{
          playerFinished = false;
        }
    }
    );

    player2 = Player(
        gridPosition: p2,
        cameraComponent: cameras[1], onPlayerStopped: () {
        player2Moving = false;

        Vector2 checkPosition = Vector2((player2.position.x / 64).round() as double,
          ((player2.position.y /player2.size.y) * -1).round() as double,
        );

        if(checkPosition == finish2Position){
          player2Finished = true;
          hasGameFinished();
        }else{
          player2Finished = false;
        }
    }
    );

    cameraWorld.add(player);

    cameraWorld.add(player2);
  }

  void hasGameFinished(){

    if(playerFinished && player2Finished){

     print("asdasdasd" + "congrats!!!!");

    }
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    if (direction == null) {
      if (info.delta.game.x > 0) {
        direction = Direction.right;
      } else if (info.delta.game.x < 0) {
        direction = Direction.left;
      }
    }
  }

  @override
  void onVerticalDragUpdate(DragUpdateInfo info) {
    if (direction == null) {
      if (info.delta.game.y > 0) {
        direction = Direction.down;
      } else if (info.delta.game.y < 0) {
        direction = Direction.up;
      }
    }
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    if (direction != null && !playerMoving && !player2Moving) {
      player.move(direction!);
      player2.move(direction!);
      direction = null;
      playerMoving = true;
      player2Moving = true;
    }
  }

  @override
  void onVerticalDragEnd(DragEndInfo info) {
    if (direction != null && !playerMoving && !player2Moving) {
      player.move(direction!);
      player2.move(direction!);
      direction = null;
      playerMoving = true;
      player2Moving = true;
    }
  }

}
