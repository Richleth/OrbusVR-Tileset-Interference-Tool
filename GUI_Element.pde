class GuiElement {
  private int x1, y1, x2, y2; //Controls the text area
  private int shapeStrokeWeight; //Controls stroke weight of the shape
  private int id; //ID of the object
  private int[][] shapeVertices; //2D Array of vertices for the shape (Format: {{x,y},{x,y},{x,y}} )
  private String text; //The text that can be displayed
  private color strokeColor; //Color of lines
  private color fillColor; //Color of fill
  private color textColor; //Color of text
  private boolean border; //Does shape have a border
  private boolean textVisibility; //Is text visible
  private PShape shape; //Controller for the shape
  private GuiElementBehavior guiElementBehavior; //Controller for the behavior

  GuiElement(int[] a, int[][] tShapeVertices, String tText, color[] tColors, boolean tBorder, 
    boolean tTextVisibility, GuiElementBehavior behavior) {
    x1 = a[0];
    y1 = a[1];
    x2 = a[2];
    y2 = a[3];
    shapeStrokeWeight = a[4];
    id = a[5];
    shapeVertices = tShapeVertices;
    text = tText;
    strokeColor = tColors[0];
    fillColor = tColors[1];
    textColor = tColors[2];
    border = tBorder;
    textVisibility = tTextVisibility;
    shape = new PShape();
    guiElementBehavior = behavior;
  }

  void display() {
  }
}
