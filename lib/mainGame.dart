import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'CheckerboardBackground.dart';
import 'actors/player.dart';
import '../helpers/enums.dart';
import 'managers/segmentManager.dart';
import 'objects.dart';

class DualDifficulty extends FlameGame with HorizontalDragDetector, VerticalDragDetector,
    HasCollisionDetection, TapCallbacks {
  DualDifficulty();

  late Player player;
  late Player player2;
  late CheckerboardBackground background;
  final someVector = Vector2(100, 100);
  Direction? direction;
  late final World cameraWorld;

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

  void initializeGame() {
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }
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
      gridPosition: Vector2(5,6),
      cameraComponent: cameras[0]
     );

    player2 = Player(
      gridPosition: Vector2(15,6),
        cameraComponent: cameras[1]
    );

    cameraWorld.add(player);

    cameraWorld.add(player2);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          break;
        case WallBlock:
         cameraWorld.add(WallBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          break;
      }
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
    if (direction != null) {
      player.move(direction!);
      player2.move(direction!);
      direction = null;
    }
  }

  @override
  void onVerticalDragEnd(DragEndInfo info) {
    if (direction != null) {
      player.move(direction!);
      player2.move(direction!);
      direction = null;
    }
  }

}
