#include "_impress_inc"

void main()
{
    object oSeen = GetLastPerceived();
    if (GetLastPerceptionSeen())
      SendMessageToPC(oSeen, "seen: "+GetName(oSeen));
    if (GetLastPerceptionVanished())
      SendMessageToPC(oSeen, "unseen: "+GetName(oSeen));
}
