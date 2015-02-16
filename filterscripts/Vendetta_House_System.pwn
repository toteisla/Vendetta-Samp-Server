#include <a_samp>
#include <a_players>
#include <file>
#include <core>
#include <utils>
#include <morphinc>

#define COLOR_GREY 0xAFAFAFAA

new File: hFile;

forward split(const strsrc[], strdest[][], delimiter);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

enum hinfo
{
    Owner[24],
	CostPrice,
	Float:EnterPos[3],
	Float:TelePos[3],
	SellPrice,
	Interior,
};
new HouseInfo[MAX_PLAYERS][hinfo];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" House System By Tote_Vendetta");
	print("--------------------------------------\n");
	
	new idx = 0;
	new string[32] = "Casas.cfg";
    hFile = fopen(string, io_read);
	if(hFile)
    {
        new strLine[10][256];
        new line[256];
        while ( fread( hFile , line , sizeof( line ) ) )
        {
            split(line, strLine, '|');
            HouseInfo[idx][Owner] = strval(strLine[0]);
            HouseInfo[idx][CostPrice] = strval(strLine[1]);
            HouseInfo[idx][EnterPos][0] = strval(strLine[2]);
            HouseInfo[idx][EnterPos][1] = strval(strLine[3]);
            HouseInfo[idx][EnterPos][2] = strval(strLine[4]);
            HouseInfo[idx][TelePos][0] = strval(strLine[5]);
            HouseInfo[idx][TelePos][1] = strval(strLine[6]);
            HouseInfo[idx][TelePos][2] = strval(strLine[7]);
            HouseInfo[idx][SellPrice] = strval(strLine[8]);
            HouseInfo[idx][Interior] = strval(strLine[9]);
        }
    }
	return 1;
}

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 1;
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

public OnFilterScriptExit()
{
	new idx = 0;
	while (idx < sizeof(HouseInfo))
	{
		new strLine[256];
		format(strLine, sizeof(strLine), "%s|%d|%f|%f|%f|%f|%f|%f|%d|%d\n",
		HouseInfo[idx][Owner],
		HouseInfo[idx][CostPrice],
		HouseInfo[idx][EnterPos],
		HouseInfo[idx][EnterPos],
		HouseInfo[idx][EnterPos],
		HouseInfo[idx][TelePos],
		HouseInfo[idx][TelePos],
		HouseInfo[idx][TelePos],
		HouseInfo[idx][SellPrice],
		HouseInfo[idx][Interior]);
		if(idx == 0)
		{
			hFile = fopen("Casas.cfg", io_write);
		}
		else
		{
			hFile = fopen("Casas.cfg", io_append);
		}
		fwrite(hFile, strLine);
		idx++;
		fclose(hFile);
    }
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new nombre[24];
	new cmd[256];
	new tmp[256];
	new idx;
	cmd = strtok(cmdtext, idx);
//------------------------------<[ Comandos ]>-----------------------------------------------------------
	if(strcmp(cmd, "/comprarcasa", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			for(new i=0 ; i<MAX_PLAYERS ; i++)
			{
			    new Float:coordX = HouseInfo[i][EnterPos][0];
				new Float:coordY = HouseInfo[i][EnterPos][1];
				new Float:coordZ = HouseInfo[i][EnterPos][2];
			    if(PlayerToPoint(5.0, playerid, coordX, coordY, coordZ))
			    {
			        if(GetPlayerMoney(playerid) >= HouseInfo[i][SellPrice] && strcmp(HouseInfo[i][Owner], "none") == 0)
			        {
			            GetPlayerName(playerid, nombre, sizeof(nombre));
			            HouseInfo[i][Owner] = nombre;
			        }
			    }
			}
	    }
	    return 1;
	}//fin comprar casa
	
	if(strcmp(cmd, "/vendercasa", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        tmp = strtok(cmdtext, idx);
	        if(!strlen(tmp) || !IsNumeric(tmp))
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   USO: /vendercasa [id]");
	            return 1;
	        }
	        else
	        {
	            for(new i=0 ; i<MAX_PLAYERS ; i++)
				{
				    new Float:coordX = HouseInfo[i][EnterPos][0];
					new Float:coordY = HouseInfo[i][EnterPos][1];
					new Float:coordZ = HouseInfo[i][EnterPos][2];
					new comprador = ReturnUser(tmp);
				    if(PlayerToPoint(5.0, playerid, coordX, coordY, coordZ) && PlayerToPoint(5.0, comprador, coordX, coordY, coordZ))
				    {
				        GetPlayerName(playerid, nombre, sizeof(nombre));
				        if(strcmp(HouseInfo[i][Owner], nombre) == 0)//comprueba que la casa es del vendedor
				        {
				            if(GetPlayerMoney(comprador) >= HouseInfo[i][SellPrice])//comprueba que el comprador tiene dinero suficiente
					        {
					            GetPlayerName(comprador, nombre, sizeof(nombre));
					            HouseInfo[i][Owner] = nombre;
					        }
				        }
				    }
				}
	        }//fin else
	    }
	    return 1;
	}//fin vender casa
	
	if(strcmp(cmd, "/entrarcasa", true) == 0)
	{
		if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        for(new i=0 ; i<MAX_PLAYERS ; i++)
			{
			    new Float:coordX = HouseInfo[i][EnterPos][0];
				new Float:coordY = HouseInfo[i][EnterPos][1];
				new Float:coordZ = HouseInfo[i][EnterPos][2];
			    if(PlayerToPoint(5.0, playerid, coordX, coordY, coordZ))
			    {
			        GetPlayerName(playerid, string, sizeof(string));
			        if(strcmp(HouseInfo[i][Owner], string) == 0)// comprueba que el tio es el dueño
			        {
			            coordX = HouseInfo[i][TelePos][0];
				 		coordY = HouseInfo[i][TelePos][1];
				 		coordZ = HouseInfo[i][TelePos][2];
				        SetPlayerPos(playerid, coordX, coordY, coordZ);
				        SetPlayerInterior(playerid, HouseInfo[i][Interior]);
			        }
			    }
			}
	    }
	    return 1;
 	}
 	
 	if(strcmp(cmd, "/salircasa", true) == 0)
	{
		if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        for(new i=0 ; i<MAX_PLAYERS ; i++)
			{
			    new Float:coordX = HouseInfo[i][TelePos][0];
				new Float:coordY = HouseInfo[i][TelePos][1];
				new Float:coordZ = HouseInfo[i][TelePos][2];
			    if(PlayerToPoint(5.0, playerid, coordX, coordY, coordZ))
			    {
			        GetPlayerName(playerid, string, sizeof(string));
			        if(strcmp(HouseInfo[i][Owner], string) == 0)// comprueba que el tio es el dueño
			        {
			            coordX = HouseInfo[i][EnterPos][0];
				 		coordY = HouseInfo[i][EnterPos][1];
				 		coordZ = HouseInfo[i][EnterPos][2];
				        SetPlayerPos(playerid, coordX, coordY, coordZ);
				        SetPlayerInterior(playerid, 0);
			        }
			    }
			}
	    }
	    return 1;
 	}
 	return 0;
}//fin comandos

