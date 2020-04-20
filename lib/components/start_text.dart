import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game_controller.dart';

class StartText{
  final GameController gameController;
  TextPainter textPainter;
  Offset offset;

  StartText(this.gameController){
    textPainter = TextPainter(textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    offset = Offset.zero;
  }

  void render(Canvas c){
    textPainter.paint(c, offset);
  }

  void update(double t){
    textPainter.text = TextSpan(
      text: 'Start',
      style: TextStyle(
        color: Colors.lightGreenAccent,
        fontSize: 30.0,
      ),);
    textPainter.layout();

    offset = Offset((gameController.screenSize.width/2)-(textPainter.width/2),
        (gameController.screenSize.height * 0.7)-(textPainter.height/2));
  }

}