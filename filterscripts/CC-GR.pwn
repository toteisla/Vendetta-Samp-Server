//------------------------------------------------------//
//------------------------------------------------------//
//------------------------------------------------------//
/*
		+-------------------------------------+
		|                                     |
		|         Creador de Camaras          |
		|            Por GROVE4L              |
		|       www.pawnoscripting.com        |
		|                                     |
		+-------------------------------------+

*/
//------------------------------------------------------//
//------------------------------------------------------//
//------------------------------------------------------//

#include <a_samp>

#define FILTERSCRIPT

new PasosC[MAX_PLAYERS];
new ObjetoC[MAX_PLAYERS];
new TCamara[MAX_PLAYERS];

new Text:ControlesG0[MAX_PLAYERS];
new Text:ControlesG1[MAX_PLAYERS];
new Text:ControlesG2[MAX_PLAYERS];
new Text:ControlesG3[MAX_PLAYERS];
new Text:ControlesG4[MAX_PLAYERS];
new Text:ControlesG5[MAX_PLAYERS];

forward Camara(playerid);

public OnPlayerCommandText(playerid, cmdtext[])
{
 	if(strcmp("/CrearCamara", cmdtext, true, 10) == 0)
	{
	    if(PasosC[playerid] == 0)
	    {
			ShowPlayerDialog(playerid,159,DIALOG_STYLE_MSGBOX,"Creador de Camara || Por GROVE4L (Paso 1)","Bien, primero ponte en el lugar donde quieres posicionar la camara.\nCuando estes en la posicion deseada, pulsa \"F\" ","Seguir","Salir");
			return 1;
		}
	}
	return 0;
}

