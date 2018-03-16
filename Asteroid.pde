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
    //noFill();
    //strokeWeight(1);
    fill(asteroidColor, 70);
    rect(x, y, aSize, aSize);
  }

  void hit() {
    if (sqrt(pow(mouseX - x, 2) + pow(mouseY - y, 2)) < aSize/2 + ufoSize/2) {      
      gameScreen = 2;
    }
  }
}