#include <a_samp>
#include <Dini>
#define PlayerFile 	       		"Bank/%s.ini"
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
enum PLAYER_MAIN {
    Deposit,
};
new pInfo[MAX_PLAYERS][PLAYER_MAIN];
new chosenpid;
public OnFilterScriptInit()
{
SetTimer("CallConnect",1,0);
return 1;
}
forward CallConnect(playerid);
public CallConnect(playerid)
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
OnPlayerConnect(i);
}
return 1;
}
public OnPlayerConnect(playerid)
{
    SetPlayerMapIcon(playerid, 12, -1600.1012,897.7770,9.2266, 52, 1);
  	new file[100],Name[MAX_PLAYER_NAME]; GetPlayerName(playerid,Name,sizeof(Name)); format(file,sizeof(file),PlayerFile,Name);
	if(!dini_Exists(file)) {
		dini_Create(file);
		dini_IntSet(file,"Deposit",pInfo[playerid][Deposit]);
	}
	else if(dini_Exists(file))
	{
	pInfo[playerid][Deposit] = dini_Int(file,"Deposit");
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
return 1;
}
public OnPlayerPickUpPickup(playerid,pickupid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
 	new file[100],Name[MAX_PLAYER_NAME]; GetPlayerName(playerid,Name,sizeof(Name)); format(file,sizeof(file),PlayerFile,Name);
	dini_IntSet(file,"Deposit",pInfo[playerid][Deposit]);
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 1122) //deposit
    {
 		new file[100],Name[MAX_PLAYER_NAME]; GetPlayerName(playerid,Name,sizeof(Name)); format(file,sizeof(file),PlayerFile,Name);
        if(!response) return ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Bank","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
        else if(strval(inputtext) > GetPlayerMoney(playerid)) return SendClientMessage(playerid,COLOR_RED,"Tu no tienes esta cantidad de dinero");
        else if(!IsNumeric(inputtext))
        {
        new string[128];
        format(string,sizeof(string),"Tu saldo actual es de : %d\nPon la cantidad de dinero que quieres depositar :",pInfo[playerid][Deposit]);
       	ShowPlayerDialog(playerid,1122,DIALOG_STYLE_INPUT,"Depositar",string,"Depositar","Atras");
        SendClientMessage(playerid,COLOR_RED,"Por favor usa numeros");
        }
		else
		{
  		GivePlayerMoney(playerid,-strval(inputtext));
		pInfo[playerid][Deposit] += strval(inputtext);
		new string[128];
		format(string,sizeof(string),"Tu has depositado : %d$",strval(inputtext));
		SendClientMessage(playerid,COLOR_YELLOW,string);
		dini_IntSet(file,"Deposit",pInfo[playerid][Deposit]);
		new string2[128]; format(string2,128,"Tu nuevo saldo es de : %d$",pInfo[playerid][Deposit]);
		SendClientMessage(playerid,COLOR_YELLOW,string2);
		ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
		}
		return 1;
    }
	if(dialogid == 1123) //withdraw
	{
  		new file[100],Name[MAX_PLAYER_NAME]; GetPlayerName(playerid,Name,sizeof(Name)); format(file,sizeof(file),PlayerFile,Name);
     	if(!response) return ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
     	else if(strval(inputtext) > pInfo[playerid][Deposit]) return SendClientMessage(playerid,COLOR_RED,"Tu no tienes tanto dinero en el banco!");
        else if(!IsNumeric(inputtext))
        {
        new string[128];
        format(string,sizeof(string),"Tu saldo actual es de :%d\nPon la cantidad que quieres sacar del banco :",pInfo[playerid][Deposit]);
        ShowPlayerDialog(playerid,1123,DIALOG_STYLE_INPUT,"Sacar dinero",string,"Sacar dinero","Atras");
        SendClientMessage(playerid,COLOR_RED,"Por favor usa numeros");
        }
		else
		{
		GivePlayerMoney(playerid,strval(inputtext));
		pInfo[playerid][Deposit] -= strval(inputtext);
		new string[128];
		format(string,sizeof(string),"Tu has sacado : %d$",strval(inputtext));
		SendClientMessage(playerid,COLOR_YELLOW,string);
		dini_IntSet(file,"Deposit",pInfo[playerid][Deposit]);
		new string2[128]; format(string2,128,"Tu nuevo saldo es de : %d$",pInfo[playerid][Deposit]);
		SendClientMessage(playerid,COLOR_YELLOW,string2);
		ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
		}
		return 1;
	}
	if(dialogid == 1124)
	{
	if(!response) return ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
	else
	{
    ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
    }
    return 1;
    }
    if(dialogid == 1130) //transfer (choose playerid)
	{
     	if(!response) return ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
     	else if(strval(inputtext) == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED,"El jugador no esta conectado");
        else if(!IsNumeric(inputtext))
        {
        new string[128];
	    format(string,sizeof(string),"Tu saldo actual es de Is :%d$\nPon la id del jugador al que quieres transferir el dinero :",pInfo[playerid][Deposit]);
	    ShowPlayerDialog(playerid,1130,DIALOG_STYLE_INPUT,"Transferir",string,"Siguiente","Atras");
        SendClientMessage(playerid,COLOR_RED,"Por favor usa una id, no un nombre");
        }
		else
		{
		chosenpid = strval(inputtext);
		new string[128];
		format(string,sizeof(string),"Tu saldo : %d\nElige una Id de un jugador : %d\nAhora pon la cantidad que quieres transferir",pInfo[playerid][Deposit],chosenpid);
		ShowPlayerDialog(playerid,1131,DIALOG_STYLE_INPUT,"Transferir",string,"Transferir","Atras");
		}
		return 1;
	}
	if(dialogid == 1131) //transfer (choose amount)
	{
  		new file[100],Name[MAX_PLAYER_NAME]; GetPlayerName(playerid,Name,sizeof(Name)); format(file,sizeof(file),PlayerFile,Name);
     	if(!response) return ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
     	else if(strval(inputtext) > pInfo[playerid][Deposit]) return SendClientMessage(playerid,COLOR_RED,"Tu no tienes esa cantidad de dinero para transferir");
        else if(!IsNumeric(inputtext))
        {
        new string[128];
		format(string,sizeof(string),"Elige una Id de un jugador : %d\nAhora pon la cantidad que quieres transferir",chosenpid);
		ShowPlayerDialog(playerid,1131,DIALOG_STYLE_INPUT,"Transferir",string,"Transferir","Atras");
        SendClientMessage(playerid,COLOR_RED,"Por favor usa numeros");
        }
		else
		{
		pInfo[playerid][Deposit] -= strval(inputtext);
		pInfo[chosenpid][Deposit] += strval(inputtext);
		new string[128];
		format(string,sizeof(string),"Tu transfieres %d$ a la cuenta del banco de la Id %d",strval(inputtext),chosenpid);
		SendClientMessage(playerid,COLOR_YELLOW,string);
		dini_IntSet(file,"Deposit",pInfo[playerid][Deposit]);
		new string2[128]; format(string2,128,"Tu nuevo saldo es de : %d$",pInfo[playerid][Deposit]);
		SendClientMessage(playerid,COLOR_YELLOW,string2);
		new string3[128]; format(string3,128,"ID : %d ha transferido %d$ a tu cuenta del banco",playerid,strval(inputtext));
		SendClientMessage(chosenpid,COLOR_YELLOW,string3);
		new string4[128]; format(string4,128,"Tu saldo es de : %d$",pInfo[chosenpid][Deposit]);
		SendClientMessage(chosenpid,COLOR_YELLOW,string4);
		ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
		}
		return 1;
	}
	if(dialogid == 1125 && response) // /bank
		 {
		 	switch(listitem)
	    	{
	        	case 0:
		        {
		            new string[128];
		            format(string,sizeof(string),"Tu saldo actual es de : %d$\nPon la cantidad de dinero que quieres depositar :",pInfo[playerid][Deposit]);
	              	ShowPlayerDialog(playerid,1122,DIALOG_STYLE_INPUT,"Depositar",string,"Depositar","Atras");

	 			}
	 			case 1:
		        {
		            new string[128];
		            format(string,sizeof(string),"Tu saldo actual es de :%d\nPon la cantidad que quieres sacar del banco :",pInfo[playerid][Deposit]);
		            ShowPlayerDialog(playerid,1123,DIALOG_STYLE_INPUT,"Sacar dinero",string,"Sacar dinero","Atras");
	 			}
	 			case 2:
		        {
	              	new string[128];
					format(string,sizeof(string),"Tu saldo es de %d$",pInfo[playerid][Deposit]);
					ShowPlayerDialog(playerid,1124,DIALOG_STYLE_MSGBOX,"Saldo",string,"Aceptar","Atras");
	 			}
	 			case 3:
		        {
					new string[128];
		            format(string,sizeof(string),"Tu saldo actual es de :%d$\nPon la id del jugador al que quieres transferir el dinero :",pInfo[playerid][Deposit]);
		            ShowPlayerDialog(playerid,1130,DIALOG_STYLE_INPUT,"Transferir",string,"Siguiente","Atras");
	 			}
	 		}
	 	}
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
dcmd(bank,4,cmdtext);
dcmd(banktele,8,cmdtext);
return 0;
}
dcmd_bank(playerid,params[])
{
#pragma unused params
if(!IsPlayerInRangeOfPoint(playerid,15.0,322.4866,119.6555,1003.2194)) return SendClientMessage(playerid,COLOR_RED,"Tu estas en el Banco");
else
{
ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Banco","DEPOSITAR\nSACAR DINERO\nTU SALDO\nTRANSFERIR DINERO","Seleccionar","Cancelar");
}
return 1;
}
dcmd_banktele(playerid,params[])
{
#pragma unused params
SetPlayerPos(playerid,322.4866,119.6555,1003.2194);
SendClientMessage(playerid,COLOR_YELLOW,"Te has teleportado al Banco");
SetPlayerFacingAngle(playerid,180.0);
SetCameraBehindPlayer(playerid);
return 1;
}


//------------------[SSCANF]-------------------------------------
stock sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(string))
	#else
		if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{

				new changestr[16], changepos = 0, strpos = stringPos;
				while(changepos < 16 && string[strpos] && string[strpos] != delim)
				{
					changestr[changepos++] = string[strpos++];
    				}
				changestr[changepos] = '\0';
				setarg(paramPos,0,_:floatstr(changestr));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach (Player, playerid)
					{
      GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}
stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
