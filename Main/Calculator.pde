class Calculator {
  // Calculates distance between two coordinates using standard mathematical function.
    float distanceBetweenCoordinates(Coordinate start, Coordinate end) {
    float distance;
    distance = (float) Math.sqrt(Math.pow((end.x - start.x), 2) + Math.pow((end.y - start.y), 2) + Math.pow((end.y - start.y), 2));
    return distance;
  }
  
  // Calculate the speed from a start coordinate to an end coordinate. Hack solution returns a coordinate.
    Coordinate calculateSpeed(Coordinate start, Coordinate end) {
    Coordinate speed = new Coordinate(0, 0, 0);
    float distance = distanceBetweenCoordinates(start, end);
    speed.x = (end.x - start.x)/(distance/Main.speed);
    speed.y = (end.y - start.y)/(distance/Main.speed);
    speed.z = (end.z - start.z)/(distance/Main.speed);
    return speed;
  }
  
  // Gets a coordinate away from the threat for the escapee to use.
  Coordinate getEscapeCoordinate(Coordinate escapee, Coordinate threat) {
    Coordinate vector = new Coordinate(threat.x - escapee.x, threat.y - escapee.y, threat.z - escapee.z);
    vector = normalizeVector(vector);
    Coordinate escapeCoordinate = new Coordinate(escapee.x - (Main.droneBuffer * vector.x), escapee.y - (Main.droneBuffer * vector.y), escapee.z - (Main.droneBuffer * vector.z));
    return escapeCoordinate;
  }
  
  Coordinate normalizeVector(Coordinate vector) {
    float length = (float) Math.sqrt(Math.pow(vector.x, 2) + Math.pow(vector.y, 2) + Math.pow(vector.z, 2));
    Coordinate normVector = new Coordinate(vector.x/length, vector.y/length, vector.z/length);
    return normVector;
  }
  
  // Returns whether two drones are colliding.
  Boolean checkDroneCollision(Drone drone1, Drone drone2) {
  if ((
    (drone1.location.x - drone2.location.x)*(drone1.location.x - drone2.location.x)
    + (drone1.location.y - drone2.location.y)*(drone1.location.y - drone2.location.y)
    + (drone1.location.z - drone2.location.z)*(drone1.location.z - drone2.location.z)
    ) < (
    (droneRadius + droneRadius)*(droneRadius + droneRadius))) {
      return true;
  } else {
    return false;
  }
}
  
}
