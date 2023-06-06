import java.util.Date;

import processing.embroider.*;
PEmbroiderGraphics E;

String projectTitle = "sampler";
Date d = new Date();
String fileName = "./output/" + projectTitle + "_" + d.getTime();

void setup() {
  noLoop(); 
  
  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  //float mm = 10;

  //int almost4Inches = 916;
  size(2400,2000); // M1
  // size (1260, 1100); // M2
  //size(500, 500); // M3

  E = new PEmbroiderGraphics(this, width, height);
  
  // JEF
  String outputFilePath = jefSetup(fileName);
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  E.strokeWeight(1); 
  E.fill(0, 0, 0); 
  E.noStroke(); 

  draw();
  

}

// returns jef output file path
public String jefSetup(String filename) {
    return sketchPath(filename + ".jef");
}

// End of boilerplate ---------------------------
int[] hatchModes = {
    PEmbroiderGraphics.PERLIN,
    PEmbroiderGraphics.CROSS,
    PEmbroiderGraphics.PARALLEL,
    PEmbroiderGraphics.CONCENTRIC,
    PEmbroiderGraphics.SPIRAL,
  };

public int randomArrayItem(int[] array) {
  int index = (int)random(array.length);
  int item = array[index];
  return item;
}

int count = 25;
int[][] colors = {{255,0,0}, {255,127,0},{255,255,0},{0,255,0},{0,0,255},{75,0,130},{148,0,211}};

void draw() {
  
  E.beginCull(); // for random
  for (int i = 0; i < count; i++) {
    int colorIndex = int(random(colors.length));
    println(colors, colorIndex);
    int[] fill = colors[colorIndex];
    
    E.fill(fill[0], fill[1], fill[2]);

    int angle = int(random(0,360));
    E.hatchAngle(radians(angle));
    E.hatchMode(randomArrayItem(hatchModes));
    E.hatchSpacing(random(10,30));// 5-15, 10-30 for pes
    E.circle(random(width), random(height), random(200, 750));
  }
  
  // border
  E.strokeMode(E.TANGENT);
  E.strokeWeight(10); 
  E.strokeSpacing(1);
  E.stroke(0, 0, 0);
  E.noFill();
  E.rect(0, 0, width, height);

  E.endCull(); // for random
  
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  save(fileName + ".png");
}
