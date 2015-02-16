/*

	Menu info Vendetta's revenge

*/

#include <a_samp>
#include "../include/gl_common.inc"
#include <progress.inc>

//cosas en comun de los menus
#define DIALOG_BASE_X   	75.0
#define DIALOG_BASE_Y   	110.0
#define DIALOG_WIDTH    	550.0
#define DIALOG_HEIGHT   	150.0

#define NEXT_TEXT   "SIG."
#define PREV_TEXT   "ANT."

//cosas del menu con pestanas

#define SKIN_BASE_X			95.0
#define SKIN_BASE_Y			130.0
#define SKIN_WIDTH			160.0
#define SKIN_HEIGHT			200.0

#define SKILL_BASE_X		320.0
#define SKILL_BASE_Y		150.0
#define SKILL_WIDTH			145.0
#define SKILL_HEIGHT		25.0

#define PESTANA_BASE_X		100.0		
#define PESTANA_BASE_Y		400.0
#define PESTANA_WIDTH		60.0
#define PESTANA_HEIGHT		25.0

#define CAR_BASE_X			100.0
#define CAR_BASE_Y			140.0
#define CAR_WIDTH			160.0
#define CAR_HEIGHT			190.0

#define INVENTARIO_BASE_X  	75.0
#define INVENTARIO_BASE_Y  	135.0
#define INVENTARIO_WIDTH   	445.0
#define INVENTARIO_HEIGHT   235.0
#define MAX_INVENTARIO		18
#define NUM_FILAS_INV		3
#define NUM_COLUMNAS_INV	(MAX_INVENTARIO / NUM_FILAS_INV)

#define INVENTARIO_VACIO_ID 323 

#define NUM_SKILLS	12
#define MAX_NOMBRE_SKILL 20

#define NUM_PESTANAS		4

#define PESTANA_SKILL 		1
#define PESTANA_BANDA 		2
#define PESTANA_COCHES		3
#define PESTANA_INVENTARIO 	4

#define PESTANA_SIN_BANDA 	20 //es especial, no sigue orden

#define SELECTION_COLOR 0xFFFFFFFF//0xFFFF00AA

forward OnPlayerSkillSelection(playerid, response, skillid, pestana);
forward OnPlayerCambiaPestana(playerid, pestana);
forward OnPlayerCarMenuSelection(playerid, carKeyIndex);

new nombrePestana[NUM_PESTANAS][20] = {
"Personal",
"Banda",
"Coches",
"Inventario"
};

#define NUM_OPCIONES_COCHE 6
new opcionesCoche[NUM_OPCIONES_COCHE][20] = {
"Crear copia llaves",
"Cambiar spawn",
"Cambiar colores",
"Llamar grua",
"Aviso robo",
"Cerrar con llave" 
};

new nombreSkills[NUM_SKILLS][MAX_NOMBRE_SKILL] = {
"Contrabando ",
"Robo        ",
"Punteria    ",
"Elocuencia  ",
"SKILL5      ",
"SKILL6      ",
"SKILL7      ",
"SKILL8      ",
"SKILL9      ",
"SKILL10     ",
"SKILL11     ",
"SKILL12     "};

new PlayerText:gBackgroundTextDrawId[MAX_PLAYERS];
new PlayerText:gPlayerSkin[MAX_PLAYERS];
new PlayerText:gHeaderTextDrawId[MAX_PLAYERS];
new PlayerText:gSkillTextDraw[MAX_PLAYERS][NUM_SKILLS];
new PlayerText:gPestanaTextDraw[MAX_PLAYERS][NUM_SKILLS];
new PlayetText:gModeloCocheTextDraw[MAX_PLAYERS];
new PlayerText:gNextButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gPrevButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gOpcionesCoche[MAX_PLAYERS][NUM_OPCIONES_COCHE];
new PlayerText:gInventario[MAX_PLAYERS][MAX_INVENTARIO];

new pestana_actual[MAX_PLAYERS];
new coche_actual[MAX_PLAYERS];

//cosas del menu de la tienda

#define TIENDA_BASE_X  	75.0
#define TIENDA_BASE_Y  	135.0
#define TIENDA_WIDTH   	445.0
#define TIENDA_HEIGHT   235.0
#define SELECTION_ITEMS		18
#define NUM_FILAS_TIENDA	3
#define NUM_COLUMNAS_TIENDA	(SELECTION_ITEMS / NUM_FILAS_TIENDA)
#define NUM_SKINS			24 

