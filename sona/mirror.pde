class Mirror {
  PVector pos;
  int direction;// 0-No placement; 1-horizontal placement; 2-vertical placement
  boolean isDisplay;
  boolean mouseOver;
  float reflectDiameter;

  //for curve computing
  boolean firstEnter;
  PVector enterPos;
  PVector enterVel;
  PVector exitPos;
  float curveAmp;

  Mirror(PVector pos) {
    this.pos = pos;
    this.direction = 0; 
    this.isDisplay = true;
    this.mouseOver = false;
    this.reflectDiameter = reflect_diameter;

    this.firstEnter = false;
    this.enterPos = new PVector(0, 0);
    this.enterVel = new PVector(0, 0);
    this.exitPos = new PVector(0, 0);
    this.curveAmp = curve_amp;
  }

  void display() {

    if (this.isDisplay) {
      noFill();
      stroke(255, 0, 0, 120);
      ellipse(this.pos.x, this.pos.y, this.reflectDiameter, this.reflectDiameter);//the reflect area
    }

    fill(255, 0, 0);
    switch(this.direction) {
    case 0:
      //no placement;
      noStroke();
      ellipse(this.pos.x, this.pos.y, 5, 5);
      break;

    case 1:
      //horizontal mirror
      stroke(255, 0, 0);
      line(this.pos.x-50, this.pos.y, this.pos.x + 50, this.pos.y);

      break;
    case 2:
      //verticle mirror
      stroke(255, 0, 0);
      line(this.pos.x, this.pos.y-50, this.pos.x, this.pos.y+50);
      break;
    }
  }

  void update() {
    if (this.mouseOver) {
      this.direction= (this.direction+1)%3;
    }
  }

  void mouseClickOver() {
    if (dist(mouseX, mouseY, pos.x, pos.y) <= this.reflectDiameter/2) {
      this.mouseOver = true;
    } else {
      this.mouseOver = false;
    }
  }

  void reflect(Mover m) {
    float d = dist(pos.x, pos.y, m.pos.x, m.pos.y);

    if (d <= this.reflectDiameter/2) {

      if (this.isDisplay) {
        //guide line
        stroke(255, 0, 0, 120);
        line(pos.x, pos.y, m.pos.x, m.pos.y);
      }

      //check first enter & exit
      if (!this.firstEnter) {
        //println("First Enter!");
        this.firstEnter = true;
        this.enterPos.x = m.pos.x;
        this.enterPos.y = m.pos.y;
        this.enterVel.x = m.vel.x;
        this.enterVel.y = m.vel.y;
        this.exitPos.x = this.enterPos.x + 2*(this.pos.x-this.enterPos.x);
        this.exitPos.y = this.enterPos.y + 2*(this.pos.y-this.enterPos.y);
      }

      //curver computing using sin function
      //println("Still indise reflect area");
      switch(direction) {
      case 0:
        //println("No mirror");
        break;

      case 1:
        //println("Horizontal Mirror");
        //m.vel.y *= -1; //solid solution

        float yoff = map(m.pos.x, this.enterPos.x, this.exitPos.x, 0, radians(180));
        if (this.enterVel.y > 0) {
          m.pos.y = this.enterPos.y + this.curveAmp*sin(yoff);
        } else {
          m.pos.y = this.enterPos.y - this.curveAmp*sin(yoff);
        }

        break;

      case 2:
        //println("Vertical mirror");
        //m.vel.x *= -1;

        float xoff = map(m.pos.y, this.enterPos.y, this.exitPos.y, 0, radians(180));

        if (this.enterVel.x > 0) {
          m.pos.x = this.enterPos.x + this.curveAmp*sin(xoff);
        } else {
          m.pos.x = this.enterPos.x - this.curveAmp*sin(xoff);
        }

        break;
      }//end of happening inside
    } else {
      if (this.firstEnter && direction != 0) {

        //println("Exit");
        switch(direction) {
        case 1:
          m.vel.y *= -1; // horizontal reflect only change y velocity direction
          m.pos.x = this.exitPos.x;
          m.pos.y = this.enterPos.y; // horizontal reflect exit through the same y position
          break;

        case 2:
          m.vel.x *= -1; // Vertical reflect only change x velocity direction
          m.pos.x = this.enterPos.x; // Vertical reflect exit through the same x position
          m.pos.y = this.exitPos.y;
          break;
        }
      }//end of exit position computing

      this.firstEnter = false;
    }//end of enter-curve-exit computing
  }//end of mirror class reflect function
}
