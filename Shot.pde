class Shot {
  float x, y;
  float speed;
  float accleration;
  int length_;

  Shot(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    speed = 3;
    accleration = 0.5;
    length_ = 20;
    
    shotCounter--;
  }


  void move() {    
    speed += accleration;
    y -= speed;
  }

  boolean finished() {
    if (y <= 0) {
      shotFired = 0;
      return true;
    } else {
      return false;
    }
  }

  void display() {
    stroke(0, 255, 0);
    strokeWeight(5);

    line(x, y, x, y-length_);
  }
}
