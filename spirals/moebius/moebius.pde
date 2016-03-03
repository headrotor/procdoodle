
boolean makeGif = true;
boolean gifdone = false;
int framecount = 0;

// use imagemagick to make gifs:  $convert  -delay 7 -loop 0 f*.png ani.gif
int xw = 20;
int yw = 20;
CVector[]  pts; // input points, on a square grid
CVector[] grid; // transformed output points

int xdim;
int ydim;

float offset = 0;

void setup() {
  size(600, 600);
  noStroke();
  smooth();


  xdim = (2*xw + 1);
  ydim = (2*yw + 1);
  pts = new CVector[xdim*ydim];
  grid = new CVector[xdim*ydim];
  int index = 0;
  for (int y = -yw; y <= yw; y++) {
    for (int x = -xw; x <= xw; x++) {
      grid[index] = new CVector(0, 0);

      pts[index++] = new CVector((float)x/xw, (float)y/yw);
    }
  }
}


void draw() {
  background(#2810B2);
  CVector draw;
  CVector num;
  CVector denom;
  CVector one = new CVector(1.0, 0.0);
  int index = 0;
  //number of transitions
  offset += 1.0/(20*xw);
  if (offset > 1.01/xw) {

    offset=0;
    gifdone = true;
  }
  for (int y  = -yw; y <=yw; y++) {
    for (int x = -xw; x <=xw; x++) {
      draw = pts[index];
      //draw = draw.add(new CVector(nMouseX(), nMouseY()));
      draw = draw.add(new CVector(0, offset));
      num = draw.add(one);
      denom = draw.neg();
      grid[index++] = num.div(denom.add(one));
    }
  }

  CVector c1, c2, c3, c4;
  CVector scalev = new CVector(200, 0);
  for (int y  = 0; y < ydim-1; y++) {
    for (int x = 0; x < xdim-1; x++) {
      c1 = grid[y*xdim + x].mul(scalev);
      c2 = grid[(y+1)*xdim + x ].mul(scalev);
      c3 = grid[y*xdim + (x +1)].mul(scalev);
      c4 = grid[(y+1)*xdim + (x +1)].mul(scalev);
      //line(sc*draw.re() +100, sc*draw.im() + height/2, sc*lastx + 100, sc*lasty+height/2);
      //stroke(color(0,0,255));
      //line(c1.i + width/2, height - c1.r, c2.i + width/2, height-c2.r );
      //stroke(0);
      //line(c1.i + width/2, height -c1.r, c3.i + width/2, height-c3.r );
      stroke(255);
      fill(255);
      // size of quad is roughly bounding box
      float maxy = max(max(c1.r, c2.r), max(c3.r, c4.r));
      float miny = min(min(c1.r, c2.r), min(c3.r, c4.r));
      float maxx = max(max(c1.i, c2.i), max(c3.i, c4.i));
      float minx = min(min(c1.i, c2.i), min(c3.i, c4.i));
      float w = 1;
      if ((maxx < width ) & (maxx > -width)) {
        if ((minx < width ) & (minx > -width)) {
          w = 0.3*( abs(maxx-minx) + abs(maxy -miny))/2;
        }
      }  
      //noFill();
      //strokeWeight(1);
      noStroke();
      fill(color(200, 200, 200, 50));
      fill(200);
      //println(maxx, minx);
      ellipse((c1.i + c3.i + width)/2.0, height - (c1.r + c3.r)/2.0, w, w); 


      stroke(0);
      strokeWeight(1.0);
      //line(c1.i + width/2, height -c1.r, c4.i + width/2, height-c4.r );
      line(c2.i + width/2, height -c2.r, c3.i + width/2, height-c3.r );
    }
  }

  if (gifdone) {
    return;
  }
  //gifExport.addFrame();   
  String fname = "frames/f" + nf(framecount, 3) + ".png";
  saveFrame(fname);

  framecount += 1;
  //if (framecount > 100) {
  //  gifDone = true;
  //  println("gif done!");
  //}
}


  float nMouseX() {
    return ((0.5/(float)width)*(float)(mouseX - width/2));
  }
  float nMouseY() {
    return ((0.5/(float)height)*(float)(mouseY - height/2));
  }