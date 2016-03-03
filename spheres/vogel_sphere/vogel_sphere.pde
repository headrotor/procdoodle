
float vscale =7.0;
float rstart = 2*PI/18;
float rend = 2*PI/17;
float offset = 0;
int framecount = 0;
boolean makeGif = true;
void setup() {

  size(800, 800, P3D);
  textureMode(NORMAL);
  //lights();
  noStroke();
  //frameRate(12);
  offset = rstart;
}

void draw() {


  if (offset <= rend) {
    offset += 0.00005;
    background(0);
    drawspiralsphere( offset );
    if (!makeGif) {
      return;
    }
    if (framecount %2 == 1) {
      String fname = "frames/f" + nf(framecount,3) + ".png";
      saveFrame(fname);
    }
    framecount += 1;
    println(offset);
  }
  else {
    makeGif = false;
  }
}


void drawspiralsphere(float off) {
  float r=0;
  float th=0;
  float ph=0;
  float g = PI*(3-sqrt(5));
  int npts = 600;


  pushMatrix();
  translate(width / 2, height / 2);
  float rotation = 0;
  float zoom = 1000;
  float x, y, z;
  rotateX(PI/4);
  //rotateY(PI/4);
  //rotateY(map(mouseX, 0, width, 0, 2 * PI) + rotation);
  //rotateX(map(mouseY, 0, height, 0, 2 * PI));
  //scale(width / zoom, width / zoom, width / zoom);
  float sscale = 200;
  for (int n=0; n< npts; n++) {
    //th= (g+off)*n;
    th = off*n;
    r = vscale*sqrt(n);
    ph = PI*n/(2*npts);

    x = r*sin(th)*sin(ph);
    y = r*cos(th)*sin(ph);
    z= vscale*sqrt(npts)*cos(ph);
    float norm = sqrt(x*x + y*y + z*z);
    //translate(r*sin(th)*sin(ph), r*cos(th)*sin(ph), vscale*sqrt(npts)*cos(ph));
    pushMatrix();
    translate(sscale*x/norm, sscale*y/norm, sscale*z/norm);
    //fill(128 + 50*(1+sin((100*off)*5*2*PI*n/npts)));
    sphere(3);
    popMatrix();
    pushMatrix();
    translate(sscale*x/norm, sscale*y/norm, -sscale*z/norm);
    sphere(3);
    popMatrix();
    //x = r*sin(th) + width/2;
    //y = r*cos(th) + height/2;
    //line(x,y,oldx,oldy);
    //oldx = x;
    //oldy =y;
  }
  float lastth = th;
  //  for (int n=(npts-1); n>=0; n--) {
  //    //th= (g+off)*n;
  //    //th =  off*n + PI/11;
  //    th =  off*n + PI/11;
  //    r = vscale*sqrt(npts - n);
  //    ph = PI*n/(2*npts);
  //    pushMatrix();
  //    x = r*sin(th)*sin(ph);
  //    y = r*cos(th)*sin(ph);
  //    z= vscale*sqrt(npts)*cos(ph);
  //    float norm = sqrt(x*x + y*y + z*z);
  //    translate(-sscale*x/norm, -sscale*y/norm, -sscale*z/norm);
  //    //translate(-r*sin(th)*sin(ph), -r*cos(th)*sin(ph), -vscale*sqrt(npts)*cos(ph));
  //    sphere(3);
  //    popMatrix();
  //}
  popMatrix();
}