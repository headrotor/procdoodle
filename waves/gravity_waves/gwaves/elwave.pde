

class Elwave {
  int npts = 100; // number of points
  float xc, yc;  // centers  
  float ecc; // eccentricity: 0.5 is lines, 0 is circle 
  float ephase; // eccentricity phase
  float ephase_off; // original phase offset
  float ephase_incr; // increment eccentricity phase every draw
  float r;
  Boolean done = false; // signal that we've done a phase
  Elwave (float x, float y, float radius, float off) {
    xc = x;
    yc  = y;
    r = radius;
    ecc = 0.12;
    ephase = off;
    ephase_off = off;
    ephase_incr = 2*PI/100.0;
  }

  void drawme() {
    // draw ellipse with eccentricity
    float rx, ry, w;
    beginShape();
    rx = r * (1 + ecc*cos(ephase));
    ry = r * (1 + ecc*cos(ephase + PI));
    for (int i = 0; i < npts; i++) {
      w = 2*PI*i/(npts -3);
      curveVertex(rx*sin(w) + xc, ry*cos(w) + yc);
    }
    endShape();
    ephase += ephase_incr;
    if (ephase > 4*PI) {
      ephase -= 4*PI;
      done = true; 
    }
    if ((ephase - ephase_off) > (2*PI + ephase_incr)) {
      done = true; 
    }
    //println(ephase);
  }
}

