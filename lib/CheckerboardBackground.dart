import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CheckerboardBackground extends Component {
  static const cellSize = 32.0;
  late Paint darkPaint;
  late Paint lightPaint;

  @override
  int priority = -1;

  CheckerboardBackground() {
    darkPaint = Paint()..color = Colors.green;
    lightPaint = Paint()..color = Colors.blue;
  }

  @override
  void render(Canvas canvas) {
    for (var x = 0; x < 5000; x += 50) {
      for (var y = 0; y < 5000; y += 50) {
        final paint = (x ~/ cellSize + y ~/ cellSize) % 2 == 0 ? darkPaint : lightPaint;
        canvas.drawRect(Rect.fromLTWH(x.toDouble(), y.toDouble(), cellSize, cellSize), paint);
      }
    }
  }
}

