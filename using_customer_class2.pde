class Customer {
  // Basic attributes
  String name;      // Customer's name
  float x, y;       // Current position of customer
  float targetX;    // Where the customer should stop (in front of counter)
  String state;    // State: "arriving", "waiting", or "exiting"
  int stateTimer;  // Tracks how long the customer has been in current state

  // State flags
  boolean waiting = false;
  boolean leaving = false;
  boolean thoughtBubbleVisible = false;  // Shows what food they want
  String orderType;  // Type of food customer wants

  // Animal-specific attributes
  String catType;
  PImage catImage;

  // Constructor to initialize a new customer
  Customer(String name, float startY, String catType, PImage catImage) {
    this.name = name;
    this.x = -50;  // Start off-screen to the left
    this.y = startY;
    this.targetX = width / 2 - 25;  // Stops/Destination near the center
    this.state = "arriving";
    this.stateTimer = 0;

    this.catType = catType;
    this.catImage = catImage;

    randomizeOrder();  // Assign a random food order
  }

  // Function that randomly chooses a food item to order
  void randomizeOrder() {
    String[] possibleTypes = {"croissant", "sando", "carrotcake", "berries"}; 
    orderType = possibleTypes[int(random(possibleTypes.length))];
  }

  // Function that handles transitions between customer states
  void stateTransitions() {
    stateTimer++;

    if (state.equals("arriving") && x >= targetX) {
      state = "waiting";
      waiting = true;
      thoughtBubbleVisible = true;
      stateTimer = 0;
    } 
    // No eating state here, goes straight to exiting on receiving food
  }

  // Function that updates customer's position and handles state changes
  void update() {
    stateTransitions();

    // Move customer horizontally if arriving or leaving
    if (state.equals("arriving") || state.equals("exiting")) {
      x += 3;
    }
  }

  // Function called when customer receives food
  void receiveFood(String givenType) {
    if (state.equals("waiting") && typesMatch(orderType, givenType)) {
      thoughtBubbleVisible = false;
      waiting = false;
      state = "exiting";  // Immediately start exiting on correct food
      leaving = true;
      stateTimer = 0;
    }
  }

  // Function that displays customer and their thoughts bubble
  void display() {
    if (catImage != null) {
      image(catImage, x, y);
    } else {
      fill(150, 200, 250);  // Fallback if image is missing
      rect(x, y, 50, 50, 10);
    }

    // Removed name and state text display

    if (thoughtBubbleVisible) {
      drawThoughtBubble();
    }
  }

  // Function that draws the customer's food order bubble
  void drawThoughtBubble() {
    // Shift bubble lower by 30 pixels for better positioning
    float bubbleX = x - 50;
    float bubbleY = y - 100;

    // Main bubble shape
    fill(255);
    stroke(0);
    strokeWeight(2);
    beginShape();
    vertex(bubbleX + 100, bubbleY);
    bezierVertex(bubbleX + 140, bubbleY - 70, bubbleX - 140, bubbleY - 70, bubbleX - 100, bubbleY);
    bezierVertex(bubbleX - 140, bubbleY + 70, bubbleX + 140, bubbleY + 70, bubbleX + 100, bubbleY);
    endShape(CLOSE);

    // Thought trail
    ellipse(bubbleX + 40, bubbleY + 90, 28, 28);
    ellipse(bubbleX + 70, bubbleY + 120, 18, 18);
    ellipse(bubbleX + 95, bubbleY + 140, 12, 12);

    // Order text inside the bubble
    fill(0);
    textSize(22);
    textAlign(CENTER, CENTER);
    text(orderType, bubbleX - 40, bubbleY - 20, 180, 90);
  }

  // Function that checks if food was dragged into the thought bubble area
  boolean isPlaceholderHovered(float fx, float fy) {
    float bubbleX = x - 50;
    float bubbleY = y - 100;
    return fx > bubbleX - 100 && fx < bubbleX + 100 && fy > bubbleY - 70 && fy < bubbleY + 70;
  }

  // Functin that checks if the food matches the customer's order
  boolean typesMatch(String customerOrder, String draggedType) {
    return customerOrder.equals(draggedType);
  }
}
