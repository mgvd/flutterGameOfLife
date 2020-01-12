import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:gameoflife/View.dart';
import 'package:gameoflife/components/splash.dart';
import 'package:gameoflife/controllers/cell-controller.dart';

import 'components/background.dart';

class GameController extends Game with DoubleTapDetector, LongPressDetector, ScaleDetector {
  int numberofcellsHor = 150;
  double initialCellSize = 4;

  View view;
  Timer splashCountDown = Timer(2);
 
  Splash splash;


  double scale = 1;
  Offset offset = Offset(0, 0);
  Offset saveOffset = Offset(0, 0);

  Offset startPanPoint = Offset(0, 0);

  Size screenSize;
  double cellSize;
  Background background;
  CellController cc;

  int xSize;
  int ySize;

  

  GameController() {
    initialize();
  }

  void initialize() async {
    view = View.splash;

    

    resize(await Flame.util.initialDimensions());
    ySize = (screenSize.height / cellSize).floor(); // number of vertical cells
    xSize = (screenSize.width / cellSize).floor(); // number of horizontal cells
    cc = CellController(this);
    //cc.initialize();
    splashCountDown = Timer(2, repeat: false, callback: cc.initialize);
    splashCountDown.start();
    splash = Splash(this);
    background = Background(this);
  }

  @override
  void render(Canvas c) {
    background.render(c);
    if (view == View.splash) {

      splash.render(c);
    } else {
      cc.render(c);
    }
  }

  @override
  void update(double t) {
    splashCountDown.update(t);
    if (!splashCountDown.isFinished()) {
      return;
    }

    view = View.game;
    cc.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    cellSize = screenSize.width / numberofcellsHor * scale; // 10 in a row
    super.resize(size);
  }

  @override
  void onDoubleTap() {
    offset = Offset(0, 0);
    saveOffset = Offset(0, 0);
    scale = 1;
    cellSize = screenSize.width / numberofcellsHor * scale;
    cc.randomize();
  }

  @override
  void onLongPressStart(LongPressStartDetails details) {
    // get x and y from position
    int x = (details.localPosition.dx / cellSize).floor();
    int y = (details.localPosition.dy / cellSize).floor();
    for (var i = -3; i < 3; i++) {
      for (var j = -3; j < 3; j++) {
        cc.cells[x + i][y + j].active = Random().nextBool();
      }
    }
  }

  @override
  void onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    // get x and y from position
    int x = (details.localPosition.dx / cellSize).floor();
    int y = (details.localPosition.dy / cellSize).floor();
    for (var i = -3; i < 3; i++) {
      for (var j = -3; j < 3; j++) {
        cc.cells[x + i][y + j].active = Random().nextBool();
      }
    }
  }

  // @override
  // void onScaleStart(ScaleStartDetails details) {
  //   startPanPoint = details.focalPoint;
  // }

  // @override
  // void onScaleEnd(ScaleEndDetails details) {
  //  saveOffset += offset;
  //  offset = Offset(0,0);

  // }

  // @override
  // void onScaleUpdate(ScaleUpdateDetails details) {
  //   offset = details.focalPoint - startPanPoint;
  //   offset = boundOffset(offset);
  // }

  Offset boundOffset(Offset offset) {
    double x = 0; double y = 0;
    offset.dx > 0 ? x = 0 : x = offset.dx;
    offset.dy > 0 ? y = 0 : y = offset.dy;

    Offset newOffset = Offset(x,y);
    return newOffset;


  }

}
