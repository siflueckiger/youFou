class UFO {

  color ufoColor = color(0, 0, 255);

  void show() {
    fill(ufoColor, 60);
    stroke(ufoColor);
    ellipse(mouseX, mouseY, ufoSize, ufoSize);
    fill(ufoColor, 90);
    ellipse(mouseX, mouseY, ufoSize - 25, ufoSize - 25);
  }
}