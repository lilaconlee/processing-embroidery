import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

void setup() {
  noLoop(); 

  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  //float mm = 10;

  size (500, 500);

  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "machine_test_jump";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String fileExt = "dst"; // jef, dst, pes, svg
  String outputFilePath = sketchPath(fileName + "." + fileExt);
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();

  draw();
  
  E.optimize(); // slow, but good and important
  E.visualize(true, true, false); // color, stitches, route
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

void draw() {
  E.noFill();
  E.strokeWeight(5);
  E.strokeSpacing(2.0);
  E.PERPENDICULAR_STROKE_CAP_DENSITY_MULTIPLIER = 0.4;
  
  float ay = 2; 
  int lines = 15;
  for (int i=0; i<lines; i++) {
    //float x = pow(ay,i) + 10;
    float x = pow(ay * i,2) + 10;
    println(x);
    E.line(x,10,x,210);
  }
}
