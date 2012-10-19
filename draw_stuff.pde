void drawScreenText() {                                             // --- // function adds text to a string and prints on screen

  fill(0);
  String showText = "";

  showText += "TO HIDE THIS WINDOW PRESS [ X ]\n\n";
  showText += "print to output.dxf [ P ]\n\n";
  showText += "--- Brush Size ---\n";
  showText += "+5 [ Q ]\n";
  showText += brushSize;
  showText += "\n";
  showText += "-5 [ A ]\n";
  showText += "\n--- Brush Pinch ---\n";
  showText += "+5 [ W ]\n";
  showText += window;
  showText += "\n";
  showText += "-5 [ S ]\n";

  showText += "\n--- Shape Type ---\n";
  showText += "+1 [ E ]\n";
switch(shapes) {
     case 0:
     showText += "0.Triangle\n";
     break;
     case 1:
     showText += "1.Rectangle\n";
     break;
     case 2:
     showText += "2.Pentagon\n";
     break;
     case 3:
     showText += "3.Hexagon\n";
     break;
     case 4:
     showText += "4.Circle\n";
     break;
   }
  showText += "-1 [ D ]\n";
  showText += "\n--- Shape Max Size ---\n";
  showText += "+5% [ R ]\n";
  showText += maxSize;
  showText += " %\n";
  showText += "-5% [ F ]\n";
  showText += "\n--- Shape Rotation ---\n";
  showText += "+15 [ T ]\n";
  showText += round(degrees(rotAngle));
  showText += " degrees\n";
  showText += "-15 [ G ]\n";
  showText += "\n\n";
  showText += "Toggle enallaX ( ";
  showText += enallaX;
  showText += " ) [ K ]\n";
  showText += "Toggle enallaY ( ";
  showText += enallaY;
  showText += " ) [ L ]\n";
  showText += "\n";
  showText += " Undo [ U ]\n";
  showText += " Clear [ C ]\n";
  showText += "\n\n--- Comments ---\n";
  showText += "should run much faster now...\n brush pinch is approximate\n max size a bit buggy";
  textMode(SCREEN);
  textAlign(RIGHT);
  rectMode(CORNER);
  if (drawText) {
    noStroke();
    fill(9, 200);
    pushMatrix();
    translate(0, -10);
    scRect(width-240, 0, 225, height-50);
    popMatrix();
    fill(255);
    text(showText, width-220, 40, 200, height-80);
  }
  else {
    fill(255,0,0);
    showText = "";
    showText += "Shape:";
    showText += "[P+] ";
    showText += shapes;
    showText += "    .    ";
    showText += "Enallax:";
    showText += "[E+] ";
    showText += enallaX;
    showText += "    .    ";
    showText += "Size:";
    showText += "[Q+] ";
    showText += brushSize;
    showText += " [-A]";
    showText += "    .    ";
    showText += "Pinch: ";
    showText += "[W+] ";
    showText += window;
    showText += " [-S]";
    showText += "    .    ";
    showText += "[ X ] to show all commands";

    text(showText, 0, 10, width-20, height-20);
  }
}

