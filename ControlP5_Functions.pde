void Player_Chosen(int n) {
  /* request the selected item based on index n */
  String tName = playerDropdown.get(ScrollableList.class, "Player_Chosen").getItem(n)+"";
  String[] pieces = split(tName, ",");
  String[] subPieces = split(pieces[16], "=");
  name = subPieces[1];
  nameGiven = true;
  println(name);
}
void Crit_Damage(int n) {
  /* request the selected item based on index n */
  String tName = critDamageDropdown.get(ScrollableList.class, "Crit_Damage").getItem(n)+"";
  String[] pieces = split(tName, ",");
  String[] subPieces = split(pieces[16], "=");
  critDamagePlus = critDamagePlusGivenMultipliers.get(subPieces[1]);
  critDamagePlusGiven = true;
  println(subPieces[1], critDamagePlus);
}