public OnPlayerSpawn(playerid)
{
	/*ControlesG0[playerid] = TextDrawCreate(27.000000,126.000000,"_");
	ControlesG1[playerid] = TextDrawCreate(35.000000,133.000000,"~y~Controles");
	ControlesG2[playerid] = TextDrawCreate(36.000000,175.000000,"Abajo: ~g~~k~~PED_LOCK_TARGET~");
	ControlesG3[playerid] = TextDrawCreate(35.000000,157.000000,"Arriba: ~g~~k~~PED_FIREWEAPON~");
	ControlesG4[playerid] = TextDrawCreate(36.000000,195.000000,"Adelante: ~g~~k~~PED_SPRINT~~n~~w~~n~Atras: ~g~~k~~PED_JUMPING~");
	ControlesG5[playerid] = TextDrawCreate(37.000000,238.000000,"Izq: ~g~4 PadNumerico ~n~~n~~w~Der: ~g~6 PadNumerico");*/

    ControlesG0[playerid] = TextDrawCreate(27.000000,126.000000,"_");
	ControlesG1[playerid] = TextDrawCreate(35.000000,133.000000,"~y~Controles");
	ControlesG2[playerid] = TextDrawCreate(36.000000,175.000000,"~g~~k~~PED_LOCK_TARGET~");
	ControlesG3[playerid] = TextDrawCreate(35.000000,157.000000,"~g~~k~~PED_FIREWEAPON~");
	ControlesG4[playerid] = TextDrawCreate(36.000000,195.000000,"~g~~k~~PED_SPRINT~~n~~n~~k~~PED_JUMPING~");
	ControlesG5[playerid] = TextDrawCreate(37.000000,238.000000,"~g~4 PadNumerico ~n~~n~6 PadNumerico");
	TextDrawUseBox(ControlesG0[playerid],1);
	TextDrawBoxColor(ControlesG0[playerid],0x00000099);
	TextDrawTextSize(ControlesG0[playerid],217.000000,-64.00000);
	TextDrawAlignment(ControlesG0[playerid],0);
	TextDrawAlignment(ControlesG1[playerid],0);
	TextDrawAlignment(ControlesG2[playerid],0);
	TextDrawAlignment(ControlesG3[playerid],0);
	TextDrawAlignment(ControlesG4[playerid],0);
	TextDrawAlignment(ControlesG5[playerid],0);
	TextDrawBackgroundColor(ControlesG0[playerid],0x000000ff);
	TextDrawBackgroundColor(ControlesG1[playerid],0x000000ff);
	TextDrawBackgroundColor(ControlesG2[playerid],0x000000ff);
	TextDrawBackgroundColor(ControlesG3[playerid],0x000000ff);
	TextDrawBackgroundColor(ControlesG4[playerid],0x000000ff);
	TextDrawBackgroundColor(ControlesG5[playerid],0x000000ff);
	TextDrawFont(ControlesG0[playerid],1);
	TextDrawLetterSize(ControlesG0[playerid],1.000000,17.000000);
	TextDrawFont(ControlesG1[playerid],1);
	TextDrawLetterSize(ControlesG1[playerid],0.699999,1.800000);
	TextDrawFont(ControlesG2[playerid],2);
	TextDrawLetterSize(ControlesG2[playerid],0.399999,1.600000);
	TextDrawFont(ControlesG3[playerid],2);
	TextDrawLetterSize(ControlesG3[playerid],0.399999,1.500000);
	TextDrawFont(ControlesG4[playerid],2);
	TextDrawLetterSize(ControlesG4[playerid],0.399999,1.300000);
	TextDrawFont(ControlesG5[playerid],2);
	TextDrawLetterSize(ControlesG5[playerid],0.399999,1.200000);
	TextDrawColor(ControlesG0[playerid],0xffffffff);
	TextDrawColor(ControlesG1[playerid],0xffffffff);
	TextDrawColor(ControlesG2[playerid],0xffffffff);
	TextDrawColor(ControlesG3[playerid],0xffffffff);
	TextDrawColor(ControlesG4[playerid],0xffffffff);
	TextDrawColor(ControlesG5[playerid],0xffffffff);
	TextDrawSetOutline(ControlesG0[playerid],1);
	TextDrawSetOutline(ControlesG1[playerid],1);
	TextDrawSetOutline(ControlesG2[playerid],1);
	TextDrawSetOutline(ControlesG3[playerid],1);
	TextDrawSetOutline(ControlesG4[playerid],1);
	TextDrawSetOutline(ControlesG5[playerid],1);
	TextDrawSetProportional(ControlesG0[playerid],1);
	TextDrawSetProportional(ControlesG1[playerid],1);
	TextDrawSetProportional(ControlesG2[playerid],1);
	TextDrawSetProportional(ControlesG3[playerid],1);
	TextDrawSetProportional(ControlesG4[playerid],1);
	TextDrawSetProportional(ControlesG5[playerid],1);
	TextDrawSetShadow(ControlesG0[playerid],1);
	TextDrawSetShadow(ControlesG1[playerid],1);
	TextDrawSetShadow(ControlesG2[playerid],1);
	TextDrawSetShadow(ControlesG3[playerid],1);
	TextDrawSetShadow(ControlesG4[playerid],1);
	TextDrawSetShadow(ControlesG5[playerid],1);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 159)
	{
        if(response)
		{
	        PasosC[playerid] = 1;
	        TogglePlayerControllable(playerid, 1);
	        return 1;
		}
		else
		{
			TogglePlayerControllable(playerid, 1);
			SendClientMessage(playerid,0xCBCCCEFF,"Cancelaste en el Paso 1 de 3");
			PasosC[playerid] = 0;
			return 1;
		}
	}
	if(dialogid == 357)
	{
	    if(response)
	    {
	        TogglePlayerControllable(playerid, 0);
		    new Float:X, Float:Y, Float:Z, Float:X2, Float:Y2;
			GetPlayerPos(playerid, X, Y, Z);
			GetXYInFrontOfPlayer(playerid, X2, Y2, 0.5);
			SetPlayerCameraPos(playerid, X2, Y2, Z+0.9);
			ObjetoC[playerid] = CreateObject(2770,X+1,Y+1,Z,0.0,0.0,0.0);
			TCamara[playerid] = SetTimerEx("Camara",150,0,"i",playerid);
			TextDrawShowForPlayer(playerid,ControlesG0[playerid]);
		    TextDrawShowForPlayer(playerid,ControlesG1[playerid]);
		    TextDrawShowForPlayer(playerid,ControlesG2[playerid]);
		    TextDrawShowForPlayer(playerid,ControlesG3[playerid]);
		    TextDrawShowForPlayer(playerid,ControlesG4[playerid]);
		    TextDrawShowForPlayer(playerid,ControlesG5[playerid]);
			return 1;
		}
		else
		{
		    TogglePlayerControllable(playerid, 1);
			SendClientMessage(playerid,0xCBCCCEFF,"Cancelaste en el Paso 2 de 3");
			PasosC[playerid] = 0;
			return 1;
		}
	}
	if(dialogid == 258)
	{
	    if(response)
	    {
		    SetCameraBehindPlayer(playerid);
		    TogglePlayerControllable(playerid, 1);
		    new string2[256];
		    format(string2, sizeof(string2), "Archivo de Camara guardado como: %s.txt || Buscalo en la carpeta \"scripfiles => GCamaras\"", inputtext);
		    SendClientMessage(playerid,0xCBCCCEFF,string2);
		    PasosC[playerid] = 0;
	        new string[100];
			format(string, sizeof(string), "GCamaras/%s.txt", inputtext);
			new File: hFile = fopen(string, io_write);

			new Float:JX, Float:JY, Float:JZ, Float:OX, Float:OY, Float:OZ;
			GetPlayerPos(playerid,JX,JY,JZ);
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			DestroyObject(ObjetoC[playerid]);
			if(hFile)
			{
			    new var[200];
			    format(var, 200, "[=====================================================================================================]\r\n");fwrite(hFile, var);
			    format(var, 200, " \r\n");fwrite(hFile, var);
			    format(var, 200, "Codigo de Camara || FS por GROVE4L\r\n");fwrite(hFile, var);
			    format(var, 200, " \r\n");fwrite(hFile, var);
			    format(var, 200, "SetPlayerCameraPos(playerid,%.0f.000,%.0f.000,%.0f.000);\r\n", JX,JY,JZ+0.9);fwrite(hFile, var);
			    format(var, 200, "SetPlayerCameraLookAt(playerid,%.0f.000,%.0f.000,%.0f.000);\r\n", OX,OY,OZ);fwrite(hFile, var);
                format(var, 200, " \r\n");fwrite(hFile, var);
				format(var, 200, "Coloca este codigo en donde quieras.\r\n");fwrite(hFile, var);
				format(var, 200, " \r\n");fwrite(hFile, var);
				format(var, 200, "Ejemplo:\r\n");fwrite(hFile, var);
				format(var, 200, "if(strcmp(\"/camara1\", cmdtext, true, 10) == 0)\r\n");fwrite(hFile, var);
				format(var, 200, "{\r\n");fwrite(hFile, var);
				format(var, 200, "	SetPlayerCameraPos(playerid,%.0f.000,%.0f.000,%.0f.000);\r\n", JX,JY,JZ+0.9);fwrite(hFile, var);
			    format(var, 200, "	SetPlayerCameraLookAt(playerid,%.0f.000,%.0f.000,%.0f.000);\r\n", OX,OY,OZ);fwrite(hFile, var);
			    format(var, 200, "	return 1;\r\n");fwrite(hFile, var);
			    format(var, 200, "}\r\n");fwrite(hFile, var);
			    format(var, 200, " \r\n");fwrite(hFile, var);
			    format(var, 200, "Creador de Camara por GROVE4L\r\n");fwrite(hFile, var);
			    format(var, 200, "[=====================================================================================================]\r\n");fwrite(hFile, var);
				fclose(hFile);
			    return 1;
			}
		}
		else
		{
		    TogglePlayerControllable(playerid, 1);
			SendClientMessage(playerid,0xCBCCCEFF,"Cancelaste en el Paso 3 de 3");
			PasosC[playerid] = 0;
			DestroyObject(ObjetoC[playerid]);
			return 1;
		}
	}
	return 1;
}

