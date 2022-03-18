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
    println("GuiElement "+id+" performed GuiElementClickBehavior0");
  }
}
class GuiElementClickBehavior1 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code
    //Record Test
    println("GuiElement "+id+" performed GuiElementClickBehavior1");
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
  String textToReturn = null;
  void doDisplayAction(int id, int displayCode) {
    switch(displayCode) {
    case 0:
      textToReturn = avgDps+" DPS";
      break;
    case 1:
      textToReturn = avgDpsDifference+" DPS Difference"; //Temporary code
      break;
    case 2:
      textToReturn = avgPercentDamageIncrease+" % Damage Increase"; //Temporary code
      break;
    case 3:
      textToReturn = "Control Standard Deviation: +- "+cStandardDeviation;
      break;
    case 4:
      textToReturn = "Test Standard Deviation: +- "+tStandardDeviation;
      break;
    case 5:
      textToReturn = "Deviation Range Case 0";
      break;
    case 6:
      textToReturn = "Deviation Range Case 1";
      break;
    case 7:
      textToReturn = "Deviation Range Case 2";
      break;
    default:
      //textToReturn = "default"; //Temporary code
      break;
    }
    guiController.getElement(id).setElementText(textToReturn);
  }
}
