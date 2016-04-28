float[][] ggrid;
int xd = 64;
int yd = 48;
int scale = 10;
void setup() {

  ggrid = new float[xd][yd];
  fill(#FF55EE);
  size(xd*scale, yd*scale);
  for (int i =0; i < xd; i++) {
    for (int j =0; j < yd; j++ ) {
      ggrid[i][j] = (i+j) %2;
    }
  }
}



void draw() {
  for (int i =0; i < xd; i++) {
    for (int j =0; j < yd; j++ ) {
      fill(int(ggrid[i][j])*255);
      rect(i*scale, j*scale, scale, scale);
    }
  }
}


void ca_iterate(){
  for (int i =0; i < xd; i++) {
    for (int j =0; j < yd-1; j++ ) {
      fill(int(ggrid[i][j])*255);
      rect(i*scale, j*scale, scale, scale);
    }
  }
}
