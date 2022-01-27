class BehaviorFactory {
  private GuiElementBehavior behavior;

  private void determineBehaviorToCreate(String s) {
    switch(s) {
    default:
      behavior = new DefaultBehavior();
      break;
    case "DefaultBehavior":
      behavior = new DefaultBehavior();
      break;
    case "GuiElementClickBehavior0":
      behavior = new GuiElementClickBehavior0();
      break;
    case "GuiElementClickBehavior1":
      behavior = new GuiElementClickBehavior1();
      break;
    }
  }
  BehaviorFactory(String s) {
    determineBehaviorToCreate(s);
  }


  GuiElementBehavior createBehavior(String s) {
    determineBehaviorToCreate(s);
    return behavior;
  }
  GuiElementBehavior returnBehavior() {
    return behavior;
  }
}

interface GuiElementBehavior {
  void doAction(int id);
}

class DefaultBehavior implements GuiElementBehavior {
  void doAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed DefaultBehavior");
  }
}
class GuiElementClickBehavior0 implements GuiElementBehavior {
  void doAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior0");
  }
}
class GuiElementClickBehavior1 implements GuiElementBehavior {
  void doAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior1");
  }
}
