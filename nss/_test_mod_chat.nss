#include "_impress_inc"
void givem(object oPC);

void main()
{
    object oPC = GetPCChatSpeaker();
    string sChatMsg = GetPCChatMessage();
           sChatMsg = GetStringLowerCase(sChatMsg);
           sChatMsg = GetStringLeft(sChatMsg, 5);

    if (sChatMsg == "help")
      SendMessageToPC(oPC, HELP);
    if (sChatMsg == "hello")
      ExecuteScript("_spawn_in_common", GetArea(oPC));
    if (sChatMsg == "away!")
      DespawnAnnoyingNPC(oPC);
    if (sChatMsg == "strip")
      MoveItems(oPC);
    if (sChatMsg == "equip")
      GiveBackItems(oPC);
    if (sChatMsg == "lvlup")
      GiveXPToCreature(oPC, (GetHitDice(oPC))*1000);
    if (sChatMsg == "found")
      SendMessageToPC(oPC, "items: "+IntToString(GetLocalInt(oPC, "impr_cr")));
    if (sChatMsg == "count")
      SendMessageToPC(oPC, "scan: "+IntToString(ScanForVisibleItemsOnPC(oPC)));
    if (sChatMsg == "sorty")
      ExecuteScript("_sortinvbyitmsiz", oPC);
    if (sChatMsg == "givem")
      givem(oPC);
}

void givem(object oPC)  // create some test items
{
  CreateItemOnObject("nw_it_medkit001", oPC);
  CreateItemOnObject("nw_wswls001", oPC);
  CreateItemOnObject("nw_wmgst005", oPC);
  CreateItemOnObject("nw_wswbs001", oPC);
  CreateItemOnObject("nw_wplhb001", oPC);
  CreateItemOnObject("x3_it_camp", oPC);
}
