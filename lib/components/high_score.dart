import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game_controller.dart';

class HighscoreText{
  final GameController gameController;
  Offset offset;
  TextPainter textPainter;

  HighscoreText(this.gameController){
    textPainter = TextPainter(textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    offset = Offset.zero;
  }

  void render(Canvas c){
    textPainter.paint(c, offset);
  }

  void update(double t){
    int highscore = gameController.sharedPreferences.getInt('highscore') ?? 0;
      textPainter.text = TextSpan(
        text: 'Highscore: $highscore',
        style: TextStyle(
          color: Colors.lightGreenAccent,
          fontSize: 40.0,
        ),);
      textPainter.layout();

      offset = Offset((gameController.screenSize.width/2)-(textPainter.width/2),
          (gameController.screenSize.height * 0.2)-(textPainter.height/2));
    }
  }