import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

String layer1FileName = "./tulip/1.png";
String layer2FileName = "./tulip/2.png";
String layer3FileName = "./tulip/3.png";
String layer4FileName = "./tulip/4.png";
//String layer5FileName = "./tulip/5.png";
//String layer6FileName = "./tulip/6.png";


void setup() {
  noLoop(); 

  // janome mb-7
  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  // brother se400
  // 4x4 hoop: 100x100mm, 4x4in, 916x916
  // int almost4Inches = 916; // had issues with exactly 4x4

  // float mm = 10; // machine unit size
  // size(2400, 2000); // M1
  size (1260, 1100); // M2
  // size(500, 500); // M3
  // size (916, 916); // 4x4

  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "layered_bitmap";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String fileExt = "pes"; // jef, dst, pes, svg
  String outputFilePath = sketchPath(fileName + "." + fileExt);

  PImage layer1 = loadImage(layer1FileName);
  PImage layer2 = loadImage(layer2FileName);
  PImage layer3 = loadImage(layer3FileName);
  PImage layer4 = loadImage(layer4FileName);
  //PImage layer5 = loadImage(layer5FileName);
  //PImage layer6 = loadImage(layer6FileName);

  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  
  draw(layer1, layer2, layer3, layer4);//, layer5, layer6);
  
  E.optimize(); // slow, but good and important
  E.visualize(true,true,true);
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

// returns pes output file path
public String pesSetup(String filename) {
    return sketchPath(filename + ".pes");
}

// TODO: array
void draw(PImage layer1, PImage layer2, PImage layer3, PImage layer4) {//, PImage layer5, PImage layer6) {

  E.strokeWeight(1); 
  E.strokeSpacing(4);
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC); 
  E.hatchSpacing(6);
  E.setStitch(5, 20, 0);

  E.beginCull();
  
  E.strokeWeight(3); 
  E.stroke(0, 250, 0); 
  E.fill(0, 250, 0); 
  E.image(layer1, 0, 0, width,height);
  
  E.stroke(255, 0, 0); 
  E.fill(255, 0, 0); 
  E.image(layer2, 0, 0, width,height);
  
  //E.strokeWeight(1); 
  E.stroke(255, 255, 0); 
  E.fill(255, 255, 0); 
  E.image(layer3, 0, 0, width,height);
  
  E.stroke(243, 229, 171); 
  E.fill(243, 229, 171);   
  E.image(layer4, 0, 0, width,height);
  
  //E.stroke(173, 216, 230); 
  //E.fill(173, 216, 230);   
  //E.image(layer5, 0, 0, width,height);
  
  //E.stroke(145, 163, 176); 
  //E.fill(145, 163, 176);   
  //E.image(layer6, 0, 0, width,height);
  
  E.endCull();
}