public Camara(playerid)
{
	new Float:OX, Float:OY, Float:OZ;
	GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
	SetPlayerCameraLookAt(playerid, OX,OY,OZ);
	TCamara[playerid] = SetTimerEx("Camara",150,0,"i",playerid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & (KEY_SECONDARY_ATTACK)) == (KEY_SECONDARY_ATTACK))
	{
	    if(PasosC[playerid] == 1)
	    {
	        ShowPlayerDialog(playerid,357,DIALOG_STYLE_MSGBOX,"Creador de Camara || Por GROVE4L (Paso 2)","Bien, ahora mueve el Objeto hacia la direccion donde quieras que mire la camara\nCuando estes en la posicion deseada, pulsa \"F\" ","Seguir","Salir");
	        PasosC[playerid] = 2;
	        return 1;
		}
		else if(PasosC[playerid] == 2)
		{
		    TextDrawHideForPlayer(playerid,ControlesG0[playerid]);
		    TextDrawHideForPlayer(playerid,ControlesG1[playerid]);
		    TextDrawHideForPlayer(playerid,ControlesG2[playerid]);
		    TextDrawHideForPlayer(playerid,ControlesG3[playerid]);
		    TextDrawHideForPlayer(playerid,ControlesG4[playerid]);
		    TextDrawHideForPlayer(playerid,ControlesG5[playerid]);
		    ShowPlayerDialog(playerid,258, DIALOG_STYLE_INPUT,"Creador de Camara || Por GROVE4L (Paso 3)","Listo. Por ultimo coloca el nombre con el que deceas guardar el archivo.","Seguir","Salir");
			KillTimer(TCamara[playerid]);
			PasosC[playerid] = 3;
		}
	}
	if((newkeys & (KEY_FIRE)) == (KEY_FIRE))
	{
	    if(PasosC[playerid] == 2)
	    {
			new Float:OX, Float:OY, Float:OZ;
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			MoveObject(ObjetoC[playerid],OX,OY,OZ+0.3,300000);
	  		return 1;
		}
	}
	if((newkeys & (KEY_HANDBRAKE)) == (KEY_HANDBRAKE))
	{
	    if(PasosC[playerid] == 2)
	    {
			new Float:OX, Float:OY, Float:OZ;
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			MoveObject(ObjetoC[playerid],OX,OY,OZ-0.1,300000);
	  		return 1;
		}
	}
	
	if((newkeys & (KEY_ANALOG_LEFT)) == (KEY_ANALOG_LEFT))
	{
	    if(PasosC[playerid] == 2)
	    {
			new Float:OX, Float:OY, Float:OZ;
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			MoveObject(ObjetoC[playerid],OX,OY+0.1,OZ,300000);
	  		return 1;
		}
	}
	
 	if((newkeys & (KEY_ANALOG_RIGHT)) == (KEY_ANALOG_RIGHT))
	{
	    if(PasosC[playerid] == 2)
	    {
			new Float:OX, Float:OY, Float:OZ;
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			MoveObject(ObjetoC[playerid],OX,OY-0.1,OZ,300000);
	  		return 1;
		}
	}
	if((newkeys & (KEY_JUMP)) == (KEY_JUMP))
	{
	    if(PasosC[playerid] == 2)
	    {
			new Float:OX, Float:OY, Float:OZ;
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			MoveObject(ObjetoC[playerid],OX+0.1,OY,OZ,300000);
	  		return 1;
		}
	}
	if((newkeys & (KEY_SPRINT)) == (KEY_SPRINT))
	{
	    if(PasosC[playerid] == 2)
	    {
			new Float:OX, Float:OY, Float:OZ;
			GetObjectPos(ObjetoC[playerid],OX,OY,OZ);
			MoveObject(ObjetoC[playerid],OX-0.1,OY,OZ,300000);
	  		return 1;
		}
	}
	
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}


//						 	Creador de Camaras por GROVE4L
// 								www.pawnoscripting.com
