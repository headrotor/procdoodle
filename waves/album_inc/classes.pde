class Square {
  float s2;
  float xc, yc;  // centers  
  boolean dosmooth = true;
  Square (float x, float y, float size) {
    s2 = (size -3)/2;
    xc = x;
    yc = y;
  }
  void update() {
  }
  void drawMe(float ph) {
    int i;
    pushMatrix();
    translate(xc, yc);
    rotateY(ph);
    rotateX(ph/2);
    beginShape();
    vertex(-s2, -s2);
    vertex( s2, -s2);
    vertex( s2, s2);
    vertex(-s2, s2);
    vertex(-s2, -s2);
    endShape();
    popMatrix();
  }
}
