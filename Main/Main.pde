import java.util.List;

void setup(){
  size(1000,800,P3D);
}

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
    
    stroke(200,200,200);
    noFill();
    translate(100,100,100);
    box(25);
    
    float rotation = (mouseX-(width/2))/2;
    float orbitRadius= 300;//mouseX/2;
    
    float xpos= cos(radians(rotation))*orbitRadius;
    float ypos= mouseY-(height/2);
    float zpos= sin(radians(rotation))*orbitRadius;
    
    camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);    
  }
  init = true;
}

/*
void mouseMoved(){
  moveX = mouseX;
  moveY = mouseY;
}
*/
