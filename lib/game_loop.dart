import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_fly/components/agile-fly.dart';
import 'package:flutter_app_fly/components/backyard.dart';
import 'package:flutter_app_fly/components/credits-button.dart';
import 'package:flutter_app_fly/components/drooler-fly.dart';
import 'package:flutter_app_fly/components/help-button.dart';
import 'package:flutter_app_fly/components/house-fly.dart';
import 'package:flutter_app_fly/components/hungry-fly.dart';
import 'package:flutter_app_fly/components/macho-fly.dart';
import 'package:flutter_app_fly/components/score-display.dart';
import 'package:flutter_app_fly/components/start-button.dart';
import 'package:flutter_app_fly/controllers/spawner.dart';
import 'package:flutter_app_fly/view.dart';
import 'package:flutter_app_fly/view/credits-view.dart';
import 'package:flutter_app_fly/view/help-view.dart';
import 'package:flutter_app_fly/view/home-view.dart';
import 'package:flutter_app_fly/view/lost-view.dart';

import 'components/fly.dart';

class GameLoop extends Game {

  View activeView = View.home;

  Size screenSize;
  double tileSize;
  Random rnd;

  List<Fly> flies;
  Backyard backyard;

  HomeView homeView;
  StartButton startButton;
  LostView lostView;

  FlySpawner spawner;

  HelpButton helpButton;
  CreditsButton creditsButton;

  HelpView helpView;
  CreditsView creditsView;

  int score;

  ScoreDisplay scoreDisplay;

  GameLoop() {
    initialize();
  }

  void initialize() async{
    flies = List<Fly>();
    score = 0;
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    spawner = FlySpawner(this);

    backyard = Backyard(this);

    homeView = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);

    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);

    scoreDisplay = ScoreDisplay(this);
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
    if (startButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        return;
      }
    }

    // help button
    if (helpButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        return;
      }
    }

  // credits button
    if (creditsButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        return;
      }
    }

    if (activeView == View.help || activeView == View.credits) {
      activeView = View.home;
      return;
    }

    bool didHitAFly = false;

    List<Fly>.from(flies).forEach((fly) {
      if (fly.flyRect.contains(details.globalPosition) && !fly.isDead) {
        fly.onTapDown();
        didHitAFly = true;
        return;
      }
    });

    if (activeView == View.playing && !didHitAFly) {
      activeView = View.lost;
    }

  }


  void render(Canvas canvas) {
    backyard.render(canvas);

    if (activeView == View.playing) scoreDisplay.render(canvas);

    flies.forEach((fly) {
      fly.render(canvas);
    });

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  void update (double t) {
    spawner.update(t);

    flies.forEach((fly) {
      fly.update(t);
    });
    
    flies.removeWhere((fly) {
      return fly.isOffScreen;
    });

    if (activeView == View.playing) scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

}