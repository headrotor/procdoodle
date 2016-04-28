int[][] ggrid1;

int xd = 64;
int yd = 48;
int scale = 10;
int flip = 0;
//int rule[] = {1, 1, 1, 1, 1, 1, 1, 0}; 
//int rule[] = {  1, 1, 1, 1, 1, 1, 0, 1}; 
int rule[] = { // rule 39 from http://atlas.wolfram.com/01/07/Rules/39/
  1, 1, 0, 1, 1, 0, 0, 0
}; 
void setup() {

  ggrid1 = new int[xd+2][yd+2];
  size(xd*scale, yd*scale);

  //  for (int i =0; i < xd; i++) {
  //    ggrid1[i][0] = 1;
  //  }
  //  ggrid1[32][0] = 0;
  //  ggrid1[33][0] = 0;


  randomize();
}

void mouseClicked() {
  randomize();
}

void randomize() {
  for (int i =0; i < xd; i++) {
    if (random(1.0) > 0.5) {
      ggrid1[i][0] = 1;
    } else {
      ggrid1[i][0] = 0;
    }
  }
  ca_iterate();
}

void draw() {

  int i = mouseX/scale;
  int j = mouseY/scale;


  ca_iterate() ;
  noStroke();
  for ( i =0; i < xd; i++) {
    for ( j =0; j < yd; j++ ) {
      fill(ggrid1[i][j]*255);
      rect(i*scale, j*scale, scale, scale);
    }
  }
}



void ca_iterate() {
  // from http://atlas.wolfram.com/01/07/Rules/39/
  for (int j =0; j < yd; j++ ) {
    for (int i =0; i < xd; i+=2) {
      int n = i + (j%2);
      if (ggrid1[n][j] == 0) { // 00
        if (ggrid1[n+1][j] ==0) {
          ggrid1[n][j+1] = rule[0];
          ggrid1[n+1][j+1] = rule[1];
        } else { //01
          ggrid1[n][j+1] = rule[2];
          ggrid1[n+1][j+1] = rule[3];
        }
      } else { //1X
        if (ggrid1[n+1][j] ==0) { //10
          ggrid1[n][j+1] = rule[4];
          ggrid1[n+1][j+1] = rule[5];
        } else { //11
          ggrid1[n][j+1] = rule[6];
          ggrid1[n+1][j+1] = rule[7];
        }
      }
    }
  }
}

