// Class for the draggable food items in the cafe game
class FoodCircle {
  float x, y, r = 25;
  color c = color(255);
  String type = "";
  boolean beingDragged = false;
  PImage food_image;

  // Shelf bounds (only draggable if mouse is within these hitboxes)
  float shelfx, shelfy, shelfRightX, shelfBottomY;

  // Constructor to initialize food item with below parameters
  FoodCircle(float x, float y, PImage food_image, String type) {
    this.x = x;
    this.y = y;
    this.food_image = food_image;
    this.type = type;
  }

  // Function to update position if being dragged
  void update() {
    if (beingDragged) {
      x = mouseX;
      y = mouseY;
    }
  }

  // Function to display the image of the food while it's being dragged
  void display() {
    if (beingDragged) {
      image(food_image, x, y); // follows mouse
    }
    // else: nothing displayed when not dragging
  }

  //Function that returns true if the mouse is over the food's sehlf area
  boolean isMouseOver() {
    // Only allows grabbing from shelf area
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }

  // Function that checks if food is placed in the center serving area
  boolean isInCenter() {
    return dist(x, y, width / 2, height / 2) < 50;
  }
}

// Subclass of FoodCircle (a croissant food item located in upper-left shelf)
class Croissant extends FoodCircle {
  Croissant(float x, float y, PImage food_image){
    super(x, y, food_image, "croissant");
    this.shelfx = 0;
    this.shelfy = 500;
    this.shelfRightX = 500;
    this.shelfBottomY = 640;
  }
}

// Subclass of FoodCircle (a sando food item located in middle-right shelf)
class Sando extends FoodCircle {
  Sando(float x, float y, PImage food_image) {
    super(x, y, food_image, "sando");
    this.shelfx = 503;
    this.shelfy = 520;
    this.shelfRightX = 1000;
    this.shelfBottomY = 660;
  }
}

// Subclass of FoodCircle (a berry bowl item located in bottom-right shelf)
class Berries extends FoodCircle {
  Berries(float x, float y, PImage food_image) {
    super(x, y, food_image, "berries");
    this.shelfx = 500;
    this.shelfy = 660;
    this.shelfRightX = 1000;
    this.shelfBottomY = 790;
  }
}

// Subclass of FoodCircle (a carrot cake located in bottom-left shelf)
class CarrotCake extends FoodCircle {
  CarrotCake(float x, float y, PImage food_image) {
    super(x, y, food_image, "carrotcake");
    this.shelfx = 0;
    this.shelfy = 655;
    this.shelfRightX = 500;
    this.shelfBottomY = 790;
  }
}
