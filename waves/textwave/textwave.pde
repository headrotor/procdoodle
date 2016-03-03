
import gifAnimation.*;

GifMaker gifExport;

class Lem { 
  char c;
  int i, j; // offset coordinates
  float p = 0;
  Lem(int it, int jt, char ct, float phase) {  
    c = ct;
    i = it;
    j = jt;
    p = phase;
  }
} 

// gsx, gsy is grid size, imax jmax grid extents.
int gsx = 15;
int gsy = 20; 
int imax = 50, jmax = 10;
// array of letter element
Lem[][] lems = new Lem[imax][jmax];
// no need to compute this every time



PFont italic;

String[] lines = {
  "", 
  "Like as the waves make towards the pebbled shore,", 
  "", 
  "So do our minutes hasten to their end;", 
  "", 
  "Each changing place with that which goes before,", 
  "", 
  "In sequent toil all forwards do contend.",
};

float gphase = 0.0;
float amp;

void setup() {
  smooth();


  size(int(gsx*(imax+4)), int(gsy*(jmax+4)));

  frameRate(60);

  println("gifAnimation " + Gif.version());
  gifExport = new GifMaker(this, "export.gif");

  //rotational amplitude
  amp = 0.5*float(gsx);

  char c;
  for (int i = 0; i < imax; i ++) {
    for (int j = 0; j < jmax; j ++) {
      c = ' ';
      if (j < 8) {
        if (i < lines[j].length()) {
          c= lines[j].charAt(i);
        }
      }
      float phase = 2*PI*i/float(imax) + 2*PI*j/float(jmax);
      lems[i][j] = new Lem((i+2)*gsx, (j+2)*gsy + 20, c, phase);
    }
  }


  //drawgrid();

  //italic = loadFont("AngsanaNew-Italic-32.vlw");
  italic = loadFont("Consolas-BoldItalic-32.vlw");
  textFont(italic);
}

void keyPressed() {
  gifExport.finish();
  println("gif saved");
}

void draw() {
  background(255);
  gphase = gphase + 0.1;
  for (int ii = 0; ii < imax; ii ++) {
    for (int jj = 0; jj < jmax; jj ++) {
      drawLem(lems[ii][jj]);
    }
  }
  if (gphase < 2*PI) {

    TImage frame = new TImage(width,height,RGB,sketchPath("frame_"+nf(frameCount,3)+".png"));
    frame.set(0,0,get());
    frame.saveThreaded();
    
    //gifExport.setDelay(1);
    //gifExport.addFrame();
  } else 
    println("Done!");
}

void drawLem(Lem l) {
  float x = l.i + amp*sin(l.p + gphase);
  float y = l.j + amp*cos(l.p + gphase);
  fill(0);
  //text(l.c, x, y);
  //fill(128);
  ellipse(x, y, 3, 3); 
  if ((l.i == 2*gsx) && (l.j == 2*gsy +20)) 
    println(x);
}

void mousePressed() {
}

