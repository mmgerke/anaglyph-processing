// Since we are looking at left neighbors
PImage img, imgM, imgC, imgY;  // Declare PImages for image layers
String fileName = "roses.jpg";  // Filename of image to process
int shift; // How much to offset the red/cyan layers

void settings() {
  img = loadImage(fileName);
  shift = ceil(img.width/354)*-10;
  size(img.width-(2*-shift),img.height);
}

void setup() {
  colorMode(RGB, 255);
  imgM = loadImage(fileName);
  imgC = loadImage(fileName);  
  imgY = loadImage(fileName);  
  image(img, shift, 0);
  
  buildMagentaLayer();
  buildCyanLayer();
  buildYellowLayer();
  //findEdges();
  
  String saveFile = "anaglyph_" + hour() + minute() + ".jpg";
  saveFrame(saveFile);
  print("Output saved as ", saveFile);
}

void draw() {
}

void buildMagentaLayer() {
  // Draw the image to the screen at coordinate (0,0)
  tint(255, 0, 255, 100);
  image(imgM, shift, 0);
}

void buildCyanLayer() {
  // Draw the image to the screen at coordinate (0,0)
  tint(0, 255, 255, 100);
  image(imgC, 0, 0);
}

void buildYellowLayer() {
  // Draw the image to the screen at coordinate (0,0)
  tint(255, 255, 0, 100);
  image(imgY, shift/2, 0);
}

void findEdges() {
  img.loadPixels();
  
  // We skip the first column (x=0)
  for (int x = 1; x < width-1; x++) {
    for (int y = 0; y < height-1; y++ ) {
      // Pixel location and color
      int loc = x + y*img.width;
      color pix = img.pixels[loc];
  
      // Pixel to the left location and color
      int leftLoc = (x-1) + y*img.width;
      color leftPix = img.pixels[leftLoc];
  
      // Find difference between pixel and left neighbor
      float diff = abs(brightness(pix) - brightness(leftPix));
      if (diff > 200) {  // edge detection sensitivity
        print(diff, "\n");
        // Color edges white
        img.pixels[loc] = color(255);
        //img.pixels[leftLoc] = color(255);
      }
    }
  }
  img.updatePixels();
}
