import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

import 'components/enemy.dart';
import 'components/player.dart';

class SpaceShooter extends FlameGame with PanDetector, HasCollisionDetection {
  late Player player;
  @override
  Future<void> onLoad() async {
    // await super.onLoad();
    final parallax = await loadParallaxComponent([
      ParallaxImageData("stars_0.png"),
      ParallaxImageData("stars_1.png"),
      ParallaxImageData("stars_2.png"),
    ],
        baseVelocity: Vector2(0, 5),
        repeat: ImageRepeat.repeat,
        velocityMultiplierDelta: Vector2(0, -5));

    add(parallax);

    player = Player();
    add(player);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}
