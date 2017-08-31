class SpiderGraph {
  
  int centerX;
  int centerY;
  int angle;
  int radius;
  int numCircles; //days
  int numLines; //time
  int difference;
  int lineL;
  float size1;
  float size2;
  int rot;
  
  SpiderGraph() {
    centerX = width/2 - 200;
    centerY = height/2;
    radius = 50;
    difference = 100;
    angle = 30;
    numCircles = 7;
    numLines = 12;
    lineL = 375;
    size1 = -2*(PI);
    size2 = 0;
    rot = 270;
  }
    
  void drawMe() {
    stroke(100);
    strokeWeight(1);
    noFill();
  for (int i = 0; i <= numCircles; i++) { //days
    arc(centerX, centerY, radius+(difference*i), radius+(difference*i), size1, size2);
  }
  for (int i = 0; i < numLines; i++) { //hours
    stroke(50);
    float newX = (float) (Math.cos((rot+angle*i)/57.2958)*lineL);
    float newY = (float) (Math.sin((rot+angle*i)/57.2958)*lineL);
    line(centerX, centerY, (centerX + newX), (centerY + newY));
  }
}
  void setSize(float si1, float si2) {
    size1 = si1;
    size2 = si2;
  }
  void setRotation(int r) {
    rot = r;
  }
  void setX(int x) {
    centerX = x;
  }
  int getX() {
    return centerX;
  }
    int getY() {
    return centerY;
  }
    int getRad() {
    return radius;
  }
    int getDiff() {
    return difference;
  }
  void setY(int y) {
    centerY = y;
  }
  void setR(int r) {
    radius = r;
  }
  void setDiff(int d) {
    difference = d;
  }
  void setLL(int l) {
    lineL = l;
  }
  void setNumL(int a) {
    numLines = a;
  }
}