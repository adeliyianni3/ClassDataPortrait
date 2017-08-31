class Circle {
  
  String id;
  float x;
  float y;
  float rad;
  color c;
  PImage pic;
  Date date;
  int day;
  float time;
  String owner;
  color strC;
  
  Circle(PImage p, String i, float radius, int col, Date dat) {
    rad = radius;
    pic = p;
    date = dat;
    id = i;
    c = col;
    strC = col;
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    day = (int) cal.get(Calendar.DAY_OF_WEEK);
    time = (float) cal.get(Calendar.HOUR) + ((float) cal.get(Calendar.MINUTE)/60) + ((float) cal.get(Calendar.SECOND)/3600);
    this.setX((width/2 - 200), 50, 100);
    this.setY((height/2), 50, 100*day);
  }
  int getColor() {
  return c;
  }
  void setOwner(String o) {
    owner = o;
  }
  String getID() {
    return id;
  }
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getRad() {
    return rad;
  }
  void setRad(int a) {
    rad = a;
  }
  Date getDate() {
    return date;
  }
  void drawMe(int curD) {
    if (curD == day) {
      stroke(strC, 255);
    } else if (curD == 8){
      stroke(strC, 255);
    } else {
      stroke(strC, 100);
    }
      strokeWeight(2);
      ellipse(x,y,rad,rad);
  }
  void select() {
    strC = color(255,255,255);
  }
    void unSelect() {
    strC = c;
  }
  boolean overCircle(int xx, int yy) {
    float disX = x - xx;
    float disY = y - yy;
    if ((sqrt(sq(disX) + sq(disY)) < (rad/2))) {
      return true;
    } else {
      return false;
    }
  }
  void setY(float centerY, float rad, int dif) {
      y = ((centerY +( (float) (Math.sin((270+time*360/12)/57.2958)*(rad+(dif*day))/2))));
  }
  void setX(float centerX, float rad, int dif) {
    x = ((centerX +( (float) (Math.cos((270+time*360/12)/57.2958)*(rad+(dif*day))/2))));
  }
  PImage getImage() {
    return pic;
  }
  int getDay() {
    return day;
  }
  String getUser() {
    return owner;
  }
  @Override
  boolean equals(Object o) {
    if (this == o) {
        return true;
  }
    if (o == null) {
        return false;
    }
    if (getClass() != o.getClass()) {
        return false;
    }
    Circle cir = (Circle) o;
    return (cir.getID().equals(this.id));
  }
}