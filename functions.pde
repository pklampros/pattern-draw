void undo() {
  dS.undo();
  for (int i = 1; i<gridSizeX; i++) {
    for (int j = 1; j < gridSizeY; j++) {
        shapeArray0[i][j].sz = dS.reCalc(shapeArray0[i][j].c);
        shapeArray1[i][j].sz = dS.reCalc(shapeArray1[i][j].c);
        shapeArray2[i][j].sz = dS.reCalc(shapeArray2[i][j].c);
        shapeArray3[i][j].sz = dS.reCalc(shapeArray3[i][j].c);
    }
  }
}
void clear() {
  dS.clear();
  for (int i = 1; i<gridSizeX; i++) {
    for (int j = 1; j < gridSizeY; j++) {
        shapeArray0[i][j].sz = 0;
        shapeArray1[i][j].sz = 0;
        shapeArray2[i][j].sz = 0;
        shapeArray3[i][j].sz = 0;
    }
  }
}
void scRect(int x,int y,int w,int h) {
  rect(drawScale*x,drawScale*y,drawScale*w,drawScale*h);
}
