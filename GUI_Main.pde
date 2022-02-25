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
  
  GuiElement getElement(int id) {
    return guiElements.get(id);
  }

  void createGuiElement(int x1, int y1, int w, int h, int shapeStrokeWeight, int id, int tDisplayCode, int[][] shapeVertices, 
    String text, color[] colors, boolean border, boolean fillVisibility, boolean shapeClosed, 
    boolean textVisibility, GuiElementClickBehavior guiElementBehavior, GuiElementDisplayBehavior displayBehavior) {
    int[] array1 = {x1, y1, w, h, shapeStrokeWeight, id};
    guiElements.add(new GuiElement(array1, shapeVertices,tDisplayCode, text, colors, border, fillVisibility, shapeClosed, textVisibility, guiElementBehavior, displayBehavior));
  }
  void createGuiElement(int[] a, String tText, int tDisplayCode, color[] tColors, boolean tBorder, boolean tShapeFilled, 
    boolean tShapeClosed, boolean tTextVisibility, GuiElementClickBehavior clickBehavior, GuiElementDisplayBehavior displayBehavior, int[][] tShapeVertices) {
    guiElements.add(new GuiElement(a, tText,tDisplayCode, tColors, tBorder, tShapeFilled, tShapeClosed, tTextVisibility, clickBehavior, displayBehavior, tShapeVertices));
  }
}
