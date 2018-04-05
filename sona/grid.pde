class Grid{
  int cols;
  int rows;
  int side;
  int originX;
  int originY;
  
  Grid(int cols, int rows, int side, int x, int y){
    this.cols = cols;
    this.rows = rows;
    this.side = side;
    this.originX = x;
    this.originY = y;
  }
  
  void display(){
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        int _posX = originX + i * side;
        int _posY = originY + j * side;
        fill(255);
        noStroke();
        ellipseMode(CENTER);
        ellipse(_posX, _posY, thickness, thickness);
      }
    }
  }
}
