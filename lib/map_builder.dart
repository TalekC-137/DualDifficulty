import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/extensions.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'CheckerboardBackground.dart';

class MapEditor extends FlameGame with TapDetector {
  final int rows = 8;
  final int cols = 8;
  final double squareSize = 64;
  final double outlineThickness = 2.0;
  late List<List<bool>> squareStates;
  double scale = 1.0;
  final double zoomFactor = 0.2;
  double offsetX = 0.0;
  double offsetY = 0.0;
  final double moveFactor = 32.0;
  Color pickedColor = Colors.red;

  MapEditor() {
    squareStates = List.generate(rows, (y) => List.generate(cols, (x) => false));
    add(CheckerboardBackground());
  }

  void zoomIn() {
    if (scale + zoomFactor < 3.5) {
      scale += zoomFactor;
    }
  }

  void zoomOut() {
    if (scale - zoomFactor > 0.001) {
      scale -= zoomFactor;
      print("zoom " + (scale-zoomFactor).toString());
    }
  }

  void changeColor(Color color){
    pickedColor = color;
  }


  void moveLeft() {
    offsetX += moveFactor;
  }

  void moveRight() {
    offsetX -= moveFactor;
  }

  void moveDown() {
    offsetY -= moveFactor;
  }

  void moveUp() {
    offsetY += moveFactor;
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(offsetX, offsetY); // Moved above scale
    canvas.scale(scale);
    super.render(canvas);

    final Paint fillPaint = Paint();
    final Paint outlinePaint = Paint()..color = Colors.white;

    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        fillPaint.color = squareStates[y][x] ? pickedColor : Colors.blue;
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
    final Vector2 touchPosition = details.eventPosition.game;
    final int x = ((touchPosition.x - offsetX) / (scale * squareSize)).floor();
    final int y = ((touchPosition.y - offsetY) / (scale * squareSize)).floor();

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
