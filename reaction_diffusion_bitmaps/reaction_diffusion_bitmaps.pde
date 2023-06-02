import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

int almost4Inches = 916; // 4x4 hoop

// project details
String projectTitle = "reaction_diffusion_bitmap";
String bmpFileName = "./may_31/3.png"; // b&w bitmap
// String photoFileName = ""; // photo for preview, if desired
String photoFileName = null;

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
  E.fill(0, 0, 0); 
  E.noStroke();
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC);
  E.hatchSpacing(3);

  E.image(bmp, 0, 0, almost4Inches,almost4Inches);
}
