class UFO {

  color ufoColor;
  float x, y;

  UFO () {
    ufoColor = color(0, 0, 255);
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
    ellipse(x, y, ufoSize - 25, ufoSize - 25);
  }

  void outOfArea() {
    if (x < -50 ||  x > width+50 || y < -50 || y > height + 50) {
      println("outOfScreen");
    }
  }
}
