#include "_impress_inc"

void main()
{
    object oItem = GetModuleItemAcquired();
    object oPC   = GetModuleItemAcquiredBy();
    ScanForVisibleItemsOnPC(oPC);

    ExecuteScript("x2_mod_def_aqu");
}
