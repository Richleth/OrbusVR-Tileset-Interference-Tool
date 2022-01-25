class GuiElement {
  private int x1, y1, x2, y2; //Controls the text area and shape location
  private int shapeStrokeWeight; //Controls stroke weight of the shape
  private int id; //ID of the object
  private int[][] shapeVertices; //2D Array of vertices for the shape (Format: {{x,y},{x,y},{x,y}} )
  private String text; //The text that can be displayed
  private color strokeColor; //Color of lines
  private color fillColor; //Color of fill
  private color textColor; //Color of text
  private boolean border; //Does shape have a border
  private boolean shapeFilled; //Does shape have fill
  private boolean shapeClosed; //Is shape closed
  private boolean textVisibility; //Is text visible
  private PShape shape; //Controller for the shape
  private GuiElementBehavior guiElementBehavior; //Controller for the behavior

  private void shapeSetup() {
    println("Shape created for GuiElement id "+id);
    if (!shapeFilled) {
      noFill(); // Determine if shape is filled or not
      println("Shape creation for GuiElement id "+id+": has noFill()");
    } else {
      fill(fillColor);
      println("Shape creation for GuiElement id "+id+": does not have noFill()");
    }
    if (!border) {
      noStroke();
      println("Shape creation for GuiElement id "+id+": has noStroke()");
    } else {
      stroke(strokeColor);
      println("Shape creation for GuiElement id "+id+": does not have noStroke()");
    }
    shape = createShape();
    shape.beginShape();
    for (int i = 0; i < shapeVertices.length; i++) { // Loop through vertices array to set shape's vertices
      shape.vertex(shapeVertices[i][0], shapeVertices[i][1]);
      println("Shape creation for GuiElement id "+id+": Vertex created at "+(shapeVertices[i][0])+","+ (shapeVertices[i][1]));
    }
    if (shapeClosed) { // Determine if shape ends closed or not
      endShape(CLOSE);
      println("Shape creation for GuiElement id "+id+": ended CLOSE");
    } else {
      endShape();
      println("Shape creation for GuiElement id "+id+": ended default");
    }
  }

  GuiElement(int[] a, int[][] tShapeVertices, String tText, color[] tColors, boolean tBorder, boolean tShapeFilled, 
    boolean tShapeClosed, boolean tTextVisibility, GuiElementBehavior behavior) {
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
    shapeFilled = tShapeFilled;
    shapeClosed = tShapeClosed;
    textVisibility = tTextVisibility;
    shapeSetup();
    guiElementBehavior = behavior;
  }
  GuiElement(PShape tShape, int[] a, String tText, color tTextColor, boolean tTextVisibility, GuiElementBehavior behavior) {
    x1 = a[0];
    y1 = a[1];
    x2 = a[2];
    y2 = a[3];
    shapeStrokeWeight = a[4];
    id = a[5];
    shape = tShape;
    text = tText;
    textColor = tTextColor;
    textVisibility = tTextVisibility;
    shapeSetup();
    guiElementBehavior = behavior;
  }

  void display() {
    shape(shape);
  }
}
