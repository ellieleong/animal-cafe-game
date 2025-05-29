class FoodCircle {
  float x, y, r = 25;
  color c = color(255); //it doesn't need a color, it needs a type
  String type = "";
  boolean beingDragged = false;
  PImage food_image;

  // Shelf bounds and anchor location
  float shelfx, shelfy, shelfRightX, shelfBottomY;

  FoodCircle(float x, float y, PImage food_image, String type) {
    this.x = x;
    this.y = y;
    this.food_image = food_image;
    this.type = type;
  }

  void update() {
    if (beingDragged) {
      x = mouseX;
      y = mouseY;
    }
  }

  void display() {
    if (beingDragged) {
      image(food_image, x, y); // follows mouse
    } else {
      image(food_image, shelfx, shelfy); // static on shelf
    }
  }

  boolean isMouseOver() {
    // Only allows grabbing from shelf
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }

  boolean isInCenter() {
    return dist(x, y, width / 2, height / 2) < 50;
  }
}

class Croissant extends FoodCircle {
    float shelfx = 0; //the croissant is always going to be at a shelf in this x location
    float shelfy = 500;
    float shelfRightX = 500;
    float shelfBottomY = 640;
    
    Croissant(float x, float y, PImage food_image){
      super(x, y, food_image, "croissant");
    }
   
    //THIS CAN NOW check for the specific location of the croissant specifically
  boolean isMouseOver() {
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }
}

class Sando extends FoodCircle {
  float shelfx = 503;
  float shelfy = 520;
  float shelfRightX = 1000;
  float shelfBottomY = 660;

  Sando(float x, float y, PImage food_image) {
    super(x, y, food_image, "sando");
  }

  boolean isMouseOver() {
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }
}

class Berries extends FoodCircle {
  float shelfx = 500;
  float shelfy = 660;
  float shelfRightX = 1000;
  float shelfBottomY = 790;

  Berries(float x, float y, PImage food_image) {
    super(x, y, food_image, "berries");
  }

  boolean isMouseOver() {
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }
}

class CarrotCake extends FoodCircle {
  float shelfx = 0;
  float shelfy = 655;
  float shelfRightX = 500;
  float shelfBottomY = 790;

  CarrotCake(float x, float y, PImage food_image) {
    super(x, y, food_image, "carrotcake");
  }

  boolean isMouseOver() {
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }
}
