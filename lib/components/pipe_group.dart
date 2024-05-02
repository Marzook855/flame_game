import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

import 'package:games/components/pipe.dart';
import 'package:games/game/assets.dart';
import 'package:games/game/configuartion.dart';
import 'package:games/game/flappy_bird_game.dart';
import 'package:games/game/pipe_postition.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centery =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centery - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centery + spacing / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
