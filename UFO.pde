class UFO {

  color ufoColor;
  float x, y;
  
  UFO (){
    ufoColor = color(0, 0, 255);
    x = width/2;
    y = width/2;
  }
  
  void show() {
    //noFill();
    fill(ufoColor, 60);
    stroke(ufoColor);
    ellipse(x, y, ufoSize, ufoSize);
    fill(ufoColor, 90);
    ellipse(x, y, ufoSize - 25, ufoSize - 25);
  }
}
