import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_app_fly/game_loop.dart';
import 'package:flutter_app_fly/view.dart';

class Fly {

  Rect flyRect;
  final GameLoop gameLoop;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  double get speed => gameLoop.tileSize * 3; //variavel que só pode ser lida
  Offset targetLocation;

  Fly(this.gameLoop){
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = gameLoop.rnd.nextDouble() * (gameLoop.screenSize.width - (gameLoop.tileSize * 2));
    double y = gameLoop.rnd.nextDouble() * (gameLoop.screenSize.height - (gameLoop.tileSize * 2));
    targetLocation = Offset(x, y);
  }

  void render(Canvas canvas) {
    if(isDead) {
      deadSprite.renderRect(canvas, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(canvas, flyRect.inflate(2));
    }
  }

  void update(double time) {
    if (isDead) {
      flyRect = flyRect.translate(0, gameLoop.tileSize * 12 * time);
      if (flyRect.top > gameLoop.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * time;
      flyingSpriteIndex = flyingSpriteIndex % flyingSprite.length;

      double stepDistance = speed * time;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }

    }
  }

  void onTapDown() {
    isDead = true;
    if (gameLoop.activeView == View.playing) {
      gameLoop.score += 1;
    }
  }

}