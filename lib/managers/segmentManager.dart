import 'package:flame/components.dart';
import '../objects.dart';

class Block {

  final Vector2 gridPosition;
  final Type blockType;
  Block(this.gridPosition, this.blockType);
}

final segments = [
  segment0,
  segment1,
  segment2
];

final segment0 = [
  //left wall
  Block(Vector2(0, 0), WallBlock),
  Block(Vector2(0, 1), WallBlock),
  Block(Vector2(0, 2), WallBlock),
  Block(Vector2(0, 3), GroundBlock),
  Block(Vector2(0, 4), WallBlock),
  Block(Vector2(0, 5), WallBlock),
  Block(Vector2(0, 6), GroundBlock),
  Block(Vector2(0, 7), GroundBlock),
  Block(Vector2(0, 8), GroundBlock),
  Block(Vector2(0, 9), WallBlock),
  Block(Vector2(0, 10), WallBlock),
  //right wall
  Block(Vector2(10, 0), WallBlock),
  Block(Vector2(10, 1), WallBlock),
  Block(Vector2(10, 2), WallBlock),
  Block(Vector2(10, 3), WallBlock),
  Block(Vector2(10, 4), WallBlock),
  Block(Vector2(10, 5), WallBlock),
  Block(Vector2(10, 6), WallBlock),
  Block(Vector2(10, 7), WallBlock),
  Block(Vector2(10, 8), WallBlock),
  Block(Vector2(10, 9), WallBlock),
  Block(Vector2(10, 10), WallBlock),
  //bottom wall
  Block(Vector2(1, 0), WallBlock),
  Block(Vector2(2, 0), WallBlock),
  Block(Vector2(3, 0), WallBlock),
  Block(Vector2(4, 0), WallBlock),
  Block(Vector2(5, 0), WallBlock),
  Block(Vector2(6, 0), WallBlock),
  Block(Vector2(7, 0), WallBlock),
  Block(Vector2(8, 0), WallBlock),
  Block(Vector2(9, 0), WallBlock),

  //top wall
  Block(Vector2(1, 10), WallBlock),
  Block(Vector2(2, 10), WallBlock),
  Block(Vector2(3, 10), WallBlock),
  Block(Vector2(4, 10), WallBlock),
  Block(Vector2(5, 10), WallBlock),
  Block(Vector2(6, 10), WallBlock),
  Block(Vector2(7, 10), WallBlock),
  Block(Vector2(8, 10), WallBlock),
  Block(Vector2(9, 10), WallBlock),

  //puzzle
  Block(Vector2(2, 0), WallBlock),
  Block(Vector2(2, 1), WallBlock),
  Block(Vector2(3, 2), WallBlock),
  Block(Vector2(3, 3), WallBlock),
  Block(Vector2(3, 4), WallBlock),
  Block(Vector2(3, 5), WallBlock),
  Block(Vector2(3, 6), WallBlock),

];

final segment1 = [
//left wall
  Block(Vector2(0, 0), WallBlock),
  Block(Vector2(0, 1), WallBlock),
  Block(Vector2(0, 2), WallBlock),
  Block(Vector2(0, 3), WallBlock),
  Block(Vector2(0, 4), WallBlock),
  Block(Vector2(0, 5), WallBlock),
  Block(Vector2(0, 6), WallBlock),
  Block(Vector2(0, 7), WallBlock),
  Block(Vector2(0, 8), WallBlock),
  Block(Vector2(0, 9), WallBlock),
  Block(Vector2(0, 10), WallBlock),
  //right wall
  Block(Vector2(10, 0), WallBlock),
  Block(Vector2(10, 1), WallBlock),
  Block(Vector2(10, 2), WallBlock),
  Block(Vector2(10, 3), WallBlock),
  Block(Vector2(10, 4), WallBlock),
  Block(Vector2(10, 5), WallBlock),
  Block(Vector2(10, 6), WallBlock),
  Block(Vector2(10, 7), WallBlock),
  Block(Vector2(10, 8), WallBlock),
  Block(Vector2(10, 9), WallBlock),
  Block(Vector2(10, 10), WallBlock),
  //bottom wall
  Block(Vector2(1, 0), WallBlock),
  Block(Vector2(2, 0), WallBlock),
  Block(Vector2(3, 0), WallBlock),
  Block(Vector2(4, 0), WallBlock),
  Block(Vector2(5, 0), WallBlock),
  Block(Vector2(6, 0), WallBlock),
  Block(Vector2(7, 0), WallBlock),
  Block(Vector2(8, 0), WallBlock),
  Block(Vector2(9, 0), WallBlock),

  //top wall
  Block(Vector2(1, 10), WallBlock),
  Block(Vector2(2, 10), WallBlock),
  Block(Vector2(3, 10), WallBlock),
  Block(Vector2(4, 10), WallBlock),
  Block(Vector2(5, 10), WallBlock),
  Block(Vector2(6, 10), WallBlock),
  Block(Vector2(7, 10), WallBlock),
  Block(Vector2(8, 10), WallBlock),
  Block(Vector2(9, 10), WallBlock),

  //puzzle
  Block(Vector2(3, 0), WallBlock),
  Block(Vector2(3, 1), WallBlock),
  Block(Vector2(3, 2), WallBlock),
  Block(Vector2(3, 3), WallBlock),
  Block(Vector2(3, 4), WallBlock),
  Block(Vector2(3, 5), WallBlock),
  Block(Vector2(3, 6), WallBlock),

];

final segment2 = [

];
