import 'dart:async';

import 'package:flame/components.dart';
import 'package:spaceshooter/spaceshooter.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooter> {
  Player()
      : super(
          size: Vector2(50, 70),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      "player.png",
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .1,
        textureSize: Vector2(32, 38),
      ),
    );

    position = game.size / 2;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
