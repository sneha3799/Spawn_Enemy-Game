import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game_controller.dart';

class ScoreText{
  final GameController gameController;
  Offset offset;
  TextPainter textPainter;

  ScoreText(this.gameController){
    textPainter = TextPainter(textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                 );
    offset = Offset.zero;
  }

  void render(Canvas c){
    textPainter.paint(c, offset);
  }

  void update(double t){
    if((textPainter.text ?? '') != gameController.score.toString()){
      textPainter.text = TextSpan(
          text: 'Score: ' + gameController.score.toString(),
          style: TextStyle(
            color: Colors.purpleAccent,
            fontSize: 30.0,
          ),);
      textPainter.layout();

      offset = Offset((gameController.screenSize.width/2)-(textPainter.width/2),
                      (gameController.screenSize.height * 0.2)-(textPainter.height/2));
    }
  }

}