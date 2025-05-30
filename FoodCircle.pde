// This is class for draggable food stuff in the Animal Cafe game
class FoodCircle {
  float x, y, r;
  color c;

  // State flag to track if the food is currently being dragged, defaulted as flase
  boolean beingDragged = false;

  // Constructor
  FoodCircle(float x, float y, float r, color c) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.c = c;
  }

  // Function to update the position of the food to follow the mouse if it's being dragged
  void update() {
    if (beingDragged) {
      x = mouseX;
      y = mouseY;
    }
  }

  // Function to display the food circle on the screen
  void display() {
    fill(c);
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }

  // Function to check if the mouse is currently over this food circle
  boolean isMouseOver() {
    return dist(mouseX, mouseY, x, y) < r;
  }

  // Function to check if the food is within a 50 radius of the center of the screen
  boolean isInCenter() {
    return dist(x, y, width / 2, height / 2) < 50;
  }
}
