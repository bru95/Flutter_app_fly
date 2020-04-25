import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_app_fly/components/fly.dart';
import 'package:flutter_app_fly/game_loop.dart';

class HungryFly extends Fly {

  HungryFly (GameLoop gameLoop, double x, double y) : super(gameLoop, 1) {
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize * 1.1, gameLoop.tileSize * 1.65);

    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/hungry-fly-1.png"));
    flyingSprite.add(Sprite("flies/hungry-fly-2.png"));
    deadSprite = Sprite("flies/hungry-fly-dead.png");

    pointValue = 2;
  }

}