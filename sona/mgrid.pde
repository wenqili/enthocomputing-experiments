class MGrid {
  int cols;
  int rows;
  int side;
  int originX;
  int originY;

  MGrid(int cols, int rows, int side, int x, int y) {
    this.cols = cols;
    this.rows = rows;
    this.side = side;
    this.originX = x;
    this.originY = y;
  }

  void display() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        if (i%2 == 1 && j%2 == 0 || i%2 ==0 && j%2 ==1) {

          int _posX = originX + i * side;
          int _posY = originY + j * side;

          //place mirrors
          PVector _pos = new PVector(_posX, _posY);
          Mirror _mirror = new Mirror(_pos);

          //initial placement for borders
          if (i == 0 || i == rows-1) {
            _mirror.direction = 2;
          } else if (j == 0 || j==cols-1) {
            _mirror.direction = 1;
          }

          //initial placement for starting point
          if (i == 1 && j == 0 ) {
            _mirror.direction = 0;
          }

          _mirror.display();
          mirrorArray.add(_mirror);
        }
      }
    }
  }
}
