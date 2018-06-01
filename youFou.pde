//todo

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import oscP5.*;
import netP5.*;

/****** CONTROLLER ******/
ControlIO control;
ControlDevice stick;


/****** OSC ******/
OscP5 osc;
NetAddress oscIN;
NetAddress[] oscOUT = new NetAddress[3]; //make oscOUT objects for all IPs


/****** OBJECTS ******/
UFO u;
Screen s;
Treasure t;


/****** VARIABLES ******/
color backgroundColor = color(0, 0, 0);
PImage bg;

int ufoSize = 40;
int gameScreen;
int score, highscore;
Asteroid[] asteroids = new Asteroid[100];

//shot
int ishot;
float iX, iY;
boolean _shoot, _select;
int shotCounter, beginShots = 5;
int shotFired;
ArrayList<Shot> shots;


/****** OSC ******/
String[] IPsOut = {"192.168.0.24", "192.168.0.19", "192.168.0.18"}; //ip where message is send to
int portsOut[] = {10500, 10500, 10500}; //port on which message will be send
int portIn = 5007; //port on which it will listen for messages


/****** SETTINGS ******/
void settings() {
  fullScreen();
  //size(800, 800, P3D);
}


/****** SETUP ******/
void setup() {
  background(0);
  bg = loadImage("alien.jpg");
  bg.resize(width, height);
  background(bg);
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

  //start oscP5, listening for incoming messages at portIn
  osc = new OscP5(this, portIn);

  //create oscOUT objects for all IPs
  for (int i=0; i < IPsOut.length; i++) {
    oscOUT[i] = new NetAddress(IPsOut[i], portsOut[i]);
  }

  //initialize objects
  init();
}

void draw() {
  getUserInput();

  OSC_sender();


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


/****** OSC Sender *****/
void OSC_sender() {
  //create message
  OscMessage messageTransmit = new OscMessage("/YouFou");
  messageTransmit.add(u.x/width);
  messageTransmit.add(u.y/height);

  //send to all IPs
  for (int i=0; i < IPsOut.length; i++) {
    osc.send(messageTransmit, oscOUT[i]);
    //println(IPsOut[i], portsOut[i]);
  }
  //println(messageTransmit);
}

/****** INIT *****/
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


/****** CONTROLLER *****/
public void getUserInput() {
  iX = map(stick.getSlider("X").getValue(), -1, 1, -8, 8);
  iY = map(stick.getSlider("Y").getValue(), -1, 1, -8, 8);
  _shoot = stick.getButton("SHOOT").pressed();
  _select = stick.getButton("SELECT").pressed();
  //println("Joystickinput: ", iX, iY, _shoot);

  switch(gameScreen) {
  case 0: //init screen
    if (_select == true) {
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
    if (_select == true) {
      gameScreen = 3;
    }
    break;
  }

  u.x += iX;
  u.y += iY;
}
