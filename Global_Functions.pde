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
      frameRate(100);
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
        //println("fallback");
        addNames(pieces, 1);
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
        playerDropdown.get(ScrollableList.class, "Player_Chosen").clear();
        playerDropdown.get(ScrollableList.class, "Player_Chosen").addItems(names);
      } 
      catch (UnsupportedOperationException e) {
        e.printStackTrace();
      }
    }
  }
} 
void parseCombatLog() {
  if (!startAudioEffectPlayed) {
    startParseSfx.play();
    startAudioEffectPlayed = true;
  }
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
      frameRate(100);
      println("---Ready To Parse---");
      readyToParse = true;
    }
  } else {
    //Below code allows for dynamic adding of names to a list
    sameName = false;
    String[] pieces = split(line, " "); 
    if (pieces.length >= 7) {
      // println("Length Check Success");
      if (pieces[pieces.length-1].equals("(Critical)") && pieces[pieces.length-2].equals(nameChosen) && int(pieces[pieces.length-5]) > 0) {
        // println("length - 1 check");
        float damageWithoutCrit = float(pieces[pieces.length-5])/critDamagePlus;
        testDataController.newDataPoint(damageWithoutCrit, timer);
        //println(damageWithoutCrit);
      } else if (pieces[pieces.length-1].equals(nameChosen) && pieces[1].equals("[Combat]") && int(pieces[pieces.length-4]) > 0 && ((pieces[pieces.length-2].equals("from") && pieces[pieces.length-3].equals("damage")) || pieces[pieces.length-2].equals("damage"))) {
        //println("fallback");
        testDataController.newDataPoint(float(pieces[pieces.length-4]), timer);
        // println(float(pieces[pieces.length-4]));
      }
    }
  }
}
void parseCombatLogInit() { 
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
      frameRate(100);
      println("---Ready To Parse---");
      readyToParse = true;
    }
  } else {
    //Below code allows for dynamic adding of names to a list
    sameName = false;
    String[] pieces = split(line, " "); 
    if (pieces.length >= 7) {
      //println("Length Check Success");
      if (pieces[pieces.length-1].equals("(Critical)") && pieces[pieces.length-2].equals(nameChosen) && int(pieces[pieces.length-5]) > 0) {
        //println("length - 1 check");
        float damageWithoutCrit = float(pieces[pieces.length-5])/critDamagePlus;
        testDataController.newDataPoint(damageWithoutCrit, 1);
        //println(damageWithoutCrit);
        combatStarted = true;
      } else if (pieces[pieces.length-1].equals(nameChosen) && pieces[1].equals("[Combat]") && int(pieces[pieces.length-4]) > 0 && ((pieces[pieces.length-2].equals("from") && pieces[pieces.length-3].equals("damage")) || pieces[pieces.length-2].equals("damage"))) {
        //println("fallback");
        testDataController.newDataPoint(float(pieces[pieces.length-4]), 1);
        //println(float(pieces[pieces.length-4]));
        combatStarted = true;
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

        for (int i = 16; i < pieces.length; i+=2) {
          verts.add(new int[]{int(pieces[i]), int(pieces[i+1])});
        }
        int[][] vertsConvert = new int[verts.size()][2];
        for (int i = 0; i < verts.size(); i++) {
          vertsConvert[i] = verts.get(i);
        }
        verts.clear();
        //min 15
        BehaviorFactory factory = new BehaviorFactory(pieces[14]);
        GuiElementClickBehavior clickBehavior = factory.createClickBehavior(pieces[14]);
        GuiElementDisplayBehavior displayBehavior = factory.createDisplayBehavior(pieces[15]);
        color[] colors = {unhex(pieces[7]), unhex(pieces[8]), unhex(pieces[9])};
        guiController.createGuiElement(new int[] {int(pieces[0]), int(pieces[1]), int(pieces[2]), int(pieces[3]), int(pieces[4]), 
          id}, pieces[5], int(pieces[6]), colors, boolean(pieces[10]), boolean(pieces[11]), 
          boolean(pieces[12]), boolean(pieces[13]), clickBehavior, displayBehavior, vertsConvert);
        id++;
      }
    } 
    catch (ArrayIndexOutOfBoundsException e) {
      e.printStackTrace();
    }
  }
}
JSONObject newData() {
  JSONObject damageData = testDataController.returnFloatLists();
  JSONObject controlData = damageData;
  controlData.setString("playerName", nameChosen);
  controlData.setFloat("controlDpsResult", avgDps);
  controlData.setFloat("testDpsResult", avgDps);
  controlData.setJSONArray("testDpsData", damageData.getJSONArray("testDpsData"));
  controlData.setJSONArray("controlDpsData", damageData.getJSONArray("controlDpsData"));

  /*
  Using wrong keys? NEEDS TO BE TESTED
   JSONArray damageDataToReturn = new JSONArray();
   JSONArray frameDataToReturn = new JSONArray();
   JSONArray controlDpsDataToReturn = new JSONArray();
   JSONArray testDpsDataToReturn = new JSONArray();
   
   */

  //Need to calculate data varience here
  controlData.setJSONArray("controlDpsSecondData", damageData.getJSONArray("controlDpsSecondData"));
  controlData.setJSONArray("testDpsSecondData", damageData.getJSONArray("testDpsSecondData"));
  controlData.setJSONArray("damagesDelt", damageData.getJSONArray("damagesDelt"));
  //println(controlData.getJSONArray("damagesDelt"));
  controlData.setJSONArray("frameDamageDelt", damageData.getJSONArray("frameDamageDelt"));

  double testVarience = 0; // Potentially do varience on the AVG Dps values instead || SWAPPED TO AVG DPS VALUES, NEEDS TESTING
  double controlVarience = 0;
  //Control Varience
  if (controlParse) {
    for (int i = 0; i < controlData.getJSONArray("controlDpsData").size(); i++) { 
      controlVarience += ((controlData.getJSONArray("controlDpsData").getFloat(i) - avgDps)*(controlData.getJSONArray("controlDpsData").getFloat(i) - avgDps));
    }
    controlVarience /= controlData.getJSONArray("controlDpsData").size();
  }
  //Test Varience
  if (testParse) {
    for (int i = 0; i < controlData.getJSONArray("testDpsData").size(); i++) { 
      testVarience += ((controlData.getJSONArray("testDpsData").getFloat(i) - avgDps)*(controlData.getJSONArray("testDpsData").getFloat(i) - avgDps));
    }
    testVarience /= controlData.getJSONArray("testDpsData").size();
  }
  try {
    cStandardDeviation = sqrt((float)controlVarience);
    controlData.setDouble("controlDataVarience", controlVarience); // ARRAY IN ARRAY LIKE [[]] NEEDS TO BE OJBECT IN ARRAY [{}]
  } 
  catch (RuntimeException e) {
  }
  try {
    tStandardDeviation = sqrt((float)testVarience);
    controlData.setDouble("testDataVarience", testVarience);
  } 
  catch (RuntimeException e) {
  }
  println();
  println("control "+controlVarience);
  println("test "+testVarience);


  controlData.setJSONObject("tilesets", new JSONObject()); //TO BE IMPLEMENTED LATER
  println(controlData);
  return controlData;
}

