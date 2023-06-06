import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

void setup() {
  noLoop(); 

  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  //float mm = 10;

  //int almost4Inches = 916;
  size (1260, 1100);

  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "machine_test";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  // JEF
  String outputFilePath = jefSetup(fileName);
  // SVG
  // String outputFilePath = svgSetup(fileName);
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();

  draw();
  
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

// configures for svg, returns svg output file path
public String svgSetup(String filename) {

  // PLOTTER-SPECIFIC COMMANDS: 
  // Set this to false so that there aren't superfluous waypoints on straight lines:
  E.toggleResample(false);
  // Set this to false so that there aren't connecting lines between shapes. 
  // Note that you'll still be able to pre-visualize the connecting lines 
  // (the plotter path) if you set E.visualize(true, true, true);
  E.toggleConnectingLines(false);
  // This affects the visual quality of inset/offset curves for CONCENTRIC fills:
  E.CONCENTRIC_ANTIALIGN = 0.0;
  return sketchPath(filename + ".svg");
}

// returns jef output file path
public String jefSetup(String filename) {
    return sketchPath(filename + ".jef");
}

void draw() {
  E.noFill();
  E.strokeWeight(44);
  E.strokeSpacing(2.0);
  E.setStitch(5,66,0);
  E.PERPENDICULAR_STROKE_CAP_DENSITY_MULTIPLIER = 0.4;

  E.strokeMode(E.ANGLED);

  float ay = 50; 
  int nCurves = 7;
  for (int i=0; i<nCurves; i++) {
    float ax = map(i, 0, (nCurves-1), 0+50, width-200-50);
    float sa = map(i, 0, (nCurves-1), 30, -30); 
    println(sa);
    E.strokeAngleDeg(sa);
    
    E.stroke(0,0,i);

    E.beginShape();
    E.vertex(ax, ay);
    E.quadraticVertex(ax+075, ay+025, ax+100, ay+200);
    E.quadraticVertex(ax+125, ay+375, ax+200, ay+400);
    E.endShape();
  }
}
