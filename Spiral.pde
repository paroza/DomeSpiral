  class Spiral {

  int sizeSpiral; 
  float angle; // angle of the spiral lines
  float anglespeed; // the speed at which the angle should change
  float pivot; // controls the circular rotation of the spiral
  float pivotspeed;  // controls how fast the spiral should rotate
  
  PVector location = new PVector (0,0);
 PVector velocity = new PVector (0,0);  
  
  //int spiralX;  
  //int spiralY; 
  int len; 
  float vol; 
  int life; 
  boolean dead; 
  int alpha = 255;
  color myColor; 

  Spiral (PVector mylocation, color myColor)  {
   // println("I'm in the constructor!"); 
   
   this.location = mylocation; 
   this.velocity = new PVector(0,0); 
   //this.location.x = location.x;
   //this.location.y = location.y;
   // this.spiralX = posx; 
    //this.spiralY = posy; 
    this.sizeSpiral = 1; 
    this.angle = 0.01; 
    this.anglespeed = 0.01; 
    this.pivot = 0; 
    this.pivotspeed =0.05;
    this.myColor = myColor;  
  }


  // draw a new spiral
  void drawSpiral() { 

    pivot += pivotspeed;
    angle = angle + anglespeed;

    // if we  hit a  high angle, bounce and start going down
    if (angle > 2.0)
    {
      angle = 2.0;
      anglespeed = -1 * anglespeed;
    }

    // if we hit a low angle, bounce and start going up
    if (angle < -2.0)
    {
      angle = -2.0;
      anglespeed = -1 * anglespeed;
    }

    // define the initial starting point of the spiral
    //this is where we would define where the spiral starts 
    int xpos = width/2; 
    int ypos = height/2;

    // define how long the spiral lines should start at
    int len = 10; 

    // remember the orientation of the sketch
    pushMatrix();

    // move to our center point
    translate(location.x, location.y);

    // rotate based on the pivot
    // rotate(radians(pivot));

    // make our center point 0, 0 (of the line) 
    xpos = 0;
    ypos = 0;

    // loop to create the spiral
    // we will loop once for each line in the spiral
    for (int i = 0; i < this.sizeSpiral; i++)
    {
      // move to the last ending point that we drew at
      translate (xpos, ypos); 

      // rotate 90 degrees plus our angle (which is always changing)
      rotate(radians(90+angle)); 

      // draw this line - use our transparency value
      stroke(myColor, this.alpha);
      strokeWeight(3); 
      line(0, 0, len, 0); 

      // make our new ending point where we just left off drawing
      xpos= len; 
      ypos= 0;

      // increase our length value - making this bigger will make the
      // spiral appear more less "crowded"
      len += 5;
    }

    // restore the coordinate system of the sketch
    popMatrix();
  }
}

