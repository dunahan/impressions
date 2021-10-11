#include "_impress_inc"

void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC   = GetPCItemLastUnequippedBy();
    ScanForVisibleItemsOnPC(oPC);

    ExecuteScript("x2_mod_def_unequ");
}
