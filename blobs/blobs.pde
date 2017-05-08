//Based on https://pastebin.com/aspcVzGx
Blob[] blobs = new Blob[30];
float theta;
int frms = 300;

void setup() {
  size(640, 480);
  colorMode(HSB,360,100,100);
  for (int i=0; i<blobs.length; i++) {
    int d = i%2==0?1:-1;
    float offSet = TWO_PI/blobs.length*i;
    blobs[i] = new Blob(random(width), random(height),offSet);
  }
}

void draw() {
  background(34);
  for (int i=0; i<blobs.length; i++) {
    blobs[i].update();
  }
  loadPixels();
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      int index = x + y * width;
      float sum = 0;
      for (Blob b : blobs) {
        float d = dist(x, y, b.pos.x, b.pos.y);
        sum += 20*(b.r/d);
      }
      pixels[index] = color(sum-150);
    }
  }
  updatePixels();
  theta += TWO_PI/frms;
  //if (frameCount<frms) saveFrame("image-###.gif");
}

class Blob {

  PVector orig;
  PVector pos;
  PVector vel;
  float r;
  float d;
  float offSet;
  float drift;

  Blob(float x, float y, float _offSet) {
    orig = new PVector(x, y);
    pos = new PVector(0, 0);
    //vel = PVector.random2D();
    //vel.mult(random(2, 5));
    r = random(150, 155);
    //r = 70;
    //d = random(50, 200);
    offSet = _offSet;
    drift = 0;
  }

  void update() {
    //pos.add(vel);
    //d = map(pow(abs(sin(theta+offSet*9)),0.5),0,1,-5,200);
    d = map(pow(sin(theta+offSet*11),1),-1,1,-10,180);
    //d = map(pow(sin(theta+offSet*3),3),0,1,50,200);
    pos.x = width/2 + 1.2*cos(offSet + drift)*d;
    pos.y = height/2 + 0.7*sin(offSet + drift)*d;
    //noiseDetail(4,0.5);
    //drift  += 0.75*(noise( -0.03) -0.5); 
    drift  += 0.05*(noise(theta, 100*offSet) -0.5 ); 
   }
}