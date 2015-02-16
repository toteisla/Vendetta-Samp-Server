//-------------------------------------------------
//
// Based on kyeman's vactions script
//
//-------------------------------------------------

#include <a_samp>
#include <core>
#include <float>
#define FILTERSCRIPT
#pragma tabsize 0
#define WHITE 0xFFFFFFFF
#define COLOR_UNEMD 0x99CEFFFF
#define COLOR_ORANGE 0xffcc00FF
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GREEN 0x33AA33AA
#define COLOR_USAGE 0xEFEFF7AA
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new IsOnePlayAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];
new BackOut[MAX_PLAYERS];
new animation[200];

AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	IsOnePlayAnim[playerid] = 1;
	animation[playerid]++;
}
BackAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp,animback)
{
    BackOut[playerid] = animback;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
    animation[playerid]++;
}
LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    gPlayerUsingLoopingAnim[playerid] = 1;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
    animation[playerid]++;
}

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SPRINT)
	{
		if(gPlayerUsingLoopingAnim[playerid] == 1)
		{
			gPlayerUsingLoopingAnim[playerid] = 0;
    		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
        	animation[playerid] = 0;
        }
        if(IsOnePlayAnim[playerid] == 1)
        {
            ClearAnimations(playerid);
            IsOnePlayAnim[playerid] = 0;
            animation[playerid] = 0;
        }
        if(BackOut[playerid] == 1)
        {
			ApplyAnimation(playerid,"SUNBATHE","parksit_m_out",3.0,0,0,0,0,0);
        }
        if(BackOut[playerid] == 2)
        {
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
        }
        if(BackOut[playerid] == 4)
        {
			ApplyAnimation(playerid,"CAR_CHAT","carfone_out",3.0,0,0,0,0,0);
        }
        if(BackOut[playerid] == 5)
        {
			ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_out",3.0,0,0,0,0,0);
        }
        if(BackOut[playerid] == 6)
        {
			ApplyAnimation(playerid,"ON_LOOKERS","shout_out",3.0,0,0,0,0,0);
        }
        if(BackOut[playerid] == 7)
        {
			ApplyAnimation(playerid,"ON_LOOKERS","pointup_out",3.0,0,0,0,0,0);
        }
        if(BackOut[playerid] == 8)
        {
			ApplyAnimation(playerid,"PED","seat_up",3.0,0,0,0,0,0);
        }
        BackOut[playerid] = 0;
    }
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(gPlayerUsingLoopingAnim[playerid] == 1)
	{
 		gPlayerUsingLoopingAnim[playerid] = 0;
	}
	if(IsOnePlayAnim[playerid] == 1)
	{
 		IsOnePlayAnim[playerid] = 0;
	}
	if(BackOut[playerid] == 1)
	{
	    BackOut[playerid] = 0;
	}
 	return 1;
}

