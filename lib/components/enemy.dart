import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spaceshooter/components/player.dart';
import 'package:spaceshooter/spaceshooter.dart';

import 'bullet.dart';
import 'explosion.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooter>, CollisionCallbacks {
  Enemy({super.position})
      : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );

  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(16),
      ),
    );
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;
    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
    }

    if (other is Player) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
      Future.delayed(const Duration(seconds: 3), () {
        game.add(Player());
      });
    }
  }
}
