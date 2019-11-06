import network.client.Client;
import java.awt.Color;

class Drone {
  public Coordinate location;
  public Coordinate destination;
  public Coordinate speed; // Misuse of Coordinate class for a "speed" - an X, Y and Z directional speed.
  public int droneId;
  public Calculator calc = new Calculator();
  public Client client;
  public Color lightColor;
  public int lightVolume;
  
  
  // These variables are for collision.
  public Color tempColor;
  public Coordinate tempDestination;
  public int collisionBuffer;
  public boolean hasCollided = false;
  
  public Drone(int droneId){
    this.droneId = droneId;
    this.lightColor = Color.WHITE;
    this.lightVolume = 100;
    this.client = new Client("127.0.0.1", 5000, new ClientAdapter());
    this.collisionBuffer = Main.collisionBufferTime;
    client.start();
  }
  
  public void goToDestination(Coordinate destination) {
    this.destination = destination;
    this.tempDestination = destination;
    hasCollided = false;
    speed = calc.calculateSpeed(location, destination);
  }
  
  @Override
  public String toString(){
    return droneId + " " + location;
  }
  
}
