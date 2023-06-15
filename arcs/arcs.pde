import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

int[][] colors = {{255,0,0}, {255,127,0},{255,255,0},{0,255,0},{0,0,255},{75,0,130},{148,0,211}};

void settings() {
  // janome mb-7
  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  // brother se400
  // 4x4 hoop: 100x100mm, 4x4in, 916x916
  // int almost4Inches = 916; // had issues with exactly 4x4

  // float mm = 10; // machine unit size
  // size(2400, 2000); // M1
  // size (1260, 1100); // M2
   size(500, 500); // M3
  // size (916, 916); // 4x4
}

void setup() {
  noLoop(); 

  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "arcs";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String fileExt = "jef"; // jef, dst, pes, svg
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
  E.setStitch(10, 25, 0);
  E.strokeWeight(1);

  int count = 300;
  for(int i = 0; i < count; i++) {
    setRandomStroke();
    int size = int(random(0,width));
    float start = random(0, TWO_PI);
    float end = random(0, TWO_PI);
    // x, y, width, height, start (radians), stop (radians)
    E.beginRepeatEnd(3);
    E.arc(width/2, height/2, size, size, start, end);
    E.endRepeatEnd();
  }
}

void setRandomStroke() {
  int colorIndex = floor(random(0,colors.length));
  setStroke(colorIndex);
}

void setStroke(int colorIndex) {
  int[] c = colors[colorIndex];
  E.stroke(c[0],c[1],c[2]);
}
