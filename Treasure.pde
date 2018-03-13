class Treasure {

  float x = random(40, width - 40);
  float y = random(40, height - 40);
  float size = random(10, 30);
  color tresColor = color(255, 0, 0);

  void show() {
    stroke(tresColor);
    fill(tresColor, 90);
    ellipse(x, y, size, size);
  }

  void pick() {
    if (sqrt(pow(mouseX - x, 2) + pow(mouseY - y, 2)) < size/2 + ufoSize/2 - 12) {      
      score = score + 1;
      t = new Treasure();
    }
  }
 
}