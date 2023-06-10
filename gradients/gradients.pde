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
  //E.visualize(true, true, true); // color, stitches, route
  E.visualize(true,true,true);
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

void draw() {
  int resolution = 10;
  int cols = width/resolution;
  float rows = height/resolution;

  E.noFill();
  E.stroke(0,0,0);

  for (int i = 0; i < cols; i++) {
      int colorIndex = getColorIndex(i,resolution);
      setStroke(colorIndex);
    for (int j = 0; j < rows; j++) {

    
      E.pushMatrix();
      E.translate(i*resolution,j*resolution);
      
      float x = random(-resolution,resolution);
      float halfRes = resolution/2;
      float y1 = floor(random(-1 * halfRes, halfRes));
      E.line(x,y1,x,resolution);
      E.popMatrix();
    }
  }
}

int getColorIndex(int i, int resolution) {
  float rows = height/resolution;
  int colorChunkSize = ceil(rows/colors.length); // gotta be better name
  int remainder = i%colorChunkSize;
  int r = floor(random(0,2));
  int defaultIndex = ceil(i/colorChunkSize);
  if (remainder <= colorChunkSize/3) {
    // random btwn last and current
    println(1,r);
    return defaultIndex == 0 ? defaultIndex : defaultIndex - r;
  } else if (colorChunkSize/3 < remainder && remainder < (colorChunkSize/3 * 2)) {
    println(2,r);
    return defaultIndex;
  } else {
    println(3,r);
    // random btwn current and next
    return defaultIndex == colors.length ? defaultIndex : defaultIndex + r;
  } 
}

void setStroke(int colorIndex) {
  int[] c = colors[colorIndex];
  E.stroke(c[0],c[1],c[2]);
}
