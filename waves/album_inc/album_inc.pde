
int nlines = 20;
int npts = 0;
int nx = 20;
int ny = 20;
Square[] sq;
int sep = 20;
int ns = 0; // number of squares
float ph0 =0;
float ph1 = 1;
// use imagemagick to make gifs:  $convert  -delay 7 -loop 0 f*.png ani.gif
boolean framesdone = false;

void setup() {
  size((nx + 2)*sep, (ny + 2)*sep, P3D);
  smooth();
  sq = new Square[nx*ny];
  for (int i = 0; i < nx; i++) {
    for (int j = 0; j < ny; j++) {
      sq[ns++] = new Square(i * sep + 1.5*sep, j* sep +1.5*sep, sep);
    }
  }
}

void draw() {  
  background(10);
  fill(255);
  ph0 += (2*PI)/180;
  if (ph0 > 2*PI) {
    framesdone = true;
    ph0 -= 2*PI;
  }
  noStroke();
  for (int i = 0; i < ns; i++) {
    sq[i].drawMe(ph0);
  }

  if (framesdone) {
  println("done");
    return;
  }
  String fname = "frames/f" + nf(frameCount, 3) + ".png";
  saveFrame(fname);
}

