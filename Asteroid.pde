class Asteroid {

  float xAsteroid = random(width);
  float yAsteroid = random(-1000, -100);
  float yspeed = 0.5;

  color asteroidColor = color(0, 255, 0);
  float aSize = random(5, 15);

  void fall() {
    yAsteroid = yAsteroid + yspeed;
    if (yAsteroid > height + 40) {
      yAsteroid = random(-200, -100);
      xAsteroid = random(width);
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
    rect(xAsteroid, yAsteroid, aSize, aSize);
  }

  void hit(int i) {
    if (sqrt(pow(u.get(i).x - xAsteroid, 2) + pow(u.get(i).y - yAsteroid, 2)) < aSize/2 + ufoSize/2) {      
      u.get(i).removeUfo = true;
      if (u.size() == 0) { 
        gameScreen = 2;
      }
    }
  }

  void shot() {
    for (int i = 0; i < u.size(); i++) {
      float distShotTopAsteroidCenter = sqrt(pow(u.get(i).shot.x - xAsteroid, 2) + pow(u.get(i).shot.y - u.get(i).shot.length_ - yAsteroid, 2));
      if (distShotTopAsteroidCenter < aSize/2) {
        u.get(i).shot.finished();
        u.get(i).shot.removeShot();
        
        yAsteroid = random(-200, -100);
        xAsteroid = random(width);
        yspeed = 0.5;
        aSize = random(5, 40);
        color(255);
      }
    }
  }
}
