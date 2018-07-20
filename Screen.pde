//gamescreen index
//0 = start screen
//1 = game screem
//2 = gameover screen

class Screen {

  Screen() {
    textAlign(CENTER);
  }

  void init() {
    //background(bg);
    background(0);
    fill(255);

    textSize(60);
    text("SPIELANLEITUNG", width / 2, height / 3);
    textSize(35);
    text("Flieg mit dem runden Raumschiff nicht", width / 2, height / 2 - 40);
    text("in die viereckigen Asteroide.", width / 2, height / 2 - 5);
    text("Sammle die dreieckigen Schätze ein.", width / 2, height / 2 + 60);
    textSize(35);
    text("Drücke die Daumentaste um zu beginnen.", width / 2, height / 2 + 200);
  }

  void play() {
    //background(bg);
    background(0);

    //get GPIO input for all UFOs
    for (int i = 0; i < u.size(); i++) {
      u.get(i).getGPIOInput();
    }

    // treasures
    for (int i = 0; i < t.size(); i++) {
      t.get(i).show();
      t.get(i).pick(i);
    }

    if (playerCount == 1) {
      newPlayer.show();
      newPlayer.activate();
    } else if (playerCount >= 2 && playerCount < 4) {
      newPlayer.show();
      newPlayer.activate();
    }



    for (int i = 0; i < u.size(); i++) {
      // Move Ufos && Check out of Area
      u.get(i).show();
      u.get(i).outOfArea();
      
      // Move Shot && check if shot leaves Areas
      if (u.get(i).shot.shotFired) {
        u.get(i).shot.move();
        u.get(i).shot.display();
        u.get(i).shot.finished();
      }
      
      // Check if Ufo is shot by other ufo
      if (u.get(i).ufoShotUfo()) {
        u.get(i).removeUfo = true;
      }

      // Draw Asteroids && Check if Ufo hits Asteroid && Check if asteroid was Shot
      for (int j = 0; j < asteroids.length; j++) {
        asteroids[j].fall();
        asteroids[j].show();
        asteroids[j].hit(i);
        asteroids[j].shot();
      }
      
      if (u.get(i).removeUfo){
        u.remove(i);
      }
      
    }

    textSize(30);
    fill(255);
    textAlign(LEFT);
    if (u.size() != 0) {
      text("score: " + score, 40, 80);
    }
    for (int i = 0; i < u.size(); i++) {
      String text = "shots: " + u.get(i).shot.shotCounter;
      fill(u.get(i).ufoColor);
      text(text, 40 + (150 * i), 40);
    }
  }

  void gameOver() {
    textAlign(CENTER);
    textSize(60);
    fill(255);
    text("- GAME OVER -", width / 2, height / 3);
    textSize(35);
    text("Drücke die Daumentaste um zu beginnen.", width / 2, height / 3 + 350);


    textSize(40);
    if (score > highscore) {
      text("NEUER HIGHSCORE! ", width / 2, height / 3 + 150);
      text("Deine Punktzahl: " + score, width / 2, height / 3 + 200);
    } else if (score <= highscore) {
      text("Naja.. Schön hast du es probiert... ", width / 2, height / 3 + 150);
      text("Deine Punktzahl: " + score, width / 2, height / 3 + 200);
      text("Highscore: " + highscore, width / 2, height / 3 + 250);
    }
  }

  void verfahren() {
    textSize(60);
    fill(255);
    text("- GAME OVER -", width / 2, height / 3);
    text("Du hast dich verfahren.", width / 2, height / 3 + 150);
    textSize(35);
    text("Drücke die Daumentaste um zu beginnen.", width / 2, height / 3 + 350);
  }

  void reset() {
    playerCount = 1;

    if (score > highscore) {
      highscore = score;
      highScoreFile[0] = str(highscore);
      println(highScoreFile[0]);
      saveStrings("highScore.txt", highScoreFile);
    }

    s = new Screen();

    u = new ArrayList<UFO>(maxPlayer);
    for (int i = 0; i < maxPlayer; i++) {
      u.add(new UFO(playerColor[playerCount-1], playerGPIO[playerCount-1], int(random(width)), int(random(height))));
    }

    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i] = new Asteroid();
    }

    background(0);

    score = 0;
    gameScreen = 0;
  }
}
