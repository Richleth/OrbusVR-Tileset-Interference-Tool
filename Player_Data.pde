class PlayerDataMain {
  private HashMap<String, PlayerDataElement> playerDataElements = new HashMap<String, PlayerDataElement>();
  private ArrayList<String> playerDataElementKeys = new ArrayList<String>();

  PlayerDataElement getPlayerDataElement(String s) {
    return playerDataElements.get(s);
  }

  boolean playerDataElementMatchesSelectName(String s) {
    try {
      if (playerDataElements.get(s).equals(nameChosen)) {
        return true;
      } else {
        return false;
      }
    } 
    catch (NullPointerException e) {
      e.printStackTrace();
      return false;
    }
  }

  void updatePlayerDataElement(String pName, float controlTestR) {
    playerDataElements.get(pName).updateControlTestResult(controlTestR);
  }

  void createPlayerDataElement(String pName, float controlTestR) {
    playerDataElements.put(pName, new PlayerDataElement(pName, controlTestR));
    playerDataElementKeys.add(pName);
  }

  void writePlayerDataElementsToFile() {
    PrintWriter output = createWriter("data/playerDataElements.txt");
    for (int i = 0; i < playerDataElementKeys.size(); i++) {
      output.println(playerDataElementKeys.get(i)+"|"+playerDataElements.get(playerDataElementKeys.get(i)).returnControlTestResult());
      println(playerDataElementKeys.get(i)+"|"+playerDataElements.get(playerDataElementKeys.get(i)).returnControlTestResult());
    }
    output.flush();
    output.close();
  }

  void readPlayerDataElementsFromFile() {
    BufferedReader playerDataElementReader = createReader("data/playerDataElements.txt");
    String line = null;
    try {
      while ((line = playerDataElementReader.readLine()) != null) {
        String[] pieces = split(line, "|");
        String pName = pieces[0];
        float controlTestR = float(pieces[1]);
        createPlayerDataElement(pName, controlTestR);
      }
      playerDataElementReader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
}

class PlayerDataElement {
  private String playerName;
  private float controlDpsResult;
  private float testDpsResult;
  private float dataVarience;
  private FloatList damagesDelt = new FloatList();
  private FloatList frameDamageDelt = new FloatList();
  private int[][] tilesets = new int[5][6];
  private String[] weaponAffixes; //uses _ notation EX: lightning_forged

  PlayerDataElement(String pName, float tControlDpsResult) {
    playerName = pName;
    controlDpsResult = tControlDpsResult;
  }

  void updateControlTestResult(float tControlDpsResult) {
    controlDpsResult = tControlDpsResult;
  }

  String returnPlayerName() {
    return playerName;
  }
  float returnControlTestResult() {
    return controlDpsResult;
  }
}

class TestData {
  private FloatList damagesDelt = new FloatList();
  private FloatList frameDamageDelt = new FloatList();
  private float previousTotalFrames = 0;

  // calcAvg func may return something, void may be temporary return type
  private void calcAvg() {
    if (frameDamageDelt.size() > 1 && damagesDelt.size() > 1) {
      float currentHitDamageDelt = damagesDelt.get(damagesDelt.size()-1);
      float currentHitFrameDamageDelt = frameDamageDelt.get(frameDamageDelt.size()-1) - frameDamageDelt.get(frameDamageDelt.size()-2);
      for (int i = 1; i < frameDamageDelt.size(); i++) {
        previousTotalFrames += frameDamageDelt.get(i-1);
      }
      //uses formula at https://www.statisticshowto.com/combined-mean/ to calculate damage per frame
      float avgDpf = ((previousTotalFrames*avgDps) + (currentHitFrameDamageDelt*currentHitDamageDelt))/(previousTotalFrames+currentHitFrameDamageDelt);
      //multiply damage per frame by framerate to get damage per second
      avgDps = avgDpf * frameRate;
    } else if (frameDamageDelt.size() == 1 && damagesDelt.size() == 1) {
      float avgDpf = damagesDelt.get(damagesDelt.size()-1) / frameDamageDelt.get(frameDamageDelt.size()-1);
      avgDps = avgDpf * frameRate;
    }
  }

  void newDataPoint(float d, float fd) {
    damagesDelt.append(d);
    frameDamageDelt.append(fd);
    calcAvg();
  }

  void clearData() {
    damagesDelt.clear();
    frameDamageDelt.clear();
  }
}
