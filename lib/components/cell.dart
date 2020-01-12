import 'package:flutter/material.dart';
import 'package:gameoflife/game-controller.dart';

class Cell {
  GameController gc;
  bool active = false;
  int x;
  int y;

  

  Cell(this.gc,this.x,this.y,this.active);

  void render(Canvas c) {
    Paint cellPaint = Paint();
    Rect cellRect;

    // double middleOffsetX = gc.xSize * gc.cellSize / 2;
    // double middleOffsetY = gc.ySize * gc.cellSize / 2;
    
    cellRect = Rect.fromLTWH(
        x * gc.cellSize + gc.offset.dx + gc.saveOffset.dx, y * gc.cellSize + gc.offset.dy+gc.saveOffset.dy, gc.cellSize, gc.cellSize); 
    cellRect.translate(30,30);
    active ? cellPaint.color = Colors.white : cellPaint.color = Colors.black;
    c.drawRect(cellRect, cellPaint);
  }

  void update(double t) {}

  int activeNeighbours(List<List<Cell>> cells) {
    int n = 0;
    // int x = cell.x;
    // int y = cell.y;

    if (x > 0) {
      if (y + 1 < gc.ySize && cells[x - 1][y + 1].active) n++;
      if (cells[x - 1][y].active) n++;
      if (y - 1 > -1 && cells[x - 1][y - 1].active) n++;
    }

    if (y + 1 < gc.ySize && cells[x][y + 1].active) n++;
    if (y - 1 > -1 && cells[x][y - 1].active) n++;

    if (x + 1 < gc.xSize) {
      if (y + 1 < gc.ySize && cells[x + 1][y + 1].active) n++;
      if (cells[x + 1][y].active) n++;
      if (y - 1 > -1 && cells[x + 1][y - 1].active) n++;
    }

    return n;
  }  
}
