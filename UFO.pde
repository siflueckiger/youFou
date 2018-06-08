class UFO {

  color ufoColor;
  float x, y;

  UFO () {
    ufoColor = color(0, 255, 255);
    x = width/2;
    y = width/2;
  }

  void show() {
    //noFill();
    fill(ufoColor);
    stroke(ufoColor);
    strokeWeight(2);
    ellipse(x, y, ufoSize, ufoSize);
    fill(0);
    ellipse(x, y, ufoSize - 20, ufoSize - 15);
  }

  void outOfArea() {
    if (x < -500 ||  x > width+500 || y < -500 || y > height + 500) {
      gameScreen = 4;
    }
  }
}
