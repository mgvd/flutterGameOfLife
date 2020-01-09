import 'package:flutter/material.dart';
import 'package:gameoflife/game-controller.dart';

class Background {

  Color bgColor = Colors.black; // black
  Rect bgRect;
  Paint bgPaint;

  final GameController gc;
  Background(this.gc) {
    initialize();
  }

  void initialize() {
    bgRect = Rect.fromLTWH(0, 0, gc.screenSize.width, gc.screenSize.height);
    bgPaint = Paint();
    bgPaint.color = bgColor;
  }

  void render(Canvas c) {
    
    c.drawRect(bgRect, bgPaint);
  }

  void update(double t) {

  }
}