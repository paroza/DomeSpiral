import ddf.minim.*;

ArrayList<Spiral> mySpirals; 

Minim minim;
AudioInput in;

int sizeSpiral; 
int size = 20; //random between 100 and 200
boolean dead; 

// CONTROL VARS
int CHANCE = 20;
int VOLUME = 10; // bump up to 50 when it's not a quiet hallway
int DEATHTHRESH = 100;

Mover a; 
Mover b; 
Mover c; 

boolean showVectors = true; 

// setup runs once
void setup () {

  //background(0); 
  size (800, 800,P2D); 
  smooth(); 
  dead = false; 
  sizeSpiral = 0;
  mySpirals = new ArrayList<Spiral>();
  minim = new Minim(this);
  
  a = new Mover(new PVector(random(5), random(-5,5)), new PVector(10,10)); 
  b= new Mover (new PVector(-2,1), new PVector(150,150)); 
  c= new Mover (new PVector(-2,1), new PVector(150,150)); 

  // get a connection to the microphone
  in = minim.getLineIn(Minim.MONO, 512);
  println("The microphone has been connected"); 

}

// draw - infinite loop
void draw () {
  background(0);
  
    //a.go(); 
    //b.go(); 
    //c.go(); 
    
   // b.go(); 
      
    //a.collideEqualMass(mySpirals); 
    //b.collideEqualMass(mySpirals);
    //c.collideEqualMass(mySpirals);

  // get volume
  float vol = getVolume();

  // if the volume is lound enough AND we pick a random number > 80% then we can create a new spiral
//  if (random(0,100) > CHANCE && vol > VOLUME)
//    mySpirals.add(new Spiral(int(random(width)), int(random(height))));

  // iterate over all spirals
  for (int i= 0; i<mySpirals.size(); i++) {

    // grab a reference to this Spiral
    Spiral temp = mySpirals.get(i);

    // if this spiral isn't dead then we can have it display itself
    if (temp.dead == false)
    {
    
      // if the volume is high enough then we should tell all this spiral to get a little bigger
      if (vol > VOLUME)
      {
        temp.sizeSpiral++;
      }

      // now have the spiral draw itself at its own size
      mySpirals.get(i).drawSpiral();

      // has this spiral gotten too big?  If so, we should reduce its alpha by 1
      if (temp.sizeSpiral > DEATHTHRESH)
      {
        temp.alpha -= 2;

        // and if we get down to being totally transparent then we should die
        if (temp.alpha < 0)
          temp.dead = true;
      }

    }   
  }


  }


  // get the volume from the microphone
  float getVolume() {
    // assume no volume
    float sum = 0;
    // look at all of our sample inputs from the microphone
    for (int i = 0; i < in.bufferSize() - 1; i++)
    {// add the volume we see here to our sum
      sum += abs(in.left.get(i));
    }

    // send the sum back to the caller
    return sum;
  }


  void stop() {
    // always close Minim audio classes when you are done with them
    in.close();
    minim.stop();

    super.stop();
  }

  void keyPressed () {
    if (key == 'a')
        mySpirals.add(new Spiral(new PVector(width/2,height/2), color(255,20,147)) );
        
        
    if (key == 'l')
        mySpirals.add(new Spiral(new PVector(width/2,height/2), color(160,32,240) )) ; 
        
     if (key == 'g')
        mySpirals.add(new Spiral(new PVector(width/2,height/2), color(0,250,154) )) ; 
        
       
       
//    if (key == 'c') 
//      a.go(); 
//      b.go(); 
//      
//      a.collideEqualMass(b); 


  }

