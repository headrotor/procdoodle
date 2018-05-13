import gifAnimation.*;
GifMaker gifExport;
boolean makeGif = true;
boolean gifdone = false;

int xw = 60;
int yw = 60;

float ph = PI;

int xdim;
int ydim;

float offset = -1;

void setup() {
  xdim = 200;
  ydim = 200;
  size(200, 200);
  noStroke();
  smooth();
  background(#2810B2);

  if (makeGif) {
    gifExport = new GifMaker(this, "target1.gif");
    gifExport.setRepeat(1);             // make it an "endless" animation
    // twitter seeems to ignore this
    gifExport.setDelay(33);
  }  //gifExport.setTransparent(0, 0, 0);    // black is transparent
}



void draw() {
  int index = 0;
  //number of transitions

  ph =  ph + PI/100;  
  int xd = xdim/2;
  int yd = ydim/2;
  println(fmouseX());
  noStroke();
  float scale = 8;
  for (int y  = 0; y < ydim; y++) {
    for (int x = 0; x < xdim; x++) {

      float r = sqrt( (x-xd)*(x-xd) + (y-yd)*(y-yd));
      int red = int(80*sin(r*cos(ph*0.9)/scale)) + 127;
      int grn = int(800*sin(r*cos(ph)/scale)) + 127;
      int blu = int(800*sin(r*cos(ph*1.1)/scale)) + 127;
      fill(red, grn, blu);
      //fill(red);
      rect(x,y,1,1);
    }
  }

  if (ph > 3*PI) {
    gifdone = true;
  }
  if (!makeGif) {
    return;
  }

  if (gifdone) {
    gifExport.finish();
    makeGif = false;
    return;
  }
  gifExport.addFrame();
  println(offset);
}

float fmouseX() {

  return 2.0*map(mouseX, 0, width, -1.0, 1.0);
}
float fmouseY() {

  return 1.0*map(mouseY, 0, height, -1.0, 1.0);
}
