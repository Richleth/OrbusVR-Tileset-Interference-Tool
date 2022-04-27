/** //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
 ----------IMPORTANT----------
 Users must use a non bleed weapon as bleed is inherintly luck based and will throw off results!
 Users must use a non lightning forged weapon as lightning forged is inherintly luck based and will throw off results!
 Users must use a non lifesteal weapon as lifesteal is inherintly luck based and will throw off results due to extra tiles!
 Crit however is okay as the code normalizes damage to entirely non crits. This is possible as crits are reported by the combat log and all possible crit damage multipliers are known.
 
 Status effects like potions must be the same between both control and sample tests.
 
 !!THIS PROGRAM IS ONLY TESTED FOR RUNEMAGE!!
 I don't see why it would not work for the other classes but compatability is NOT garunteed.
 ----------IMPORTANT----------
 
 This program attempts to analyse the real damage boost your tiles give on average in an isolated test with the testing dummies.
 To do this the progam analyses DPS for 1 Minute without tilesets and then compares against the DPS with tilesets to attempt to determine the % boost the equiped tilesets have.
 Tilesets that last longer but have worse interference CAN give higher an overall damage boost due to the extra length that the set is active.
 
 As tilesets are vastly complicated the best place to learn them is from a master who knows how tilesets work and learn under them.
 A very helpful resource is located at the Traveler's Hall Wiki. Provided are a few links.
 https://wiki.thehall.xyz/wiki/Alchemy_101_/_Runes_/_Rune_Tile_Making
 https://wiki.thehall.xyz/wiki/Alchemy_101_/_Runes_/_Rune_Tile_Making_/_Tileset_Creation
 https://wiki.thehall.xyz/wiki/Alchemy_101_/_Runes_/_Rune_Tile_Making_/_Tileset_Creation_/_Timing_and_Interference
 
 These resources go over a lot about tiles and are the main thing you need to know about tilesets. Oh how I wish we had this information back in Preborn :(
 
 ----------HOW TO USE----------
 
 First you must record a control damage value with NO TILESETS* (*Tilesets can be equiped as long as they do not change between tests. A notable example is any start of combat runes or testing interference between two different sets of tiles.)
 Both tests (control and sample) will last for 1 minute and will start as soon as the targeted player (name chosen in the dropdown menu) hits a target dummy.
 The control test will provide an average DPS that will be used later in comparison with the sample test to determine the % damage boost the tiles in the sample test give over the control. (This test will be written to the data folder after the control test is complete)
 Next, the sample test will largely do the same as the control test but will compare the result with the control and output a percent on the screen telling you how much better or worse the sample test is from the control test.
 Note: This percent may have a bit of margin of error so if you feel your results are incorrect; it is advisable to run the sample test again.
 */

