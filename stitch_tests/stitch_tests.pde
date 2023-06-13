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
  E.strokeWeight(1);
  
  float ay = 2; 
  int lines = 30;
  
  
  // setStitch(minLength, desiredLength, noise)
  //the minimum stitch length (in machine units; for our machine, this is 0.1mm)
  //the desired stitch length (in machine units)
  //the amount of noise (0...1) affecting stitch length. (This can be helpful for dithering the stitches in fills, so that they don't all line up.)

  E.setStitch(1, 500, 0);

  for (int i=0; i<lines; i++) {
    //float x = pow(ay,i) + 10;
    float x = i * 7;
    float y2 = pow(ay * i,1.5) + 10;
    //E.beginRepeatEnd(3); 
    E.line(x,10,x,y2);
    //E.endRepeatEnd();
  }
  
  for (int i=0; i<lines; i++) {
    E.setStitch(1, (i + 1) * 4, 0);

    //float x = pow(ay,i) + 10;
    float x = i * 7 + 250;
    float y2 = 490;
    E.beginRepeatEnd(3); 
    E.line(x,10,x,y2);
    E.endRepeatEnd();
  }
}
