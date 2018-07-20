class PlayerGPIO {
  int up;
  int down;
  int left;
  int right;
  int button;

  PlayerGPIO(int up_, int down_, int left_, int right_, int button_) {
    up = up_;
    down = down_;
    left = left_;
    right = right_;
    button = button_;
  }
}
