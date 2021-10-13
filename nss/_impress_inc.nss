#include "x2_inc_switches"
#include "x2_inc_intweapon"
#include "x3_inc_horse"
const int INVENTORY_BOXES_PER_PAGE = 60;
const int INVENTORY_PAGES_PER_TOON = 6;
const int PLACEABLE_INV_BOXES_PAGE = 35;
const int IMPRESS_ITM_WORN_ON_TOON = 3;

string HELP = "First at all, this chat is not case sensitive =)\n"+
              "For spawning in a NPC for testing purposes, chat hello\n"+
              "Getting rid of this annoying NPC, chat away!\n"+
              "Strip off of your inventory, chat strip\n"+
              "Get your stripped inventory back, chat equip\n"+
              "Give your toon a level up, chat lvlup\n"+
              "See how many impressive items you had while entering, chat found\n"+
              "And at least, recount these items manually, chat count.";


int GetItemSizeInInventory(object oItem)
{
  int nBoxesInInv = FALSE;
  int nBaseItemType = GetBaseItemType(oItem);                                   // from Daz and Shadguy on Discord
  int nInvWidth = StringToInt(Get2DAString("baseitems", "InvSlotWidth", nBaseItemType));
  int nInvHeigt = StringToInt(Get2DAString("baseitems", "InvSlotHeight", nBaseItemType));

  nBoxesInInv = nInvWidth * nInvHeigt;                                          // count the boxes needed for

  return nBoxesInInv;
}


int ScanForVisibleItemsOnPC(object oPC)
{
  int i = 0, n;
  object oItem = GetFirstItemInInventory(oPC);                                  // scan items in inv
  while (GetIsObjectValid(oItem) &&                                             // is it valid AND
         GetItemSizeInInventory(oItem) >= IMPRESS_ITM_WORN_ON_TOON)             // it's box-size is greater than 3, so it must be worn
  {
    i++;                                                                        // count it as visible
    oItem = GetNextItemInInventory(oPC);
  }

  for (n=0; n<=6; n++)                                                          // scan the body slots, head to cloak => these are visible, if valid
    i += GetIsObjectValid(GetItemInSlot(n, oPC));

  i += GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BELT, oPC));               // additional, if belt, arrows or bolts are worn, these are visible too
  i += GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
  i += GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));

  SetLocalInt(oPC, "impr_cr", i);                                               // save the visible items
  return i;
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

void DespawnAnnoyingNPC(object oPC)
{
  object oNPC = GetNearestObject(OBJECT_TYPE_CREATURE, oPC);
  while (GetIsObjectValid(oNPC) && GetResRef(oNPC) == "nw_commale" || GetResRef(oNPC) == "nw_comfemale")
  {
    DestroyObject(oNPC, 0.01);
    return;
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
