#include "_impress_inc"

void main()
{
    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();
    ScanForVisibleItemsOnPC(oPC);

    ExecuteScript("x2_mod_def_equ");
}