forward MenuTiendaHandler(playerid, skinid, precio);

new skinprecio[NUM_SKINS][2] = {
{0, 100}, 
{1, 100},
{2, 500},
{3, 500},
{4, 500},
{5, 500},
{6, 500},
{7, 500},
{8, 500},
{9, 500},
{10, 500},
{11, 500},
{12, 500},
{13, 500},
{14, 500},
{15, 500},
{16, 500},
{17, 500},
{18, 500},
{19, 500},
{20, 500},
{21, 500},
{22, 500},
{23, 500}
};

new PlayerText:gTienda[MAX_PLAYERS][SELECTION_ITEMS];
new pag_actual[MAX_PLAYERS];

// ------------------------------------------------ IMPLEMENTACION -----------------------------------
// fondo
stock PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos, "_"); // ReEdited by AirKite (for universal localization)
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 30.0); // ReEdited by AirKite (for universal localization)
	PlayerTextDrawFont(playerid, txtBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, 0x000000FF);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

// sprites
//skin
stock PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height, clickable)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x000000EE);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, 0.0, 0.0, 0.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, clickable);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

// coche
stock PlayerText:CreateVehPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height, Float:rotX, Float:rotY, Float:rotZ, col1, col2)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x000000EE);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
	PlayerTextDrawSetPreviewVehCol(playerid, txtPlayerSprite, col1, col2);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, rotX, rotY, rotZ);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 0);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

// cabecera/titulo
stock PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.75, 2.0);
	PlayerTextDrawFont(playerid, txtInit, 3);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//ANTERIOR/SIGUIENTE
PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0); // no shadow
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}


// botones
stock PlayerText:CreateButtonTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0); // no shadow
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

// inventario
stock PlayerText:CreateModeloInventario(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, modelindex)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x000000EE);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, Width, Height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, 0.0, 0.0, 0.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

// skills
stock IniSkillTextDraw(playerid, skills[NUM_SKILLS]) {
	new Float:x = SKILL_BASE_X;
	new Float:y = SKILL_BASE_Y;
	new str[50];
	for (new i = 0; i < NUM_SKILLS / 2; i++) {
		format(str,sizeof(str),"%s\t\t%d",nombreSkills[i], skills[i]);
		gSkillTextDraw[playerid][i] = CreateButtonTextDraw(playerid, x,y,SKILL_WIDTH,SKILL_HEIGHT, str);
		y += SKILL_HEIGHT+5;
	}
	x = SKILL_BASE_X + SKILL_WIDTH + 10.0;
	y = SKILL_BASE_Y;
	for (new i = NUM_SKILLS/2; i < NUM_SKILLS; i++) {
		format(str,sizeof(str),"%s\t\t%d",nombreSkills[i], skills[i]);
		gSkillTextDraw[playerid][i] = CreateButtonTextDraw(playerid, x,y,SKILL_WIDTH,SKILL_HEIGHT, str);
		y += SKILL_HEIGHT+5;
	}
	
}

