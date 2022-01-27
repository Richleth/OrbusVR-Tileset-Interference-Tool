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
void addGuiButtonsFromFile() {
  addGuiButtonsFromFileContent();
  while (line2 != null) {
    addGuiButtonsFromFileContent();
  }
}
void addGuiButtonsFromFileContent() {
  try {
    line2 = reader2.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line2 == null) {
    // Stop reading because of an error or file is empty
  } else {
    try {
      String[] pieces = splitTokens(line2, "|_");

      if (pieces[0].equals("Example")) {
        //Checking to see if line2 is an example or not
      } else {

        for (int i = 14; i < pieces.length; i+=2) {
          verts.add(new int[]{int(pieces[i]), int(pieces[i+1])});
        }
        int[][] vertsConvert = new int[verts.size()][2];
        for (int i = 0; i < verts.size(); i++) {
          vertsConvert[i] = verts.get(i);
        }
        verts.clear();
        //min 14
        BehaviorFactory factory = new BehaviorFactory(pieces[13]);
        GuiElementBehavior behavior = factory.createBehavior(pieces[13]);
        color[] colors = {color(unhex(pieces[6])), color(unhex(pieces[7])), color(unhex(pieces[8]))};
        guiController.createGuiElement(new int[] {int(pieces[0]), int(pieces[1]), int(pieces[2]), int(pieces[3]), int(pieces[4]), 
          id}, pieces[5], colors, boolean(pieces[9]), boolean(pieces[10]), 
          boolean(pieces[11]), boolean(pieces[12]), behavior, vertsConvert);
        id++;
      }
    } 
    catch (ArrayIndexOutOfBoundsException e) {
      e.printStackTrace();
    }
  }
}
