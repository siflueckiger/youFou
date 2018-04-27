//gamescreen index
//0 = start screen
//1 = game screem
//2 = gameover screen

class Screen {

  Screen() {
    textAlign(CENTER);
  }

  void init() {
    background(bg);
    fill(255);

    textSize(30);
    text("SPIELANLEITUNG", width / 2, height / 3);
    textSize(20);
    text("Flieg mit dem Raumschiff nicht in die Asteroide und sammle die Schätze ein!", width / 2, height / 2 -60);
    text("pull the trigger to begin..", width / 2, height / 2 -30);
  }

  void play() {
    background(bg);


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
    t.pick();

    textSize(16);
    fill(255, 0, 0);
    text("score: " + score, width / 2, 20);
    text("shots: " + shotCounter, width / 2, 40);
  }

  void gameOver() {
    textSize(60);
    fill(255, 0, 0);
    text("- GAME OVER -", width / 2, height / 3);


    textSize(40);
    if (score > highscore) {
      highscore = score;
      text("NEUER HIGHSCORE! ", width / 2, height / 3 + 150);
      text("deine punktzahl: " + score, width / 2, height / 3 + 200);
      fill(255);
      text("pull the trigger to play again..", width / 2, height / 3 + 300);
    } else if (score < highscore || score == 0) {
      text("naja.. schön hast dus probiert... ", width / 2, height / 3 + 150);
      text("deine punktzahl: " + score, width / 2, height / 3 + 200);
      text("highscore: " + highscore, width / 2, height / 3 + 250);
      fill(255);
      text("pull the trigger to play again..", width / 2, height / 3 + 350);
    }
  }

  void reset() {
    s = new Screen();
    u = new UFO();
    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i] = new Asteroid();
    }

    background(0);

    score = 0;
    gameScreen = 0;
    shotCounter = beginShots;
  }
}
