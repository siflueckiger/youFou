class UFO {

  color ufoColor;
  float x, y;
  int up, down, left, right, button;
  boolean removeUfo = false;
  int ufoSpeed;

  Shot shot;

  UFO (color ufoColor_, PlayerGPIO playerGPIO, int x_, int y_) {
    x = x_;
    y = y_;
    
    up = playerGPIO.up;
    down = playerGPIO.down;
    left = playerGPIO.left;
    right = playerGPIO.right;
    button = playerGPIO.button;
    
    ufoColor = ufoColor_;
    shot = new Shot(ufoColor);
  }

  void show() {
    //noFill();
    fill(ufoColor);
    stroke(ufoColor);
    strokeWeight(2);
    ellipse(x, y, ufoSize, ufoSize);
    fill(0);
    ellipse(x, y, ufoSize - 20, ufoSize - 15);
  }

  void outOfArea() {
      if (x < -500 ||  x > width+500 || y < -500 || y > height + 500) {
        removeUfo = true;
        if (u.size() == 0) {
          gameScreen = 4;
      }
    }
  }

  void setColor(int r, int g, int b) {
    ufoColor = color(r, g, b);
    shot.shotColor = ufoColor;
  }

  boolean ufoShotUfo() {
    boolean hit = false;
    for (int i = 0; i < u.size(); i++) {
      float distShotTopUfoCenter = sqrt(pow(u.get(i).shot.x - x, 2) + pow(u.get(i).shot.y - u.get(i).shot.length_ - y, 2));
      if (distShotTopUfoCenter < ufoSize/2) {
        u.get(i).shot.finished();
        u.get(i);
        u.get(i).shot.removeShot();
        hit = true;
      }
    }
    return hit;
  }


  void getGPIOInput() {
    //BUTTON
    if (GPIO.digitalRead(button) == GPIO.HIGH) {
      //println(shotFired, shotCounter);
      if (shot.shotFired == false && shot.shotCounter > 0) {
        shot.shotFired = true;
        shot.shoot(x, y);
      }
      //u.shoot();
    }

    if (GPIO.digitalRead(up) == GPIO.HIGH ) {
      //up
      y += ufoSpeed;
    }

    /*
    if (GPIO.digitalRead(up) == GPIO.HIGH && GPIO.digitalRead(right) == GPIO.HIGH) {
     //up-right
     x += ufoSpeed;
     y -= ufoSpeed;
     } else if (GPIO.digitalRead(up) == GPIO.HIGH && GPIO.digitalRead(left) == GPIO.HIGH) {
     //up-left
     x -= ufoSpeed;
     y -= ufoSpeed;
     } else if (GPIO.digitalRead(down) == GPIO.HIGH && GPIO.digitalRead(right) == GPIO.HIGH) {
     //down-right
     x += ufoSpeed;
     y += ufoSpeed;
     } else if (GPIO.digitalRead(down) == GPIO.HIGH && GPIO.digitalRead(left) == GPIO.HIGH) {
     //down-left
     x -= ufoSpeed;
     y += ufoSpeed;
     } else if (GPIO.digitalRead(up) == GPIO.HIGH) {
     //up
     y -= ufoSpeed;
     } else if (GPIO.digitalRead(down) == GPIO.HIGH) {
     //down
     y += ufoSpeed;
     } else if (GPIO.digitalRead(right) == GPIO.HIGH) {
     //right
     x += ufoSpeed;
     } else if (GPIO.digitalRead(left) == GPIO.HIGH) {
     //left
     x -= ufoSpeed;
     }
     */
  }
}
