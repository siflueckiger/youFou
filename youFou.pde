import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlIO control;
ControlDevice stick;
int ishot;
float iX, iY;
boolean _shoot;
color backgroundColor = color(0, 0, 0);
int ufoSize = 40;
int gameScreen;
int score, highscore;
int shotCounter, beginShots = 5;
int shotFired;

ArrayList<Shot> shots;
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

  //initialize the ControlIO
  control = ControlIO.getInstance(this);
  //fina a device that maches the configuration file
  stick = control.getMatchedDevice("joystick");
  if (stick == null) {
    println("no suitable device configured");
    System.exit(-1);
  }

  //initialize objects
  init();
}

void draw() {
  getUserInput();

  //println(gameScreen);

  if (gameScreen == 0) {
    //println("init");
    s.init();
  } else if (gameScreen == 1) {
    //println("play");
    //start game
    s.play();
  } else if (gameScreen == 2) {
    //println("over");
    //show gameover screen
    s.gameOver();
  } else if (gameScreen == 3) {
    //println("reset");
    //reset game
    s.reset();
  }
}

void init() {
  //initialize objects
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }

  shots = new ArrayList<Shot>();
  //shots.add(new Shot(width/2, height/2));

  s = new Screen();
  u = new UFO();
  t = new Treasure();

  shotCounter = beginShots;
}

public void getUserInput() {
  iX = map(stick.getSlider("X").getValue(), -1, 1, -8, 8);
  iY = map(stick.getSlider("Y").getValue(), -1, 1, -8, 8);
  _shoot = stick.getButton("SHOOT").pressed();
  //println("Joystickinput: ", iX, iY, _shoot);

  switch(gameScreen) {
  case 0: //init screen
    if (_shoot == true) {
      gameScreen = 1;
    }
    break;

  case 1: //game screen
    if (_shoot == true) {
      if (shotFired == 0 && shotCounter > 0) {
        shotFired = 1;
        shots.add(new Shot(u.x, u.y));
      }
      //u.shoot();
    }

    break;

  case 2: //game over screen
    if (_shoot == true) {
      gameScreen = 3;
    }
    break;
  }



  u.x += iX;
  u.y += iY;
}
