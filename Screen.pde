//gamescreen index
//0 = start screen
//1 = game screem
//2 = gameover screen

class Screen {

  Screen() {
    gameScreen = 0;
    textAlign(CENTER);
  }

  void init() {
    background(0);
    fill(255);

    textSize(30);
    text("SPIELANLEITUNG", width / 2, height / 3);
    textSize(20);
    text("Flieg mit dem Raumschiff nicht in die Asteroide!", width / 2, height / 2 -60);
  }

  void play() {
    background(backgroundColor);


    t.show();

    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i].fall();
      asteroids[i].show();
      asteroids[i].hit();
    }

    u.show();
    t.pick();

    textSize(16);
    fill(255, 0, 0);
    text("score: " + score, width / 2, 20);
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
    } else if (score < highscore){
      text("naja.. schön hast dus probiert... " + score, width / 2, height / 3 + 150);
      text("deine punktzahl: " + score, width / 2, height / 3 + 200);
      text("highscore: " + highscore, width / 2, height / 3 + 250);
    }
  }

  void reset() {
    s = new Screen();
    u = new UFO();
    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i] = new Asteroid();
    }

    background(0);
    gameScreen = 0;
    
    score = 0;
  }
}