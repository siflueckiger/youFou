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

    t.show();

    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i].fall();
      asteroids[i].show();
      asteroids[i].hit();
      asteroids[i].shot();
    }

    for (int i = shots.size() - 1; i >= 0; i--) {
      Shot shot = shots.get(i);
      shot.move();
      shot.display();
      if (shot.finished()) {
        shots.remove(i);
      }
    }

    u.show();
    u.outOfArea();
    t.pick();

    textSize(30);
    fill(255);
    text("score: " + score, width / 2, 40);
    text("shots: " + shotCounter, width / 2, 80);
  }

  void gameOver() {
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
    if(score > highscore){
      highscore = score;
    }

    s = new Screen();
    u = new UFO();
    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i] = new Asteroid();
    }
    shots = new ArrayList<Shot>();

    background(0);

    score = 0;
    gameScreen = 0;
    shotCounter = beginShots;
    shotFired = 0;
  }
}
