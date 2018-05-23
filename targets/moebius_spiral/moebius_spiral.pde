import gifAnimation.*;
GifMaker gifExport;
boolean makeGif = true;
boolean gifdone = false;

int xw = 60;
int yw = 60;
CVector[]  pts; // input points, on a square grid
CVector[] grid; // transformed output points

int xdim;
int ydim;

float offset = -1;

void setup() {
  size(600, 600);
  noStroke();
  smooth();
  background(#2810B2);

  if (makeGif) {
    gifExport = new GifMaker(this, "moebius.gif");
    gifExport.setRepeat(1);             // make it an "endless" animation
  }  //gifExport.setTransparent(0, 0, 0);    // black is transparent

  xdim = (2*xw + 1);
  ydim = (2*yw + 1);
  pts = new CVector[xdim*ydim];
  grid = new CVector[xdim*ydim];
  int index = 0;
  float g = PI*(3-sqrt(5));
  for (int y = -yw; y <= yw; y++) {
    for (int x = -xw; x <= xw; x++) {
      grid[index] = new CVector(0, 0);
      float th= 1*index;
      float r = 0.01*sqrt(index);
      pts[index] = new CVector((float)x/xw, (float)y/yw);
      pts[index].frompolar(r, th);

      index++;
    }
  }
}



void draw() {
  CVector draw;
  CVector num;
  CVector denom;
    background(#2810B2);
  CVector one = new CVector(1.0, 0.0);
  //CVector one = new CVector(1.0 + fmouseX(), fmouseY());
  //CVector one = new CVector(0.005*fmouseX(), 0.0);
  int index = 0;
  //number of transitions
  float g = PI*(3-sqrt(5));

  println(fmouseX());
  offset += 1.0/30;
  if (offset > 2.0) {

    offset=0;
    gifdone = true;
  }

  for (int y  = -yw; y <=yw; y++) {
    for (int x = -xw; x <=xw; x++) {
      float th= g*index;
      th = 2.01*(PI/3)*index;
      //float r = 0.01*sqrt(index) + offset;
      float r = 0.01*sqrt(index) + offset;
      //draw = draw.add(new CVector(nMouseX(), nMouseY()));
      draw = new CVector(0, 0);
      draw.frompolar(r, th);
      num = draw.add(one);
      denom = draw.neg();
      grid[index++] = num.div(denom.add(one));
    }
  }

  CVector c1, c2, c3, c4;
  float zoom = 200;
  index = 0;
  CVector scalev = new CVector(zoom, 0);
  for (int y  = 0; y < ydim-1; y++) {
    for (int x = 0; x < xdim-1; x++) {
      c1 = grid[y*xdim + x].mul(scalev);

      //stroke(255);
      noStroke();
      fill(color(255, 255, 255, 255));
      float w = 0.001*(xw*yw - index);
      w = 0.05*sqrt(index);
      //w = 1.0;
      ellipse((c1.i + width)/2.0, 0.25*height  - (c1.r/2.0) + zoom/2,  w, w);
      index++;
    }
  }

  if (!makeGif) {
    return;
  }

  if (gifdone) {
    gifExport.finish();
    makeGif = false;
    return;
  }
  //gifExport.setDelay(1);
  gifExport.addFrame();
  println(offset);
}

float fmouseX() {

  return 2.0*map(mouseX, 0, width, -1.0, 1.0);
}
float fmouseY() {

  return 1.0*map(mouseY, 0, height, -1.0, 1.0);
}
