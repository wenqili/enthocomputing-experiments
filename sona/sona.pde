//Enthocomputing Experiments
//Pioneer Work, Second Sunday, 2018 April 8
//Wenqi Li

//config
//
int thickness = 10;
float curve_amp = 8;
float reflect_diameter = 60;
int dot_cols = 12;
int dot_rows = 7;
int side_length = 100;

//The dots grid
Grid gcd;

//Mirrors
MGrid mgcd;
ArrayList<Mirror> mirrorArray;

//trace
PGraphics trace;
Mover mover;

void setup() {

  size(1300, 800); // 100px padding
  pixelDensity(2); // HD for Macbook
  frameRate(60); // Speed up

  mirrorArray = new ArrayList<Mirror>();
  //thickness = 10;
  trace = createGraphics(1300, 800);
  mover = new Mover(100, 50);

  gcd = new Grid(dot_rows, dot_cols, side_length, side_length, side_length); // Grid(int cols, int rows, int side, int OriginX, int OriginY)
  mgcd = new MGrid(2*dot_rows+1, 2*dot_cols+1, side_length/2, side_length/2, side_length/2);
  mgcd.display();
}


void draw() {
  background(0);

  //Draw trace layer beneath the canvas
  trace.beginDraw();
  //trace.background(255, 255, 0, 50);
  mover.update();
  mover.checkEdges();
  mover.display();
  trace.endDraw();
  image(trace, 0, 0);

  //display mirror grid on canvas
  for (int i = 0; i < mirrorArray.size(); i++) {
    Mirror _mirror = mirrorArray.get(i);
    _mirror.display();
    _mirror.reflect(mover); // Algorithm
  }

  //display dots grid on canvas
  gcd.display();
}


// Mirror place interaction
void mousePressed() {
  for (int i = 0; i < mirrorArray.size(); i++) {
    Mirror _tempMirror = mirrorArray.get(i);
    _tempMirror.mouseClickOver();
    _tempMirror.update();
  }
}


// Trace on/off triggerred by SPACEBLANK key
void keyPressed() {
  if (key == 32) {
    mover.isMoving = !mover.isMoving;
  }
}
