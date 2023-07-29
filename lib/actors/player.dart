import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/cupertino.dart';

import '../objects.dart';
import '../screens/gameScreen.dart';
import '../helpers/enums.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<DualDifficulty>, CollisionCallbacks {
  final Vector2 gridPosition;
  final CameraComponent cameraComponent;
  final VoidCallback onPlayerStopped;

  Player({
    required this.gridPosition, required this.cameraComponent, required this.onPlayerStopped
  }) : super(size: Vector2.all(50), anchor: Anchor.center);

  final Vector2 velocity = Vector2.zero();
  late Vector2 directionVector = Vector2.zero();
  final double moveSpeed = 500;
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
    position = Vector2((gridPosition.x * 64),
      (gridPosition.y * size.y) * -1,
    );
    add(
      RectangleHitbox(),
    );
  }
  @override
  void update(double dt) {

    cameraComponent.viewfinder.position = position;

    velocity.x = directionVector.x * moveSpeed;
    velocity.y = directionVector.y * moveSpeed;
    position += velocity * dt;

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //prevents player to collide with finish block
    if (other is! FinishBlock) {
      onPlayerStopped();
      //sets position to the center of the current block after collision to avoid texture clipping and getting stuck
      position = Vector2((position.x/64).round() * 64, (position.y/64).round() * 64 );

      directionVector = Vector2(0,0);
    }

    super.onCollision(intersectionPoints, other);
  }

  void move(Direction direction) {
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
