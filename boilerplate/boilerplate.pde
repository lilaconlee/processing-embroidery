import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;

void setup() {
  noLoop(); 

 // 4x4 hoop
  int almost4Inches = 916;
  size (916, 916);

  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "boilerplate";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  // PES
  String outputFilePath = pesSetup(fileName);
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

// returns pes output file path
public String pesSetup(String filename) {
    return sketchPath(filename + ".pes");
}

void draw() {
  E.strokeWeight(1); 
  E.fill(0, 0, 0); 
  E.noStroke(); 
  E.circle (width/2, height/2, 150);
}
