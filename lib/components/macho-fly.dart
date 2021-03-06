import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter_app_fly/components/fly.dart';
import 'package:flutter_app_fly/game_loop.dart';

class MachoFly extends Fly {

  double get speed => gameLoop.tileSize * 2.2; //variavel que só pode ser lida

  MachoFly (GameLoop gameLoop, double x, double y) : super(gameLoop, 1) {
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize * 1.35, gameLoop.tileSize * 2.0);

    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/macho-fly-1.png"));
    flyingSprite.add(Sprite("flies/macho-fly-2.png"));
    deadSprite = Sprite("flies/macho-fly-dead.png");

    pointValue = 2;
  }

}