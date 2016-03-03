
int nw  = 15;
int framecount = 0;
// use imagemagick to make gifs:  $convert  -delay 7 -loop 0 f*.png ani.gif
Elwave[] ew;

void setup() {
  size(500, 500);
  ew = new Elwave[nw];
  for (int i=0; i < nw; i++) {
    ew[i] = new Elwave(width/2, height/2, 12*i, i*2*PI/10);
  }
}

void draw() {  
  background(80);
  float x1, y1; 
  float x2, y2;


  stroke(255);
  fill(100, 100, 100, 25);
  //noFill();
  for (int i=1; i < nw; i++) {
    ew[i].drawme();
  }

  if (ew[1].done) {
    return;
  }
  if (framecount %2 == 1) {
    String fname = "frames/f" + nf(framecount, 3) + ".png";
    saveFrame(fname);
  }
  framecount += 1;
}

