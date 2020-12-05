public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
  int r, g, b;
  int cnt;

  Particle(PVector start, float maxspeed, int pr, int pg, int pb) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
    r = pr;
    g = pg;
    b = pb;
    cnt = 0;
  }

  void run() {
    updatePosition();
    edges();
    show();
  }

  void updatePosition() {
    pos.add(vel);
    vel.add(acc);
    vel.limit(maxSpeed);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void applyFieldForce(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);

    PVector force = flowfield.vectors[x][y];
    applyForce(force);
  }

  void show() {
    //if (isDrawingTrace)
    //  stroke(r, g, b, 15);
    //else
    //  stroke(r, g, b, 225);
    ////strokeWeight(3);
    //strokeWeight(1);
    //strokeCap(SQUARE);
    //line(pos.x, pos.y, previousPos.x, previousPos.y);
    ////point(pos.x, pos.y);
    if (cnt%60 == 0) {
      float w = random(100, 200) * pow(0.8, cnt/60);
      rect(pos.x, pos.y, w, 2*w);
      float g = noise(pos.x, pos.y, cnt)*100*pow(1.1, cnt/60);
      fill(0, g, 0);
      stroke(0, g, 0);
    }
    cnt++;
    updatePreviousPos();

  }

  void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }

  void edges() {
    if (pos.x > width) {
      pos.x = 0;//10*width-9*pos.x;
      updatePreviousPos();
    }
    if (pos.x < 0) {
      pos.x = width;//-9*pos.x;    
      updatePreviousPos();
    }
    if (pos.y > height) {
      pos.y = 0;//10*height-9*pos.y;
      updatePreviousPos();
    }
    if (pos.y < 0) {
      pos.y = height;//-9*pos.y;
      updatePreviousPos();
    }
  }

}
