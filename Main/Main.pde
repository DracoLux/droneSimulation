import java.util.List;
import network.client.Client;

void setup(){
  size(1000,800,P3D);
  
  drones = new ArrayList();
  
  // Initialize mover drone.
  for (int i = 0; i < droneNumber; i++) {
    drones.add(new Drone(i));
    drones.get(i).location = new Coordinate(0,0,0);
    drones.get(i).destination = drones.get(i).location;  
    drones.get(i).speed = calc.calculateSpeed(drones.get(i).location, drones.get(i).destination);
  }
  
}

final int droneNumber = 10;
int bouffer = 0;
int bouffer2 = 0;
Calculator calc = new Calculator();
public List<Drone> drones;
int size = 10000;
boolean init = false;
int moveX = 0;
int moveY = 0;
List<Coordinate> coordinates;

void readInput(){
  coordinates = new ArrayList();
  // Read coordinates from input
}

Drone getDroneByClient(Client client){
  for (Drone d : drones){
    if (d.client == client) {
      return d;
    }
  }
  return null;
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
    for (int i = 0; i < drones.size(); i++) {
      mover = drones.get(i);
      drawDrone(mover);
      
      if (calc.distanceBetweenCoordinates(mover.location, mover.destination) < 4) {
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

void drawDrone(Drone drone) {
  pushMatrix();
  translate(drone.location.x, drone.location.y, drone.location.z);
  stroke(drone.lightColor.getRed(),drone.lightColor.getGreen(),drone.lightColor.getBlue(),((float) drone.lightVolume/100)*255);
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
