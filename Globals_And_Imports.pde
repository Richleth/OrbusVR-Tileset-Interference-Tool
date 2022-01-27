import controlP5.*;
import grafica.*;
import processing.sound.*;
import java.util.*;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;
//CONTRIBUTED LIBRARY GLOBALS\\
GPlot graph;
ControlP5 cp5;
//BUFFERED READER\\
BufferedReader reader;
BufferedReader reader2;
//ARRAYLIST\\
ArrayList names = new ArrayList();
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
//LONGS\\
long charsToSkip = 0;
//STRINGS\\
String name = null;
String findPath = null;
String line;
String[] lines;
String line2;
String[] lines2;
//INTS\\
int id = 0;
//BOOLEANS\\
boolean firstHit = true;
boolean nameGiven = false;
boolean readyToParse = false;
boolean nameDropdownMenuOpen = false;
boolean sameName = false;
boolean critDamageUpGiven = false;
//GUI MAIN\\
GuiMain guiController = new GuiMain();
//ARRAYLISTS\\
ArrayList<int[]> verts = new ArrayList<int[]>();
