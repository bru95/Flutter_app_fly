import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_app_fly/components/fly.dart';
import 'package:flutter_app_fly/game_loop.dart';

class HouseFly extends Fly {

  HouseFly (GameLoop gameLoop, double x, double y) : super(gameLoop) {
    //espaço de toque
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize * 1.5, gameLoop.tileSize * 1.5);

    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/house-fly-1.png"));
    flyingSprite.add(Sprite("flies/house-fly-2.png"));
    deadSprite = Sprite("flies/house-fly-dead.png");
  }

}