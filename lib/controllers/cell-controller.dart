import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gameoflife/components/cell.dart';
import 'package:gameoflife/game-controller.dart';

class CellController {
  GameController gc;

  List<List<Cell>> cells = List();

  CellController(this.gc) {
    initialize();
  }

  void initialize() {

    cells = List.generate(gc.xSize, (_) => List(gc.ySize));

    randomize();
  }

  void render(Canvas c) {
    for (var x = 0; x < cells.length; x++) {
      for (var y = 0; y < cells[x].length; y++) {
        cells[x][y].render(c);
      }
    }
  }

  void update(double t) {
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
