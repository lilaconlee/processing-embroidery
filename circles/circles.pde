import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

int[][] colors = {{255,0,0}, {255,127,0},{255,255,0},{0,255,0},{0,0,255},{75,0,130},{148,0,211}};

int getColorIndex(int i, int resolution) {
  float rows = height/resolution;
  int colorChunkSize = ceil(rows/colors.length); // gotta be better name
  int remainder = i%colorChunkSize;
  int r = floor(random(0,2));
  int defaultIndex = floor(i/colorChunkSize);
  return floor(random(colors.length));
  //if (remainder <= colorChunkSize/3) {
    // random btwn last and current
  //  println(1,r);
  //  return defaultIndex == 0 ? defaultIndex : defaultIndex - r;
  //} else if (colorChunkSize/3 < remainder && remainder < (colorChunkSize/3 * 2)) {
  //  println(2,r);
  //  return defaultIndex;
  //} else {
  //  println(3,r,defaultIndex);
  //  // random btwn current and next
  //  return defaultIndex + r >= colors.length ? defaultIndex : defaultIndex + r;
  //} 
}

void setStroke(int colorIndex) {
  int[] c = colors[colorIndex];
  E.stroke(c[0],c[1],c[2]);
}

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
  
  String projectTitle = "circles";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String fileExt = "jef"; // jef, dst, pes, svg
  String outputFilePath = sketchPath(fileName + "." + fileExt);

  if (fileExt == "svg") {
    svgSetup();
  }
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();

  draw();
  
  E.optimize(); // slow, but good and important
  E.visualize(true, true, false); // color, stitches, route
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

void svgSetup() {
  // PLOTTER-SPECIFIC COMMANDS: 
  // Set this to false so that there aren't superfluous waypoints on straight lines:
  E.toggleResample(false);
  // Set this to false so that there aren't connecting lines between shapes. 
  // Note that you'll still be able to pre-visualize the connecting lines 
  // (the plotter path) if you set E.visualize(true, true, true);
  E.toggleConnectingLines(false);
  // This affects the visual quality of inset/offset curves for CONCENTRIC fills:
  E.CONCENTRIC_ANTIALIGN = 0.0;
}

// https://medium.com/@kuluum/drawing-wobbly-bobbly-lava-ball-21577ab6d559
void draw() { 
  E.setStitch(10, 25, 0);
  E.translate(width/2, height/2);
  E.noFill();

  int maxNoise = 10;
  int count = 40;
  for (int i = 0; i < count; i++) {
    E.beginShape();
    int colorIndex = getColorIndex(i,count);
    println(colorIndex);
    setStroke(colorIndex);
    for (float j = 0; j <= TWO_PI; j += PI/180) {
      float bobbleRate = 5;
      //float noise = map(noise(cos(j),sin(j)),0,1,-maxNoise,maxNoise);
      //float r = random(i-5,i+5) + noise;
      float xoff = map(cos(i), -1, 1, 0, bobbleRate);
      float yoff = map(sin(i), -1, 1, 0, bobbleRate);
      float noise = noise(xoff, yoff);
      //float noise = noise(cos(i),sin(i));
    
      float r = map(noise, 0, 1, 0, 300);
      println(r);
      float x = r * cos(j); 
      float y = r * sin(j);

      E.vertex(x, y);
    }
    E.endShape();
  }
}
