import controlP5.*;
import java.util.*;
import java.text.*;
import java.util.*;




String api = "https://api.flickr.com/services/rest/?method=";
String search = "flickr.photos.search";
String sizes = "flickr.photos.getSizes";
String info = "flickr.photos.getInfo";
String eXIF = "flickr.photos.getExif";
String api_key = "d88190ce645c4166b1451bd95eeea880";
String settings = "&format=json&nojsoncallback=1&api_key=" + api_key;
//______________________________________________________________
int total = 500;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
int numPg = 8; // CHANGE THIS TO ANYTHING BETWEEN 1 and 8. LOWER NUMBER MEANS LESS PHOTOS
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ArrayList<Circle> circles = new ArrayList<Circle>();

ArrayList<ArrayList<Circle>> week = new ArrayList<ArrayList<Circle>>();
ArrayList<Circle> sun = new ArrayList<Circle>();
ArrayList<Circle> mon = new ArrayList<Circle>();
ArrayList<Circle> tues = new ArrayList<Circle>();
ArrayList<Circle> wed = new ArrayList<Circle>();
ArrayList<Circle> thurs = new ArrayList<Circle>();
ArrayList<Circle> fri = new ArrayList<Circle>();
ArrayList<Circle> sat = new ArrayList<Circle>();

ArrayList<String> users = new ArrayList<String>();
ArrayList<Integer> colors = new ArrayList<Integer>();

boolean loading = true;
boolean keyOn;
String curUser = "empty";

JSONObject data;
ArrayList<String> keys;
ArrayList<PImage> images = new ArrayList<PImage>();
PImage showImage; // Current Image being displayed
int prev;
int displayImage = 0; // Element of the array being accessed

int currDay = 0;
int prevDay = 0;

int displayForDay = 0;
int prevDisDay = 0;
//______________________________________________________________

Button q1;
Button q2;
Button q3;
Button q4;
Button fullView;
Button dayOnly;
Button nightOnly;
Button tfHour;
Button getKey;
ControlP5 cp5;

Textlabel owner;
Textlabel dateTaken;
Textlabel bright;


Textlabel three;
Textlabel six;
Textlabel nine;
Textlabel twelve;
Textlabel rings;

SpiderGraph sg ;
SpiderGraph graphKey;
int view;

void setup() {
  size(1200,750);
  cp5 = new ControlP5(this);
  background(0);
  
  week.add(new ArrayList<Circle>());
  week.add(sun);
  week.add(mon);
  week.add(tues);
  week.add(wed);
  week.add(thurs);
  week.add(fri);
  week.add(sat);
  
  q1 = new Button(cp5,"12 to 3");
  q1.setWidth(50);
  q1.setHeight(50);
  q1.setPosition(1020,50);
  
  q2 = new Button(cp5, "3 to 6");
  q2.setPosition(1020,110);
  q2.setWidth(50);
  q2.setHeight(50);
  
  q3 = new Button(cp5, "6 to 9");
  q3.setPosition(960,110);
  q3.setWidth(50);
  q3.setHeight(50);
  
  q4 = new Button(cp5, "9 to 12");
  q4.setPosition(960,50);
  q4.setWidth(50);
  q4.setHeight(50);
  
  getKey = new Button(cp5, "Show Key");
  getKey.setPosition(990,175);
  getKey.setWidth(50);
  getKey.setHeight(50);
  
  fullView = new Button(cp5, "Full View");
  
  owner = new Textlabel(cp5, "-----------", 950, 510);
  dateTaken = new Textlabel(cp5, "----------", 950, 560);
  bright = new Textlabel(cp5, "---------", 950, 610);
  
three = new Textlabel(cp5, "3", 1128, 415);
six = new Textlabel(cp5, "6", 1002, 542);
nine = new Textlabel(cp5, "9", 880, 415);;
twelve = new Textlabel(cp5, "12", 1002, 280);
rings = new Textlabel(cp5, "Biggest Ring is Saturday" + " \n" +" Smallest Ring is Sunday",950, 560); 
  
  
  sg = new SpiderGraph();
  graphKey = new SpiderGraph();
  
    graphKey.setX(1010);
    graphKey.setY(415);
    graphKey.setR(40);
    graphKey.setDiff(25);
    graphKey.setLL(125);
    graphKey.setRotation(270);
  
  loading();
  }
void placeDown() {
  background(0);
  sg.drawMe();
  for (Circle u: circles) {
    u.setX(sg.getX(), sg.getRad(), sg.getDiff());
    u.setY(sg.getY(), sg.getRad(), sg.getDiff());
  }
  webs();
  for (Circle u: circles) {
    u.drawMe(currDay);
  }
}

