import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';



class GroundBlock extends SpriteComponent
    with HasGameRef<FlameGame> {
  final Vector2 gridPosition;
  double xOffset;

  GroundBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    final wallImage = game.images.fromCache('1.png');
    sprite = Sprite(wallImage);
    position = Vector2((gridPosition.x * size.x) + xOffset,
      (gridPosition.y * size.y) * -1,
    );
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}

class Star{}


class WallBlock extends SpriteComponent
    with HasGameRef<FlameGame> {
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
      (gridPosition.y * size.y) * -1,
    );
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}