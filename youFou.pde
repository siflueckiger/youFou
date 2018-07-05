//todo

import net.java.games.input.*;
//import org.gamecontrolplus.*;
//import org.gamecontrolplus.gui.*;
import oscP5.*;
import netP5.*;

/****** CONTROLLER ******/
import processing.io.*;


/****** OSC ******/
OscP5 osc;
NetAddress oscIN;
NetAddress[] oscOUT = new NetAddress[4]; //make oscOUT objects for all IPs


/****** OBJECTS ******/
UFO u;
Screen s;
Treasure t;


/****** VARIABLES ******/
color backgroundColor = color(0, 0, 0);

int shoti;

int ufoSize = 30;
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

float speed;

/****** OSC ******/
String[] IPsOut = { "192.168.1.121", //visuals 1
  "192.168.1.121", //visuals 2
  "192.168.1.121", //visuals counter
  "192.168.1.120"}; //sound

int portsOut[] = {20101, 
  20102, 
  20200, 
  20301}; //port on which message will be send

int portIn = 5007; //port on which it will listen for messages


/****** SETTINGS ******/
void settings() {
  //fullScreen(1);
  size(800, 800);
}


/****** SETUP ******/
void setup() {
  background(0);
  noCursor();
  rectMode(CENTER);

  speed = 6;

  GPIO.pinMode(23, GPIO.INPUT); // pin 7 shoot

  GPIO.pinMode(17, GPIO.INPUT); // pin 11
  GPIO.pinMode(18, GPIO.INPUT); // pin 12
  GPIO.pinMode(27, GPIO.INPUT); // pin 13
  GPIO.pinMode(22, GPIO.INPUT); // pin 15


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

  OSC_sender();

  if (gameScreen == 0) {
    //println("init");
    s.init();
    if (GPIO.digitalRead(23) == GPIO.HIGH) {
      //BUTTON
      gameScreen = 1;
      delay(1000);
    }
  } else if (gameScreen == 1) {
    //println("play");
    //start game
    if (GPIO.digitalRead(23) == GPIO.HIGH) {
      //BUTTON
      _shoot = true;
      if (_shoot == true) {
        //println(shotFired, shotCounter);
        if (shotFired == 0 && shotCounter > 0) {
          shotFired = 1;
          shots.add(new Shot(u.x, u.y));
        }
        //u.shoot();
      }
    }

    if (GPIO.digitalRead(17) == GPIO.HIGH) {
      //UP
      u.y -= speed;
    } else if (GPIO.digitalRead(18) == GPIO.HIGH) {
      //down
      u.y += speed;
    } else if (GPIO.digitalRead(22) == GPIO.HIGH) {
      //right
      u.x += speed;
    } else if (GPIO.digitalRead(27) == GPIO.HIGH) {
      //left
      u.x -= speed;
    }
    s.play();
  } else if (gameScreen == 2) {
    //println("over");
    //show gameover screen
    s.gameOver();
    if (GPIO.digitalRead(23) == GPIO.HIGH) {
      //BUTTON
      gameScreen = 3;
      delay(1000);
    }
  } else if (gameScreen == 3) {
    //println("reset");
    //reset game
    s.reset();
  } else if (gameScreen == 4) {
    //println("reset");
    //reset game
    s.verfahren();
    if (GPIO.digitalRead(23) == GPIO.HIGH) {
      //BUTTON
      gameScreen = 3;
      delay(1000);
    }
  }
}


/****** OSC Sender *****/
void OSC_sender() {
  //create message
  OscMessage messageTransmit = new OscMessage("/YouFou");
  messageTransmit.add(u.x/width);
  messageTransmit.add(u.y/height);
  messageTransmit.add(shotFired);
  messageTransmit.add(gameScreen);
  messageTransmit.add(score);


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
