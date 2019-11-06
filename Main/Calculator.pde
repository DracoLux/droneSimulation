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
}
