class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  boolean isMoving;

  Mover(float x, float y) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(0.6, 0.6);
    this.acc = new PVector(0, 0);
    this.mass = thickness;
    this.isMoving = false;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, this.mass);
    this.acc.add(f);
  }

  void update() {
    if (this.isMoving) {
      this.vel.add(this.acc);
      this.pos.add(this.vel);
      this.acc.mult(0);
    }
  }

  void display() {
    trace.ellipseMode(CENTER);
    trace.noStroke();
    //trace.stroke(0,0,255);
    trace.fill(255);
    //trace.noFill();
    trace.ellipse(this.pos.x, this.pos.y, this.mass, this.mass*1);
  }

  void checkEdges() {
    if (this.pos.x >= width) {
      this.vel.x *= -1;
      this.pos.x = width;
    } else if (this.pos.x < 0) {
      this.vel.x *= -1;
      this.pos.x = 0;
    }

    if (this.pos.y >= height) {
      this.vel.y *= -1;
      this.pos.y = height;
      //pos.y = height;
    } else if (this.pos.y < 0) {
      this.vel.y *= -1;
      this.pos.y = 0;
    }
  }
}
