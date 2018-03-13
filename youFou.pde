color backgroundColor = color(0, 0, 0);
int ufoSize = 40;
int gameScreen;
int score, highscore;


Asteroid[] asteroids = new Asteroid[100];
UFO u;
Screen s;
Treasure t;


void setup() {
  //fullScreen();
  size(800, 800);
  background(backgroundColor);
  noCursor();
  rectMode(CENTER);

//initialize objects
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }
  s = new Screen();
  u = new UFO();
  t = new Treasure();
}

void draw() {
  if (gameScreen == 0) {
    s.init();
  } else if (gameScreen == 1) {
    //start game
    s.play();
  } else if (gameScreen == 2) {
    //show gameover screen
    s.gameOver();
  } else if (gameScreen == 3) {
    //reset game
    s.reset();
  }
}

void keyPressed() {
  if (key == ' ') {

    if (gameScreen == 0) {
      gameScreen = 1;
    } else if (gameScreen == 2) {
      gameScreen = 3;
    }
  }
}