void loading() {
    fill(255);
    textAlign(CENTER);
    text("LOADING" + "\n" + "Click on an individual circle to see it’s data as well as what thread it is attached to." + "\n" + "Use the UP and DOWN arrow keys to traverse the images on just a single day " + "\n" + "and LEFT and RIGHT to see other photos on its thread.", width/2, height/2);
}
void loadCircles() {
  for (int j = 1; j <= numPg; j++){
        JSONObject data = loadJSONObject(api + search + settings + "&tags=lmc2700&per_page=" + total +"&page="+j);
        JSONArray photos = data.getJSONObject("photos").getJSONArray("photo");
//Got the photos at page j ___________________________________________________________________________________________________________
        for (int i = 0; i < photos.size(); i++) {
          String id = photos.getJSONObject(i).getString("id");
          //images.add(getImage(id));
          JSONObject photo = loadJSONObject(api+info+"&api_key="+api_key+"&photo_id="+id+"&format=json&nojsoncallback=1").getJSONObject("photo");
          Circle tempC = (new Circle(getImage(id), id, getBV(id), getOutlier(getImage(id)), getDateTaken(photo)));
          tempC.setOwner(getOwner(photo));
          circles.add(tempC);
          week.get(tempC.getDay()).add(tempC);
          if(!users.contains(tempC.getUser())) {
            users.add(tempC.getUser());
            color tmep = color(random(255), random(255), random(255));
            while(colors.contains(tmep)) {
              tmep = color(random(255), random(255), random(255));
            }
            colors.add(tmep);
          }
        }
      }
      loading = false;
      showImage = null;
    }

void mousePressed(){
  int x = mouseX;
  int y = mouseY;
  keyOn = false;
  showImage = null;
  showSelectedPicture(circles.get(displayImage));
  if (q1.isPressed()) {
    view = 1;
    sg.setX(125);
    sg.setY(height-5);
    sg.setR(100);
    sg.setDiff(185);
    sg.setLL(700);
    sg.setRotation(270);
    placeDown();
  } else if (q2.isPressed()) {
    view = 2;
    sg.setX(125);
    sg.setY(5);
    sg.setR(100);
    sg.setDiff(185);
    sg.setLL(700);
    sg.setRotation(0);
    placeDown();
  } else if (q3.isPressed()) {
    view = 3;
    sg.setX(width-405);
    sg.setY(5);
    sg.setR(100);
    sg.setDiff(185);
    sg.setLL(700);
    sg.setRotation(-270);
    placeDown();
  } else if (q4.isPressed()) {
    view = 4;
    sg.setX(width-405);
    sg.setY(height-5);
    sg.setR(100);
    sg.setDiff(185);
    sg.setLL(700);
    sg.setRotation(-270);
    placeDown();
  } else if (fullView.isPressed()) {
    view = 0;
    sg.setX(width/2 - 200);
    sg.setY(height/2);
    sg.setR(50);
    sg.setDiff(100);
    sg.setLL(375);
    sg.setRotation(270);
    currDay = 8;
    curUser = "empty";
    placeDown();
  } else if (getKey.isPressed()) {
    keyOn = true;
    showSelectedPicture(circles.get(displayImage));
  }else if (x < 1000) { //ISSUE
  int clickDay = 0;
    if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad() +(sg.getDiff()*1))/2)) {
      clickDay = 1;
    } else if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad()+(sg.getDiff()*2))/2)) {
      clickDay = 2;
    } else if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad()+(sg.getDiff()*3))/2)) {
      clickDay = 3;
    } else if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad()+(sg.getDiff()*4))/2)) {
      clickDay = 4;
    } else if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad()+(sg.getDiff()*5))/2)) {
      clickDay = 5;
    } else if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad()+(sg.getDiff()*6))/2)) {
      clickDay = 6;
    } else if((sqrt(sq(sg.getX()-x) + sq(sg.getY()-y)) < (sg.getRad()+(sg.getDiff()*7))/2)) {
      clickDay = 7;
    }
    for (int c = 0; c < week.get(clickDay).size(); c++) {//circles.size(); c++) {
      if (week.get(clickDay).get(c).overCircle(x, y)) {
        if(currDay!= 8 && currDay!=0) {
          week.get(currDay).get(displayForDay).unSelect();
          }
          prev = displayForDay;
          prevDay = currDay;
          displayForDay = c;
          currDay =  clickDay;
          showImage = week.get(currDay).get(displayForDay).getImage();
          week.get(currDay).get(displayForDay).select();
          curUser = week.get(currDay).get(displayForDay).getUser();
          displayImage = circles.indexOf(week.get(currDay).get(c));
          placeDown();
          showSelectedPicture(week.get(currDay).get(displayForDay));
      }
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    if (currDay !=0 && currDay!=8) {
    prevDisDay = displayForDay;
    week.get(currDay).get(prevDisDay).unSelect(); ///ISSUE
    displayForDay++;
    if (displayForDay>=week.get(currDay).size()) {
    displayForDay = 0;
    }
    week.get(currDay).get(displayForDay).select();
    curUser = week.get(currDay).get(displayForDay).getUser();
    showImage = week.get(currDay).get(displayForDay).getImage();
    placeDown();
    week.get(currDay).get(displayForDay).drawMe(currDay);
    displayImage = circles.indexOf(week.get(currDay).get(displayForDay));
    showSelectedPicture(week.get(currDay).get(displayForDay));
   }
  
} else if (keyCode == DOWN) {
   
    if (currDay !=0 && currDay!=8) {
    prevDisDay = displayForDay;
    week.get(currDay).get(prevDisDay).unSelect();
    displayForDay--;
    if (displayForDay<0) {
    displayForDay = week.get(currDay).size()-1;
    }
    week.get(currDay).get(displayForDay).select();
    curUser = week.get(currDay).get(displayForDay).getUser();
    showImage = week.get(currDay).get(displayForDay).getImage();
    placeDown();
    week.get(currDay).get(displayForDay).drawMe(currDay);;
    showSelectedPicture(week.get(currDay).get(displayForDay));
   }
  
} else if (keyCode == RIGHT) {
   prev = circles.indexOf(week.get(currDay).get(displayForDay));
   circles.get(prev).unSelect();
   displayImage = prev + 1;
   if (displayImage>=circles.size()) {
    displayImage = 0;
   }
    while (!(circles.get(displayImage).getUser().equals(circles.get(prev).getUser()))) {
      displayImage++;
      if (displayImage>=circles.size()) {
        displayImage = 0;
      }
    }
    circles.get(displayImage).select();
    curUser = circles.get(displayImage).getUser();
    showImage = circles.get(displayImage).getImage();
    currDay = circles.get(displayImage).getDay();
    placeDown();
    circles.get(displayImage).drawMe(currDay);
    displayForDay = week.get(currDay).indexOf(circles.get(displayImage));
    showSelectedPicture(week.get(currDay).get(displayForDay));
} else if (keyCode == LEFT) {
   prev = circles.indexOf(week.get(currDay).get(displayForDay));
   circles.get(prev).unSelect();
   displayImage = prev - 1;
   if (displayImage<0) {
    displayImage = circles.size()-1;
   }
    while (!(circles.get(displayImage).getUser().equals(circles.get(prev).getUser()))) {
      displayImage--;
      if (displayImage<0) {
        displayImage = circles.size()-1;
      }
    }
    circles.get(displayImage).select();
    curUser = circles.get(displayImage).getUser();
    showImage = circles.get(displayImage).getImage();
    currDay = circles.get(displayImage).getDay();
    placeDown();
    circles.get(displayImage).drawMe(currDay);
    displayForDay = week.get(currDay).indexOf(circles.get(displayImage));
    showSelectedPicture(week.get(currDay).get(displayForDay));
  }
}

