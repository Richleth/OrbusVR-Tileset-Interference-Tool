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
//JSON ARRAYS\\
JSONArray damagesDelt = new JSONArray();
JSONArray frameDamageDelt = new JSONArray();
//BUFFERED READER\\
BufferedReader reader;
BufferedReader reader2;
//ARRAYLIST\\
ArrayList names = new ArrayList();
ArrayList<TEXTBOX> textboxes = new ArrayList<TEXTBOX>();
ArrayList<int[]> verts = new ArrayList<int[]>();
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
final int backgroundColor = 255;
//HASHMAPS\\
HashMap<String, Float> critDamagePlusGivenMultipliers = new HashMap<String, Float>();
//FLOATS\\
float critDamagePlus = 1.53;
float avgDps = 0;
float avgDpsDifference = 0;
float avgPercentDamageIncrease = 0;
final float timerConstant = 150;
float timer = 1;
float cStandardDeviation = 0;
float tStandardDeviation = 0;
float cSD = 0;
float tSD = 0;
float controlPercentDeviation = 0;
float testPercentDeviation = 0;
//BOOLEANS\\
boolean changedChosenName = false;
boolean parsing = false;
boolean startAudioEffectPlayed = false;
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
//AUDIO FILES\\
SoundFile startParseSfx;
SoundFile endParseSfx;
