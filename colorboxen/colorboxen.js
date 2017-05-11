/*
 * @name Geometries
 * @description There are six 3D primitives in p5 now.
 */
 var slider;
 
function setup() {
  createCanvas(710, 400, WEBGL);
  ambientLight(250, 250, 250);
  slider = createSlider(0, 255, 127);
  slider.position(20, 20);
}

function draw() {
  background(250);
  orbitControl();
  translate(-250, 0, -500);

  n = 10;
  bsize = 30;
  bspace = 40;
  for ( i = 0; i < n; i++) {
    for (  j = 0; j < n; j++) {
      for (  k = 0; k < n; k++) {
        push();
        ambientMaterial(i*255/n, j*255/n, k*255/n);
        //ambientMaterial(100, 100, 100);
        translate(i*bspace, j*bspace, k*bspace);
        box(bsize, bsize, bsize);
        pop();
      }
    }
  }
}