void setup() {
  graph = new GPlot(this);
  graph.setPos(0, 50);
  graph.setDim(width-125, height/2-150);
  graph.getTitle().setText("Tileset Interference DPS");
  graph.getXAxis().getAxisLabel().setText("Time");
  graph.getYAxis().getAxisLabel().setText("Damage Per Second");
  graph.activateZooming(1.1, CENTER, CENTER);
  graph.activatePanning(LEFT);
  graph.activateReset(RIGHT);
  graph.setPoints(points1a);
  graph.setLineColor(color(0, 0, 255));
  graph.addLayer("layer 1", points1b);
  graph.getLayer("layer 1").setLineColor(color(255, 0, 0));
  graph2 = new GPlot(this);
  graph2.setPos(0, height/2);
  graph2.setDim(width-125, height/2-150);
  graph2.getTitle().setText("Tileset Interference Percent");
  graph2.getXAxis().getAxisLabel().setText("Time");
  graph2.getYAxis().getAxisLabel().setText("Percent Damage Increase");
  graph2.activateZooming(1.1, CENTER, CENTER);
  graph2.activatePanning(LEFT);
  graph2.activateReset(RIGHT);
  graph2.setPoints(points2a);
  graph2.setLineColor(color(255, 0, 0));

  surface.setIcon(loadImage("data/orbusvr_tileset_interference_tool_icon.png"));
  playerController.readPlayerDataElementsFromFile();
  startParseSfx = new SoundFile(this, "startEffect.mp3");
  endParseSfx = new SoundFile(this, "endingEffect.mp3");
  critDamagePlusGivenMultipliers.put("0% Plus Crit Damage", 1.53);
  critDamagePlusGivenMultipliers.put("2% Plus Crit Damage", 1.55);
  critDamagePlusGivenMultipliers.put("4% Plus Crit Damage", 1.57);
  critDamagePlusGivenMultipliers.put("6% Plus Crit Damage", 1.59);
  critDamagePlusGivenMultipliers.put("8% Plus Crit Damage", 1.61);
  PFont listFont = loadFont("fontForList.vlw");
  //names.add("Richleth"); OLD TESTING COMMAND TO GET ARROUND NULL POINTER
  names.add("TesterName");
  //Set Up Dropdown List\\
  playerDropdown = new ControlP5(this);
  playerDropdown.addScrollableList("Player_Chosen")
    .setPosition(30, 50)
    .setSize(395, 550)
    .setBarHeight(40)
    .setItemHeight(40)
    .addItems(names)
    .close()
    //.setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;
  playerDropdown.setFont(listFont, 14);
  critDamageDropdown = new ControlP5(this);
  critDamageDropdown.addScrollableList("Crit_Damage")
    .setPosition(435, 50)
    .setSize(395, 550)
    .setBarHeight(40)
    .setItemHeight(40)
    .addItems(critDamagePlusGivenLabels)
    //.setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    .close();
  critDamageDropdown.setFont(listFont, 14);
  //GUI\\
  //Get path to combat log\\
  String path = System.getProperty("user.home");
  String[] splitPaths = split(path, "\\");
  String foundPath = join(splitPaths, "/");
  String usePath = foundPath +"/appdata/LocalLow/Orbus Online, LLC/OrbusVR/combat.log";
  String[] lines = loadStrings(usePath);
  for (String i : lines) {
    charsToSkip = charsToSkip + i.length();
  }
  reader = createReader(usePath);
  reader2 = createReader("guiElements.txt");
  //Basic Setup\\
  size(860, 750);
  frameRate(100);
  InitLayout();
  strokeWeight(2);
  stroke(0, 0, 0);
  background(255);
  //Skip to front of log
  try {
    reader.skip(charsToSkip*2);
  } 
  catch(IOException e) {
    print("fail");
  }
  addGuiButtonsFromFile();
  //guiController.createGuiElement(100, 550, 150, 100, 5, 0, new int[][] {{0, 0}, {150, 0}, {150, 100}, {0, 100}}, 
  //"The only job is won through sheer force of will", new color[] {0, 255, 0}, true, true, true, true, new GuiElementClickBehavior0());
}

