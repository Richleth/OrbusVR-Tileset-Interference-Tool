void InitLayout() {
  TEXTBOX receiver = new TEXTBOX();
  receiver.W = 500;
  receiver.H = 35;
  receiver.X = 125;
  receiver.trueX = 125;
  receiver.Y = 50;
  textboxes.add(receiver);
}
void drawDropdownMenu() {
  if (nameDropdownMenuOpen) {
    try {
      if (readyToParse == false) {
        println("---Not Ready To Parse---");
      }
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
      println("CATCH IO");
    }
    if (line == null) {
      if (readyToParse == false) {
        frameRate(90);
        println("---Ready To Parse---");
        readyToParse = true;
      }
    } else {
      //Below code allows for dynamic adding of names to a list
      sameName = false;
      String[] pieces = split(line, " "); 
      println("Entered");
      if (pieces.length >= 7) {
        println("Length Check Success");
        if (pieces[pieces.length-1].equals("(Critical)")) {
          println("length - 1 check");
          addNames(pieces, 2);
        } else if (pieces[1].equals("[Combat]") && ((pieces[pieces.length-2].equals("from") && pieces[pieces.length-3].equals("damage")) || pieces[pieces.length-2].equals("damage"))) {
          println("fallback");
          addNames(pieces, 1);
        }
      }
    }
  }
}
void addNames(String[] pieces, int arrayIndex) {
  String[] subPieces = split(pieces[pieces.length-arrayIndex], "(");
  if (subPieces.length == 1) {
    println("Success 2a");
    for (int i = 0; i < names.size(); i++) {
      if (subPieces[0].equals(names.get(i))) {
        sameName = true;
        println("SameName");
        break;
      }
    }
    if (!sameName) {
      println("Success 3a");
      try {
        names.add(subPieces[0]);
        cp5.get(ScrollableList.class, "dropdown").clear();
        cp5.get(ScrollableList.class, "dropdown").addItems(names);
      } 
      catch (UnsupportedOperationException e) {
        e.printStackTrace();
      }
    }
  }
} 
