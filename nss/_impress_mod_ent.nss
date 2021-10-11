#include "_impress_inc"

void main()
{
    object oPC = GetEnteringObject();
    ScanForVisibleItemsOnPC(oPC);

    ExecuteScript("x3_mod_def_enter");
}

