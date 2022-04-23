# OrbusVR-Tileset-Interference-Tool
A tool to analyze how well tilesets perform in OrbusVR

This program attempts to analyse the real damage boost your tiles give on average in an isolated test with the testing dummies.

To do this the progam analyses DPS for 2 Minutes 30 seconds without tilesets and then compares against the DPS with tilesets to attempt to determine the % boost the equiped tilesets have.

Tilesets that last longer but have worse interference CAN give higher an overall damage boost due to the extra length that the set is active.
 
As tilesets are vastly complicated the best place to learn them is from a master who knows how tilesets work and learn under them.

A very helpful resource is located at the Traveler's Hall Wiki. Provided are a few links.

https://wiki.thehall.xyz/wiki/Alchemy_101_/_Runes_/_Rune_Tile_Making

https://wiki.thehall.xyz/wiki/Alchemy_101_/_Runes_/_Rune_Tile_Making_/_Tileset_Creation

https://wiki.thehall.xyz/wiki/Alchemy_101_/_Runes_/_Rune_Tile_Making_/_Tileset_Creation_/_Timing_and_Interference

 
These resources go over a lot about tiles and are the main thing you need to know about tilesets. Oh how I wish we had this information back in Preborn :(

# ----------IMPORTANT----------
Users must use a non bleed weapon as bleed is inherintly luck based and will throw off results due to extra damage delt!

Users must use a non lightning forged weapon as lightning forged is inherintly luck based and will throw off results due to extra damage delt!

Users must use a non lifesteal weapon as lifesteal is inherintly luck based and will throw off results due to extra tile procs!

Crit however is okay as the code normalizes damage to entirely non crits. This is possible as crits are reported by the combat log and all possible crit damage multipliers are known.
 
Status effects like potions must be the same between both control and sample tests.
 
!!THIS PROGRAM IS ONLY TESTED FOR RUNEMAGE!!

I don't see why it would not work for the other classes but compatability is NOT garunteed.
 
# ----------HOW TO USE----------
 
First you must record a control damage value with NO TILESETS* (*Tilesets can be equiped as long as they do not change between tests. A notable example is any start of combat runes or testing interference between two different sets of tiles.)

Both tests (control and sample) will last for 1 minute and will start as soon as the targeted player (name chosen in the dropdown menu) hits a target dummy.

The control test will provide an average DPS that will be used later in comparison with the sample test to determine the % damage boost the tiles in the sample test give over the control. (This test will be written to the data folder after the control test is complete)

Next, the sample test will largely do the same as the control test but will compare the result with the control and output a percent on the screen telling you how much better or worse the sample test is from the control test.

Note: This percent may have a bit of margin of error so if you feel your results are incorrect; it is advisable to run the sample test again.