class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color fill_color;
  color stroke_color;
  Particle(PVector p, color fill_clr, color strk) {
    acceleration = new PVector(random(-2,2)*0.001,random(-2,2)*0.001);
    velocity = new PVector(random(-4,4)*0.1,random(-4,4)*0.1);
    location = p.copy();
    fill_color = fill_clr;
    stroke_color = strk;
    lifespan = 300;
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan--;
  }
  boolean isDead() {
    if (lifespan <= 0) {
      return true;
    }
    return false;
  }
  
  void display() {
    noStroke();
    fill(fill_color,50*(lifespan/300));
    ellipse(location.x, location.y, 20,20);
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }
  void addParticles(int n, PVector source, color fill_color, color stroke_color) {
    for (int i = 0; i < n; i++) {
      particles.add(new Particle(new PVector(source.x, source.y),fill_color, stroke_color));
    
    }
  }
   void run() {
     for (int i = particles.size()-1; i>=0; i--) {
       Particle p = particles.get(i);
       p.update();
       p.display();
       if (p.isDead()) {
          particles.remove(i);
       }
     }
   }
  
}