stock DestroySkillTextDraw(playerid) {
	for (new i = 0; i < NUM_SKILLS; i++) {
		PlayerTextDrawDestroy(playerid, gSkillTextDraw[playerid][i]);
		gSkillTextDraw[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
}

// opciones coche
stock IniOpcionesCocheTextDraw(playerid) {
	new Float:x = SKILL_BASE_X;
	new Float:y = SKILL_BASE_Y;
	new str[50];
	for (new i = 0; i < NUM_OPCIONES_COCHE; i++) {
		format(str,sizeof(str),"%s",opcionesCoche[i]);
		gOpcionesCoche[playerid][i] = CreateButtonTextDraw(playerid, x,y,SKILL_WIDTH,SKILL_HEIGHT, str);
		y += SKILL_HEIGHT+5;
	}
	
}

stock DestroyOpcionesCocheTextDraw(playerid) {
	for (new i = 0; i < NUM_OPCIONES_COCHE; i++) {
		PlayerTextDrawDestroy(playerid, gOpcionesCoche[playerid][i]);
		gOpcionesCoche[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
}

//inventario
stock IniInventario(playerid, tam) {
	new Float:x = INVENTARIO_BASE_X;
	new Float:y = INVENTARIO_BASE_Y;
	new Float:ancho = INVENTARIO_WIDTH / NUM_COLUMNAS_INV;
	new Float:alto = INVENTARIO_HEIGHT / NUM_FILAS_INV;
	new cont = 0;
	new valor = 0;
	for (new i = 0; i < NUM_FILAS_INV; i++) {
		x = INVENTARIO_BASE_X;
		for (new j = 0; j < NUM_COLUMNAS_INV; j++) {
			if (cont >=  tam) {
				gInventario[playerid][cont] = CreateModeloInventario(playerid, x,y , ancho, alto, INVENTARIO_VACIO_ID);
			} else {
				new varname[10];
				format(varname,sizeof(varname), "inv%d", cont);
				valor = GetPVarInt(playerid, varname);
				gInventario[playerid][cont] = CreateModeloInventario(playerid, x,y , ancho, alto, valor);
			}
			cont++;
			x += ancho + 5.0;			
		}
		y += alto + 5.0;
	}
}

stock DestroyInventario(playerid) {
	for (new i = 0; i < MAX_INVENTARIO; i++) {
		PlayerTextDrawDestroy(playerid, gInventario[playerid][i]);
		gInventario[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
}

// pestañas de abajo
stock IniPestanaTextDraw(playerid) {
	new Float:x = PESTANA_BASE_X;
	new str[50];
	for (new i = 0; i < NUM_PESTANAS; i++) {
		format(str,sizeof(str),"%s",nombrePestana[i]);
		gPestanaTextDraw[playerid][i] = CreateButtonTextDraw(playerid, x,PESTANA_BASE_Y,PESTANA_WIDTH,PESTANA_HEIGHT, str);
		x += PESTANA_WIDTH+10;
	}
}

stock DestroyPestanaTextDraw(playerid) {
	for (new i = 0; i < NUM_SKILLS; i++) {
		PlayerTextDrawDestroy(playerid, gPestanaTextDraw[playerid][i]);
		gPestanaTextDraw[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
}

// constructor y destructor
stock CreateSelectionMenuSkill(playerid, header_text[], pestana, skills[NUM_SKILLS])
{
	pestana_actual[playerid] = pestana;
	gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, DIALOG_WIDTH, DIALOG_HEIGHT);
	gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, header_text);
	
	gPlayerSkin[playerid] = CreateModelPreviewTextDraw(playerid, GetPlayerSkin(playerid), SKIN_BASE_X, SKIN_BASE_Y, SKIN_WIDTH, SKIN_HEIGHT, 0);
	IniSkillTextDraw(playerid, skills);
	
	IniPestanaTextDraw(playerid);
	SelectTextDraw(playerid, SELECTION_COLOR);
	return 1;
}

stock CreateSelectionMenuBanda(playerid, header_text[], pestana)
{
	pestana_actual[playerid] = pestana;
	gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, DIALOG_WIDTH, DIALOG_HEIGHT);
	gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, header_text);

	IniPestanaTextDraw(playerid);
	SelectTextDraw(playerid, SELECTION_COLOR);
	return 1;
}

stock CreateSelectionMenuCoches(playerid, pestana, carKeyIndex, index) {
	pestana_actual[playerid] = pestana;
	coche_actual[playerid] = carKeyIndex;

	if (index != -1) {
		new nombre_coche[30];
		format(nombre_coche, sizeof(nombre_coche), "Coche %d", carKeyIndex);
		gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, DIALOG_WIDTH, DIALOG_HEIGHT);
		gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, nombre_coche);
		gModeloCocheTextDraw[playerid] = CreateVehPreviewTextDraw(playerid, car[index][vehmodel], CAR_BASE_X, CAR_BASE_Y, CAR_WIDTH, CAR_HEIGHT, -16.0, 0.0, -55.0, car[index][vehc][0],car[index][vehc][1]);
		IniOpcionesCocheTextDraw(playerid);
	} else {
		gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, DIALOG_WIDTH, DIALOG_HEIGHT);
		gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, "No tienes coche en este slot");
	}
	gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, NEXT_TEXT);
	gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, PREV_TEXT);	
	IniPestanaTextDraw(playerid);
	SelectTextDraw(playerid, SELECTION_COLOR);
	return 1;
}



