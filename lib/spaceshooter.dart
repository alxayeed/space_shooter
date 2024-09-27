import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'components/player.dart';

class SpaceShooter extends FlameGame with PanDetector {
  late Player player;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final playerSprite = await loadSprite("player.png");

    player = Player()
      ..sprite = playerSprite
      ..x = size.x / 2
      ..y = size.y / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;

    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}
