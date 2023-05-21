import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../mainGame.dart';
import '../helpers/enums.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<DualDifficulty>, CollisionCallbacks {
  final Vector2 gridPosition;

  Player({
    required this.gridPosition,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  final Vector2 velocity = Vector2.zero();
  late Vector2 directionVector = Vector2.zero();
  final double moveSpeed = 500;
  bool isMoving = false;

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
    position = Vector2((gridPosition.x * size.x),
      game.size.y - (gridPosition.y * size.y),
    );
    add(
      RectangleHitbox(),
    );
  }
  @override
  void update(double dt) {
    velocity.x = directionVector.x * moveSpeed;
    velocity.y = directionVector.y * moveSpeed;
    position += velocity * dt;

    super.update(dt);
  }

 @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    isMoving = false;

    position = position-(directionVector * 10);

    directionVector = Vector2(0,0);

    super.onCollision(intersectionPoints, other);
  }

  void move(Direction direction) {
    if(!isMoving) {
      isMoving = true;
      switch (direction) {
        case Direction.down:
          directionVector = Vector2(0, 1);
          break;
        case Direction.up:
          directionVector = Vector2(0, -1);
          break;
        case Direction.right:
          directionVector = Vector2(1, 0);
          break;
        case Direction.left:
          directionVector = Vector2(-1, 0);
          break;
      }
    }
  }
}