stock CreateSelectionMenuInventario(playerid, pestana, tam) {
	pestana_actual[playerid] = pestana;
	gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, DIALOG_WIDTH, DIALOG_HEIGHT);
	gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, "Inventario");
	
	IniInventario(playerid, tam);
	
	IniPestanaTextDraw(playerid);
	SelectTextDraw(playerid, SELECTION_COLOR);
}


stock DestroySelectionMenu(playerid)
{
	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	
	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	if (pestana_actual[playerid] == PESTANA_SKILL) {
		PlayerTextDrawDestroy(playerid, gPlayerSkin[playerid]);
		gPlayerSkin[playerid] = PlayerText:INVALID_TEXT_DRAW;
		DestroySkillTextDraw(playerid);
	} else if (pestana_actual[playerid] == PESTANA_BANDA) {
		
	} else if (pestana_actual[playerid] == PESTANA_COCHES) {
		PlayerTextDrawDestroy(playerid, gModeloCocheTextDraw[playerid]);
		gModeloCocheTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
		PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
		PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);
		gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
		gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
		DestroyOpcionesCocheTextDraw(playerid);
	} else if (pestana_actual[playerid] == PESTANA_INVENTARIO) {
		DestroyInventario(playerid);
	}
	DestroyPestanaTextDraw(playerid);
	
	SetPVarInt(playerid, "mS_ignore_next_esc", 1);
	CancelSelectTextDraw(playerid);
	return 1;
}

// implementacion del menu tienda

stock IniTienda(playerid, pagina) {
	new indice = pagina * SELECTION_ITEMS;
	
	new Float:x, Float:y;
	new Float:ancho = TIENDA_WIDTH / NUM_COLUMNAS_TIENDA;
	new Float:alto = TIENDA_HEIGHT / NUM_FILAS_TIENDA;
	new cont = 0;
	for (new i = 0; i < NUM_FILAS_TIENDA; i++) {
		y = TIENDA_BASE_Y + i * alto;
		for (new j = 0; j < NUM_COLUMNAS_TIENDA; j++) {
			x = TIENDA_BASE_X + j * ancho;
			if (indice < NUM_SKINS) {
				gTienda[playerid][cont] = CreateModelPreviewTextDraw(playerid, skinprecio[indice][0], x, y, ancho, alto, 1);
			} else
				gTienda[playerid][cont] = PlayerText:INVALID_TEXT_DRAW;
			cont++;
			indice++;
		}
	}
}

stock CreateTiendaSelectionMenu(playerid, pagina) {
	pag_actual[playerid] = pagina;
	gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, DIALOG_WIDTH, DIALOG_HEIGHT);
	gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, "Inventario");
	
	IniTienda(playerid, pagina);
	
	gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, NEXT_TEXT);
	gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, PREV_TEXT);	
	
	SelectTextDraw(playerid, SELECTION_COLOR);
}


