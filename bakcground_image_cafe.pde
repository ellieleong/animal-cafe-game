PImage background_image;

void setup(){
  load_background_image();
  size(1000,800);
}

void load_background_image(){
  background_image = loadImage("images/background for animal cafe *.png");
  //inserts background image
  
  background_image.resize(1000,800);
    //resizes background image
    
    image(background_image, 0,0);
}
