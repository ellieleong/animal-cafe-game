// The Customer class represents an animal customer in the cafe
// It stores information about the customer's position, order status, mood, and food preference
// This class also handles displaying the customer and updating their behavior (e.g., ordering or waiting)
class Customer {
  String name;
  float x, y;
  float targetX;
  String state;
  int stateTimer;

  boolean waiting = false;
  boolean leaving = false;
  boolean thoughtBubbleVisible = false;
  String orderType;

  // Animal-specific
  String catType;
  PImage catImage;

  Customer(String name, float startY, String catType, PImage catImage) {
    this.name = name;
    this.x = -50;
    this.y = startY;
    this.targetX = width / 2 - 25;
    this.state = "arriving";
    this.stateTimer = 0;

    this.catType = catType;
    this.catImage = catImage;

    randomizeOrder();
  }

  void randomizeOrder() {
    String[] possibleTypes = {"croissant", "sando", "carrotcake", "berries"}; 
    orderType = possibleTypes[int(random(possibleTypes.length))];
  }

  void stateTransitions() {
    stateTimer++;

    if (state.equals("arriving") && x >= targetX) {
      state = "waiting";
      waiting = true;
      thoughtBubbleVisible = true;
      stateTimer = 0;
    } 
  }

  void update() {
    stateTransitions();

    if (state.equals("arriving") || state.equals("exiting")) {
      x += 3;
    }
  }

  void receiveFood(String givenType) {
    if (state.equals("waiting") && typesMatch(orderType, givenType)) {
      thoughtBubbleVisible = false;
      waiting = false;
      state = "exiting";
      leaving = true;
      stateTimer = 0;
    }
  }

  void display() {
    if (catImage != null) {
      image(catImage, x, y);
    } else {
      fill(150, 200, 250);
      rect(x, y, 50, 50, 10);
    }

    if (thoughtBubbleVisible) {
      drawThoughtBubble();
    }
  }

  void drawThoughtBubble() {
    float bubbleX = x - 50;
    float bubbleY = y - 100;

    fill(255);
    stroke(0);
    strokeWeight(2);
    beginShape();
    vertex(bubbleX + 100, bubbleY);
    bezierVertex(bubbleX + 140, bubbleY - 70, bubbleX - 140, bubbleY - 70, bubbleX - 100, bubbleY);
    bezierVertex(bubbleX - 140, bubbleY + 70, bubbleX + 140, bubbleY + 70, bubbleX + 100, bubbleY);
    endShape(CLOSE);

    ellipse(bubbleX + 40, bubbleY + 90, 28, 28);
    ellipse(bubbleX + 70, bubbleY + 120, 18, 18);
    ellipse(bubbleX + 95, bubbleY + 140, 12, 12);

    fill(0);
    textSize(32); 
    textAlign(CENTER, CENTER);
    text(orderType, 326, 31, 200, 140); 
  }

  // Drop detection over customer's "mouth" area
  boolean isPlaceholderHovered(float fx, float fy) {
    float mouthX = x + 150;
    float mouthY = y + 120;
    float mouthWidth = 250;
    float mouthHeight = 80;

    return fx > mouthX && fx < mouthX + mouthWidth &&
           fy > mouthY && fy < mouthY + mouthHeight;
  }

  boolean typesMatch(String customerOrder, String draggedType) {
    return customerOrder.equals(draggedType);
  }
}
