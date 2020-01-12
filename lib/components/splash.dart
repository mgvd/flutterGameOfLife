import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:gameoflife/game-controller.dart';


class Splash {
  final GameController gc;
  Rect titleRect;
  Sprite titleSprite;

  Splash(this.gc) {
    double width = gc.screenSize.width;
    double height = width*0.216;
    Offset o = Offset(gc.screenSize.width/2,gc.screenSize.height/2);
    titleRect = Rect.fromCenter(center:o,width:width,height:height);
    

 
titleSprite = Sprite('GoLife_logo.png');

  }

  void render(Canvas c) {
    titleSprite.renderRect(c,titleRect);
  }

  void update(double t) {}
}