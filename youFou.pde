//todo
int iButtoni = 0;
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

/****** VARIABLES ******/
color backgroundColor = color(0, 0, 0);
int maxPlayer = 4;
color[] playerColor = new color[maxPlayer]; 

int playerCount = 1;
int shoti;

int ufoSize = 30;
int gameScreen;
int score, highscore;
Asteroid[] asteroids = new Asteroid[100];

//shot
int beginShots = 5;
String[] highScoreFile;

/****** OBJECTS ******/
ArrayList<UFO> u;
ArrayList<Treasure> t;

Screen s;
NewPlayer newPlayer;
PlayerGPIO[] playerGPIO = new PlayerGPIO[maxPlayer];

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


/****** INIT *****/
void init() {
  //initialize objects
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }

  //shots = new ArrayList<Shot>();
  //shots.add(new Shot(width/2, height/2));

  s = new Screen();
  u = new ArrayList<UFO>();
  t = new ArrayList<Treasure>();

  playerColor[0] = color(255, 0, 0);
  playerColor[1] = color(0, 255, 0);
  playerColor[2] = color(0, 255, 255);
  playerColor[3] = color(0, 0, 255);

  newPlayer = new NewPlayer(playerColor[playerCount+1]);

  // up, down, left, right, button
  playerGPIO[0] = new PlayerGPIO(27, 26, 26, 27, 16);
  playerGPIO[1] = new PlayerGPIO(26, 27, 27, 26, 15);
  playerGPIO[2] = new PlayerGPIO(26, 27, 27, 26, 15);
  playerGPIO[3] = new PlayerGPIO(27, 26, 26, 27, 16);

  // set GPIO to input
  GPIO.pinMode(playerGPIO[0].up, GPIO.INPUT);     // UP
  GPIO.pinMode(playerGPIO[0].button, GPIO.INPUT); // BUTTON
  GPIO.pinMode(playerGPIO[1].up, GPIO.INPUT);     // UP
  GPIO.pinMode(playerGPIO[1].button, GPIO.INPUT); // BUTTON

  u.add(new UFO(playerColor[playerCount-1], playerGPIO[playerCount-1], int(width/2), int(random(height))));
  t.add(new Treasure());
}


/****** SETUP ******/
void setup() {
  background(0);
  noCursor();
  frameRate(30);

  rectMode(CENTER);

  highScoreFile = loadStrings("highScore.txt");
  highscore = int(highScoreFile[0]);

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

  u.get(0).x = mouseX;
  u.get(0).y = mouseY;

  //OSC_sender();

  if (gameScreen == 0) {
    //println("init");
    s.init();
    if (GPIO.digitalRead(playerGPIO[3].button) == GPIO.HIGH || GPIO.digitalRead(playerGPIO[2].button) == GPIO.HIGH) {
      //BUTTON
      gameScreen = 1;
      delay(500);
    }
  } else if (gameScreen == 1) {
    //println("play");
    //start game
    s.play();
  } else if (gameScreen == 2) {
    //println("over");
    //show gameover screen
    s.gameOver();
    if (GPIO.digitalRead(playerGPIO[3].button) == GPIO.HIGH || GPIO.digitalRead(playerGPIO[2].button) == GPIO.HIGH) {
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
    if (GPIO.digitalRead(playerGPIO[3].button) == GPIO.HIGH || GPIO.digitalRead(playerGPIO[2].button) == GPIO.HIGH) {
      //BUTTON
      gameScreen = 3;
      delay(500);
    }
  }
}

/****** OSC Sender *****
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
 */
