import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter_app_fly/game_loop.dart';
import 'package:flutter_app_fly/view.dart';

class StartButton {
  final GameLoop game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('ui/start-button.png');
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void update(double time) {}

  void onTapDown() {
    game.score = 0;
    game.activeView = View.playing;
    game.spawner.start();
    game.playPlayingBGM();
  }
}