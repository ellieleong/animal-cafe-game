PImage background_image;
int foodCost = 3;
int money = 5;

void setup(){
  load_background_image();
  size(1000, 800);
  
  float padding = circleRadius + 10; // ensures full fit inside square

// creates place for food circles
  circleSpots = new PVector[] {
    new PVector(displayX + padding, displayY + padding),                                        
    new PVector(displayX + displaySize - padding, displayY + padding),                          
    new PVector(displayX + padding, displayY + displaySize - padding),                          
    new PVector(displayX + displaySize - padding, displayY + displaySize - padding)
  };
  //there was an extra for loop here so i deleted it
  //this draws a new food circle
  for (int i = 0; i < 4; i++) {
    circles.add(new FoodCircle(circleSpots[i].x, circleSpots[i].y, circleRadius, colors[i]));
  }
 textSize(16);
  textAlign(CENTER, CENTER);

  customer = new Customer("A", height / 2);
}


void draw(){
  image(background_image, 0,0);//adds background image 

  
  fill(224, 214, 175);
 rect(0,0,350,75);
  fill(0);
  textSize(30);
  text("money: $" + money, 30, 30);
  text("drag food to animal(+$" + foodCost +")", 20, 60); // shows text instructions
  
  stroke(0);
  fill(200);
  rect(displayX, displayY, displaySize, displaySize, 10);

 
  for (FoodCircle fc : circles) {
    fc.update();
    fc.display();
  }
  
  for (int i = circles.size() - 1; i >= 0; i--) {
    FoodCircle fc = circles.get(i);
    if (fc.beingDragged && fc.isInCenter()) {
      circles.remove(i);
    }
  }
 // Draw food display box
  stroke(0);
  fill(200);
  rect(displayX, displayY, displaySize, displaySize, 10);

  // Draw and update food circles
  for (FoodCircle fc : circles) {
    fc.update();
    fc.display();
  }

  // Update and draw customer
  customer.update();
  customer.display();

  // Check for correct drop
  if (draggingCircle != null && customer.thoughtBubbleVisible) {
    if (customer.isPlaceholderHovered(draggingCircle.x, draggingCircle.y)) {
      customer.receiveFood(draggingCircle.c);
      circles.remove(draggingCircle);
      draggingCircle = null;
    }
  }
}

void mousePressed() {
  for (int i = circles.size() - 1; i >= 0; i--) { //go through all food circles starting at the end
    FoodCircle fc = circles.get(i);
    if (fc.isMouseOver()) { //if the mouse is on the circle we're looking at
      fc.beingDragged = true; //it is being dragged
      draggingCircle = fc; //keeps track of which circle is currently being dragged 

     //creating circles at the spots  
      for (int j = 0; j < 4; j++) {
        if (dist(fc.x, fc.y, circleSpots[j].x, circleSpots[j].y) < 5) {
          circles.add(new FoodCircle(circleSpots[j].x, circleSpots[j].y, circleRadius, colors[j]));
          break;
        }
      }

      break;
    }
  }
}


void mouseReleased() {
  if (draggingCircle != null) {//if you were dragging a cirle and the you relese your finger the circle disapears
    draggingCircle.beingDragged = false;
    draggingCircle = null;
  }
  sellCoffee();
} 



void sellCoffee(){
  money += foodCost;//adds 3 everytimes it pressed
}
void load_background_image(){
  background_image = loadImage("images/background for animal cafe *.png"); //inserts background image
  
  background_image.resize(1000,800); //resizes background image
    
    image(background_image, 0,0);
}
