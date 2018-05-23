// port of Rudy Rucker's Cellular Automata to Processing. 
// mashup of https://www.fourmilab.ch/cellab/webca/?ruleprog=hodge
// Thanks to @shiffman for  


// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 200;
int rows = 200;
int size = 2;

void setup() {
  size(400, 400);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*size,j*size,size,size,i+j);
    }
  }
}

void draw() {
  background(0);
  int sum8 = 0;
  
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows -1; j++) {
      // Oscillate and display each object

      sum8 = grid[i-1][j-1].temp;
      sum8 += grid[i-1][j].temp;
      sum8 += grid[i-1][j+1].temp;
      sum8 += grid[i][j-1].temp;
      sum8 += grid[i][j+1].temp;
      sum8 += grid[i+1][j-1].temp;
      sum8 += grid[i+1][j].temp;
      sum8 += grid[i+1][j+1].temp;
      
      grid[i][j].newtemp = hodge(grid[i][j].temp, sum8);
      grid[i][j].display();
    }
  }
}

// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height
  float angle; // angle for oscillating brightness
  int temp = int(15*random(1.0));
  int newtemp = 0;


  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, float tempAngle) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    angle = tempAngle;
    temp = 1;
  } 
  
  void display() {
    //stroke(255);
    noStroke();
    // Color calculated using sine wave
    //fill(10*newtemp);
    fill(120*(sin(PI*float(newtemp)/31)));
    rect(x,y,w,h); 
    temp = newtemp;
  }

}

int hodge(int oldstate, int SUM_8) {
  int temp = 0;

  if (oldstate == 0) {
    if (SUM_8 < 5) {
      temp = 0;
    } else {
      if (SUM_8 < 100) {
        temp = 2;
      } else {
        temp = 3;
      }
    }
  } else if ((oldstate > 0) && (oldstate < 31)) {
    temp = ((SUM_8 >> 3) + 5) & 255;
  }
  if (temp > 31) {
    temp = 31;
  }
  if (oldstate == 31) {
    temp = 0;
  }
  return temp;
}