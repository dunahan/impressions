string PrintLocation(location lLocation);
int GetItemHeigth(object oItem);
int GetItemWidth(object oItem);
int GetFullBoxesForInventory(object oItem);
void MoveItemBoxwise(object oItem);

void main()
{
  object oPC = OBJECT_SELF;
  object oItem = GetFirstItemInInventory(oPC);
  while (GetIsObjectValid(oItem))
  {
    MoveItemBoxwise(oItem);
    oItem = GetNextItemInInventory(oPC);
  }

  if (!GetIsObjectValid(oPC))
    FloatingTextStringOnCreature("Dunno what to do!", GetFirstPC(), FALSE);
}

string PrintLocation(location lLocation)
{
  vector vecLoc = GetPositionFromLocation(lLocation);

  return GetResRef(GetAreaFromLocation(lLocation))+"|"+
         FloatToString(vecLoc.x,3,3)+"|"+
         FloatToString(vecLoc.y,3,3)+"|"+
         FloatToString(vecLoc.z,3,3)+"|"+
         FloatToString(GetFacingFromLocation(lLocation),3,3);
}

int GetItemHeigth(object oItem)
{
  return StringToInt(Get2DAString("baseitems", "InvSlotHeight", GetBaseItemType(oItem)));
}

int GetItemWidth(object oItem)
{
  return StringToInt(Get2DAString("baseitems", "InvSlotWidth", GetBaseItemType(oItem)));
}

int GetFullBoxesForInventory(object oItem)
{
  return GetItemHeigth(oItem)*GetItemWidth(oItem);
}

void MoveItemBoxwise(object oItem)
{
  object oBox; int nBoxes = GetFullBoxesForInventory(oItem), nItemWidth = GetItemWidth(oItem);

  if (nBoxes == 1 ||                                    // sort out itemsize 1 OR
      nBoxes == 3 ||                                    // sort out itemsize 3 OR
      nBoxes == 4 && nItemWidth == 2  ||                // sort out itemsize 4 AND sqare-size OR
      nBoxes >= 5 && nBoxes <= 35)                      // sort out itemsize 5+ AND is equal/smaller then plc inv boxes (7*5)
    oBox = GetObjectByTag(IntToString(nBoxes)+"_box");

  else if (nBoxes == 2 && nItemWidth == 1)
    oBox = GetObjectByTag(IntToString(nBoxes)+"h_box");

  else if (nBoxes == 2 && nItemWidth > 1)
    oBox = GetObjectByTag(IntToString(nBoxes)+"w_box");

  else if (nBoxes == 4 && nItemWidth == 1)
    oBox = GetObjectByTag(IntToString(nBoxes)+"h_box");


  if (GetIsObjectValid(oBox)) // transport only if target valid
  {
    CopyItem(oItem, oBox, TRUE);
    DestroyObject(oItem, 0.5f);
  }
                              // something is oversized or is not possible yet
  else
    SendMessageToPC(GetItemPossessor(oItem), "Not possible");
}
