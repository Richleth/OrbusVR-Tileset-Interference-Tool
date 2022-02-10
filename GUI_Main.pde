class GuiMain {
  private ArrayList<GuiElement> guiElements = new ArrayList<GuiElement>();

  void display() {
    for (GuiElement i : guiElements) {
      i.display();
    }
  }

  void buttonCheckMouseHovering() {
    for (GuiElement i : guiElements) {
      i.performGuiElementBehavior();
    }
  }


  void createGuiElement(int x1, int y1, int x2, int y2, int shapeStrokeWeight, int id, int[][] shapeVertices, 
    String text, color[] colors, boolean border, boolean fillVisibility, boolean shapeClosed, 
    boolean textVisibility, GuiElementClickBehavior guiElementBehavior, GuiElementDisplayBehavior displayBehavior) {
    int[] array1 = {x1, y1, x2, y2, shapeStrokeWeight, id};
    guiElements.add(new GuiElement(array1, shapeVertices, text, colors, border, fillVisibility, shapeClosed, textVisibility, guiElementBehavior, displayBehavior));
  }
  void createGuiElement(int[] a, String tText, color[] tColors, boolean tBorder, boolean tShapeFilled, 
    boolean tShapeClosed, boolean tTextVisibility, GuiElementClickBehavior clickBehavior, GuiElementDisplayBehavior displayBehavior, int[][] tShapeVertices) {
    guiElements.add(new GuiElement(a, tText, tColors, tBorder, tShapeFilled, tShapeClosed, tTextVisibility, clickBehavior, displayBehavior, tShapeVertices));
  }
}