public OnPlayerSpawn(playerid)
{
    AntiDeAMX();
	if(gPlayerAnimLibsPreloaded[playerid] == 0)
	{
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
    gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	IsOnePlayAnim[playerid] = 0;
	BackOut[playerid] = 0;
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
//--------------------------[For FilterScript "Anims"]--------------------------
   		PreloadAnimLib(playerid,"BOMBER"); PreloadAnimLib(playerid,"RAPPING");
    	PreloadAnimLib(playerid,"SHOP"); PreloadAnimLib(playerid,"BEACH");
   		PreloadAnimLib(playerid,"SMOKING"); PreloadAnimLib(playerid,"FOOD");
    	PreloadAnimLib(playerid,"ON_LOOKERS"); PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK"); PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT"); PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE"); PreloadAnimLib(playerid,"PED");
		PreloadAnimLib(playerid,"MISC"); PreloadAnimLib(playerid,"OTB");
		PreloadAnimLib(playerid,"BD_Fire"); PreloadAnimLib(playerid,"BENCHPRESS");
		PreloadAnimLib(playerid,"KISSING"); PreloadAnimLib(playerid,"BSKTBALL");
		PreloadAnimLib(playerid,"MEDIC"); PreloadAnimLib(playerid,"SWORD");
		PreloadAnimLib(playerid,"POLICE"); PreloadAnimLib(playerid,"SUNBATHE");
		PreloadAnimLib(playerid,"FAT"); PreloadAnimLib(playerid,"WUZI");
		PreloadAnimLib(playerid,"SWEET"); PreloadAnimLib(playerid,"ROB_BANK");
		PreloadAnimLib(playerid,"GANGS"); PreloadAnimLib(playerid,"RIOT");
		PreloadAnimLib(playerid,"GYMNASIUM"); PreloadAnimLib(playerid,"CAR");
		PreloadAnimLib(playerid,"CAR_CHAT"); PreloadAnimLib(playerid,"GRAVEYARD");
		PreloadAnimLib(playerid,"POOL");
//------------------------------------------------------------------------------
}
public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new tmp[256];
	new idx;
	new dancestyle;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd,"/anims",true)==0)
	{
		SendClientMessage(playerid,COLOR_ORANGE,". : : Animations 160+ v.1.2f : : .");
	    SendClientMessage(playerid,COLOR_UNEMD,"/fall /injured /push /handsup /kiss /cell /slap /bomb /drunk /laugh");
        SendClientMessage(playerid,COLOR_UNEMD,"/basket /medic /spray /robman /taichi /lookout /sit /lay /sup /crossarms");
        SendClientMessage(playerid,COLOR_UNEMD,"/deal /crack /smoke /chat /hike /dance /fuck /strip /lean /walk /rap /caract");
        SendClientMessage(playerid,COLOR_UNEMD,"/tired /box /scratch /hide /vomit /eats /cop /stance /wave /run");
        SendClientMessage(playerid,COLOR_UNEMD,"/flag /giver /look /show /shout /endchat /face /pull");
        SendClientMessage(playerid,COLOR_GREEN,"  To Stop The Animations Press SPACE,LMB or ENTER");
        return true;
	}
