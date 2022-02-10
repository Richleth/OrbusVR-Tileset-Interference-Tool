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

    println("GuiElement "+id+" performed GuiElementClickBehavior0");
  }
}
class GuiElementClickBehavior1 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior1");
  }
}
class GuiElementClickBehavior2 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior2");
  }
}
class GuiElementClickBehavior3 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior3");
  }
}
class GuiElementClickBehavior4 implements GuiElementClickBehavior {
  void doClickAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior4");
  }
}

interface GuiElementDisplayBehavior {
 void doDisplayAction(int id); 
}

class GuiElementDefaultDisplayBehavior implements GuiElementDisplayBehavior {
  void doDisplayAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementDefaultDisplayBehavior");
  }
}
class GuiElementNoDisplayBehavior implements GuiElementDisplayBehavior {
  void doDisplayAction(int id) {
    //Action Code

    println("GuiElement "+id+" does not have a click behavior");
  }
}
