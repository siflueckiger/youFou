class NewPlayer {

  int x = width / 2;//random(40, width - 40);
  int y = int(random(height / 2, height - 40));
  float size = 50;
  color newPlayerColor;

  NewPlayer(color newPlayerColor_) {
    newPlayerColor = newPlayerColor_;
  }

  void show() {
    String newPlayerNumber = "P" + int(playerCount + 1);
    textAlign(CENTER, CENTER);
    fill(newPlayerColor);
    textSize(36);
    noFill();
    ellipse(x, y, size, size);
    text(newPlayerNumber, x, y);
  }

  void activate() {
    for (int i = 0; i < u.size(); i++) {
      if (sqrt(pow(u.get(i).x - x, 2) + pow(u.get(i).y - y, 2)) < size/2 + ufoSize/2 - 12) {      
        playerCount++;
        u.add(new UFO(playerColor[playerCount-1], playerGPIO[playerCount-1], int(random(width)), int(random(height))));
        t.add(new Treasure());
        
        x = width/2;
        y = int(random(height));
        
        break;
      }
    }
  }
}
