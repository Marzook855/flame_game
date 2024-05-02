import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/widgets.dart';

import 'package:games/components/bird_movement.dart';
import 'package:games/game/assets.dart';
import 'package:games/game/configuartion.dart';
import 'package:games/game/flappy_bird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();
  int score = 0;
  @override
  void onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdownFlap = await gameRef.loadSprite(Assets.birdownFlap);

    size = Vector2(80, 80);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.dowm: birdownFlap
    };

    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(Vector2(0, Config.gravity),
          EffectController(duration: 0.2, curve: Curves.decelerate),
          onComplete: () => current = BirdMovement.dowm),
    );
    current = BirdMovement.up;
    FlameAudio.play(Assets.flying);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  void gameOver() {
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit = true;

    FlameAudio.play(Assets.collision);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
  }
}
