//Based on https://pastebin.com/aspcVzGx
Blob[] blobs = new Blob[30];
float theta;
int frms = 300;



void setup() {
  size(640, 480);
  //colorMode(HSB, 360, 100, 100);
  for (int i=0; i<blobs.length; i++) {
    int d = i%2==0?1:-1;
    float offSet = float(i)/float(blobs.length);
    blobs[i] = new Blob(random(width), random(height), offSet);
  }
}

void draw() {
  background(34);
  noStroke();
  fill(color(0, 0, 255));

  rect( width/2 - width/4, height/2 - height/4, width/2, height/2, height/8);

  for (int i=0; i<blobs.length; i++) {
    //blobs[i].update();
    //blobs[i].draw_me();
    blobs[i].rect_update();
  }
  if (true) {
    loadPixels();
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        int index = x + y * width;
        float sum = 0;
        for (Blob b : blobs) {
          float d = dist(x, y, b.pos.x, b.pos.y);
          sum += 22*(b.r/d);
        }
        pixels[index] += color(sum-496);
      }
    }
    updatePixels();
  }
  for (int i=0; i<blobs.length; i++) {
    //blobs[i].draw_me();
  }
  theta += 0.02;
  //if (frameCount<frms) saveFrame("image-###.gif");
}

class Blob {

  float orig;
  PVector pos;
  PVector vel;
  float r;
  float d;
  float offset;
  float driftx;
  float drifty;
  float rl = width/2 - width/4;
  float rr = width/2 + width/4;
  float rt = height/2 - height/4;
  float rb = height/2 + height/4;
  float rw = rr - rl;
  float rh =  rb -rt;
  float speed = 0.002;

  Blob(float x, float y, float _offSet) {
    pos = new PVector(0, 0);
    //vel = PVector.random2D();
    //vel.mult(random(2, 5));
    r = random(150, 155);
    //r = 70;
    //d = random(50, 200);
    orig = _offSet;
    driftx = 0;
    drifty = 0;
    offset = 0;
  }

  PVector rect_pos(float frac) {
    // returns position on rectangle "frac" around the perimiter
    // 0 <= frac < 1
    float perim =  2*(rw + rh);
    float pfrac = frac * perim;

    if (pfrac < rw) {
      // top edge, return
      return(new PVector(rl + pfrac, rt));
    }
    pfrac = pfrac - rw;
    if (pfrac < rh) {
      // right edge, return
      return(new PVector(rr, rt + pfrac));
    }
    pfrac = pfrac - rh;
    if (pfrac < rw) {
      // bottom edge, return
      return(new PVector(rr - pfrac, rb));
    }

    pfrac = pfrac - rw;
    // left edge
    return(new PVector(rl, rb - pfrac));
  }

  void rect_update() {
    // make blob walk around rectangle perimeter
    offset = offset + 0.0002;
    //offset = offset + 0.004*(noise(theta, 200*orig + 0000) -0.3 );
    while ((orig + offset) >= 1.0) {
      offset = offset - 1.0;
    }
    while ((orig + offset) < 0) {
      offset = offset + 1.0;
    }
    pos = rect_pos(orig + offset);
    noiseDetail(3, 0);
    driftx  = 70*(noise(theta+  PI*100*orig, 0) -0.4 );
    drifty  = 70*(noise(theta, 100*orig) -0.4 );
    pos.x += driftx; 
    pos.y += drifty; 
    //ellipse(pos.x, pos.y, 20, 20);
  }

  void draw_me() {
    // for debugging, 
    float rs = r*0.15;
    //ellipse(pos.x - rs, pos.y -rs, rs, pos.y +rs);
    ellipse(pos.x, pos.y, rs, rs);
  }
}