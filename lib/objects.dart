import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'mainGame.dart';

class GroundBlock{}

class Star{}


class WallBlock extends SpriteComponent
    with HasGameRef<DualDifficulty> {
  final Vector2 gridPosition;
  double xOffset;

  WallBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    final wallImage = game.images.fromCache('crate.png');
    sprite = Sprite(wallImage);
    position = Vector2((gridPosition.x * size.x) + xOffset,
      gridPosition.y * size.y,
    );
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}