//Based on https://pastebin.com/aspcVzGx
Blob[] blobs = new Blob[30];
float theta;
int frms = 300;

void setup() {
  size(640, 480);
  colorMode(HSB,360,100,100);
  for (int i=0; i<blobs.length; i++) {
    int d = i%2==0?1:-1;
    float offSet = TWO_PI/blobs.length*i + random(1);
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
      pixels[index] = color(sum-50);
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

  Blob(float x, float y, float _offSet) {
    orig = new PVector(x, y);
    pos = new PVector(0, 0);
    //vel = PVector.random2D();
    //vel.mult(random(2, 5));
    r = random(10, 100);
    //d = random(50, 200);
    offSet = _offSet;
  }

  void update() {
    //pos.add(vel);
    d = map(pow(abs(sin(theta+offSet*9)),0.5),0,1,-5,200);
    //d = map(pow(sin(theta+offSet*9),2),-1,1,0,200);
    //d = map(pow(sin(theta+offSet*3),3),0,1,50,200);
    pos.x = width/2 + cos(offSet)*d;
    pos.y = height/2 + sin(offSet)*d;
  }
}