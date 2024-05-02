import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:games/game/assets.dart';
import 'package:games/game/flappy_bird_game.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = ' gameOver';
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'score: ${game.bird.score}',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontFamily: 'game',
              ),
            ),
            Image.asset(
              Assets.gameOver,
              cacheHeight: 100,
              cacheWidth: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onRestart,
              child: const Text(
                'Restart ',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
