class Drone {
  public Coordinate location;
  public Coordinate destination;
  public Coordinate speed; // Misuse of Coordinate class for a "speed" - an X, Y and Z directional speed.
  public int droneId;
  public Calculator calc = new Calculator();
  
  public void goToDestination(Coordinate destination) {
    this.destination = destination;
    speed = calc.calculateSpeed(location, destination);
  }
  
}