stock DestroyTiendaSelectionMenu(playerid)
{
	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	
	for (new i = 0; i < SELECTION_ITEMS; i++) {
		if (gTienda[playerid][i] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gTienda[playerid][i]);
			gTienda[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);
	gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

	SetPVarInt(playerid, "mS_ignore_next_esc", 1);
	CancelSelectTextDraw(playerid);
	return 1;
}


//  funciones
public OnPlayerConnect(playerid)
{
	if (IsPlayerNPC(playerid)) return CallLocalFunction("MP_OPC", "i", playerid);
	
	pestana_actual[playerid] = 0;
	
    gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gPlayerSkin[playerid] = PlayerText:INVALID_TEXT_DRAW;
	
	gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	
	for (new i = 0; i < NUM_SKILLS; i++) {
		gSkillTextDraw[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	for (new i = 0; i < NUM_PESTANAS; i++) {
		gPestanaTextDraw[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	
	gModeloCocheTextDraw[playerid] = PlayerText:INVALID_TEXT_DRAW;
	
	
	return CallLocalFunction("MP_OPC", "i", playerid);
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect MP_OPC

forward MP_OPC(playerid);


//-------------------------------------------
// Even though only Player* textdraws are used in this script,
// OnPlayerClickTextDraw is still required to handle ESC

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   	if(GetPVarInt(playerid, "mS_ignore_next_esc") == 1) {
		SetPVarInt(playerid, "mS_ignore_next_esc", 0);
		return CallLocalFunction("MP_OPCTD", "ii", playerid, _:clickedid);
	}
	
   	if(GetPVarInt(playerid, "menu_pestanas") != 0) { 

		// Handle: They cancelled (with ESC)
		if(clickedid == Text:INVALID_TEXT_DRAW) {
			DestroySelectionMenu(playerid);
			SetPVarInt(playerid, "menu_pestanas", 0);
			return 1;
		}
	} else if(GetPVarInt(playerid, "menu_tiendas") != 0) { 
		// Handle: They cancelled (with ESC)
		if(clickedid == Text:INVALID_TEXT_DRAW) {
			DestroyTiendaSelectionMenu(playerid);
			SetPVarInt(playerid, "menu_tiendas", 0);
			return 1;
		}
	}

	return CallLocalFunction("MP_OPCTD", "ii", playerid, _:clickedid);
}

#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw MP_OPCTD

forward MP_OPCTD(playerid, Text:clickedid);


public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "menu_pestanas") != 0 ) {
		// Handle: next button
		if(playertextid == gNextButtonTextDrawId[playerid]) {
			if(coche_actual[playerid] < MAX_PLAYER_CAR_KEYS-1) {
				CallLocalFunction("OnPlayerCarMenuSelection", "dd", playerid, coche_actual[playerid]+1);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			} else {
				CallLocalFunction("OnPlayerCarMenuSelection", "dd", playerid, 0);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			}
			return 1;
		}

		// Handle: previous button
		if(playertextid == gPrevButtonTextDrawId[playerid]) {
			if(coche_actual[playerid] > 0) {
				CallLocalFunction("OnPlayerCarMenuSelection", "dd", playerid, coche_actual[playerid]-1);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			} else {
				CallLocalFunction("OnPlayerCarMenuSelection", "dd", playerid, MAX_PLAYER_CAR_KEYS-1);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			}
			return 1;
		}
	

		// Search in the array of textdraws used for the items
		for (new i = 0; i < NUM_SKILLS; i++) {
			if(playertextid == gSkillTextDraw[playerid][i]) {
				//HideModelSelectionMenu(playerid);
				CallLocalFunction("OnPlayerSkillSelection", "dddd", playerid, 1, i, pestana_actual[playerid]);
				return 1;
			}
		}
	
		for (new i = 0; i < MAX_INVENTARIO; i++) {
			if(playertextid == gInventario[playerid][i]) {
				CallLocalFunction("dropItemInventario", "dd", playerid, i);
				return 1;
			}
		}
		for (new i = 0; i < NUM_PESTANAS; i++) {
			if (playertextid == gPestanaTextDraw[playerid][i]) {
				CallLocalFunction("OnPlayerCambiaPestana", "dd", playerid, i+1); //i+1 porque la primera pestana (la de las skills) es la numero 1, no la 0
				return 1;
			}
		}
	} else if ( GetPVarInt(playerid, "menu_tiendas") != 0 ) {  //menu tiendas para comprar skins
			// Handle: next button
		if(playertextid == gNextButtonTextDrawId[playerid]) {
			if((pag_actual[playerid]+1) * SELECTION_ITEMS < NUM_SKINS-1) {
				DestroyTiendaSelectionMenu(playerid);
				CreateTiendaSelectionMenu(playerid, pag_actual[playerid]+1);
			} 
			return 1;
		}

		// Handle: previous button
		if(playertextid == gPrevButtonTextDrawId[playerid]) {
			if(pag_actual[playerid] > 0) {
				DestroyTiendaSelectionMenu(playerid);
				CreateTiendaSelectionMenu(playerid, pag_actual[playerid]-1);
			}
			return 1;
		}
		
		for (new i = 0; i < SELECTION_ITEMS; i++) {
			if (playertextid == gTienda[playerid][i]) {
				new skin = pag_actual[playerid] * SELECTION_ITEMS + i;
				CallLocalFunction("MenuTiendaHandler", "ddd", playerid, skinprecio[skin][0], skinprecio[skin][1]);
				return 1;
			}
		}
	}
	return CallLocalFunction("MP_OPCPTD", "ii", playerid, _:playertextid);
}

#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw MP_OPCPTD

forward MP_OPCPTD(playerid, PlayerText:playertextid);

