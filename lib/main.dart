import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

import 'mainGame.dart';

void main() {
  runApp(
    const GameWidget<DualDifficulty>.controlled(
      gameFactory: DualDifficulty.new,
    ),
  );
}