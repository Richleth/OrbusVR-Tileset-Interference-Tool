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
String nameChosen;
String findPath = null;
String line;
String[] lines;
String line2;
String[] lines2;
String[] critDamagePlusGivenLabels = {"0% Plus Crit Damage", "2% Plus Crit Damage", "4% Plus Crit Damage", "6% Plus Crit Damage", "8% Plus Crit Damage"};
//INTS\\
int id = 0;
int cStandardDeviation = 0;
int tStandardDeviation = 0;
int backgroundColor = 255;
//HASHMAPS\\
HashMap<String, Float> critDamagePlusGivenMultipliers = new HashMap<String, Float>();
//FLOATS\\
float critDamagePlus = 1.53;
float avgDps = 0;
float avgDpsDifference = 0;
float avgPercentDamageIncrease = 0;
final float timerConstant = 60;
float timer = 1;
//BOOLEANS\\
boolean nameGiven = false;
boolean controlParse = false;
boolean testParse = false;
boolean readyToParse = false;
boolean nameDropdownMenuOpen = false;
boolean sameName = false;
boolean critDamagePlusGiven = false;
boolean combatStarted = false;
//GUI MAIN\\
GuiMain guiController = new GuiMain();
//PLAYER DATA MAIN\\
PlayerDataMain playerController = new PlayerDataMain();
//TEST DATA\\
TestData testDataController = new TestData();
//ARRAYLISTS\\
ArrayList<int[]> verts = new ArrayList<int[]>();
