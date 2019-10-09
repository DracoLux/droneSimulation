import java.util.List;
  
    
void setup(){
  size(1000,800,P3D);
  
  drones = new ArrayList();
  
  // Initialize mover drone.
  for (int i = 0; i < droneNumber; i++) {
    drones.add(new Drone());
    drones.get(i).location = new Coordinate(150 - i * 40, 120 + i * 20, 50 + i * 10);
    drones.get(i).destination = new Coordinate(800 - i * 100, i * 100, 120 - 10 * i);  
    drones.get(i).speed = calc.calculateSpeed(drones.get(i).location, drones.get(i).destination);
  }
  
}

final int droneNumber = 3;
int bouffer = 0;
int bouffer2 = 0;
Calculator calc = new Calculator();
List<Drone> drones;
int size = 10000;
boolean init = false;
int moveX = 0;
int moveY = 0;
List<Coordinate> coordinates;

void readInput(){
  coordinates = new ArrayList();
  // Read coordinates from input
}

void draw(){
  if (init){
    background(0);
    translate(moveX, moveY);
    
    // X RED
    stroke(192,0,0);
    line(0,0,0,size,0,0);
    // Y GREEN
    stroke(0,192,0);
    line(0,0,0,0,size,0);
    // Z BLUE
    stroke(0,0,192);
    line(0,0,0,0,0,size);
    
    lights();
    noStroke();
    
    // Don't touch anything outside of this part of the code.
    // ---------
    Drone mover;
    for (int i = 0; i < droneNumber; i++) {
      mover = drones.get(i);
      setDrone(mover.location.x, mover.location.y, mover.location.z);
      if (calc.distanceBetweenCoordinates(mover.location, mover.destination) < 10) {
         mover.speed = new Coordinate(0, 0, 0);      
      }
      mover.location.x += mover.speed.x;
      mover.location.y += mover.speed.y;
      mover.location.z += mover.speed.z;
      mover.speed = calc.calculateSpeed(mover.location, mover.destination);
    }
    
    
    // ---------
    // Don't touch anything below this!

    float rotation = (mouseX-(width/2))/2;
    float orbitRadius= 300;//mouseX/2;
    
    float xpos= 1000 + /*cos(radians(rotation))*orbitRadius + */ bouffer;
    float ypos= 1000; //mouseY-(height/2);
    float zpos= 1000 + /* sin(radians(rotation))*orbitRadius + */ bouffer2;
    
    camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);    
  }
  init = true;
}

void setDrone(float x, float y, float z) {
  pushMatrix();
  translate(x, y, z);
  sphere(28);
  popMatrix();
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    bouffer += 50;
  }
  if (key == 's' || key == 'S') {
    bouffer -= 50;
  }
  if (key == 'a' || key == 'A') {
    bouffer2 -= 50;
  }
  if (key == 'd' || key == 'D') {
    bouffer2 += 50;
  }
}
