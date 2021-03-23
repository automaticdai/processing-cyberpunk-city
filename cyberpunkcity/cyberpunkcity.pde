// automaticdai
// YunFei Robotics Lab
// Inspired by Cyberpunk City, Richard Bourne

import processing.sound.*;

int fps = 15;
int building_number = 2000;
int[][] building_coor = new int[building_number][3];  // a[], x, b_height, z

float x = 0;
SoundFile song;
int timestamp = 0;
int frame_count = 0;

void building_generator(){
  textSize(14);
  int a;
  int a_min;
  int a_max;
  
  float b;

  int distance_x = 0;
  
  randomSeed(0);  // fix the random seed
  
  for (int j = 0; j < building_number; j++) {
    fill(int(random(0, 255)), 95, 95);
    int b_height = int(((random(1) * height + 60) * 0.6)); // int(random(50, height/2));
    distance_x += int(random(20, 60));
    
    // three widths of building:
    b = random(0, 1);
    if (b > 0.8) {
      a_min = 1000000; a_max = 9999999;
    } else if (b > 0.5) {
      a_min = 10000; a_max = 99999;
    } else {
      a_min = 1000; a_max = 9999;
    }

    float z = random(-100, -10);  // depth
    
    for (int y = height; y > height - b_height; y-=12) {
      a = int(random(a_min, a_max));
      
      // display if it is wihtin eye of sight (to improve performance)
      if ((distance_x > x - 100) && (distance_x < x + width + 100)) {
        text(a, distance_x, y, z); 
      }
    }
  }
  
  //println(distance_x);  // this is the maximum length of the scrolling
}


void moon() {
  int final_x = width - 200;
  int final_y = 20;
  
  if (frameCount < 500) {
    fill(255);
    ellipse(final_x + (250 - frameCount / 2), final_y + (100 - frameCount / 5), 100, 100);
  }
  else {
    fill(255);
    ellipse(final_x, final_y, 100, 100);
  }
}


void stars() {
  randomSeed(10);
  for (int i = 0; i < 20; i++) {
    fill((sin(frameCount / 10.0 + random(0,5)) + 1.0) * 255);
    float size = random(5, 10);
    ellipse(random(0, width-200), random(0, 300), size, size);
  }
}


ArrayList<Firework> fireworks;
PVector gravity = new PVector(0, 0.2); 

void fireworks() {
  if (frameCount < 200) { return;}
  
  randomSeed(frameCount);
  random(1);  // omit the first random number
  
  println(frameCount);
  if (frameCount % 40 == 0) {
    Firework firework = new Firework(new PVector(random(0, width/4*3), height), new PVector(0, random(-14, -8)));
    fireworks.add(firework);
  }
  
  if (frameCount % 30 == 0) {
    Firework firework = new Firework(new PVector(random(0, width/4*3), height), new PVector(0, random(-14, -8)));
    fireworks.add(firework);
  }
  
  for (int i = fireworks.size() - 1; i >= 0; i --) {
    fireworks.get(i).applyForce(gravity);
    fireworks.get(i).update();
    fireworks.get(i).show();
    
    if (fireworks.get(i).isDead()) {
      fireworks.remove(i);
    }
  }
}


void setup(){
  size(1920, 1080, P3D);
  background(0);
  
  frameRate(fps);
  colorMode(HSB, 255, 100, 100);
  
  // Load a soundfile from the /data folder of the sketch and play it back
  song = new SoundFile(this, "HeroDanceParty.wav");
  song.play();
  
  fireworks = new ArrayList<Firework>();
  
  Firework firework = new Firework(new PVector(random(width), height), new PVector(0, random(-20, -10)));
  fireworks.add(firework);
}


void draw() {
  background(0);
  
  pushMatrix();

  rotateX(PI/12);  // rotate to show some 3d effects
  
  translate(-x, 0);
  x = x + 1.1;
  building_generator();
  popMatrix();
  
  translate(0, 0, -200);
  moon();
  stars();
  fireworks();
  
  frame_count += 1;
}
