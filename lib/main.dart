import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/flappy_bird_game.dart';
import 'package:games/screens/game_over_screen.dart';
import 'package:games/screens/main_menu_screens.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(GameWidget(
    game: game,
    initialActiveOverlays: const [MainMenuScreen.id],
    overlayBuilderMap: {
      'mainMenu': (context, _) => MainMenuScreen(game: game),
      'gameOver': (context, _) => GameOverScreen(game: game),
    },
  ));
}
