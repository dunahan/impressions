#include "_impress_inc"

void main()
{
    string sTemplate;   int nRandom = d2();

    if (nRandom == 1)   sTemplate = "nw_commale";
    else                sTemplate = "nw_comfemale";

    object oNSC = CreateObject(OBJECT_TYPE_CREATURE, sTemplate, GetLocation(GetWaypointByTag("NSC_SpawnIn")));
    AssignCommand(oNSC, ActionRandomWalk());

    SetX2DefsOnCreature(oNSC);
    SetEventScript(oNSC, EVENT_SCRIPT_CREATURE_ON_NOTICE, "_impress_cre_per");
}

