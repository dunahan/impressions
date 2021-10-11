#include "_impress_inc"

void main()
{
    object oItem = GetModuleItemLost();
    object oPC   = GetModuleItemLostBy();
    ScanForVisibleItemsOnPC(oPC);

    ExecuteScript("x2_mod_def_unaqu");
}
