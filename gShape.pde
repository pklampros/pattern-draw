class panel {
}
class gShape {
  float sz = 0;
  float asz = 0;
  float msz = 0;
  PVector c = new PVector(0, 0);
  int i, j;
  gShape(float saiz, int type, PVector cent, float maxSize, int indexI, int indexJ) {
    sz = saiz;
    msz = maxSize;
    c = cent.get();
    i = indexI;
    j = indexJ;
  }
  void grow() {
    sz +=asz;
    asz = 0;
  }
  void draw() {
    drawShape(c, sz, j);
  }
  void drawShape(PVector c, float sz, int j) {
   switch(shapes) {
     case 0:
     tri(c, sz+asz, j,i);
     break;
     case 1:
     rec(c, sz+asz,j,i);
     break;
     case 2:
     penta(c, sz+asz, j,i);
     break;
     case 3:
     hexa(c, sz+asz, j,i);
     break;
     case 4:
     circ(c, sz+asz,j,i);
     break;
   }
  }
  void rec(PVector c, float sz,int u, int v) {
    if (sz > msz) sz = msz; 
    if (sz > 0.01)
      rect(c.x + enallaX*(u%2)*msz*0.5, c.y + enallaY*(v%2)*msz*0.5, sz, sz);
  }
  void circ(PVector c, float sz,int u, int v) {
    if (sz > msz) sz = msz; 
    if (sz > 0.01)
      ellipse(c.x + enallaX*(u%2)*msz*0.5, c.y + enallaY*(v%2)*msz*0.5, sz, sz);
  }
  void penta(PVector c, float sz, int u, int v) {
    if (sz > msz) sz = msz; 
    if (sz > 0.01) {
      int sides = 5;                                            
      float angle = 2*PI / sides;    
      beginShape();                                                    
      for (int i = 0; i < sides; i++) {
        float x = c.x + enallaX*(u%2)*msz*0.5 + cos(HALF_PI + enallaX*(u%2)*rotAngle + enallaY*(v%2)*rotAngle + (i * angle)) * (sz/2);
        float y = c.y + enallaY*(v%2)*msz*0.5 + sin(HALF_PI + enallaX*(u%2)*rotAngle + enallaY*(v%2)*rotAngle + (i * angle)) * (sz/2);
        vertex( x, y);
      }
      endShape(CLOSE);
    }
  }
  void hexa(PVector c, float sz, int u, int v) {
    if (sz > msz) sz = msz; 
    if (sz > 0.01) {
      int sides = 6;                                            
      float angle = 2*PI / sides;    
      beginShape();                                                    
      for (int i = 0; i < sides; i++) {
        float x = c.x + enallaX*(u%2)*msz*0.5 + cos(HALF_PI + (i * angle)) * (sz/2);
        float y = c.y + enallaY*(v%2)*msz*0.5 + sin(HALF_PI +  (i * angle)) * (sz/2);
        vertex( x, y);
      }
      endShape(CLOSE);
    }
  }
  void tri(PVector c, float sz, int u, int v) {
    if (sz > msz) sz = msz; 
    if (sz > 0.01) {
      int sides = 3;                                            
      float angle = 2*PI / sides;    
      beginShape();                                                    
      for (int i = 0; i < sides; i++) {
        float x = c.x + enallaX*(u%2)*msz*0.5 + cos(HALF_PI + enallaX*(u%2)*rotAngle + enallaY*(v%2)*rotAngle + (i * angle)) * (sz/2);
        float y = c.y + enallaY*(v%2)*msz*0.5 + sin(HALF_PI + enallaX*(u%2)*rotAngle + enallaY*(v%2)*rotAngle +  (i * angle)) * (sz/2);
        vertex( x, y);
      }
      endShape(CLOSE);
    }
  }
}
class gLine {
  ArrayList<PVector> trail = new ArrayList<PVector>();
  int bS, win;
  gLine(int brushSize, int window) {
    bS = brushSize;
    win = window;
  }
}
class fLine {
  PVector [] trail;
  int bS, win;
  fLine(int brushSize, int window, PVector [] history) {
    bS = brushSize;
    win = window;
    trail = history;
  }
  float returnSize(PVector p) {
    float f = 0;
    float d;
    int inBrush = 0;
    for (int k = 0 ; k < trail.length; k++) {
      d = dist(trail[k].x, trail[k].y, p.x, p.y);
      if (d < bS && inBrush == 0) inBrush = 1;
      if (inBrush == 1) f += exp(-sq(d) / (2*sq(win)));
    }
    if (inBrush == 0) f = 0;
    return f;
  }
  void draw() {
    for (int k = 1; k < trail.length; k++) 
      if (trail[k-1].z != 0)
        line(trail[k].x, trail[k].y, trail[k-1].x, trail[k-1].y);
  }
}
class drawSystem {
  ArrayList<fLine> fLines = new ArrayList<fLine>();
  ArrayList<PVector> current = new ArrayList<PVector>();
  int drawing = 0;
  int bS;
  int win;
  //gLine current = new gLine();

  int isClosed = 0;
  drawSystem() {
  }
  void addLine() {
  }
  void call(int addHistory) {
    if (addHistory == 1) extend();
    else if (drawing == 1) endLine();
  }
  void extend() {
    drawing = 1;
    //if (current.isClosed == 1) fLines.add(new fLine(brushSize, window));
    //else gLines.get(gLines.size()-1).extend();


    int k2=current.size()-1;
    if (k2 == -1) current.add(new PVector(mX, mY, 1));
    else
      if (dist(current.get(k2).x, current.get(k2).y, mX, mY) > 10) 
        current.add(new PVector(mX, mY, 1));
  }
  void endLine() {
    drawing = 0;
    //    if (current.size()-1 > -1) current.get(current.size()-1).z = 0;
    //    isClosed = 1;
    fLines.add(new fLine(brushSize, window, getCurrent()));
    current.clear();
  }
  PVector [] getCurrent() {
    PVector [] ptz = new PVector[current.size()];
    for (int i = 0; i<current.size(); i++ ) ptz[i] = current.get(i);
    return ptz;
  }
  float reCalc(PVector p) {
    float f = 0;
    for (int k = 0 ; k < fLines.size(); k++) {
      f+= fLines.get(k).returnSize(p);
    }
    return f;
  }
  float getSize(PVector p) {
    float f = 0;
    float d = 0;
    int inBrush = 0;
    bS = brushSize;
    win = window;
    for (int k = 0 ; k < current.size(); k++) {
      d = dist(current.get(k).x, current.get(k).y, p.x, p.y);
      if (d < bS && inBrush == 0) inBrush = 1;
      if (inBrush == 1) f += exp(-sq(d) / (2*sq(win)));
    }
    if (inBrush == 0) f = 0;
    return f;
  }
  void draw() {
    stroke(0, 0, 255);
    for (int i = 0; i < fLines.size(); i++) fLines.get(i).draw();
    stroke(255, 0, 0, 100);
    for (int k = 1; k < current.size(); k++) 
      if (current.get(k-1).z != 0)
        line(current.get(k).x, current.get(k).y, current.get(k-1).x, current.get(k-1).y);
  }
  void clear() {
    fLines.clear();
  }
  void undo() {
    if(fLines.size() > 0 ) fLines.remove(fLines.size()-1);
  }
}

