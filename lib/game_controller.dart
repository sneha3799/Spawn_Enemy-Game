import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/components/enemy.dart';
import 'package:flutter_game/components/health_bar.dart';
import 'package:flutter_game/components/high_score.dart';
import 'package:flutter_game/components/score_text.dart';
import 'package:flutter_game/components/start_text.dart';
import 'package:flutter_game/enemy_spawner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_game/state.dart';

import 'components/player.dart';

class GameController extends Game{

  final SharedPreferences sharedPreferences;
  Random rand;
  Size screenSize;
  double tileSize;
  Player player;
  List<Enemy> enemies;
  EnemySpawner enemySpawner;
  HealthBar healthBar;
  int score;
  ScoreText scoreText;
  States state;
  HighscoreText highscoreText;
  StartText startText;

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    spawnEnemy();
    score = 0;
    scoreText = ScoreText(this);
    state = States.menu;
    highscoreText = HighscoreText(this);
    startText = StartText(this);
  }

  GameController(this.sharedPreferences){
    initialize();
  }

  void render(Canvas canvas) {
    // TODO: implement render
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    //Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    Paint backgroundPaint = Paint()..color = Color(0xFF0000);
    canvas.drawRect(background, backgroundPaint);

    player.render(canvas);

    if(state == States.menu){
      startText.render(canvas);
      highscoreText.render(canvas);
    }
    else if(state == States.playing) {
      enemies.forEach((Enemy enemy) => enemy.render(canvas));
      scoreText.render(canvas);
      healthBar.render(canvas);
    }
  }

  void update(double t) {
    // TODO: implement update
    if(state == States.menu){
      startText.update(t);
      highscoreText.update(t);
    }
    else if(state == States.playing) {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }
  }

  void resize(Size size){
    screenSize = size;
    tileSize = screenSize.width/10;
  }

  void onTapDown(TapDownDetails d){
    if(state == States.menu){
      state = States.playing;
    }
    else if(state == States.playing) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  void spawnEnemy(){
    double x,y;
    switch(rand.nextInt(4)){
      case 0:
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize * 2.5;
        break;
      case 1:
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
        x = -tileSize * 2.5;
        y = screenSize.height * rand.nextDouble();
        break;
    }
    enemies.add(Enemy(this, x, y));
  }

}