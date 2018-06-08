class Treasure {

  float x = random(40, width - 40);
  float y = random(40, height - 40);
  float size = random(20, 40);
  color tresColor = color(255,20,147);

  void show() {
    stroke(tresColor);
    strokeWeight(1);
    //noFill();
    fill(tresColor);
    //ellipse(x, y, size, size);
    float halfSize = size / 2;
    triangle(x, y - halfSize, x + halfSize, y + halfSize, x - halfSize, y + halfSize);
  }

  void pick() {
    if (sqrt(pow(u.x - x, 2) + pow(u.y - y, 2)) < size/2 + ufoSize/2 - 12) {      
      score = score + 1;
      t = new Treasure();

      shotCounter++;
    }
  }
}
