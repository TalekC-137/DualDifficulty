import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'CheckerboardBackground.dart';
import 'actors/player.dart';
import '../helpers/enums.dart';
import 'managers/segmentManager.dart';
import 'objects.dart';

class DualDifficulty extends FlameGame with HorizontalDragDetector, VerticalDragDetector, HasCollisionDetection {
  DualDifficulty();

  late Player player;
  late CheckerboardBackground background;
  final someVector = Vector2(100, 100);
  Direction? direction;

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


    background = CheckerboardBackground();
    add(background);
    initializeGame();
    camera.followVector2(player.position);

  }

  void initializeGame() {
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    player = Player(
      gridPosition: Vector2(5,5),
    );
    add(player);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          break;
        case WallBlock:
          add(WallBlock(
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
      direction = null;
    }
  }

  @override
  void onVerticalDragEnd(DragEndInfo info) {
    if (direction != null) {
      player.move(direction!);
      direction = null;
    }
  }
}
