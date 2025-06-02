// Image variables
PImage background_image;
PImage countertop_image;

// Food images
PImage croissant_image;
PImage sando_image;       
PImage berries_image;     
PImage carrotcake_image;  

// Animal images
PImage pinkCatImage, blackCatImage, bearImage, bunnyImage;

// Game variables
int foodCost = 3;
int money = 5;

Customer customer;
ArrayList<FoodCircle> circles = new ArrayList<FoodCircle>(); // List of draggable food objects
FoodCircle draggingCircle = null;

void setup() {
  size(1000, 800);
  load_background_image();
  load_countertop_image();
  load_food_images();

  // Load animal images and resize
  pinkCatImage = loadImage("pinkcat.PNG");
  pinkCatImage.resize(545, 400);

  blackCatImage = loadImage("blackcat.PNG");
  blackCatImage.resize(545, 400);

  bearImage = loadImage("bear.PNG");
  bearImage.resize(545, 400);

  bunnyImage = loadImage("bunny.PNG");
  bunnyImage.resize(545, 400);

  textSize(16);
  textAlign(CENTER, CENTER);

  // Create food objects and place them on the shelf
  circles.add(new Croissant(10, 50, croissant_image));
  circles.add(new Sando(70, 50, sando_image));    
  circles.add(new Berries(130, 50, berries_image));   
  circles.add(new CarrotCake(190, 50, carrotcake_image));

  // Start with a random animal customer
  customer = spawnCustomer("A", height / 2 - 200, randomAnimalType());
}

void draw() {
  image(background_image, 0, 0);

  // Draw customer before countertop so it's underneath
  customer.update();
  customer.display();

  // Draw countertop above customer
  image(countertop_image, 0, 0);

  // Resize food images
  croissant_image.resize(120, 100);
  sando_image.resize(125, 105);    
  berries_image.resize(123, 103);      
  carrotcake_image.resize(140, 123);   

  // Display game status
  fill(0);
  textSize(30);
  text("money: $" + money, 100, 30);
  //text("drag food to animal ( +$" + foodCost + " )", 250, 30);

  // Update and display food circles
  for (FoodCircle fc : circles) {
    if (fc.beingDragged) {
      fc.update();
    }
    fc.display();
  }

  // Handle when food item is being dragged
  if (draggingCircle != null && customer.thoughtBubbleVisible) {
    draggingCircle.display();

    // If food is dropped onto customer's requeest and matches their order
    if (customer.isPlaceholderHovered(draggingCircle.x, draggingCircle.y)) {
      if (customer.state.equals("waiting") && customer.orderType.equals(draggingCircle.type)) {
        money += foodCost;
        customer.receiveFood(draggingCircle.type); // Serve food

        // Reset dragged food position instead of removing it
        draggingCircle.x = draggingCircle.shelfx + 10;
        draggingCircle.y = draggingCircle.shelfy + 10;

        draggingCircle.beingDragged = false;
      }
      draggingCircle = null;
    }
  }

  // Check if customer exited, then spawn new one
  if (customer.leaving && customer.x > width) {
    // Respawn customer, random animal type
    customer = spawnCustomer("A", height / 2 - 200, randomAnimalType());
  }
}

void mousePressed() {
  // Check if mouse is over any food item (top first)
  for (int i = circles.size() - 1; i >= 0; i--) {
    FoodCircle fc = circles.get(i);
    if (fc.isMouseOver()) {
      fc.beingDragged = true;
      draggingCircle = fc;
      break;
    }
  }
}

void mouseReleased() {
  // Stop dragging when mouse is released
  if (draggingCircle != null) {
    draggingCircle.beingDragged = false;
    draggingCircle = null;
  }
}

// Function to load background image and resize it
void load_background_image() {
  background_image = loadImage("background.PNG");
  background_image.resize(1000, 800);
}

// Function that spawns a new customer with a given animal type
Customer spawnCustomer(String name, float y, String animalType) {
  if (animalType.equals("pinkCat")) {
    return new Customer(name, y, "pinkCat", pinkCatImage);
  } else if (animalType.equals("blackCat")) {
    return new Customer(name, y, "blackCat", blackCatImage);
  } else if (animalType.equals("bear")) {
    return new Customer(name, y, "bear", bearImage);
  } else if (animalType.equals("bunny")) {
    return new Customer(name, y, "bunny", bunnyImage);
  }
  return null;
}

// Function that chooses a random animal type from the list
String randomAnimalType() {
  String[] animals = {"pinkCat", "blackCat", "bear", "bunny"};
  return animals[int(random(animals.length))];
}

// Function that loads and resizes countertop image
void load_countertop_image() {
  countertop_image = loadImage("countertop.PNG");
  countertop_image.resize(1000, 800);
}

// Function that loads all food images
void load_food_images() {
  croissant_image = loadImage("croisant.PNG");
  sando_image = loadImage("sando.PNG");           
  berries_image = loadImage("berries.PNG");       
  carrotcake_image = loadImage("carrotcake.PNG"); 
}
