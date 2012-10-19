import processing.opengl.*;

import processing.dxf.*;

int maxrezX = 1250;
int maxrezY = 625;
int gridSizeX = 50;
int gridSizeY = 25;
//int gridSizeX = 80;
//int gridSizeY = 60;

gShape [][] shapeArray0;
gShape [][] shapeArray1;
gShape [][] shapeArray2;
gShape [][] shapeArray3;
//ArrayList<PVector> history = new ArrayList<PVector>();
drawSystem dS = new drawSystem();
int addHistory;
boolean printDXF = false;
int crossSize = 10;
float mX, mY;

// USER VARS

int window = 150;
int maxSize = 80; //percentage of grid allowed
int brushSize = 200;
int enallaX = 0;
int enallaY = 0;
int shapes = 1;
float drawScale = 2;
float rotAngle = PI;
boolean drawText = true;

void setup() {
  size(maxrezX+20, maxrezY+60, OPENGL);
  hint(DISABLE_OPENGL_ERROR_REPORT);
  smooth();
  shapeArray0 = new gShape[gridSizeX][gridSizeY];
  for (int i = 0 ;i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      float cX = maxrezX*i/gridSizeX;
      float cY = maxrezY*j/gridSizeY;
      shapeArray0[i][j] = new gShape(0, 1, new PVector(cX, cY), (maxSize/100.00)*(maxrezX/gridSizeX), i, j);
    }
  }
  shapeArray1 = new gShape[gridSizeX][gridSizeY];
  for (int i = 0 ;i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      float cX = maxrezX + maxrezX*i/gridSizeX;
      float cY = maxrezY*j/gridSizeY;
      shapeArray1[i][j] = new gShape(0, 1, new PVector(cX, cY), (maxSize/100.00)*(maxrezX/gridSizeX), i, j);
    }
  }
  shapeArray2 = new gShape[gridSizeX][gridSizeY];
  for (int i = 0 ;i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      float cX = maxrezX*i/gridSizeX;
      float cY = maxrezY + maxrezY*j/gridSizeY;
      shapeArray2[i][j] = new gShape(0, 1, new PVector(cX, cY), (maxSize/100.00)*(maxrezX/gridSizeX), i, j);
    }
  }
  shapeArray3 = new gShape[gridSizeX][gridSizeY];
  for (int i = 0 ;i < gridSizeX; i++) {
    for (int j = 0; j < gridSizeY; j++) {
      float cX = maxrezX + maxrezX*i/gridSizeX;
      float cY = maxrezY + maxrezY*j/gridSizeY;
      shapeArray3[i][j] = new gShape(0, 1, new PVector(cX, cY), (maxSize/100.00)*(maxrezX/gridSizeX), i, j);
    }
  }



  cursor(CROSS);
  //history.add(new PVector(0, 0));
}
int temp = 0;
void draw() {

  translate(10, 30);
  scale(1/drawScale);
  mX = mouseX*drawScale;
  mY = mouseY*drawScale;
  background(255);
  stroke(100, 100);
  //  for(int i = 0; i < gridSizeX*2; i++) line(maxrezX*i/gridSizeX,0,maxrezX*i/gridSizeX,2*height);
  //  for(int j = 0; j < gridSizeY*2; j++) line(0,maxrezY*j/gridSizeY,2*width,maxrezY*j/gridSizeY);

  rectMode(CENTER);
  stroke(0);
  fill(0);

  dS.call(addHistory);
  //if (fLines.size() < 1) fLines.add(new gLine(brushSize, window));
  //else

  if (addHistory == 1) {
    temp = 1;
    for (int i = 1; i<gridSizeX; i++) {
      for (int j = 1; j < gridSizeY; j++) {
        shapeArray0[i][j].msz = (maxSize/100.00)*(maxrezX/gridSizeX);
        shapeArray1[i][j].msz = (maxSize/100.00)*(maxrezX/gridSizeX);
        shapeArray2[i][j].msz = (maxSize/100.00)*(maxrezX/gridSizeX);
        shapeArray3[i][j].msz = (maxSize/100.00)*(maxrezX/gridSizeX);
        shapeArray0[i][j].asz = dS.getSize(shapeArray0[i][j].c);
        shapeArray1[i][j].asz = dS.getSize(shapeArray1[i][j].c);
        shapeArray2[i][j].asz = dS.getSize(shapeArray2[i][j].c);
        shapeArray3[i][j].asz = dS.getSize(shapeArray3[i][j].c);
      }
    }
  }
  else if (temp == 1) {
    for (int i = 1; i<gridSizeX; i++) {
      for (int j = 1; j < gridSizeY; j++) {
        shapeArray0[i][j].grow();
        shapeArray1[i][j].grow();
        shapeArray2[i][j].grow();
        shapeArray3[i][j].grow();

        temp = 0;
      }
    }
  }

  if (printDXF) {
    beginRaw(DXF, "output.dxf");

    noFill();
    strokeWeight(1);
    beginShape();
    vertex(0, 0);
    vertex(1, 1);
    vertex(2, 2);
    endShape();
    line(0, 0, 1, 1);
  }
  if (enallaY == 0 && enallaX == 1) {
    for (int i = 1; i<gridSizeX; i++) {
      for (int j = 1; j < gridSizeY; j++) {
        if (i != gridSizeX-1 || (j%2)*enallaX != 1) {
          shapeArray0[i][j].draw();
          shapeArray1[i][j].draw();
          shapeArray2[i][j].draw();
          shapeArray3[i][j].draw();
        }
      }
    }
  }
  if (enallaX == 0 && enallaY == 1) {
    for (int i = 1; i<gridSizeX; i++) {
      for (int j = 1; j < gridSizeY; j++) {
        if (j != gridSizeY-1 || (i%2)*enallaY != 1) {
          shapeArray0[i][j].draw();
          shapeArray1[i][j].draw();
          shapeArray2[i][j].draw();
          shapeArray3[i][j].draw();
        }
      }
    }
  }
  if(enallaY == enallaX) {
    for (int i = 1; i<gridSizeX; i++) {
      for (int j = 1; j < gridSizeY; j++) {
          shapeArray0[i][j].draw();
          shapeArray1[i][j].draw();
          shapeArray2[i][j].draw();
          shapeArray3[i][j].draw();
        
      }
    }
  }
  rectMode(CORNER);
  noFill();
  stroke(0);
  rect(0, 0, maxrezX, maxrezY);
  rect(maxrezX, 0, maxrezX, maxrezY);
  rect(0, maxrezY, maxrezX, maxrezY);
  rect(maxrezX, maxrezY, maxrezX, maxrezY);
  rectMode(CENTER);
  if (printDXF) {
    endRaw();
    printDXF = false;
  }
  dS.draw();
  //for (int k = 0; k < gLines.size(); k++) gLines.get(k).draw();
  noStroke();
  fill(200, 150, 5, 50);
  ellipse(mX, mY, brushSize*2, brushSize*2);
  fill(5, 150, 200, 50);
  ellipse(mX, mY, window*2, window*2);
  stroke(0);
  line(mX-crossSize, mY, mX+crossSize, mY);
  line(mX, mY-crossSize, mX, mY+crossSize);
  //println(gLines.size());
  drawScreenText();
}

