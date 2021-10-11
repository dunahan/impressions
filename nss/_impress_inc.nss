#include "x2_inc_switches"
#include "x2_inc_intweapon"
#include "x3_inc_horse"

string HELP = "First at all, this chat is not case sensitive =)\n"+
              "For spawning in a NPC for testing purposes, chat hello\n"+
              "Strip off of your inventory, chat strip\n"+
              "Get your stripped inventory back, chat equip\n"+
              "Give your toon a level up, chat lvlup\n"+
              "See how many impressive items you had while entering, chat found\n"+
              "And at least, recount these items manually, chat count.";


int IsItemImpressive(object oItem)                                              // irgendwie noch herausarbeiten, wie ein item als beeindruckend gewertet werden kann
{                                                                               // größe, eigenschaften usw.?
  int n = FALSE;

  return GetIsObjectValid(oItem); // n;                                         // aktuell nur ist das item existent!
}

int ScanForVisibleItemsOnPC(object oPC)
{
  int i = 0, n;
  object oItem = GetFirstItemInInventory(oPC);                                  // Was für Items sind im Inv, die sollten dann noch nach größe ausgefiltert werden
  while (GetIsObjectValid(oItem))
  {
     i += IsItemImpressive(oItem);                                              // wenn die ne bestimmte größe überschreiten, dann erst zählen! aktuell mal drin lassen...

    oItem = GetNextItemInInventory(oPC);
  }

  for (n=0; n<=6; n++)                                                          // scan die body slots, kopf bis umhang
    i += IsItemImpressive(GetItemInSlot(n, oPC));

  i += IsItemImpressive(GetItemInSlot(INVENTORY_SLOT_BELT, oPC));               // zusätzlich ausgerüstete(r) gürtel, pfeile und bolzen
  i += IsItemImpressive(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
  i += IsItemImpressive(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));

  SetLocalInt(oPC, "impr_cr", i);
  return i;     // wiedergabe
}

void MoveItems(object oCreature)
{
  object oGiveTo = GetObjectByTag("chest");
  if (!GetIsObjectValid(oGiveTo))
    oGiveTo = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetStartingLocation(), FALSE, "chest");

  object oItem = GetFirstItemInInventory(oCreature);
  while (GetIsObjectValid(oItem))
  {
    CopyItem(oItem, oGiveTo, TRUE);
    DestroyObject(oItem, 0.5f);

    oItem = GetNextItemInInventory(oCreature);
  }
}

void GiveBackItems(object oCreature)
{
  object oGiveTo = GetObjectByTag("chest");
  object oItem = GetFirstItemInInventory(oGiveTo);
  while (GetIsObjectValid(oItem))
  {
    CopyItem(oItem, oCreature, TRUE);
    DestroyObject(oItem, 0.5f);

    oItem = GetNextItemInInventory(oGiveTo);
  }
}

void SetX2DefsOnCreature(object oCreature)
{
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR, "x2_def_onblocked");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_DAMAGED, "x2_def_ondamage");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_DEATH, "x2_def_ondeath");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_DIALOGUE, "x2_def_onconv");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_DISTURBED, "x2_def_ondisturb");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND, "x2_def_endcombat");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT, "x2_def_heartbeat");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED, "x2_def_attacked");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_NOTICE, "x2_def_percept");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_RESTED, "x2_def_rested");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_SPAWN_IN, "x2_def_spawn");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT, "x2_def_spellcast");
    SetEventScript(oCreature, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT, "x2_def_userdef");
}
