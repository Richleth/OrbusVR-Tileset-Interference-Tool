class PlayerDataMain { //<>// //<>//
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
  private JSONArray controlDpsData;
  private float testDpsResult;
  private JSONArray testDpsData;
  private double controlDataVarience;  
  private double testDataVarience;  
  private JSONArray damagesDelt;
  private JSONArray frameDamageDelt;
  // Below Params are for when API is Implemented
  private JSONObject tilesets;
  private JSONArray weaponAffixes; //uses _ notation EX: lightning_forged


  PlayerDataElement(JSONObject tData, String tName) {
    data = tData;
    playerName = data.getJSONArray(tName).getJSONObject(0).getString("playerName");
    controlDpsResult = data.getJSONArray(tName).getJSONObject(0).getFloat("controlDpsResult");
    controlDpsData = data.getJSONArray(tName).getJSONObject(0).getJSONArray("controlDpsData");
    testDpsResult = data.getJSONArray(tName).getJSONObject(0).getFloat("testDpsResult");
    testDpsData = data.getJSONArray(tName).getJSONObject(0).getJSONArray("testDpsData");
    controlDataVarience = data.getJSONArray(tName).getJSONObject(0).getDouble("controlDataVarience");
    testDataVarience = data.getJSONArray(tName).getJSONObject(0).getDouble("testDataVarience");
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
      case "controlDpsData":
        controlDpsData = data.getJSONArray("controlDpsData");
        break;
      case "testDpsData":
        testDpsData = data.getJSONArray("testDpsData");
        break;
      case "controlDataVarience":
        controlDataVarience = data.getDouble("controlDataVarience");
        break;
      case "testDataVarience":
        testDataVarience = data.getDouble("testDataVarience");
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
    playerDataObject.setDouble("controlDataVarience", controlDataVarience);
    playerDataObject.setDouble("testDataVarience", testDataVarience);    
    playerDataObject.setJSONArray("damagesDelt", damagesDelt);
    playerDataObject.setJSONArray("frameDamageDelt", frameDamageDelt);
    playerDataObject.setJSONObject("tilesets", tilesets);
    playerDataObject.setJSONArray("weaponAffixes", weaponAffixes);
    playerDataObject.setJSONArray("controlDpsData", controlDpsData);
    playerDataObject.setJSONArray("testDpsData", testDpsData);
    println(playerDataObject);
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
  private FloatList controlDpsAverages = new FloatList();
  private FloatList testDpsAverages = new FloatList();
  private JSONObject objectToReturn = new JSONObject();
  private float previousTotalFrames = 0;

  // calcAvg func may return something, void may be temporary return type
  private void calcAvg() {
    if (frameDamageDelt.size() > 1 && damagesDelt.size() > 1) {
      float currentHitDamageDelt = damagesDelt.get(damagesDelt.size()-1);
      float currentHitFrameDamageDelt = frameDamageDelt.get(frameDamageDelt.size()-1) - frameDamageDelt.get(frameDamageDelt.size()-2);
      previousTotalFrames = frameDamageDelt.get(frameDamageDelt.size()-2);
      float totalDamage = 0;
      for (int i = 0; i < damagesDelt.size(); i++) {
        totalDamage+= damagesDelt.get(i);
      }
      float avgDpf = totalDamage/frameDamageDelt.get(frameDamageDelt.size()-1);
      //multiply damage per frame by framerate to get damage per second
      avgDps = avgDpf * frameRate;
      testDpsAverages.append(avgDps);
      controlDpsAverages.append(avgDps);
      println(avgDpf, avgDps);
      // println();
    } else if (frameDamageDelt.size() == 1 && damagesDelt.size() == 1) {
      float avgDpf = damagesDelt.get(damagesDelt.size()-1) / frameDamageDelt.get(frameDamageDelt.size()-1);
      avgDps = avgDpf * frameRate;
      testDpsAverages.append(avgDps);
      controlDpsAverages.append(avgDps);
    }
  }

  JSONObject returnFloatLists() {    
    JSONArray damageDataToReturn = new JSONArray();
    JSONArray frameDataToReturn = new JSONArray();
    JSONArray controlDpsDataToReturn = new JSONArray();
    JSONArray testDpsDataToReturn = new JSONArray();
    for (int i = 0; i < damagesDelt.size(); i++) {
      try {
        damageDataToReturn.setFloat(i, damagesDelt.get(i));
      } 
      catch(ArrayIndexOutOfBoundsException e) {
        damageDataToReturn.setFloat(i, 0);
      }
      //println(damageDataToReturn.getJSONArray(0));
    }
    for (int i = 0; i < frameDamageDelt.size(); i++) {
      try {
        frameDataToReturn.setFloat(i, frameDamageDelt.get(i));
      } 
      catch(ArrayIndexOutOfBoundsException e) {
        ;
        frameDataToReturn.setFloat(i, 0);
      }
    }
    for (int i = 0; i < controlDpsAverages.size(); i++) {
      try {
        controlDpsDataToReturn.setFloat(i, controlDpsAverages.get(i));
      } 
      catch(ArrayIndexOutOfBoundsException e) {
        controlDpsDataToReturn.setFloat(i, 0);
      }
    }
    for (int i = 0; i < testDpsAverages.size(); i++) {
      try {
        testDpsDataToReturn.setFloat(i, testDpsAverages.get(i));
      } 
      catch(ArrayIndexOutOfBoundsException e) {
        testDpsDataToReturn.setFloat(i, 0);
      }
    }
    objectToReturn.setJSONArray("damagesDelt", damageDataToReturn);
    objectToReturn.setJSONArray("frameDamageDelt", frameDataToReturn);
    objectToReturn.setJSONArray("controlDpsData", controlDpsDataToReturn);
    objectToReturn.setJSONArray("testDpsData", testDpsDataToReturn);
    testDpsAverages.clear();
    controlDpsAverages.clear();

    //println(objectToReturn);
    return objectToReturn;
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
