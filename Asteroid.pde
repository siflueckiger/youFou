class Asteroid {

  float x = random(width);
  float y = random(-1000, -100);
  float yspeed = 0.5;

  color asteroidColor = color(0, 255, 0);
  float aSize = random(5, 15);

  void fall() {
    y = y + yspeed;
    if (y > height + 40) {
      y = random(-200, -100);
      x = random(width);
      yspeed = 0.5;
      aSize = random(5, 25);
    }
  }

  void show() {
    stroke(asteroidColor);
    strokeWeight(1);
    //noFill();
    //strokeWeight(1);
    fill(asteroidColor);
    rect(x, y, aSize, aSize);
  }

  void hit(int i) {
    if (sqrt(pow(u.get(i).x - x, 2) + pow(u.get(i).y - y, 2)) < aSize/2 + ufoSize/2) {      
      u.get(i).removeUfo = true;
      if (u.size() == 0) { 
        gameScreen = 2;
      }
    }
  }

  void shot() {
    for (int i = 0; i < u.size(); i++) {
      float distShotTopAsteroidCenter = sqrt(pow(u.get(i).shot.x - x, 2) + pow(u.get(i).shot.y - u.get(i).shot.length_ - y, 2));
      if (distShotTopAsteroidCenter < aSize/2) {
        u.get(i).shot.finished();
        u.get(i).shot.removeShot();
        
        y = random(-200, -100);
        x = random(width);
        yspeed = 0.5;
        aSize = random(5, 40);
        color(255);
      }
    }
  }
}
