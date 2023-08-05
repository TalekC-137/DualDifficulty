import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MapEditor extends FlameGame with TapDetector {
  final int rows = 8;
  final int cols = 8;
  final double squareSize = 64;
  final double outlineThickness = 2.0;
  late List<List<bool>> squareStates;
  double scale = 1.0;
  final double zoomFactor = 0.2;

  MapEditor() {
    squareStates = List.generate(rows, (y) => List.generate(cols, (x) => false));
  }

  void zoomIn() {
    scale += zoomFactor;
  }

  void zoomOut() {
    if (scale - zoomFactor > 0) {
      scale -= zoomFactor;
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(scale);
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

    canvas.restore();
  }

  @override
  void onTapDown(TapDownInfo details) {
    final Vector2 touchPosition = details.eventPosition.game / scale;
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
