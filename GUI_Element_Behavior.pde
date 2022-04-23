class BehaviorFactory {
  private GuiElementClickBehavior clickBehavior;
  private GuiElementDisplayBehavior displayBehavior;

  private void determineClickBehaviorToCreate(String s) {
    switch(s) {
    default:
      clickBehavior = new GuiElementDefaultClickBehavior();
      break;
    case "GuiElementDefaultClickBehavior":
      clickBehavior = new GuiElementDefaultClickBehavior();
      break;
    case "GuiElementNoClickBehavior":
      clickBehavior = new GuiElementNoClickBehavior();
      break;
    case "GuiElementClickBehavior0":
      clickBehavior = new GuiElementClickBehavior0();
      break;
    case "GuiElementClickBehavior1":
      clickBehavior = new GuiElementClickBehavior1();
      break;
    case "GuiElementClickBehavior2":
      clickBehavior = new GuiElementClickBehavior2();
      break;
    case "GuiElementClickBehavior3":
      clickBehavior = new GuiElementClickBehavior3();
      break;
    case "GuiElementClickBehavior4":
      clickBehavior = new GuiElementClickBehavior4();
      break;
    }
  }
  private void determineDisplayBehaviorToCreate(String s) {
    switch(s) {
    default:
      displayBehavior = new GuiElementDefaultDisplayBehavior();
      break;
    case "GuiElementDefaultDisplayBehavior":
      displayBehavior = new GuiElementDefaultDisplayBehavior();
      break;
    case "GuiElementNoDisplayBehavior":
      displayBehavior = new GuiElementNoDisplayBehavior();
      break;
    case "GuiElementTextChangeBehavior":
      displayBehavior = new GuiElementTextChangeBehavior();
      break;
    }
  }

  BehaviorFactory(String s) {
    determineClickBehaviorToCreate(s);
  }


  GuiElementClickBehavior createClickBehavior(String s) {
    determineClickBehaviorToCreate(s);
    return clickBehavior;
  } 
  GuiElementDisplayBehavior createDisplayBehavior(String s) {
    determineDisplayBehaviorToCreate(s);
    return displayBehavior;
  }
}

interface GuiElementClickBehavior {
  void doClickAction(int id);
}

class GuiElementDefaultClickBehavior implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementDefaultClickBehavior");
  }
}
class GuiElementNoClickBehavior implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code

    println("GuiElement "+id+" does not have a click behavior");
  }
}
class GuiElementClickBehavior0 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code
    //Record Control
    if (nameGiven && critDamagePlusGiven) {
      combatStarted = false;
      parsing = true;
      controlParse = true;
      testParse = false;
      startAudioEffectPlayed = false;
      timer = 1;
      testDataController.clearData();
      String str = "";
      try {
        while ((str=reader.readLine())!=null)
          println(str);
      } 
      catch (IOException e) {
        e.printStackTrace();
        line = null;
        println("CATCH IO");
      }
      println(line);
      println("GuiElement "+id+" performed GuiElementClickBehavior0 Successfully");
    } else {
      println("GuiElement "+id+" performed GuiElementClickBehavior0 Unsuccessfully");
    }
  }
}
class GuiElementClickBehavior1 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code
    //Record Test
    if (nameGiven && critDamagePlusGiven) {
      combatStarted = false;
      parsing = true;
      controlParse = false;
      testParse = true;
      startAudioEffectPlayed = false;
      timer = 1;
      testDataController.clearData();
      String str = "";
      try {
        while ((str=reader.readLine())!=null)
          println(str);
      } 
      catch (IOException e) {
        e.printStackTrace();
        line = null;
        println("CATCH IO");
      }
      println(line);
      println("GuiElement "+id+" performed GuiElementClickBehavior1 Successfully");
    } else {
      println("GuiElement "+id+" performed GuiElementClickBehavior1 Unsuccessfully");
    }
  }
}
class GuiElementClickBehavior2 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code
    //AVG DPS
    guiController.getElement(5).setElementDisplayCode(0);
    guiController.getElement(8).setElementDisplayCode(5);
    println("GuiElement "+id+" performed GuiElementClickBehavior2");
  }
}
class GuiElementClickBehavior3 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code
    //AVG DPS DIFF
    guiController.getElement(5).setElementDisplayCode(1);
    guiController.getElement(8).setElementDisplayCode(6);
    println("GuiElement "+id+" performed GuiElementClickBehavior3");
  }
}
class GuiElementClickBehavior4 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code
    //% Damage Boost VS Control
    guiController.getElement(5).setElementDisplayCode(2);
    guiController.getElement(8).setElementDisplayCode(7);
    println("GuiElement "+id+" performed GuiElementClickBehavior4");
  }
}

interface GuiElementDisplayBehavior {
  void doDisplayAction(int id, int displayCode);
}

