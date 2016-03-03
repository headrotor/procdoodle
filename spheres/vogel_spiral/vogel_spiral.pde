// Simple fibonacci spiral
//https://en.wikipedia.org/wiki/Fibonacci_number#In_nature
float scale = 7.0;
float g = PI*(3-sqrt(5)); // spiral constant
void setup() {
  size(500,500);
  background(0);
  fill(255);
  float r, th; // radius and angle
  for (int n=0; n< 1000; n++) {
    // calculate polar coordinates of next point in spiral
    th= g*n;
    r = scale*sqrt(n);
    // plot cartesian spiral points
    ellipse(r*sin(th) + width/2, r*cos(th) + height/2, 7, 7);
  }
  saveFrame("spiral.gif");
}

//void draw() {
//}