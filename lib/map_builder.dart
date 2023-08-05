import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MapEditor extends FlameGame with TapDetector {
  final int rows = 12;
  final int cols = 12;
  final double squareSize = 64;
  final double outlineThickness = 2.0; // thickness of the outline
  late List<List<bool>> squareStates; // true if red, false if blue

  MapEditor() {
    squareStates = List.generate(rows, (y) => List.generate(cols, (x) => false));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final Paint fillPaint = Paint();
    final Paint outlinePaint = Paint()..color = Colors.white;

    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        fillPaint.color = squareStates[y][x] ? Colors.red : Colors.blue;
        final Rect rect = Rect.fromPoints(
          Offset(x * squareSize, y * squareSize),
          Offset((x + 1) * squareSize, (y + 1) * squareSize),
        );
        canvas.drawRect(rect, fillPaint);

        final Rect outlineRect = Rect.fromPoints(
          Offset(x * squareSize + outlineThickness, y * squareSize + outlineThickness),
          Offset((x + 1) * squareSize - outlineThickness, (y + 1) * squareSize - outlineThickness),
        );
        canvas.drawRect(outlineRect, outlinePaint);
      }
    }
  }

  @override
  void onTapDown(TapDownInfo details) {
    final Vector2 touchPosition = details.eventPosition.game;
    final int x = (touchPosition.x / squareSize).floor();
    final int y = (touchPosition.y / squareSize).floor();

    if (x >= 0 && x < cols && y >= 0 && y < rows) {

      squareStates[y][x] = !squareStates[y][x];
      print('Square coordinates: ($x, $y)');
    }
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
