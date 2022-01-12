interface GuiElementBehavior {
  void doAction(int id);
}

class GuiElementClickBehavior0 implements GuiElementBehavior {
  void doAction(int id) {
    //Action Code

    println("GuiElement "+id+" performed GuiElementClickBehavior0");
  }
}
