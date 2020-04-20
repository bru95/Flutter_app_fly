import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_fly/components/agile-fly.dart';
import 'package:flutter_app_fly/components/backyard.dart';
import 'package:flutter_app_fly/components/drooler-fly.dart';
import 'package:flutter_app_fly/components/house-fly.dart';
import 'package:flutter_app_fly/components/hungry-fly.dart';
import 'package:flutter_app_fly/components/macho-fly.dart';

import 'components/fly.dart';

class GameLoop extends Game {

  Size screenSize;
  double tileSize;
  Random rnd;

  List<Fly> flies;
  Backyard backyard;

  GameLoop() {
    initialize();
  }

  void initialize() async{
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    backyard = Backyard(this);
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2));
    double y = rnd.nextDouble() * (screenSize.height - (tileSize * 2));

    switch(rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(AgileFly(this, x, y));
        break;
      case 2:
        flies.add(HungryFly(this, x, y));
        break;
      case 3:
        flies.add(DroolerFly(this, x, y));
        break;
      case 4:
        flies.add(MachoFly(this, x, y));
        break;
    }
  }

  void onTapDown(TapDownDetails details) {
    flies.forEach((fly) {
      if (fly.flyRect.contains(details.globalPosition) && !fly.isDead){
        fly.onTapDown();
        spawnFly();
      }
    });
  }


  void render(Canvas canvas) {
    backyard.render(canvas);

    flies.forEach((fly) {
      fly.render(canvas);
    });
  }

  void update (double t) {
    flies.forEach((fly) {
      fly.update(t);
    });
    
    flies.removeWhere((fly) {
      return fly.isOffScreen;
    });
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

}