class Firework extends Particle {

  boolean exploded = false;
  float   z = random(1, 2); // z is a fake depth
  
  Particle[] particles;  
  int[] colorPatterns = {50, 80, 120, 180, 220}; 
  int c = floor(random(5)); // a random color pattern
  
  Firework(PVector loc_, PVector vel_) {
    loc = loc_;
    vel = vel_;
    particles = new Particle[100];
  }
  
  void update() {
    
    if (!exploded) {
      // if not exploded, update the main firework
      super.update();
      
      if (abs(vel.y) <= 1) {
        exploded = true;
        for (int i = 0; i < particles.length; i++) {
          PVector vel_n = PVector.fromAngle(TWO_PI / particles.length * i);
          vel_n.mult(random(0, 5));
          vel_n.div(z);
          particles[i] = new Particle(loc, vel_n);
          particles[i].setLife(random(150, 250));

          int c_p = colorPatterns[c];
          particles[i].setColor(color(random(c_p, c_p + 30), 255, 255));
          
        }
      }
    } else {
      // if exploeded, update small particles instead of the main firework
      for (int i = 0; i < particles.length; i++) {
        particles[i].update();
        particles[i].decreaseLife(3);
      }
    }
  }
  
  void show() {
    if (!exploded) {
      // display the main firework
      fill(120);
      ellipse(loc.x, loc.y, 8 / z, 8 / z);
      }
    else {
      // or display exploded small fireworks
      pushStyle();
      
      for (int i = 0; i < particles.length; i++) {
        fill(particles[i].c, particles[i].lifeSpan);
        ellipse(particles[i].loc.x, particles[i].loc.y,  5 / z, 5 / z);
      }
      popStyle();
    }  
  }
  
  boolean isDead() {
    boolean bAllParticlesDead = true;
    if (exploded) {
      for (int i = 0; i < particles.length; i++) {
        if (!particles[i].isDead()) {
          bAllParticlesDead = false;
        }
      }
    }
    return (exploded && bAllParticlesDead);
  }
}