void draw() {
  if (changedChosenName) {
    // CODE THAT ATTEMPTS TO LOAD FROM JSON THE DATA FOR THE SELECTED PLAYER
    PlayerDataElement dataElement = playerController.getPlayerDataElement(nameChosen);
    if (dataElement != null) {
      println("helloWorld");
      println(dataElement.returnAllObjectData());
      float testDpsResult = dataElement.returnAllObjectData().getFloat("testDpsResult");
      float controlDpsResult = dataElement.returnAllObjectData().getFloat("controlDpsResult");
      float testDataVarience = dataElement.returnAllObjectData().getFloat("testDataVarience");
      float controlDataVarience = dataElement.returnAllObjectData().getFloat("controlDataVarience");
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
      avgDpsDifference = testDpsResult - controlDpsResult;
      avgPercentDamageIncrease = (avgDpsDifference/controlDpsResult)*100;
      cStandardDeviation = sqrt(testDataVarience);
      tStandardDeviation = sqrt(controlDataVarience);
      changedChosenName = false;
    } else {
      avgDpsDifference = 0;
      avgPercentDamageIncrease = 0;
      cStandardDeviation = 0;
      tStandardDeviation = 0;
      changedChosenName = false;
    }
  }
  if (cSD != 0) {
    cStandardDeviation = cSD;
  }
  if (cSD != 0) {
    tStandardDeviation = tSD;
  }
  background(backgroundColor);
  graphModeDps();
  graphModePercent();
  //println(frameRate, frameCount);
  //println(mouseX,mouseY);
  if (playerDropdown.get(ScrollableList.class, "Player_Chosen").isOpen()) {
    drawDropdownMenu();
  }
  guiController.display();
  fill(0);
  textAlign(LEFT);
  //Main\\
  // Player must self report how much + % Crit Damage they have on their gear

  if (nameGiven && critDamagePlusGiven) {
    //ERROR: Any addition to combat log will prevent parsing

    if (parsing) {
      if (controlParse) {
        if (combatStarted) {
          if (timer <= timerConstant*frameRate) {
            parseCombatLog(); // Need to log frame hit data and the damage delt
            timer++;
            //println(timer);
          } else if (timer > timerConstant*frameRate) { // POTENTIALLY NEEDS BOOLEAN TO MAKE SURE THIS CODE ONLY RUNS ONCE
            //Log player dps avg pair
            try {
              playerController.updatePlayerDataElement(newData(), nameChosen, new String[] {"controlDpsResult", "controlDataVarience", "damagesDelt", "frameDamageDelt", "controlDpsData"});
            } 
            catch (NullPointerException e) {
              playerController.createPlayerDataElement(newData(), nameChosen, "NEW");
            }
            combatStarted = false;
            parsing = false;
            controlParse = false;
            endParseSfx.play();
          }
        } else {
          parseCombatLogInit();
        }
      } else if (testParse) {
        if (combatStarted) {
          if (timer <= timerConstant*frameRate) {
            parseCombatLog();
            timer++;
          } else
            if (timer > timerConstant*frameRate) {
              //Log player dps avg pair
              try {
                playerController.updatePlayerDataElement(newData(), nameChosen, new String[] {"testDpsResult", "testDataVarience", "damagesDelt", "frameDamageDelt", "testDpsData"});
              } 
              catch (NullPointerException e) {
                playerController.createPlayerDataElement(newData(), nameChosen, "NEW");
              }
              combatStarted = false;
              parsing = false;
              testParse = false;
              endParseSfx.play();
            }
        } else {
          parseCombatLogInit();
        }
      }
    }
  }
  push();
  fill(0);
  textSize(15);
  text("ESC: Save and Exit   |   G: Graph Mode   |   M: Main Mode", 15, height-15);
  pop();
}
void mousePressed() {
  // Code to check what GUI Element is pressed
  // Buttons will be for 2 main function options and reporting the + % Crit Damage on a player's gear to counteract any crit damage
  guiController.buttonCheckMouseHovering();
}
void keyPressed() {
  if (key == 'p' || key == 'P') {
    //Litterally a command to pause debugger
    //Click on the if statement line number in debugger mode
    println("Pause Debugger");
  } else if (key == 'g' || key == 'G') { //Graph Mode
    playerDropdown.hide();
    critDamageDropdown.hide();
    graphMode = true;
    guiController.setHidden();
  } else if (key == 'm' || key == 'M') { //Main Mode
    playerDropdown.show();
    critDamageDropdown.show();
    graphMode = false;
    guiController.setVisible();
  } else if (key == ']' || key == ']') { //Main Mode
    timer = 999999999;
  } else if (keyCode == ESC) {
    playerController.writePlayerDataElementsToFile();
    exit();
  }
}
