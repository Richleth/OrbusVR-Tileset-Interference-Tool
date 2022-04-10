/** //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
 ----------IMPORTANT----------
 Users must use a non bleed weapon as bleed is inherintly luck based and will throw off results!
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
  playerController.readPlayerDataElementsFromFile();
  startParseSfx = new SoundFile(this, "startEffect.mp3");
  endParseSfx = new SoundFile(this, "endingEffect.mp3");
  critDamagePlusGivenMultipliers.put("0% Plus Crit Damage", 1.53);
  critDamagePlusGivenMultipliers.put("2% Plus Crit Damage", 1.55);
  critDamagePlusGivenMultipliers.put("4% Plus Crit Damage", 1.57);
  critDamagePlusGivenMultipliers.put("6% Plus Crit Damage", 1.59);
  critDamagePlusGivenMultipliers.put("8% Plus Crit Damage", 1.61);
  PFont listFont = loadFont("fontForList.vlw");
  names.add("Richleth");
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
    .close()
    ;
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
  frameRate(360);
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
  background(backgroundColor);
  //println(frameRate, frameCount);
  //println(mouseX,mouseY);

  drawDropdownMenu();
  guiController.display();
  fill(0);
  textAlign(LEFT);
  //Main\\
  // Player must self report how much + % Crit Damage they have on their gear

  if (nameGiven && critDamagePlusGiven) {
    // ERROR // Both will detect first hit on the player dummy then parse for 1 minute to either record a control or test against control //ERROR: Any addition to combat log will prevent parsing

    if (parsing) {
      if (controlParse) {
        if (combatStarted) {
          if (timer <= timerConstant*frameRate) {
            parseCombatLog(); // Need to log frame hit data and the damage delt
            timer++;
            //println(timer);
          } else
            if (timer > timerConstant*frameRate) { // POTENTIALLY NEEDS BOOLEAN TO MAKE SURE THIS CODE ONLY RUNS ONCE
              //Log player dps avg pair
              try {
                playerController.updatePlayerDataElement(newData(), nameChosen, new String[] {"controlDpsResult", "controlDataVarience", "damagesDelt", "frameDamageDelt","controlDpsData"});
              } 
              catch (NullPointerException e) {
                playerController.createPlayerDataElement(newData(), nameChosen);
              }
              combatStarted = false;
              parsing = false;
              controlParse = false;
              endParseSfx.play();
            }
        } else {
          parseCombatLogInit();
        }
      } else if (testParse && playerController.playerDataElementMatchesSelectName(nameChosen)) {
        if (combatStarted) {
          if (timer <= timerConstant*frameRate) {
            parseCombatLog();
            timer++;
          } else
            if (timer > timerConstant*frameRate) {
              //Log player dps avg pair
              try {
                playerController.updatePlayerDataElement(newData(), nameChosen, new String[] {"testDpsResult", "testDataVarience", "damagesDelt", "frameDamageDelt","testDpsData"});
              } 
              catch (NullPointerException e) {
                playerController.createPlayerDataElement(newData(), nameChosen);
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
  textSize(20);
  text("G: Graph Mode   |   M: Main Mode", 15, height-15);
  pop();
}
void mousePressed() {
  // Code to check what GUI Element is pressed
  // Buttons will be for 2 main function options and reporting the + % Crit Damage on a player's gear to counteract any crit damage
  guiController.buttonCheckMouseHovering();
}
void keyPressed() {
  if (key == 'p' || key == 'P') { //<>//
    //Litterally a command to pause debugger
    //Click on the if statement line number in debugger mode
    println("Pause Debugger");
  } else if (key == 'g' || key == 'G') { //Graph Mode
    playerDropdown.hide();
    critDamageDropdown.hide();
    guiController.setHidden();
  } else if (key == 'm' || key == 'M') { //Main Mode
    playerDropdown.show();
    critDamageDropdown.show();
    guiController.setVisible();
  } else if (key == ']' || key == ']') { //Main Mode
    timer = 999999999;
  }
}
void exit() {
  println("Exit Program");
  playerController.writePlayerDataElementsToFile();
}
