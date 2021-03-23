class Particle {
  PVector loc = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  
  float   lifeSpan = 0;
  color   c = 0;
  
  // construction functions
  Particle() {
    ;
  }

  Particle(PVector loc_) {
    loc = loc_.copy();
  }
  
  Particle(PVector loc_, PVector vel_) {
    loc = loc_.copy();
    vel = vel_.copy();
  }

  Particle(PVector loc_, PVector vel_, PVector acc_) {
    loc = loc_.copy();
    vel = vel_.copy();
    acc = acc_.copy();
  }  
  
  // basic physics
  void applyForce(PVector force) {
    acc.add(force);
  }    
  
  void update() {
    loc.add(vel);
    vel.add(acc);
    acc.mult(0);
  }
  
  // default display function
  void show() {
    color(c);
    point(loc.x, loc.y);
  }
  
  void setColor(color c_) {
    c = c_;
  }
  
  // span life
  void setLife(float life_) {
    lifeSpan = life_;
  }

  void decreaseLife() {
    if (lifeSpan > 0) {
      lifeSpan -= 1.0;
    }
  }
  
  void decreaseLife(float value) {
    if (lifeSpan > 0) {
      lifeSpan -= value;
    }
  }
  
  boolean isDead() {
    if (lifeSpan <= 0) {
      return true;
    } else {
      return false;
    }
  }

}
