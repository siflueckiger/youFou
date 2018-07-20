class Shot {
  float x, y;
  float speed;
  float accleration;
  int length_;
  color shotColor;
  int player;

  int shotCounter; 
  boolean shotFired;

  Shot(color shotColor_) {
    speed = 3;
    accleration = 0.5;
    length_ = 20;
    shotColor = shotColor_;
    shotCounter = beginShots;
  }

  void shoot(float x_, float y_) {
    x = x_;
    y = y_;
    shotCounter--;
  }

  void move() {    
    speed += accleration;
    y -= speed;
  }

  void finished() {
    if (y <= 0) {
      removeShot();
    }
  }

  void removeShot() {
    shotFired = false;
    speed = 3;
  }

  void display() {
    stroke(shotColor);
    strokeWeight(5);
    line(x, y, x, y-length_);
  }
}