class GuiElementDefaultDisplayBehavior implements GuiElementDisplayBehavior {
  void doDisplayAction(int id, int displayCode) {
    //Action Code

    //println("GuiElement "+id+" performed GuiElementDefaultDisplayBehavior");
  }
}
class GuiElementNoDisplayBehavior implements GuiElementDisplayBehavior {
  void doDisplayAction(int id, int displayCode) {
    //Action Code
    //Do Nothing For Display
    //println("GuiElement "+id+" does not have a display behavior");
  }
}
class GuiElementTextChangeBehavior implements GuiElementDisplayBehavior {
  private void deviationCheckerFunctionDps() {
    if (cStandardDeviation == 0 && tStandardDeviation == 0) {
      textToReturn = "Requires Control and Test Data";
    } else if (tStandardDeviation == 0) {
      textToReturn = "Requires Test Data";
    } else if (cStandardDeviation == 0) {
      textToReturn = "Requires Control Data";
    } else {
      /*
        Where T = Test Mean, C = Control Mean, Ts = Test Standard Deviation, Cs = Control Standard Deviation
       (((T+Ts)-(C-Cs))/(C-Cs))*100 = Maximum Percent Increase Comparing Control and Test
       (((T-Ts)-(C+Cs))/(C+Cs))*100 = Minimum Percent Increase Comparing Control and Test
       (T+Ts)-(C-Cs) = Maximum Increase Comparing Control and Test
       (T-Ts)-(C+Cs) = Minimum Increase Comparing Control and Test
       */
      JSONObject playerData = playerController.getPlayerDataElement(nameChosen).returnAllObjectData();
      float C = playerData.getFloat("controlDpsResult");
      float T = playerData.getFloat("testDpsResult");
      float tCs = (float)playerData.getDouble("controlDataVarience"); //Converting a double to a float you put (float)doubleVariable  |  It's stupid
      float tTs = (float)playerData.getDouble("testDataVarience");
      float Cs = sqrt(tCs);
      float Ts = sqrt(tTs);

      double deviationMaximum = (T+Ts)-(C-Cs); 
      double deviationMinimum = (T-Ts)-(C+Cs);
      textToReturn = "The Range of Deviation is between "+ deviationMinimum +" and "+deviationMaximum;
    }
  }
  private void deviationCheckerFunctionPercent() {
    if (cStandardDeviation == 0 && tStandardDeviation == 0) {
      textToReturn = "Requires Control and Test Data";
    } else if (tStandardDeviation == 0) {
      textToReturn = "Requires Test Data";
    } else if (cStandardDeviation == 0) {
      textToReturn = "Requires Control Data";
    } else {
      /*
        Where T = Test Mean, C = Control Mean, Ts = Test Standard Deviation, Cs = Control Standard Deviation
       (((T+Ts)-(C-Cs))/(C-Cs))*100 = Maximum Percent Increase Comparing Control and Test
       (((T-Ts)-(C+Cs))/(C+Cs))*100 = Minimum Percent Increase Comparing Control and Test
       (T+Ts)-(C-Cs) = Maximum Increase Comparing Control and Test
       (T-Ts)-(C+Cs) = Minimum Increase Comparing Control and Test
       */
      JSONObject playerData = playerController.getPlayerDataElement(nameChosen).returnAllObjectData();
      float C = playerData.getFloat("controlDpsResult");
      float T = playerData.getFloat("testDpsResult");
      float tCs = (float)playerData.getDouble("controlDataVarience"); //Converting a double to a float you put (float)doubleVariable  |  It's stupid
      float tTs = (float)playerData.getDouble("testDataVarience");
      float Cs = sqrt(tCs);
      float Ts = sqrt(tTs);
      double deviationMaximum = (((T+Ts)-(C-Cs))/(C-Cs))*100; 
      double deviationMinimum = (((T-Ts)-(C+Cs))/(C+Cs))*100;
      textToReturn = "The Range of Deviation is between "+ deviationMinimum +"% and "+deviationMaximum+"%";
    }
  }
  String textToReturn = null;
  void doDisplayAction(int id, int displayCode) {
    switch(displayCode) {
    case 0:
      textToReturn = avgDps+" DPS";
      break;
    case 1:
      textToReturn = avgDpsDifference+" DPS Difference"; //NEEDS TO ACTUALLY DISPLAY DIFFERENCE BETWEEN CONTROL AND TEST
      break;
    case 2:
      textToReturn = avgPercentDamageIncrease+" % Damage Increase"; //NEEDS TO ACTUALLY DISPLAY DIFFERENCE BETWEEN CONTROL AND TEST
      break;
    case 3:
      textToReturn = "Control Standard Deviation: +- "+cStandardDeviation;
      break;
    case 4:
      textToReturn = "Test Standard Deviation: +- "+tStandardDeviation;
      break;
    case 5:
      deviationCheckerFunctionDps();
      break;
    case 6:
      deviationCheckerFunctionDps();
      break;
    case 7:
      deviationCheckerFunctionPercent();
      break;
    default:
      //textToReturn = "default"; //Temporary code
      break;
    }
    guiController.getElement(id).setElementText(textToReturn);
  }
}
