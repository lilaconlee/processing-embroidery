import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

int almost4Inches = 916; // 4x4 hoop

// project details
String projectTitle = "physarum_bitmap";
String bmpFileName = "jun_4_mistake.png"; // b&w bitmap
String photoFileName = null; // photo for preview, if desired

void setup() {
  noLoop(); 

  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  //float mm = 10;
  size(2400, 2000); // M1
  //size (1260, 1100); // M2
  // size(500, 500); // M3

  E = new PEmbroiderGraphics(this, width, height);
  
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String outputFilePath = pesSetup(fileName);

  // load images
  if (photoFileName != null) {
    PImage photo = loadImage(photoFileName);
    image(photo, 0, 0, 2400,2000); 
  }
  PImage bmp = loadImage(bmpFileName);
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();

  draw(bmp);
  
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

// returns pes output file path
public String pesSetup(String filename) {
    return sketchPath(filename + ".jef");
}

void draw(PImage bmp) {
  // Dense concentric hatch from bitmap_image_1
  // E.stroke(0, 0, 0); // not sure exactly what the params are here
  // E.strokeWeight(30); 
  // E.strokeSpacing(4);
  E.fill(0,0,0);
  E.noStroke();
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC); 
  E.hatchSpacing(2);
 // E.setStitch(5, 20, 1.0);

  E.image(bmp, 0, 0, 2400,2000);
}
