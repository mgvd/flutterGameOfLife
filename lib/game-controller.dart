import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:gameoflife/View.dart';
import 'package:gameoflife/controllers/cell-controller.dart';

import 'components/background.dart';

class GameController extends Game with DoubleTapDetector, TapDetector {
  int numberofcellsHor = 150;
  double initialCellSize = 3;

  View view;
  Timer splashCountDown = Timer(2);

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

    background = Background(this);
  }

  @override
  void render(Canvas c) {
    background.render(c);
    if (view == View.splash) {
      TextConfig textConfig = TextConfig(color: const Color(0xFFFFFFFF));
      textConfig.render(
          c,
          "Countdown: ${splashCountDown.current.round().toString()}",
          Position(10, 100));
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
    cellSize = screenSize.width / numberofcellsHor / scale; // 10 in a row
    super.resize(size);
  }

  @override
  void onDoubleTap() {
    offset = Offset(0, 0);
    saveOffset = Offset(0, 0);
    scale = 1;
    cellSize = screenSize.width / numberofcellsHor / scale;
  }

  @override
  void onTapDown(TapDownDetails details) {
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
  //     //  scale = details.verticalScale;

  //     //   cellSize = 10 / scale;

  // }

}
