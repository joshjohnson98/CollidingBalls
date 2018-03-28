// Citation: "twoBallBouncing" by Rong Zhang is modified in this code
// The code now accounts for a 3rd ball bouncing around and the background 
// changes every time there is a collision.

float locx1, locy1, locx2, locy2, locx3, locy3;
float sx1, sy1, sx2, sy2, sx3, sy3;
int diameter = 60;
int radius = diameter / 2;
color color1, color2, color3, backgroundC;
float nlocx1, nlocy1, nlocx2, nlocy2, nlocx3, nlocy3;
float nsx1, nsy1, nsx2, nsy2, nsx3, nsy3;

void setup()
{
  // set scene
  size (400, 400);
  noStroke();
  frameRate(30);
  smooth();
  
  // initialize ball location and speed
  locx1 =  diameter + 10;
  locy1 = diameter + 10;

  locx2 =  width - diameter - 10;
  locy2 = height - diameter - 10;
  
  locx3 = diameter + 100;
  locy3 = diameter + 100;
  
  // randomly initialize ball speed
  sx1 = random(10);
  sy1 = random(5);
  
  sx2 = -random(10);
  sy2 = -random(5);
  
  sx3 = random(6);
  sy3 = random(8);
  
  // set ball colors
  color1 = color(10, 200, 50);
  color2 = color(255, 0, 150);
  color3 = color(255);
  
  // set initial background color
  backgroundC = color(0);
}

void draw()
{
  // collision using posteriori method
  
  // update with new background color
  background(backgroundC);
  
  // calculate new location of the balls
  nlocx1 = locx1 + sx1;
  nlocy1 = locy1 + sy1;
  nlocx2 = locx2 + sx2;
  nlocy2 = locy2 + sy2;
  nlocx3 = locx3 + sx3;
  nlocy3 = locy3 + sy3;  
  nsx1 = sx1;
  nsy1 = sy1;
  nsx2 = sx2;
  nsy2 = sy2;
  nsx3 = sx3;
  nsy3 = sy3;

  // simplified version 
  // check collision with walls
  collisionWithWall();
  // check collision between the two balls  
  collisionBetweenBalls();
  
  // updating ball positions
  locx1 = nlocx1;
  locy1 = nlocy1;
  locx2 = nlocx2;
  locy2 = nlocy2;
  locx3 = nlocx3;
  locy3 = nlocy3;
 
  // updating ball speed
  sx1 = nsx1;
  sy1 = nsy1;
  sx2 = nsx2;
  sy2 = nsy2;
  sx3 = nsx3;
  sy3 = nsy3;
 
  // draw the balls
  fill(color1);
  ellipse(locx1, locy1, diameter, diameter);
  fill(color2);
  ellipse(locx2, locy2, diameter, diameter);
  fill(color3);
  ellipse(locx3, locy3, diameter, diameter);
}

void collisionWithWall(){
  // check whether the ball hit the wall
  
  // left wall
  if (nlocx1 < radius) {
    // if so update the new location and speed
    // first calculate the time when the ball hit the wall
    float t = (radius - locx1) / sx1;
    // now update new speed and new location
    nsx1 = - sx1;
    nlocx1 = radius + nsx1 * (1 - t);
  }
  if (nlocx2 < radius) {
    float t = (radius - locx2) / sx2;
    nsx2 = - sx2;
    nlocx2 = radius + nsx2 * (1 - t);
  }
  if (nlocx3 < radius) {
    float t = (radius - locx3) / sx3;
    nsx3 = - sx3;
    nlocx3 = radius + nsx3 * (1 - t);
  }

  // top wall
  if (nlocy1 < radius) {
    // if so update the new location and speed
    // first calculate the time when the ball hit the wall
    float t = (radius - locy1) / sy1;
    // now update new speed and new location
    nsy1 = - sy1;
    nlocy1 = radius + nsy1 * (1 - t);
  }
  if (nlocy2 < radius) {
    float t = (radius - locy2) / sy2;
    nsy2 = - sy2;
    nlocy2 = radius + nsy2 * (1 - t);
  }
  if (nlocy3 < radius) {
    float t = (radius - locy3) / sy3;
    nsy3 = - sy3;
    nlocy3 = radius + nsy3 * (1 - t);
  }
  
  // right wall
  if (nlocx1 > width - radius) {
    // if so update the new location and speed
    // first calculate the time when the ball hit the wall
    float t = (width - radius - locx1) / sx1;
    // now update new speed and new location
    nsx1 = - sx1;
    nlocx1 = width - radius + nsx1 * (1 - t);
  }
  if (nlocx2 > width - radius) {
    float t = (width - radius - locx2) / sx2;
    nsx2 = - sx2;
    nlocx2 = width - radius + nsx2 * (1 - t);
  }
  if (nlocx3 > width - radius) {
    float t = (width - radius - locx3) / sx3;
    nsx3 = - sx3;
    nlocx3 = width - radius + nsx3 * (1 - t);
  }

  // bottom wall
  if (nlocy1 > height - radius) {
    // if so update the new location and speed
    // first calculate the time when the ball hit the wall
    float t = (height - radius - locy1) / sy1;
    // now update new speed and new location
    nsy1 = - sy1;
    nlocy1 = height - radius + nsy1 * (1 - t);
  }
  if (nlocy2 > height - radius) {
    float t = (height - radius - locy2) / sy2;
    nsy2 = - sy2;
    nlocy2 = height - radius + nsy2 * (1 - t);
  }
  if (nlocy3 > height - radius) {
    float t = (height - radius - locy3) / sy3;
    nsy3 = - sy3;
    nlocy3 = height - radius + nsy3 * (1 - t);
  }
}


