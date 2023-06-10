import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

String projectTitle = "gradients";


int[][] colors = {{255,0,0}, {255,127,0},{255,255,0},{0,255,0},{0,0,255},{75,0,130},{148,0,211}};
int mm = 10; // machine unit size

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
  //size (1260, 1100); // M2
  size(500, 500); // M3
  // size (916, 916); // 4x4
}

void setup() {
  noLoop(); 

  E = new PEmbroiderGraphics(this, width, height);
  
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
  //E.visualize();
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

void draw() {
  int gradientSize = 100 * mm;
  int stitchSize = mm/2;
  int pad = 10;
  
  E.noFill();
  
  int xStart = pad;
  int yStart = pad;
  int chunk = gradientSize/colors.length;
  //for(int i = yStart; i < gradientSize; i += stitchSize) {
  //  for (int j = xStart; j < gradientSize; j += 2) {
  //    setStroke(floor(i/chunk));
  //    // x1, y1, x2, y2
  //    E.line(j,i,j,i+stitchSize);
  //  }
  //}

  for(int i = yStart; i < gradientSize; i += stitchSize) {
    for (int j = gradientSize; j < gradientSize; j += 2) {
      setStroke(floor(i/chunk));
      // x1, y1, x2, y2
      E.line(j,i,j,i+stitchSize);
    }
  }
}

void setStroke(int colorIndex) {
  int[] c = colors[colorIndex];
  E.stroke(c[0],c[1],c[2]);
}
