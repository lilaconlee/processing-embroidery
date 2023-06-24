import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;
int[][] colors = {{255,0,0}, {255,127,0},{255,255,0},{0,255,0},{0,0,255},{75,0,130},{148,0,211}};
//int[][] colors = {{0,0,255},{0,255,0},{255,0,0}};

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
  
  String projectTitle = "spiral";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  String fileExt = "pes"; // jef, dst, pes, svg
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

void setColor(float p) {
  //color col = lerpColor(color(0),color(1),p);
  int colorIndex = floor(lerp(0,colors.length - 1,p));
  int[] col = colors[colorIndex];
  E.stroke(col[0], col[1], col[2]);
  E.fill(col[0], col[1], col[2]);
  //E.stroke(0,0,0);
  //E.fill(0,0,0);
}

//void setColor(int colorIndex) {
//  int[] c = colors[colorIndex];
//  E.stroke(c[0],c[1],c[2]);
//  E.fill(c[0],c[1],c[2]);
//}

void draw() {
  E.setStitch(50,10,.5);
  E.strokeWeight(1); 
  int count = 15;
  float t = random(1);
  E.hatchMode(E.SPIRAL);
  E.hatchSpacing(8);
  E.beginCull();
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      float x = map(i,0,count-1,20,width-20);
      float y = map(j,0,count-1,20,height-20);
      
      float offset = 0.003*dist(x,y,width/2,height/2) + atan2(y-width/2,x-width/2)/TWO_PI;
      float changeParameter = map(sin(TWO_PI*(t-offset)),-1,1,0,1);
      setColor(changeParameter);
      if (floor(random(2)) == 1) {
        println(1);
        E.setSpiralDirection(E.CCW);
      } else {
        println(0);
        E.setSpiralDirection(E.CW);
      }
      
      E.circle(x,y,50);
    }
  }
  E.endCull();
}
