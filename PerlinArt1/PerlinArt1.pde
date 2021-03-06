FlowField flowfield;
ArrayList<Particle> particles;

boolean isShowingFF = false;
boolean isDrawingTrace = true;

float ratioOfWhiteParticles = 1.0;
float flowFieldTimeStep = 0.007;

int cnt = 1;

void setup() {
  size(1200, 800);
  
  flowfield = new FlowField(20, flowFieldTimeStep);
  flowfield.updateFF();
  
  initNParticles(10000);
  
  background(0);
}

void draw() {
  if (!isDrawingTrace) background(245);
  
  if(cnt % 10 == 0) flowfield.updateFF();
  //cnt++;
  
  if (isShowingFF) flowfield.display();
  
  for (Particle p : particles) {
    p.applyFieldForce(flowfield);
    p.run();
  }
}

// This is how we init particles 
void initNParticles(int n){
  particles = new ArrayList<Particle>();
  for (int i = 0; i < n; i++) {
    float maxSpeed = random(1, 4);
    PVector start_point = new PVector(random(width), random(height));
    if (random(1)<ratioOfWhiteParticles)
      particles.add(new Particle(start_point, maxSpeed, (int)random(255), (int)random(255), (int)random(255)));
     else
       particles.add(new Particle(start_point, maxSpeed, 0, 0, 0));
    
    
    //if (i%2 == 0){
    //  PVector start_point = new PVector(width/2-random(width)/4, height/4+random(height/4));
    //  if (random(1)<ratioOfWhiteParticles)
    //    particles.add(new Particle(start_point, maxSpeed, 255, 255, 255));
    //  else
    //    particles.add(new Particle(start_point, maxSpeed, 200, 0, 100));
    //}
    //else{
    //  PVector start_point = new PVector(width/2+random(width/4), height/2+random(height/4));
    //  if (random(1)<ratioOfWhiteParticles)
    //    particles.add(new Particle(start_point, maxSpeed, 255, 255, 255));
    //  else
    //    particles.add(new Particle(start_point, maxSpeed, 100, 50, 200));
    //}
    
  }
}