void collisionBetweenBalls(){
  // calculate distance between the new location of balls (1&2)
  float distance12 = sqrt(sq(nlocx1 - nlocx2)+sq(nlocy1 - nlocy2));
  
  // calculate distance between the new location of balls (2&3)
  float distance23 = sqrt(sq(nlocx2 - nlocx3)+sq(nlocy2 - nlocy3));
  
  // calculate distance between the new location of balls (3&1)
  float distance31 = sqrt(sq(nlocx3 - nlocx1)+sq(nlocy3 - nlocy1));
  
  //************************************************************************
  if ( distance12 <= diameter ) {
    // collision between 1 and 2
    backgroundC = color(random(0,255),random(0,255),random(0,255)); //new background color

    // calculate coefficients
    float A = sq((sx1 - sx2)) + sq((sy1 - sy2));
    float B = 2 * ((sx1-sx2) * (locx1-locx2) + (sy1 - sy2) * (locy1-locy2));
    float C = sq(locx1 - locx2) + sq(locy1 - locy2) - sq(diameter);
      
    float t = calculateT(A,B,C); //new function to limit copy/pasting
    
    println("t12: " + t);
    
    nlocx1 = locx1 + t * sx1;
    nlocy1 = locy1 + t * sy1;
    nlocx2 = locx2 + t * sx2;
    nlocy2 = locy2 + t * sy2;

    // calculate the normal to the collision plane
    float nx = (nlocx1 - nlocx2) / diameter;
    float ny = (nlocy1 - nlocy2) / diameter;
  
    // for ball 1
    // calculate the normal component
    float ncx1 = (sx1 * nx + sy1 * ny) * nx;
    float ncy1 = (sx1 * nx + sy1 * ny) * ny;
    // calculate the tangental component
    float tcx1 = sx1 - ncx1;
    float tcy1 = sy1 - ncy1;
  
     // for ball 2
    // calculate the normal component
    float ncx2 = (sx2 * nx + sy2 * ny) * nx;
    float ncy2 = (sx2 * nx + sy2 * ny) * ny;
    // calculate the tangental component
    float tcx2 = sx2 - ncx2;
    float tcy2 = sy2 - ncy2;

    // suppose m1 = m2, the new velocities of balls
    nsx1 = ncx2 + tcx1;
    nsy1 = ncy2 + tcy1;
    nsx2 = ncx1 + tcx2;
    nsy2 = ncy1 + tcy2;
    
    // calculate new location of balls
    nlocx1 = nlocx1 + (1 - t) * nsx1;
    nlocy1 = nlocy1 + (1 - t) * nsy1;
    nlocx2 = nlocx2 + (1 - t) * nsx2;
    nlocy2 = nlocy2 + (1 - t) * nsy2;
    
    // now double check if the new location is hitting the wall
    collisionWithWall();
  }
  //************************************************************************
    
  if ( distance23 <= diameter ) {
    // collision between 2 and 3
    backgroundC = color(random(0,255),random(0,255),random(0,255)); //new background color
    
    // calcluate coefficients
    float A = sq((sx2 - sx3)) + sq((sy2 - sy3));
    float B = 2 * ((sx2-sx3) * (locx2-locx3) + (sy2 - sy3) * (locy2-locy3));
    float C = sq(locx2 - locx3) + sq(locy2 - locy3) - sq(diameter);
      
    float t = calculateT(A,B,C); //new function to limit copy/pasting
    println("t23: " + t);

    nlocx3 = locx3 + t * sx3; //<>//
    nlocy3 = locy3 + t * sy3; //<>//
    nlocx2 = locx2 + t * sx2;
    nlocy2 = locy2 + t * sy2;

    // calculate the normal to the collision plane
    float nx = (nlocx2 - nlocx3) / diameter;
    float ny = (nlocy2 - nlocy3) / diameter;
  
    // for ball 3
    // calculate the normal component
    float ncx3 = (sx3 * nx + sy3 * ny) * nx;
    float ncy3 = (sx3 * nx + sy3 * ny) * ny;
    // calculate the tangental component
    float tcx3 = sx3 - ncx3;
    float tcy3 = sy3 - ncy3;
  
     // for ball 2
    // calculate the normal component
    float ncx2 = (sx2 * nx + sy2 * ny) * nx;
    float ncy2 = (sx2 * nx + sy2 * ny) * ny;
    // calculate the tangental component
    float tcx2 = sx2 - ncx2;
    float tcy2 = sy2 - ncy2;

    // suppose m2 = m3, the new velocities of balls
    nsx3 = ncx2 + tcx3;
    nsy3 = ncy2 + tcy3;
    nsx2 = ncx3 + tcx2;
    nsy2 = ncy3 + tcy2;
    
    // calculate new location of balls
    nlocx3 = nlocx3 + (1 - t) * nsx3;
    nlocy3 = nlocy3 + (1 - t) * nsy3;
    nlocx2 = nlocx2 + (1 - t) * nsx2;
    nlocy2 = nlocy2 + (1 - t) * nsy2;
    
    // now double check if the new location is hitting the wall
    collisionWithWall();
  }
//************************************************************************
    
  if ( distance31 <= diameter ) {
    // collision between 3 and 1
    backgroundC = color(random(0,255),random(0,255),random(0,255)); //new background color
    
    // calcluate coefficients
    float A = sq((sx3 - sx1)) + sq((sy3 - sy1));
    float B = 2 * ((sx3-sx1) * (locx3-locx1) + (sy3 - sy1) * (locy3-locy1));
    float C = sq(locx3 - locx1) + sq(locy3 - locy1) - sq(diameter);
      
    float t = calculateT(A,B,C); //new function to limit copy/pasting
    println("t31: " + t);

    nlocx3 = locx3 + t * sx3;
    nlocy3 = locy3 + t * sy3;
    nlocx1 = locx1 + t * sx1;
    nlocy1 = locy1 + t * sy1;

    // calculate the normal to the collision plane
    float nx = (nlocx3 - nlocx1) / diameter;
    float ny = (nlocy3 - nlocy1) / diameter;
  
    // for ball 3
    // calculate the normal component
    float ncx3 = (sx3 * nx + sy3 * ny) * nx;
    float ncy3 = (sx3 * nx + sy3 * ny) * ny;
    // calculate the tangental component
    float tcx3 = sx3 - ncx3;
    float tcy3 = sy3 - ncy3;
  
     // for ball 1
    // calculate the normal component
    float ncx1 = (sx1 * nx + sy1 * ny) * nx;
    float ncy1 = (sx1 * nx + sy1 * ny) * ny;
    // calculate the tangental component
    float tcx1 = sx1 - ncx1;
    float tcy1 = sy1 - ncy1;

    // suppose m1 = m3, the new velocities of balls
    nsx3 = ncx1 + tcx3;
    nsy3 = ncy1 + tcy3;
    nsx1 = ncx3 + tcx1;
    nsy1 = ncy3 + tcy1;
    
    // calculate new location of balls
    nlocx3 = nlocx3 + (1 - t) * nsx3;
    nlocy3 = nlocy3 + (1 - t) * nsy3;
    nlocx1 = nlocx1 + (1 - t) * nsx1;
    nlocy1 = nlocy1 + (1 - t) * nsy1;
    
    // now double check if the new location is hitting the wall
    collisionWithWall();
  }
}


//New function to limit copying and pasting //<>//
float calculateT(float A, float B, float C){ //<>//
      float t1, t2, t = 0;
      if (abs(A) >= 0.0001 && sq(B) >= 4 * A * C ) {
      // A is not zero //<>//
      t1 = (-B + sqrt( sq(B) - 4 * A * C )) / (2*A);
      t2 = (-B - sqrt( sq(B) - 4 * A * C )) / (2*A);
      
      // pick the right t
      if ( (t1>=0) && (t1<=1) ) {
        if ( (t2 >= 0) && (t2<=1) )
          t = min(t1, t2);
        else
          t = t1;
        }
      else
        t = t2;
      }
    else {
      // A is nearly 0
      if (abs(B) >= 0.0001)
        t = - C / B;
      else
        t = 0;
    }
    return t;
}
