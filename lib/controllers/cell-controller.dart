import 'dart:math';

import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:gameoflife/components/cell.dart';
import 'package:gameoflife/game-controller.dart';

class CellController {
  GameController gc;

  List<List<Cell>> cells = List();

  Timer gameTimer;

  CellController(this.gc) {
    initialize();
  }

  void initialize() {

    cells = List.generate(gc.xSize, (_) => List(gc.ySize));
    gameTimer = Timer(1/30, repeat: true, callback: recalculate);

    randomize();
    gameTimer.start();
    fillBorders();

  }

  void render(Canvas c) {
    for (var x = 0; x < cells.length; x++) {
      for (var y = 0; y < cells[x].length; y++) {
        cells[x][y].render(c);
      }
    }
  }

  void fillBorders() {
    for (var x = 0; x < cells.length; x++) {
      cells[x][0].active = true;
      cells[x][cells[x].length-1].active = true;
    }

      for (var y = 0; y < gc.ySize; y++) {
        cells[0][y].active = true;
      cells[cells.length-1][y].active = true;
      }
    
  }

  void update(double t) {
    gameTimer.update(t);
    
  }

  void recalculate() {
    List<List<Cell>> newCells = List.generate(gc.xSize, (_) => List(gc.ySize));
    int neighbours;
    for (var x = 0; x < cells.length; x++) {
      for (var y = 0; y < cells[x].length; y++) {
        newCells[x][y] = Cell(gc, x, y, cells[x][y].active);
        neighbours = cells[x][y].activeNeighbours(cells);
        // newCells[x][y] = cells[x][y];
        if (cells[x][y].active) {
          if (neighbours < 2 || neighbours > 3) {
            newCells[x][y].active = false;
          }
        } else {
          if (neighbours == 3) {
            newCells[x][y].active = true;
          }
        }
      }
    }
    cells = newCells;
  }



  void randomize() {
    for (var x = 0; x < gc.xSize; x++) {
      for (var y = 0; y < gc.ySize; y++) {
        cells[x][y] = Cell(gc, x, y, Random().nextBool());
      }
    }
  }
}