void keyStuff(boolean show) {
  if (show) {
    twelve.draw();
    six.draw();
    three.draw();
    nine.draw();
    rings.draw();
  } else {
    twelve.hide();
    six.hide();
    three.hide();
    nine.hide();
    rings.hide();
  }
}

void showSelectedPicture(Circle c) {
  if (showImage != null) {
    fill(0,180);
    noStroke();
    rect(900,300,240,400);
    owner.setText("User: " + c.getUser() + "\n" + c.getID());
    image(getImage(c.getID()),950,300,150,150); //Changed showImage to c.get
    owner.draw();
    dateTaken.setText("Date Taken: " + week.get(currDay).get(displayForDay).getDate());
    dateTaken.draw();
    bright.setText("Brightness: " + week.get(currDay).get(displayForDay).getRad());
    bright.draw();
    keyStuff(false);
  } else {
    c.unSelect();
    owner.hide();
    dateTaken.hide();
    bright.hide();
    placeDown();
    if (keyOn) {
      fill(0,180);
      noStroke();
      rect(880,290,260,270);
      graphKey.drawMe();
      keyStuff(true);
    }
  }
}
void webs() {
  for(String u: users) {
    float preX = 0;
    float preY = 0;
    for (int i = 0; i< circles.size(); i++) {
      if (circles.get(i).getUser().equals(u)) {
        if (preX!= 0 ) {
          if (curUser.equals(u)) {
            stroke(colors.get(users.indexOf(u)), 255);
          } else {
            stroke(colors.get(users.indexOf(u)), 100);
          }
          line(preX, preY, circles.get(i).getX(), circles.get(i).getY());
        }
        preX=circles.get(i).getX();
        preY=circles.get(i).getY();
      }
    }
  }
}
void draw() {
  if (loading) {
    prev = circles.size()-1;
    loadCircles();
    currDay = 8;
    placeDown();
  }
}