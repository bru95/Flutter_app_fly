import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_app_fly/components/fly.dart';
import 'package:flutter_app_fly/game_loop.dart';

class DroolerFly extends Fly {

  DroolerFly (GameLoop gameLoop, double x, double y) : super(gameLoop, 2) {
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize * 1.5);

    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/drooler-fly-1.png"));
    flyingSprite.add(Sprite("flies/drooler-fly-2.png"));
    deadSprite = Sprite("flies/drooler-fly-dead.png");

    pointValue = 1;
  }

}