// by dave whyte :) @beesandbombs

int[][] result;
float t, c;

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float mn = .5*sqrt(3), ia = atan(sqrt(.5));

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void draw() {

  if (!recording) {
    t = mouseX*1.0/width;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();

    saveFrame("f###.gif");
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 4;
int numFrames = 180;        
float shutterAngle = .4;

boolean recording = false;

void setup() {
  size(640, 640, P3D);
  result = new int[width*height][3];
  rectMode(CENTER);
  noStroke();
}

float tt;
int N = 17;
color c1 = color(30), c2 = color(30, 180, 230), c3 = color(250);
float l = 26, r = 200;

void cube(){
  for(int i=0; i<4; i++){
    push();
    fill(c1);
    if(i%2 == 1)
      fill(c2);
    rotateY(HALF_PI*i);
    translate(0,0,l/2);
    rect(0,0,l,l);
    pop();
  }
  
  for(int i=0; i<2; i++){
    push();
    fill(c3);
    rotateX(HALF_PI+PI*i);
    translate(0,0,l/2);
    rect(0,0,l,l);
    pop();
  }
}

void draw_() {
  background(30); 
  push();
  translate(width/2, height/2);
  rotateX(-.5);
  for (int i=0; i<N; i++) {
    tt = ease((t + i*1.0/N)%1,3);
    push();
    rotateY(TWO_PI*(i+.5)/N);
    rotateX(PI*tt);
    push();
    translate(0,0,r);
    cube();
    pop();
    push();
    translate(0,0,-r);
    cube();
    pop();
    pop();
  }
  pop();
}