//-----------------------------------[InCarAnims]----------------------------------------------
   	if(strcmp(cmd, "/caract", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid,COLOR_GRAD1,"  This action is available only as car driver !");
			return 1;
		}
        if (!strlen(cmdtext[8])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /caract [1-7]");
    	switch (cmdtext[8])
    	{
         	case '1': LoopingAnim(playerid,"PED","TAP_HAND",4.0,1,0,0,0,0);
        	case '2': LoopingAnim(playerid,"CAR", "sit_relaxed", 4.0, 1, 0, 0, 0, 0);
        	case '3': LoopingAnim(playerid,"CAR", "tap_hand", 4.0, 1, 0, 0, 0, 0);
        	case '4': BackAnim(playerid,"CAR_CHAT", "carfone_in", 4.0,0,1,1,1,0,3);
        	case '5': LoopingAnim(playerid,"CAR_CHAT", "carfone_loopa", 4.0, 1, 0, 0, 0, 0);
        	case '6': LoopingAnim(playerid,"CAR_CHAT", "carfone_loopb", 4.0, 1, 0, 0, 0, 0);
        	case '7': OnePlayAnim(playerid,"DRIVEBYS","Gang_DrivebyLHS",3.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /caract [1-7]");
    	}
    	return 1;
    }
//------------------------------------[OnFootAnims]--------------------------------------------
    if(strcmp(cmd, "/scratch", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
	 	LoopingAnim(playerid,"MISC","Scratchballs_01",3.0,1,0,0,0,0);
   		return 1;
    }
    if(strcmp(cmd, "/giver", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /giver [1-2]");
    	switch (cmdtext[6])
    	{
         	case '1': OnePlayAnim(playerid,"KISSING","gift_give",3.0,0,0,0,0,0);
         	case '2': OnePlayAnim(playerid,"BAR","Barserve_give",3.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /giver [1-2]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/pull", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
	 	OnePlayAnim(playerid,"AIRPORT","thrw_barl_thrw ",3.0,0,0,0,0,0);
   		return 1;
    }
    if(strcmp(cmd, "/face", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /face [1-6]");
    	switch (cmdtext[6])
    	{
         	case '1': LoopingAnim(playerid,"PED","facanger",3.0,1,1,1,1,1);
        	case '2': LoopingAnim(playerid,"PED","facgum",3.0,1,1,1,1,1);
        	case '3': LoopingAnim(playerid,"PED","facsurp",3.0,1,1,1,1,1);
        	case '4': LoopingAnim(playerid,"PED","facsurpm",3.0,1,1,1,1,1);
        	case '5': LoopingAnim(playerid,"PED","factalk",3.0,1,1,1,1,1);
        	case '6': LoopingAnim(playerid,"PED","facurios",3.0,1,1,1,1,1);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /face [1-6]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/endchat", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[9])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /endchat [1-3]");
    	switch (cmdtext[9])
    	{
         	case '1': OnePlayAnim(playerid,"PED","endchat_01",8.0,0,0,0,0,0);
        	case '2': OnePlayAnim(playerid,"PED","endchat_02",8.0,0,0,0,0,0);
        	case '3': OnePlayAnim(playerid,"PED","endchat_03",8.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /endchat [1-3]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/show", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        LoopingAnim(playerid,"ON_LOOKERS","point_loop",3.0,1,0,0,0,0);
    	return 1;
    }
    if(strcmp(cmd, "/shout", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /shout [1-3]");
    	switch (cmdtext[7])
    	{
         	case '1': BackAnim(playerid,"ON_LOOKERS","shout_loop",3.0,1,0,0,0,0,6);
        	case '2': LoopingAnim(playerid,"ON_LOOKERS","shout_01",3.0,1,0,0,0,0);
        	case '3': LoopingAnim(playerid,"ON_LOOKERS","shout_02",3.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /shout [1-3]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/look", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /look [1-4]");
    	switch (cmdtext[6])
    	{
         	case '1': LoopingAnim(playerid,"ON_LOOKERS","lkup_loop",3.0,1,0,0,0,0);
        	case '2': LoopingAnim(playerid,"ON_LOOKERS","lkaround_loop",3.0,1,0,0,0,0);
        	case '3': LoopingAnim(playerid,"PED","flee_lkaround_01",3.0,1,1,1,1,1);
        	case '4': OnePlayAnim(playerid,"BAR","Barserve_bottle",3.0,0,1,1,1,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /look [1-4]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/flag", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
	 	OnePlayAnim(playerid,"CAR","flag_drop",3.0,0,0,0,0,0);
   		return 1;
    }
 	if(strcmp(cmd, "/handsup", true) == 0)
 	{
 	    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		LoopingAnim(playerid, "ROB_BANK","SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 0);
        return 1;
    }
   	if(strcmp(cmd, "/cell", true) == 0)
 	{
 		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		ClearAnimations(playerid);
  		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
    	BackOut[playerid] = 2;
		return 1;
	}
	if(strcmp(cmd, "/drunk", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /drunk [1-3]");
    	switch (cmdtext[7])
    	{
         	case '1': LoopingAnim(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
        	case '2': LoopingAnim(playerid,"PAULNMAC", "pnm_loop_a", 3.0, 1, 0, 0, 0, 0);
        	case '3': LoopingAnim(playerid,"PAULNMAC", "pnm_loop_b", 3.0, 1, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /drunk [1-3]");
    	}
    	return 1;
    }
   	if(strcmp(cmd, "/run", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
    	tmp = strtok(cmdtext,idx);
        if (!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_USAGE,"TIP: /run [1-11]"); return 1;
		}
    	new animid = strval(tmp);
        if(animid == 1) { LoopingAnim(playerid,"FAT","FatRun",4.0,1,1,1,1,1); }
        else if(animid == 2) { LoopingAnim(playerid,"PED","run_player",4.0,1,1,1,1,1); }
        else if(animid == 3) { LoopingAnim(playerid,"PED","jog_femaleA",4.0,1,1,1,1,1); }
        else if(animid == 4) { LoopingAnim(playerid,"PED","jog_maleA",4.0,1,1,1,1,1); }
        else if(animid == 5) { LoopingAnim(playerid,"PED","run_old",4.0,1,1,1,1,1); }
        else if(animid == 6) { LoopingAnim(playerid,"PED","run_left",4.0,1,1,1,1,1); }
        else if(animid == 7) { LoopingAnim(playerid,"PED","run_fatold",4.0,1,1,1,1,1); }
        else if(animid == 8) { LoopingAnim(playerid,"PED","run_gang1",4.0,1,1,1,1,1); }
        else if(animid == 9) { LoopingAnim(playerid,"PED","run_fat",4.0,1,1,1,1,1); }
        else if(animid == 10) { LoopingAnim(playerid,"PED","run_right",4.0,1,1,1,1,1); }
        else if(animid == 11) { LoopingAnim(playerid,"PED","run_wuzi",4.0,1,1,1,1,1); }
        else { SendClientMessage(playerid,COLOR_USAGE,"TIP: /run [1-11]"); }
    	return 1;
    }
   	if(strcmp(cmd, "/bomb", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /bomb [1-2]");
    	switch (cmdtext[6])
    	{
         	case '1': LoopingAnim(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
        	case '2': OnePlayAnim(playerid,"MISC", "plunger_01", 2.0, 0, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /bomb [1-2]");
    	}
    	return 1;
    }
    if (strcmp("/laugh", cmdtext, true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
 		OnePlayAnim(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
	  	return 1;
	}
    if (strcmp("/lookout", cmdtext, true) == 0)
	{
          
		  return 1;
	}
	if(strcmp(cmd, "/lookout", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[9])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /lookout [1-2]");
    	switch (cmdtext[9])
    	{
         	case '1': OnePlayAnim(playerid, "FOOD", "eat_vomit_sk", 4.0,0,0,0,0,0);
        	case '2': OnePlayAnim(playerid, "PED", "handscower", 4.0,0,1,1,1,1);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /lookout [1-2]");
    	}
    	return 1;
    }
	if(strcmp(cmd, "/robman", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[8])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /robman [1-2]");
    	switch (cmdtext[8])
    	{
         	case '1': LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob
        	case '2': LoopingAnim(playerid,"PED", "gang_gunstand", 4.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /robman [1-2]");
    	}
    	return 1;
    }
	if(strcmp(cmd, "/crossarms", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[11])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /crossarms [1-2]");
    	switch (cmdtext[11])
    	{
         	case '1': LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
        	case '2': LoopingAnim(playerid,"OTB", "wtchrace_loop", 4.0, 1, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /crossarms [1-2]");
    	}
    	return 1;
    }
	if(strcmp(cmd, "/lay", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /lay [1-9]");
    	switch (cmdtext[5])
    	{
        	case '1': LoopingAnim(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
        	case '2': LoopingAnim(playerid,"BEACH", "parksit_w_loop", 4.0, 1, 0, 0, 0, 0);
        	case '3': LoopingAnim(playerid,"BEACH","parksit_m_loop", 4.0, 1, 0, 0, 0, 0);
        	case '4': LoopingAnim(playerid,"BEACH","lay_bac_loop", 4.0, 1, 0, 0, 0, 0);
        	case '5': LoopingAnim(playerid,"BEACH","sitnwait_loop_w", 4.0, 1, 0, 0, 0, 0);
         	case '6': BackAnim(playerid,"SUNBATHE","Lay_Bac_in",3.0,0,1,1,1,0,5);
         	case '7': LoopingAnim(playerid,"SUNBATHE","batherdown",3.0,0,1,1,1,0);
         	case '8': BackAnim(playerid,"SUNBATHE","parksit_m_in",3.0,0,1,1,1,0,1);
         	case '9': LoopingAnim(playerid,"CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /lay [1-9]");
    	}
    	return 1;
    }
   	if(strcmp(cmd, "/hide", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /hide [1-2]");
    	switch (cmdtext[6])
    	{
         	case '1': LoopingAnim(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
        	case '2': LoopingAnim(playerid,"ON_LOOKERS","panic_hide",3.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /hide [1-2]");
    	}
    	return 1;
    }
    if (strcmp("/vomit", cmdtext, true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
	      OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!
		  return 1;
	}
    if (strcmp("/eats", cmdtext, true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
 		OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger
	  	return 1;
	}
	if(strcmp(cmd, "/wave", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /wave [1-5]");
    	switch (cmdtext[6])
    	{
         	case '1': LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);
        	case '2': OnePlayAnim(playerid,"BD_Fire", "BD_GF_Wave", 4.0, 0, 0, 0, 0, 0);
        	case '3': LoopingAnim(playerid,"RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
        	case '4': OnePlayAnim(playerid,"WUZI", "Wuzi_Follow", 5.0, 0, 0, 0, 0, 0);
        	case '5': OnePlayAnim(playerid,"KISSING", "gfwave2", 4.0, 0, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /wave [1-5]");
    	}
    	return 1;
    }
   	if(strcmp(cmd, "/slap", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /slap [1-2]");
    	switch (cmdtext[6])
    	{
         	case '1': OnePlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
        	case '2': LoopingAnim(playerid,"MISC","Bitchslap",4.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /slap [1-2]");
    	}
    	return 1;
    }
    if (strcmp("/deal", cmdtext, true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		OnePlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs
		return 1;
	}
	if(strcmp(cmd, "/crack", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /crack [1-5]");
    	switch (cmdtext[7])
    	{
        	case '1': LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
        	case '2': LoopingAnim(playerid,"CRACK", "crckidle1", 4.0, 1, 0, 0, 0, 0);
        	case '3': LoopingAnim(playerid,"CRACK","crckidle2", 4.0, 1, 0, 0, 0, 0);
        	case '4': LoopingAnim(playerid,"CRACK","crckidle3", 4.0, 1, 0, 0, 0, 0);
        	case '5': LoopingAnim(playerid,"CRACK","crckidle4", 4.0, 1, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /crack [1-5]");
    	}
    	return 1;
    }
	if(strcmp(cmd, "/smoke", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /smoke [1-6]");
    	switch (cmdtext[7])
    	{
        	case '1': LoopingAnim(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // male
        	case '2': LoopingAnim(playerid,"SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); //female
        	case '3': LoopingAnim(playerid,"SMOKING","M_smkstnd_loop", 4.0, 1, 0, 0, 0, 0); // standing-fucked
        	case '4': OnePlayAnim(playerid,"SMOKING","M_smk_out", 4.0, 0, 0, 0, 0, 0); // standing
        	case '5': OnePlayAnim(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0);
        	case '6': OnePlayAnim(playerid,"SMOKING","M_smk_tap",3.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /smoke [1-6]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/chat", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /chat [1-3]");
    	switch (cmdtext[6])
    	{
        	case '1': LoopingAnim(playerid,"PED","IDLE_CHAT",2.0,1,0,0,1,1);
        	case '2': LoopingAnim(playerid,"MISC","IDLE_CHAT_02",2.0,1,0,0,1,1);
        	case '3': OnePlayAnim(playerid,"BAR","Barcustom_order",3.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /chat [1-3]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/hike", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /hike [1-3]");
    	switch (cmdtext[6])
    	{
        	case '1': LoopingAnim(playerid,"MISC","hiker_pose",4.0,1,0,0,0,0);
        	case '2': LoopingAnim(playerid,"MISC","hiker_pose_l",4.0,1,0,0,0,0);
        	case '3': OnePlayAnim(playerid,"PED","idle_taxi",3.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /hike [1-3]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/fuck", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /fuck [1-2]");
    	switch (cmdtext[6])
    	{
        	case '1': OnePlayAnim(playerid,"PED","fucku",4.0,0,0,0,0,0);
         	case '2': OnePlayAnim(playerid,"RIOT","RIOT_FUKU",2.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /fuck [1-2]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/taichi", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		 LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
         return 1;
    }
    if(strcmp(cmd, "/sit", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /sit [1-4]");
    	switch (cmdtext[5])
    	{
        	case '1': BackAnim(playerid,"PED","SEAT_down",4.1,0,1,1,1,0,8);
         	case '2': LoopingAnim(playerid,"MISC","seat_lr",2.0,1,0,0,0,0);
         	case '3': LoopingAnim(playerid,"MISC","seat_talk_01",2.0,1,0,0,0,0);
         	case '4': LoopingAnim(playerid,"MISC","seat_talk_02",2.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /sit [1-4]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/fall", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /fall [1-2]");
    	switch (cmdtext[6])
    	{
        	case '1': LoopingAnim(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
         	case '2': LoopingAnim(playerid, "PED","FLOOR_hit_f", 4.0, 1, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /fall [1-2]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/kiss", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /kiss [1-2]");
    	switch (cmdtext[6])
    	{
        	case '1': OnePlayAnim(playerid, "KISSING", "Playa_Kiss_02", 3.0, 0, 0, 0, 0, 0);
         	case '2': OnePlayAnim(playerid, "BD_Fire", "grlfrd_kiss_03", 2.0, 0, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /kiss [1-2]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/injured", true) == 0)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[9])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /injured [1-4]");
    	switch (cmdtext[9])
    	{
        	case '1': LoopingAnim(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
         	case '2': LoopingAnim(playerid, "WUZI", "CS_Dead_Guy", 4.0, 1, 1, 1, 1, 1);
         	case '3': LoopingAnim(playerid, "PED", "gas_cwr", 4.0, 1, 1, 1, 1, 1);
         	case '4': LoopingAnim(playerid, "FINALE", "FIN_Cop1_Loop", 4.0, 1, 0, 0, 0, 0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /injured [1-4]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/sup", true) == 0)
    {
   		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /sup [1-3]");
    	switch (cmdtext[5])
    	{
        	case '1': OnePlayAnim(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
         	case '2': OnePlayAnim(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
         	case '3': OnePlayAnim(playerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /sup [1-3]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/rap", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /rap [1-5]");
    	switch (cmdtext[5])
    	{
    	    case '1': LoopingAnim(playerid,"RAPPING","RAP_A_Loop",4.0,1,0,0,0,0);
        	case '2': LoopingAnim(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
        	case '3': LoopingAnim(playerid,"GANGS","prtial_gngtlkD",4.0,1,0,0,0,0);
        	case '4': LoopingAnim(playerid,"GANGS","prtial_gngtlkH",4.0,1,0,0,1,1);
        	case '5': OnePlayAnim(playerid,"BENCHPRESS","gym_bp_celebrate",4.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /rap [1-5]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/push", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /push [1-2]");
    	switch (cmdtext[6])
    	{
        	case '1': OnePlayAnim(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
        	case '2': OnePlayAnim(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /push [1-2]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/spray", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		OnePlayAnim(playerid,"SPRAYCAN","spraycan_full",4.0,0,0,0,0,0);
		return 1;
    }
    if(strcmp(cmd, "/medic", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		OnePlayAnim(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
		return 1;
    }
    if(strcmp(cmd, "/tired", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /tired [1-2]");
    	switch (cmdtext[7])
    	{
        	case '1': LoopingAnim(playerid,"PED","IDLE_tired",3.0,1,0,0,0,0);
        	case '2': OnePlayAnim(playerid,"FAT","Idle_Tired",3.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /tired [1-2]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/box", true) == 0)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
		LoopingAnim(playerid,"GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,0);
		return 1;
    }
    if(strcmp(cmd, "/cop", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /cop [1-7]");
    	switch (cmdtext[5])
    	{
        	case '1': OnePlayAnim(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
        	case '2': LoopingAnim(playerid,"POLICE","CopTraf_away",4.0,1,0,0,0,0);
        	case '3': LoopingAnim(playerid,"POLICE","CopTraf_come",4.0,1,0,0,0,0);
        	case '4': LoopingAnim(playerid,"POLICE","CopTraf_left",4.0,1,0,0,0,0);
        	case '5': LoopingAnim(playerid,"POLICE","CopTraf_stop",4.0,1,0,0,0,0);
        	case '6': LoopingAnim(playerid,"POLICE","Cop_move_fwd",4.0,1,1,1,1,1);
	        case '7': LoopingAnim(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /cop [1-7]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/stance", true) == 0)
    {
   		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
    	tmp = strtok(cmdtext,idx);
        if (!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_USAGE,"TIP: /stance [1-13]"); return 1;
		}
    	new animid = strval(tmp);
        if(animid == 1) { LoopingAnim(playerid,"DEALER","DEALER_IDLE",4.0,1,0,0,0,0); }
        else if(animid == 2) { LoopingAnim(playerid,"PED","WOMAN_IDLESTANCE",4.0,1,0,0,0,0); }
       	else if(animid == 3) { LoopingAnim(playerid,"PED","CAR_HOOKERTALK",4.0,1,0,0,0,0); }
       	else if(animid == 4) { LoopingAnim(playerid,"FAT","FatIdle",4.0,1,0,0,0,0); }
       	else if(animid == 5) { LoopingAnim(playerid,"WUZI","Wuzi_Stand_Loop",4.0,1,0,0,0,0); }
       	else if(animid == 6) { LoopingAnim(playerid,"GRAVEYARD","mrnf_loop",4.0,1,0,0,0,0); }
       	else if(animid == 7) { LoopingAnim(playerid,"GRAVEYARD","mrnm_loop",4.0,1,0,0,0,0); }
       	else if(animid == 8) { LoopingAnim(playerid,"GRAVEYARD","prst_loopa",4.0,1,0,0,0,0); }
       	else if(animid == 9) { LoopingAnim(playerid,"PED","idlestance_fat",4.0,1,0,0,0,0); }
       	else if(animid == 10) { LoopingAnim(playerid,"PED","idlestance_old",4.0,1,0,0,0,0); }
       	else if(animid == 11) { LoopingAnim(playerid,"PED","turn_l",4.0,1,0,0,0,0); }
       	else if(animid == 12) { LoopingAnim(playerid,"BAR","Barcustom_loop",4.0,1,0,0,0,0); }
       	else if(animid == 13) { LoopingAnim(playerid,"BAR","Barserve_loop",4.0,1,0,0,0,0); }
        else { SendClientMessage(playerid,COLOR_USAGE,"TIP: /stance [1-13]"); }
    	return 1;
    }
    if(strcmp(cmd, "/basket", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[8])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /basket [1-4]");
    	switch (cmdtext[8])
    	{
        	case '1': LoopingAnim(playerid,"BSKTBALL","BBALL_idleloop",4.0,1,0,0,0,0);
        	case '2': OnePlayAnim(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
        	case '3': LoopingAnim(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
        	case '4': LoopingAnim(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /basket [1-4]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/walk", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
    	tmp = strtok(cmdtext,idx);
        if (!strlen(tmp))
		{
			SendClientMessage(playerid,COLOR_USAGE,"TIP: /walk [1-14]"); return 1;
		}
		new animid = strval(tmp);
        if(animid == 1) { LoopingAnim(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1); }
        else if(animid == 2) { LoopingAnim(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1); }
        else if(animid == 3) { LoopingAnim(playerid,"FAT","FatWalk",4.1,1,1,1,1,1); }
        else if(animid == 4) { LoopingAnim(playerid,"WUZI","CS_Wuzi_pt1",4.1,1,1,1,1,1); }
        else if(animid == 5) { LoopingAnim(playerid,"WUZI","Wuzi_walk",3.0,1,1,1,1,1); }
       	else if(animid == 6) { LoopingAnim(playerid,"POOL","Pool_walk",3.0,1,1,1,1,1); }
        else if(animid == 7) { LoopingAnim(playerid,"PED","Walk_player",3.0,1,1,1,1,1); }
        else if(animid == 8) { LoopingAnim(playerid,"PED","Walk_old",3.0,1,1,1,1,1); }
        else if(animid == 9) { LoopingAnim(playerid,"PED","Walk_fatold",3.0,1,1,1,1,1); }
        else if(animid == 10) { LoopingAnim(playerid,"PED","woman_walkfatold",3.0,1,1,1,1,1); }
        else if(animid == 11) { LoopingAnim(playerid,"PED","woman_walknorm",3.0,1,1,1,1,1); }
        else if(animid == 12) { LoopingAnim(playerid,"PED","woman_walkold",3.0,1,1,1,1,1); }
        else if(animid == 13) { LoopingAnim(playerid,"PED","woman_walkpro",3.0,1,1,1,1,1); }
        else if(animid == 14) { LoopingAnim(playerid,"PED","woman_walkshop",3.0,1,1,1,1,1); }
        else { SendClientMessage(playerid,COLOR_USAGE,"TIP: /walk [1-14]"); }
    	return 1;
    }
    if(strcmp(cmd, "/lean", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /lean [1-3]");
    	switch (cmdtext[6])
    	{
        	case '1': LoopingAnim(playerid,"GANGS","leanIDLE",4.0,0,1,1,1,0);
        	case '2': LoopingAnim(playerid,"MISC","Plyrlean_loop",4.0,0,1,1,1,0);
        	case '3': OnePlayAnim(playerid,"BAR","BARman_idle",3.0,0,1,1,1,0);
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /lean [1-3]");
    	}
    	return 1;
    }
    if(strcmp(cmd, "/strip", true) == 0)
    {
    	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,COLOR_USAGE,"TIP: /strip [A-G]");
    	switch (cmdtext[7])
    	{
        	case 'a', 'A': LoopingAnim(playerid,"STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1 );
        	case 'b', 'B': LoopingAnim(playerid,"STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1 );
        	case 'c', 'C': LoopingAnim(playerid,"STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1 );
        	case 'd', 'D': LoopingAnim(playerid,"STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1 );
        	case 'e', 'E': LoopingAnim(playerid,"STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1 );
        	case 'f', 'F': LoopingAnim(playerid,"STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1 );
        	case 'g', 'G': LoopingAnim(playerid,"STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1 );
        	default: SendClientMessage(playerid,COLOR_USAGE,"TIP: /strip [A-G]");
    	}
    	return 1;
    }
 	if(strcmp(cmd, "/dance", true) == 0)
 	{
 		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) { return 1; }
 		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) { SendClientMessage(playerid,COLOR_USAGE,"TIP: /dance [style 1-4]"); return 1; }
		dancestyle = strval(tmp);
		if(dancestyle < 1 || dancestyle > 4)
		{ SendClientMessage(playerid,COLOR_USAGE,"TIP: /dance [style 1-4]"); return 1; }
		if(dancestyle == 1) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1); }
		else if(dancestyle == 2) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2); }
		else if(dancestyle == 3) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3); }
		else if(dancestyle == 4) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4); }
		return 1;
	}
	if(strcmp(cmd,"/customization",true)==0)
    {
		new lib[50];
		lib = strtok(cmdtext, idx);
		if(!strlen(lib)) { return 1; }
		new anim[256];
		anim = strtok(cmdtext, idx);
		if(!strlen(anim)) { return 1; }
		LoopingAnim(playerid,lib,anim,3.0,1,1,1,1,1);
		return 1;
	}
	return 0;
}
