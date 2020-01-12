import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gameoflife/game-controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  await Flame.images.load('GoLife_logo.png');
  GameController gameController = GameController();
  runApp(gameController.widget);
}
