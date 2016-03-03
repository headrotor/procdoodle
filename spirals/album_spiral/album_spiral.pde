// Simple fibonacci spiral
//https://en.wikipedia.org/wiki/Fibonacci_number#In_nature

float g = PI*(3-sqrt(5)); // spiral constant
int npts = 1000; 
float ph = 0; 

void setup() {
  size(500, 500);
  background(0);
  fill(255);
}

void draw() {
  background(color(10, 148, 194));
  noStroke();
  float scale = 12.0;
  float bcs = 10; //big circle size
  float scs = 5; //small circle size
  float rorb = 6;  // radius of small circle orbit as fraction of r
  float r, th;   // radius and angle
  ph += (2*PI)/240;
  if (ph > 2*PI) {
    ph -= 2*PI;
  }

  for (int n=0; n< 1000; n++) {
    // calculate polar coordinates of next point in spiral
    th= g*n;
    r = scale*sqrt(n);
    r = 0.00002*scale*n*n;
    r = 0.008*pow(n, 1.5);
    r = 0.025*pow(n, 1.3);
    r = 0.1*pow(n, 1.1);
    r = 0.22*n;

    // plot cartesian spiral points
    float x = r*sin(th) + width/2;
    float y =  r*cos(th) + height/2;
    // plot big circle
    // offset coordinates for small orbiting circle
    float xo = x + rorb*sin(ph +th);
    float yo = y + rorb*cos(ph +th);

    fill(color(200, 0, 0));

    ellipse(x, y, bcs, bcs);
    fill(color(155, 0, 0)); 
    ellipse(xo, yo, scs, scs);
  }
  //saveFrame("spiral.gif");
}

