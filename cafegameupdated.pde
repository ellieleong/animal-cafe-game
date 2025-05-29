PImage background_image;
PImage countertop_image;

PImage croissant_image;
PImage sando_image;       
PImage berries_image;     
PImage carrotcake_image;  

int foodCost = 3;
int money = 5;

void setup() {
  size(1000, 800);
  load_background_image();
  load_countertop_image();
  load_food_images();

  textSize(16);
  textAlign(CENTER, CENTER);

  circles.add(new Croissant(10, 50, croissant_image));
  circles.add(new Sando(70, 50, sando_image));    
  circles.add(new Berries(130, 50, berries_image));   
  circles.add(new CarrotCake(190, 50, carrotcake_image));
 

  customer = new Customer("A", height / 2);
}

void draw() {
  image(background_image, 0, 0);
  image(countertop_image, 0, 0);

  croissant_image.resize(120, 100);
  sando_image.resize(125, 105);    
  berries_image.resize(50, 50);      
  carrotcake_image.resize(50, 50);   

  fill(224, 214, 175);
  fill(0);
  textSize(30);
  text("money: $" + money, 30, 30);
  text("drag food to animal(+$" + foodCost + ")", 20, 60);

  // Update food circles
  for (int i = circles.size() - 1; i >= 0; i--) {
    FoodCircle fc = circles.get(i);
    if (fc.beingDragged && fc.isInCenter()) {
      circles.remove(i);
    } else {
      fc.update();
      fc.display();
    }
  }

  customer.update();
  customer.display();

  if (draggingCircle != null && customer.thoughtBubbleVisible) {
    draggingCircle.display();
    if (customer.isPlaceholderHovered(draggingCircle.x, draggingCircle.y)) {
      customer.receiveFood(draggingCircle.type);
      circles.remove(draggingCircle);
      draggingCircle = null;
    }
  }
  
//  text(mouseX + "," + mouseY, mouseX, mouseY);
}

void mousePressed() {
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
  if (draggingCircle != null) {
    draggingCircle.beingDragged = false;
    draggingCircle = null;
  }
  sellCoffee();
}

void sellCoffee() {
  money += foodCost;
}

void load_background_image() {
  background_image = loadImage("background.PNG");
  background_image.resize(1000, 800);
}

void load_countertop_image() {
  countertop_image = loadImage("countertop.PNG");
  countertop_image.resize(1000, 800);
}

void load_food_images() {
  croissant_image = loadImage("croisant.PNG");
  sando_image = loadImage("sando.PNG");           
  berries_image = loadImage("berries.PNG");       
  carrotcake_image = loadImage("carrotcake.PNG"); 
}
