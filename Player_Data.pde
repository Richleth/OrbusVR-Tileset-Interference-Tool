class PlayerDataMain {
  private HashMap<String, PlayerDataElement> playerDataElements = new HashMap<String, PlayerDataElement>();
  private ArrayList<String> playerDataElementKeys = new ArrayList<String>();

  PlayerDataElement getPlayerDataElement(String s) {
    return playerDataElements.get(s);
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
  private float controlTestResult;

  PlayerDataElement(String pName, float controlTestR) {
    playerName = pName;
    controlTestResult = controlTestR;
  }
  
  void updateControlTestResult(float controlTestR) {
    controlTestResult = controlTestR;
  }

  String returnPlayerName() {
    return playerName;
  }
  float returnControlTestResult() {
    return controlTestResult;
  }
}
