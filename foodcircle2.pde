class FoodCircle {
  float x, y, r = 25;
  color c = color(255);
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
    }
    // else: nothing displayed when not dragging
  }

  boolean isMouseOver() {
    // Only allows grabbing from shelf area
    return mouseX > shelfx && mouseX < shelfRightX && mouseY > shelfy && mouseY < shelfBottomY;
  }

  boolean isInCenter() {
    return dist(x, y, width / 2, height / 2) < 50;
  }
}

class Croissant extends FoodCircle {
  Croissant(float x, float y, PImage food_image){
    super(x, y, food_image, "croissant");
    this.shelfx = 0;
    this.shelfy = 500;
    this.shelfRightX = 500;
    this.shelfBottomY = 640;
  }
}

class Sando extends FoodCircle {
  Sando(float x, float y, PImage food_image) {
    super(x, y, food_image, "sando");
    this.shelfx = 503;
    this.shelfy = 520;
    this.shelfRightX = 1000;
    this.shelfBottomY = 660;
  }
}

class Berries extends FoodCircle {
  Berries(float x, float y, PImage food_image) {
    super(x, y, food_image, "berries");
    this.shelfx = 500;
    this.shelfy = 660;
    this.shelfRightX = 1000;
    this.shelfBottomY = 790;
  }
}

class CarrotCake extends FoodCircle {
  CarrotCake(float x, float y, PImage food_image) {
    super(x, y, food_image, "carrotcake");
    this.shelfx = 0;
    this.shelfy = 655;
    this.shelfRightX = 500;
    this.shelfBottomY = 790;
  }
}
