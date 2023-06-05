import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

int almost4Inches = 916; // 4x4 hoop

// project details
String projectTitle = "physarum_bitmap";
String bmpFileName = "jun_3_bw_1.png"; // b&w bitmap
String photoFileName = "jun_2_color.jpeg"; // photo for preview, if desired

void setup() {
  noLoop(); 

  size (916, 916);

  E = new PEmbroiderGraphics(this, width, height);
  
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String outputFilePath = pesSetup(fileName);

  // load images
  if (photoFileName != null) {
    PImage photo = loadImage(photoFileName);
    image(photo, 0, 0, almost4Inches,almost4Inches); 
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
    return sketchPath(filename + ".pes");
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

  E.image(bmp, 0, 0, almost4Inches,almost4Inches);
}
