void keyPressed() {
  switch(key) {
  case 'q':
  case 'Q':
    brushSize +=5;
    break;
  case 'a':
  case 'A':
    brushSize -=5;
    break;
  case 'w':
  case 'W':
    window +=5;
    break;
  case 's':
  case 'S':
    window -=5;
    break;
  case 'k':
  case 'K':
    enallaX = abs(enallaX - 1);
    break;
  case 'l':
  case 'L':
    enallaY = abs(enallaY - 1);
    break;
  case 'c':
  case 'C':
    clear();
    break;
  case 'e':
  case 'E':
    shapes = (shapes+1)%5;
    break;
  case 'd':
  case 'D':
    shapes--;
    if(shapes < 0) shapes =4;
    break;
  case 'r':
  case 'R':
    maxSize += 5;
    break;
  case 'f':
  case 'F':
    maxSize -= 5;
    break;
  case 't':
  case 'T':
    rotAngle += radians(15);
    break;
  case 'g':
  case 'G':
    rotAngle -= radians(15);
    break;
//  case 'z':
//    //    gridSizeX = 160;
//    //    gridSizeY = 120;
//    gLines.clear();
//    setup();
//    break;
  case 'p':
  case 'P':
    printDXF = true;
    break;
  case 'u':
  case 'U':
    undo();
    break;
  case 'x':
  case 'X':
    drawText = !drawText;
    break;
  }
}
void mousePressed() {
  addHistory = 1;
}
void mouseReleased() {
  addHistory = 0;
 // gLines.get(gLines.size()-1).endLine();
  //gLines.add();
}

