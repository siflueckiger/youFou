class Treasure {

  float x = random(40, width - 40);
  float y = random(40, height - 40);
  float size = random(20, 40);
  color tresColor = color(255);

  void show() {
    stroke(tresColor);
    strokeWeight(1);
    //noFill();
    fill(tresColor);
    //ellipse(x, y, size, size);
    float halfSize = size / 2;
    triangle(x, y - halfSize, x + halfSize, y + halfSize, x - halfSize, y + halfSize);
  }

  void pick(int _j) {
    int treasureToRemove = _j;
    for (int i = 0; i < u.size(); i++) {
      if (sqrt(pow(u.get(i).x - x, 2) + pow(u.get(i).y - y, 2)) < size/2 + ufoSize/2 - 12) {      
        newPosition();
        score = score + 1;
        u.get(i).shot.shotCounter++;
        
        if (t.size() > u.size()) {
          t.remove(treasureToRemove);
        }
      }
    }
  }

  void newPosition() {
    x = random(width);
    y = random(height);
  }
}
