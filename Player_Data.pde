class PlayerDataMain {
  private HashMap<String, PlayerDataElement> playerDataElements = new HashMap<String, PlayerDataElement>();
  private ArrayList<String> playerDataElementKeys = new ArrayList<String>();
  private JSONObject mainData = new JSONObject();
  private JSONArray jsonPlayerDataElements = new JSONArray();
  private JSONArray jsonPlayerDataElementKeys = new JSONArray();

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

  void updatePlayerDataElement(JSONObject data, String tPlayerName, String[] dataToUpdate) {
    playerDataElements.get(tPlayerName).updateData(dataToUpdate, data); // NEED TO ADD THE REST OF RESULTS
  }
  void updatePlayerDataElementTest(JSONObject data, String tPlayerName, String[] dataToUpdate) {
    playerDataElements.get(tPlayerName).updateData(dataToUpdate, data); // NEED TO ADD THE REST OF RESULTS
  }

  void createPlayerDataElement(JSONObject data, String tPlayerName) {
    playerDataElements.put(tPlayerName, new PlayerDataElement(data, tPlayerName)); //UPDATED CONSTRUCTOR NEEDS CHANGING TEST RESULT = 0 DUE TO ONLY BEING CREATED IN A CONTROL PARSE
    playerDataElementKeys.add(tPlayerName);
  }

  void writePlayerDataElementsToFile() {
    // Use JSON Object instead
    JSONObject writePlayerData = new JSONObject();
    JSONArray nameValues = new JSONArray();
    JSONArray playerDataValues = new JSONArray();
    for (int i = 0; i < playerDataElementKeys.size(); i++) {
      JSONObject dataObject = new JSONObject();
      dataObject.setString("name", playerDataElementKeys.get(i));
      nameValues.setJSONObject(i, dataObject);
      JSONObject playerDataObject = playerDataElements.get(playerDataElementKeys.get(i)).returnAllObjectData(); //SOMETHING WRONG HERE
      playerDataValues.setJSONObject(i, playerDataObject);
      // NEED TO MAKE SURE THE DATA IS UP TO DATE IN OBJECT
    }
    writePlayerData.setJSONArray("names", nameValues);
    for (int i = 0; i < playerDataElementKeys.size(); i++) {
      writePlayerData.setJSONArray(playerDataElementKeys.get(i), playerDataValues);
    }
    
    println(writePlayerData);
    // JSON Must write keys for player names to another object in the same JSON file
    saveJSONObject(writePlayerData, "data/playerDataElementsTest.json");
    PrintWriter output = createWriter("data/playerDataElements.txt");
    for (int i = 0; i < playerDataElementKeys.size(); i++) {
      output.println(playerDataElementKeys.get(i)+"|"+playerDataElements.get(playerDataElementKeys.get(i)).returnControlTestResult());
      println(playerDataElementKeys.get(i)+"|"+playerDataElements.get(playerDataElementKeys.get(i)).returnControlTestResult());
    }
    output.flush();
    output.close();
  }

  void readPlayerDataElementsFromFile() {
    // Use JSON Object instead
    JSONObject savedPlayerData = loadJSONObject("data/playerDataElements.json");
    //MUST SOMEHOW READ AND GET ALL ELEMENTS
    for (int i = 0; i < savedPlayerData.getJSONArray("names").size(); i++) {
      String playerName = savedPlayerData.getJSONArray("names").getJSONObject(i).getString("name");
      /* Old Vars
       float controlDpsResult = savedPlayerData.getFloat("controlDpsResult");
       float testDpsResult = savedPlayerData.getFloat("testDpsResult");
       float dataVarience = savedPlayerData.getFloat("dataVarience");
       JSONArray damagesDelt = savedPlayerData.getJSONArray("damagesDelt");
       JSONArray frameDamageDelt = savedPlayerData.getJSONArray("frameDamageDelt");
       JSONObject tilesets = savedPlayerData.getJSONObject("tilesets");
       JSONArray weaponAffixes = savedPlayerData.getJSONArray("weaponAffixes");
       */
      println(playerName);
      createPlayerDataElement(savedPlayerData, playerName);
    }
  }
}

class PlayerDataElement {
  private JSONObject data; // Has all below params
  private String playerName;
  private float controlDpsResult;
  private float testDpsResult;
  private float controlDataVarience;  
  private float testDataVarience;  
  private JSONArray damagesDelt;
  private JSONArray frameDamageDelt;
  // Below Params are for when API is Implemented
  private JSONObject tilesets;
  private JSONArray weaponAffixes; //uses _ notation EX: lightning_forged


  PlayerDataElement(JSONObject tData, String tName) {
    data = tData;
    playerName = data.getJSONArray(tName).getJSONObject(0).getString("playerName");
    controlDpsResult = data.getJSONArray(tName).getJSONObject(0).getFloat("controlDpsResult");
    testDpsResult = data.getJSONArray(tName).getJSONObject(0).getFloat("testDpsResult");
    controlDataVarience = data.getJSONArray(tName).getJSONObject(0).getFloat("controlDataVarience");
    testDataVarience = data.getJSONArray(tName).getJSONObject(0).getFloat("testDataVarience");
    damagesDelt = data.getJSONArray(tName).getJSONObject(0).getJSONArray("damagesDelt");
    frameDamageDelt = data.getJSONArray(tName).getJSONObject(0).getJSONArray("frameDamageDelt");
    tilesets = data.getJSONArray(tName).getJSONObject(0).getJSONObject("tilesets");
    weaponAffixes = data.getJSONArray(tName).getJSONObject(0).getJSONArray("weaponAffixes");
  }
  void updateData(String[] keysToUpdate, JSONObject data) {
    for (int i = 0; i < keysToUpdate.length; i++) {
      switch (keysToUpdate[i]) {
      case "controlDpsResult":
        controlDpsResult = data.getFloat("controlDpsResult");
        break;
      case "testDpsResult":
        testDpsResult = data.getFloat("testDpsResult");
        break;
      case "controlDataVarience":
        controlDataVarience = data.getFloat("controlDataVarience");
        break;
      case "testDataVarience":
        testDataVarience = data.getFloat("testDataVarience");
        break;
      case "damagesDelt":
        damagesDelt = data.getJSONArray("damagesDelt");
        break;
      case "frameDamageDelt":
        frameDamageDelt = data.getJSONArray("frameDamageDelt");
        break;
      case "tilesets":
        tilesets = data.getJSONObject("tilesets");
        break;
      case "weaponAffixes":
        weaponAffixes = data.getJSONArray("weaponAffixes");
        break;
      }
    }
  }
  JSONObject returnAllObjectData() {
    JSONObject playerDataObject = new JSONObject();    
    playerDataObject.setString("playerName", playerName);
    playerDataObject.setFloat("controlDpsResult", controlDpsResult);
    playerDataObject.setFloat("testDpsResult", testDpsResult);
    playerDataObject.setFloat("controlDataVarience", controlDataVarience);
    playerDataObject.setFloat("testDataVarience", testDataVarience);    
    playerDataObject.setJSONArray("damagesDelt", damagesDelt);
    playerDataObject.setJSONArray("frameDamageDelt", frameDamageDelt);
    playerDataObject.setJSONObject("tilesets", tilesets);
    playerDataObject.setJSONArray("weaponAffixes", weaponAffixes); //<>//
    return playerDataObject;
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
