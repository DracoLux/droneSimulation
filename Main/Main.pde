import java.util.List;
import network.client.Client;
import java.util.Random;

void setup() {
  size(1000, 800, P3D);

  drones = new ArrayList();

  // Initialize mover drone.
  for (int i = 0; i < droneNumber; i++) {
    drones.add(new Drone(i));
    drones.get(i).location = new Coordinate(-500 + random.nextFloat() * 1000, 0, -i * droneRadius * 3 + 500);
    drones.get(i).destination = drones.get(i).location;
    drones.get(i).speed = calc.calculateSpeed(drones.get(i).location, drones.get(i).destination);
  }
  
  try {
    Thread.sleep(1000);
  } catch (InterruptedException e) {
    e.printStackTrace();
  }
}


// ---------- Simulation drone program variables ------------
static final float droneRadius = 28; // Each sphere radius in the processing environment.
static final float droneBuffer = droneRadius * 3; // Each sphere radius in the processing environment.
static final int collisionBufferTime = 300; // The buffer time for escaping before returning to standard procedure.
final int droneNumber = 32; // How many drones to connect.
static final int speed = 4; // The flying speed of the drones.
Calculator calc = new Calculator(); // Calculator for some mathematical functions.
public List<Drone> drones; // All drones collected.
Random random = new Random();
// ----------------------------------------------------------


// ---------- Simulation Environment Variables ---------
int bouffer = 0; // Camera variables
int bouffer2 = 0; // Camera variables
int lineSize = 10000; // The length of the lines from 0,0,0 stretching along the axises.
boolean init = false; // First time run setup.
int moveX = 0; // Environment setup.
int moveY = 0; // Environment setup.
// ---------------------------------------------------------

Drone getDroneByClient(Client client) {
  for (Drone d : drones) {
    if (d.client == client) {
      return d;
    }
  }
  return null;
}

void draw() {
  if (init) {
    background(0);
    translate(moveX, moveY);

    // X RED
    stroke(192, 0, 0);
    line(0, 0, 0, lineSize, 0, 0);
    // Y GREEN
    stroke(0, 192, 0);
    line(0, 0, 0, 0, lineSize, 0);
    // Z BLUE
    stroke(0, 0, 192);
    line(0, 0, 0, 0, 0, lineSize);

    lights();
    noStroke();

    // Don't touch anything outside of this part of the code.
    // ---------
    Drone mover;
    Boolean collision;
    for (int i = 0; i < drones.size(); i++) {

      mover = drones.get(i);

      // Check collision with all other drones. Is this stupid?
      collision = false;
      for (int j = 0; j < drones.size(); j++) {
        if (drones.get(j) != mover && calc.checkDroneCollision(mover, drones.get(j))) {
          collision = true;
          mover.hasCollided = true;
          mover.lightColor = Color.RED;
          mover.destination = calc.getEscapeCoordinate(mover.location, drones.get(j).location);
          mover.collisionBuffer = collisionBufferTime;
        } else {
          mover.collisionBuffer--;
        }
      }

      drawDrone(mover);

      if (!collision && mover.collisionBuffer < 1) {
        mover.destination = mover.tempDestination;
        mover.lightColor = mover.tempColor;
      }

      
      // Makes sure the drone doesn't jitter at its destination.
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
  stroke(drone.lightColor.getRed(), drone.lightColor.getGreen(), drone.lightColor.getBlue(), ((float) drone.lightVolume/100)*255);
  sphere(droneRadius);
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