void graphModeDps() {
  if (graphMode) {
    //graph.setDim(width-100, height/4);
    graph.setPoints(points1a);
    graph.getLayer("layer 1").setPoints(points1b);
    float[] pointSizes1 = new float[points1a.getNPoints()];
    float[] pointSizes2 = new float[points1b.getNPoints()];
    //for (int i = 0; i < points1b.getNPoints()-10; i++) {
    //  pointSizes2[i] = 0;
    //}
    graph.setPointSizes(pointSizes1);
    graph.getLayer("layer 1").setPointSizes(pointSizes2);
    graph.beginDraw();
    graph.drawBox();
    graph.drawXAxis();
    graph.drawYAxis();
    graph.drawTopAxis();
    graph.drawRightAxis();
    graph.drawTitle();
    graph.drawGridLines(GPlot.BOTH);
    String[] legendNames = {"Control Parse", "Test Parse"};
    float[] pos1 = {0.07, 0.30};
    float[] pos2 = {0.92, 0.92};
    graph.drawLegend(legendNames, pos1, pos2);
    //graph.drawFilledContours(GPlot.HORIZONTAL, 0.05);
    graph.drawPoints();
    graph.drawLines();
    //graph.drawPoint(new GPoint(65, 1.5), mug);
    //graph.drawPolygon(polygonPoints, p.color(255, 200));
    graph.drawLabels();
    graph.endDraw();
  } else {
  }
}
void graphModePercent() {
  if (graphMode) {
    //graph.setDim(width-100, height/4);
    graph2.setPoints(points2a);
    float[] pointSizes1 = new float[points2a.getNPoints()];
    //for (int i = 0; i < points1b.getNPoints()-10; i++) {
    //  pointSizes2[i] = 0;
    //}
    graph2.setPointSizes(pointSizes1);
    graph2.beginDraw();
    graph2.drawBox();
    graph2.drawXAxis();
    graph2.drawYAxis();
    graph2.drawTopAxis();
    graph2.drawRightAxis();
    graph2.drawTitle();
    graph2.drawGridLines(GPlot.BOTH);
    //graph.drawFilledContours(GPlot.HORIZONTAL, 0.05);
    graph2.drawPoints();
    graph2.drawLines();
    //graph.drawPoint(new GPoint(65, 1.5), mug);
    //graph.drawPolygon(polygonPoints, p.color(255, 200));
    graph2.drawLabels();
    graph2.endDraw();
  } else {
  }
}
void calculateGraphPoints(PlayerDataElement dataElement) {
  try { // METHOD NEEDS FURTHER TESTING
    if (dataElement.returnAllObjectData().getJSONArray("controlDpsSecondData").size() < 1 || dataElement.returnAllObjectData().getJSONArray("testDpsSecondData").size() < 1) {
      //Method uses exact numbers saved when determining avg dps values
      GPointsArray tempPoints1a = new GPointsArray();
      GPointsArray tempPoints1b = new GPointsArray();
      GPointsArray tempPoints2a = new GPointsArray();
      float[] controlDpsNumbers = new float[dataElement.returnAllObjectData().getJSONArray("controlDpsData").size()];
      float[] testDpsNumbers = new float[dataElement.returnAllObjectData().getJSONArray("testDpsData").size()];
      for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("controlDpsData").size(); i++) {
        float xPosValue = dataElement.returnAllObjectData().getJSONArray("controlDpsSecondData").getFloat(i)/timerConstant;
        controlDpsNumbers[i] = dataElement.returnAllObjectData().getJSONArray("controlDpsData").getFloat(i);
        tempPoints1a.add(new GPoint(xPosValue, dataElement.returnAllObjectData().getJSONArray("controlDpsData").getFloat(i))); //Control Whole DPS Graph Point
      }
      for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("testDpsData").size(); i++) {
        float xPosValue = dataElement.returnAllObjectData().getJSONArray("testDpsSecondData").getFloat(i)/timerConstant;
        testDpsNumbers[i] = dataElement.returnAllObjectData().getJSONArray("testDpsData").getFloat(i);
        tempPoints1b.add(new GPoint(xPosValue, dataElement.returnAllObjectData().getJSONArray("testDpsData").getFloat(i))); //Test Whole DPS Graph Point
      }
      if (controlDpsNumbers.length < testDpsNumbers.length) {
        for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("controlDpsData").size(); i++) {
          float xPosValue = dataElement.returnAllObjectData().getJSONArray("testDpsSecondData").getFloat(i)/timerConstant;
          float testDpsNumber = testDpsNumbers[i];
          float controlDpsNumber = controlDpsNumbers[i];
          float percentIncrease = ((testDpsNumber-controlDpsNumber)/abs(controlDpsNumber))*100;
          tempPoints2a.add(new GPoint(xPosValue, percentIncrease)); //Percent Increase Over Control Point
        }
      } else {
        for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("testDpsData").size(); i++) {
          float xPosValue = dataElement.returnAllObjectData().getJSONArray("testDpsSecondData").getFloat(i)/timerConstant;
          float testDpsNumber = testDpsNumbers[i];
          float controlDpsNumber = controlDpsNumbers[i];
          float percentIncrease = ((testDpsNumber-controlDpsNumber)/abs(controlDpsNumber))*100;
          tempPoints2a.add(new GPoint(xPosValue, percentIncrease)); //Percent Increase Over Control Point
        }
      }
      points1a.removeRange(0, points1a.getNPoints());
      points1b.removeRange(0, points1b.getNPoints());
      points2a.removeRange(0, points1a.getNPoints());
      points1a = tempPoints1a;
      points1b = tempPoints1b;
      points2a = tempPoints2a;
    }
  } 
  catch(NullPointerException e) {
    // Old aprox method that avgs each point's x value based of # of points devided by timerConstant
    float graphXAxisIncrement1a = timerConstant/dataElement.returnAllObjectData().getJSONArray("controlDpsData").size();
    float graphXAxisIncrement1b = timerConstant/dataElement.returnAllObjectData().getJSONArray("testDpsData").size(); //Deviding the timer by the num of elements gives the avg elements per second
    GPointsArray tempPoints1a = new GPointsArray();
    GPointsArray tempPoints1b = new GPointsArray();
    GPointsArray tempPoints2a = new GPointsArray();
    float[] controlDpsNumbers = new float[dataElement.returnAllObjectData().getJSONArray("controlDpsData").size()];
    float[] testDpsNumbers = new float[dataElement.returnAllObjectData().getJSONArray("testDpsData").size()];
    for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("controlDpsData").size(); i++) {
      controlDpsNumbers[i] = dataElement.returnAllObjectData().getJSONArray("controlDpsData").getFloat(i);
      tempPoints1a.add(new GPoint(i*graphXAxisIncrement1a, dataElement.returnAllObjectData().getJSONArray("controlDpsData").getFloat(i))); //Control Whole DPS Graph Point
    }
    for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("testDpsData").size(); i++) {
      testDpsNumbers[i] = dataElement.returnAllObjectData().getJSONArray("testDpsData").getFloat(i);
      tempPoints1b.add(new GPoint(i*graphXAxisIncrement1b, dataElement.returnAllObjectData().getJSONArray("testDpsData").getFloat(i))); //Test Whole DPS Graph Point
    }
    if (controlDpsNumbers.length < testDpsNumbers.length) {
      for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("controlDpsData").size(); i++) {
        float testDpsNumber = testDpsNumbers[i];
        float controlDpsNumber = controlDpsNumbers[i];
        float percentIncrease = ((testDpsNumber-controlDpsNumber)/abs(controlDpsNumber))*100;
        tempPoints2a.add(new GPoint(i*graphXAxisIncrement1b, percentIncrease)); //Percent Increase Over Control Point
      }
    } else {
      for (int i = 0; i < dataElement.returnAllObjectData().getJSONArray("testDpsData").size(); i++) {
        float testDpsNumber = testDpsNumbers[i];
        float controlDpsNumber = controlDpsNumbers[i];
        float percentIncrease = ((testDpsNumber-controlDpsNumber)/abs(controlDpsNumber))*100;
        tempPoints2a.add(new GPoint(i*graphXAxisIncrement1b, percentIncrease)); //Percent Increase Over Control Point
      }
    }
    points1a.removeRange(0, points1a.getNPoints());
    points1b.removeRange(0, points1b.getNPoints());
    points2a.removeRange(0, points1a.getNPoints());
    points1a = tempPoints1a;
    points1b = tempPoints1b;
    points2a = tempPoints2a;
  }
}
