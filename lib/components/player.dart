import 'dart:async';

import 'package:flame/components.dart';
import 'package:spaceshooter/components/bullet.dart';
import 'package:spaceshooter/spaceshooter.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooter> {
  Player()
      : super(
          size: Vector2(50, 70),
          anchor: Anchor.center,
        );

  late final SpawnComponent _bulletSpawner;

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

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                -height / 2,
              ),
        );

        // return bullet;
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}
