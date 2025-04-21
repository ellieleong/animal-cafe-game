PImage background_image;
int foodCost = 3;
int money = 5;
void setup(){
  load_background_image();
  size(1000, 800);
}
void draw(){
 fill(224, 214, 175);
 rect(0,0,350,75);
  fill(0);
  textSize(30);
  text("money: $" + money, 30, 30);
  text("drag food to animal(+$" + foodCost +")", 20, 60);
}
void keyPressed(){
 if(key == 's' || key == 'S'){
   sellCoffee();
 }
}
void sellCoffee(){
  money += foodCost;
}
void load_background_image(){
  background_image = loadImage("images/background for animal cafe *.png");
  //inserts background image
  
  background_image.resize(1000,800);
    //resizes background image
    
    image(background_image, 0,0);
}
