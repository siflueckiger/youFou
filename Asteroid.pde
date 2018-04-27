class Asteroid {

  float x = random(width);
  float y = random(-1000, -100);
  float yspeed = random(0.5, 1.5);

  color asteroidColor = color(0, 255, 0);
  float aSize = random(5, 15);

  void fall() {
    y = y + yspeed;

    if (y > height + 40) {
      y = random(-200, -100);
      x = random(width);
      yspeed = random(0.5, 2);
      aSize = random(5, 40);
    }
  }

  void show() {
    stroke(asteroidColor);
    strokeWeight(1);
    //noFill();
    //strokeWeight(1);
    fill(asteroidColor, 97);
    rect(x, y, aSize, aSize);
  }

  void hit() {
    if (sqrt(pow(u.x - x, 2) + pow(u.y - y, 2)) < aSize/2 + ufoSize/2) {      
      gameScreen = 2;
    }
  }

  void shot() {

    for (int i = shots.size() - 1; i >= 0; i--) {

      Shot shot = shots.get(i);
      float distShotTopAsteroidCenter = sqrt(pow(shot.x - x, 2) + pow(shot.y - shot.length_ - y, 2));
      if (distShotTopAsteroidCenter < aSize/2) {

        shots.remove(i);
        shotFired = 0;

        y = random(-200, -100);
        x = random(width);
        yspeed = random(0.5, 2);
        aSize = random(5, 40);
        color(255);
      }
    }
  }
}
