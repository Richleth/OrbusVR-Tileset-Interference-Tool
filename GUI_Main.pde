class GuiMain {
  private ArrayList<GuiElement> guiElements = new ArrayList<GuiElement>();

  void display() {
    for (GuiElement i : guiElements) {
      i.display();
    }
  }

  void createGuiElement(int x1, int y1, int x2, int y2, int shapeStrokeWeight, int id, int[][] shapeVertices, 
    String text, color[] colors, boolean border, boolean textVisibility, GuiElementBehavior guiElementBehavior) {
      int[] array1 = {x1,y1,x2,y2,shapeStrokeWeight,id};
      guiElements.add(new GuiElement(array1, shapeVertices, text, colors, border, textVisibility, guiElementBehavior));
  }
}
