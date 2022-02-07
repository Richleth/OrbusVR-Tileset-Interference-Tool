import controlP5.*;
import grafica.*;
import processing.sound.*;
import java.util.*;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;
//CONTRIBUTED LIBRARY GLOBALS\\
GPlot graph;
ControlP5 playerDropdown;
ControlP5 critDamageDropdown;
//BUFFERED READER\\
BufferedReader reader;
BufferedReader reader2;
//ARRAYLIST\\
ArrayList names = new ArrayList();
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
//LONGS\\
long charsToSkip = 0;
//STRINGS\\
String name;
String findPath = null;
String line;
String[] lines;
String line2;
String[] lines2;
String[] critDamagePlusGivenLabels = {"0% Plus Crit Damage", "2% Plus Crit Damage", "4% Plus Crit Damage", "6% Plus Crit Damage", "8% Plus Crit Damage"};
//INTS\\
int id = 0;
//HASHMAPS\\
HashMap<String,Float> critDamagePlusGivenMultipliers = new HashMap<String,Float>();
//FLOATS\\
float critDamagePlus = 1.53;
//BOOLEANS\\
boolean firstHit = true;
boolean nameGiven = false;
boolean readyToParse = false;
boolean nameDropdownMenuOpen = false;
boolean sameName = false;
boolean critDamagePlusGiven = false;
//GUI MAIN\\
GuiMain guiController = new GuiMain();
//ARRAYLISTS\\
ArrayList<int[]> verts = new ArrayList<int[]>();
