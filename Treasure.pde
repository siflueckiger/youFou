class Treasure {

  float x = random(40, width - 40);
  float y = random(40, height - 40);
  float size = random(10, 30);
  color tresColor = color(255, 0, 0);

  void show() {
    stroke(tresColor);
    //noFill();
    fill(tresColor, 90);
    ellipse(x, y, size, size);
  }

  void pick() {
    if (sqrt(pow(u.x - x, 2) + pow(u.y - y, 2)) < size/2 + ufoSize/2 - 12) {      
      score = score + 1;
      t = new Treasure();
    }
  }
 
}
