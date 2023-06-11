import java.util.Date;
import processing.embroider.*;

PEmbroiderGraphics E;
FlowField flowfield;

int[][] colors = {{255,0,0}, {255,127,0},{255,255,0},{0,255,0},{0,0,255},{75,0,130},{148,0,211}};

void setup() {
  noLoop(); 

  // M1: 240x200mm, 9.4x7.9in, 2400x2000
  // M2: 126x110mm, 5x4.3in, 1260x1100
  // M3: 50x50mm,  2x2in, 500x500

  //float mm = 10;

  size (1260, 1100); // M2
  // size(500, 500); // M3

  E = new PEmbroiderGraphics(this, width, height);
  
  String projectTitle = "flow_field";
  Date d = new Date();
  String fileName = "./output/" + projectTitle + "_" + d.getTime();
  
  flowfield = new FlowField();
  
  String outputFilePath = jefSetup(fileName);
  
  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();

  draw();
  
  E.optimize(); // slow, but good and important
  E.visualize(true,true,true); //show color
  E.endDraw(); // write out the file
  save(fileName + ".png");
}

// returns jef output file path
public String jefSetup(String filename) {
    return sketchPath(filename + ".jef");
}

// https://discourse.processing.org/t/flow-fields-code/34592/3
// https://natureofcode.com/book/chapter-6-autonomous-agents/
class FlowField {
  PVector[][] field;
  int cols, rows;
  int resolution;
  int offset;


  FlowField() {
    resolution = 30;
    cols = width / resolution;
    rows = height / resolution;
    field = new PVector[cols][rows];

    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
        field[i][j] = new PVector(cos(theta), sin(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }

  // Draw every vector
  void display() {
    for (int i = 0; i < cols; i++) {
      int index = i%colors.length;
      int[] c  = colors[index];
      E.stroke(c[0], c[1], c[2]);
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution);
      }
    }
  }//

  // Renders a vector object 'v' as an arrow and a position 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    E.pushMatrix();
    // Translate to position to render vector
    E.translate(x, y);
    // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
    E.rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;

    E.beginRepeatEnd(2);
    E.line(0, 0, len, 0);
    E.endRepeatEnd();
    E.popMatrix();
  }
}

void draw() {
  E.noFill();
  //E.strokeWeight(10);
  //E.strokeSpacing(2);
  //E.setStitch(5,66,0);
  E.setStitch(1,2,0);
  //E.PERPENDICULAR_STROKE_CAP_DENSITY_MULTIPLIER = 0.4;
  
  flowfield.display();
}
