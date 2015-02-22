/*
	Estoy en el de base de datos
*/

#include <a_samp>
#include <core>
#include <float>
#include <time>
#include <file>
#include <morphinc>
#include <a_npc>
#include "../include/gl_common.inc"
#include <SpikeStrip.inc>
#include <mVeh.inc>
#include <pSelection.inc>
#include <gvc.inc>
#include <a_mysql.inc>

// ================== DB INFO =================================
#define DBHOST "127.0.0.1"
#define DBUSER "tote"
#define DBPASS "855858"
#define DBNAME "gta"

new mysql;
// ============================================================

#define CHECKPOINT_NONE 0
#define CHECKPOINT_HOME 12
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_OOC 0xE0FFFFAA
#define TEAM_CYAN 1
#define TEAM_BLUE 2
#define TEAM_GREEN 3
#define TEAM_ORANGE 4
#define TEAM_COR 5
#define TEAM_BAR 6
#define TEAM_TAT 7
#define TEAM_CUN 8
#define TEAM_STR 9
#define TEAM_HIT 10
#define TEAM_ADMIN 11
#define OBJECTIVE_COLOR 0x64000064
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_JOB_COLOR 0xFFB6C1AA
#define TEAM_BLUE_COLOR 0x8D8DFF00
#define COLOR_ADD 0x63FF60AA
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_CYAN_COLOR 0xFF8282AA
#define TEAM_ORANGE_COLOR 0xFF830000
#define TEAM_COR_COLOR 0x39393900
#define TEAM_BAR_COLOR 0x00D90000
#define TEAM_TAT_COLOR 0xBDCB9200
#define TEAM_CUN_COLOR 0xD900D300
#define TEAM_STR_COLOR 0x01FCFF00
#define TEAM_ADMIN_COLOR 0x00808000
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200
#define COLOR_ORANGE 0xFF8040FF

#define INVISIBLE 0xFFFFFF00

//#define NUM_COCHES 400 //TB DECLARADO EN EL SCRIPT SPEEDO

//-----------------
//TIPOS DE familias
#define POLI 1
#define BOMBEROS 2
#define MEDICO 2
#define LICENCIA 3
#define COCHES 4
#define DETECTIVE 5
#define CNN 6
#define ABOGADO 7
#define YAKUZA 8
#define VTA 9
#define TRAFICANTE 10
#define MECANICO 11
#define CAMIONERO 12

//rangos familias
#define LIDER 2
#define SUBLIDER 1
#define MIEMBRO 0

//rangos admin
#define SA 3
#define GM 2
#define MOD 1

//dialogos
#define DIALOGO_ACCIONES_POLI 		0
#define DIALOGO_ACCIONES_BOMBERO 	1
#define DIALOGO_NO_AUTORIZADO 		2
#define DIALOGO_ID                  3
#define DIALOGO_RAZON               4
#define DIALOGO_CONFIRMAR           5
#define DIALOGO_DINERO              6
#define DIALOGO_TIEMPO              7
#define DIALOGO_ERROR               8
#define DIALOGO_CAMARAS_POLI 		201
#define DIALOGO_SALIR_CAMARAS_POLI 	202
#define DIALOGO_USAR_DROP	        9
#define MECANICOS 					1290
#define MECANICO1 					1291

#define REGISTRO 787
#define LOGIN 790
new nLogin[MAX_PLAYER_NAME];
#define NUMALARMAS 119
#define MAX_STRING 255
//---------------------------------Control policia
forward Cuidar();
new Disparando;
new cocheEntran[300];
//------------------------------
new PoliciasDisparan[MAX_PLAYERS];
//------------------------Puertas Automaticas------------------------------------------------------------------------
forward PuertaCheck();
//-------End----------
forward IsAtClothShop(playerid);
forward IsAtGasStation(playerid);
forward IsAtBar(playerid);
forward SetPlayerSpawn(playerid);
forward SetupPlayerForClassSelection(playerid);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward ABroadCast(color,const string[],level);
forward Teleport();
forward BanLog(string[]);
forward KickLog(string[]);
forward PayLog(string[]);
forward Encrypt(string[]);
forward GameModeExitFunc();
forward GameModeInitExitFunc();
forward centrarCamara(playerid);
forward AbrirVeh(vehicleid);
forward CerrarVeh(vehicleid);

forward OnPlayerLogin(playerid,password[]);
forward OnPlayerUpdate(playerid);
forward OnPlayerRegister(playerid, password[]);
forward BroadCast(color,const string[]);
forward SendTeamMessage(team, color, string[]);
forward SendRadioMessage(member, color, string[]);
forward SendAdminMessage(color, string[]);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward InitLockDoors(playerid);
forward StoppedVehicle();
forward SyncTime();
forward SyncUp();
forward split(const strsrc[], strdest[][], delimiter);
forward IsPlayerInZone(playerid, zoneid);
forward ini_GetKey( line[] );
forward ini_GetValue( line[] );
forward CustomPickups();
forward IdleKick();
forward FixHour(hour);
forward DistanciaCoche(Float:radi, playerid, carid);
forward GivePlayerRank(team,rank,senderid,giveid);
forward GetPlayerRank(playerid,nombre[255]);
forward GetPlayerByName(name[MAX_PLAYER_NAME]);
forward Float:hyp(Float:x1,Float:y1,Float:x2,Float:y2); //calcula hipotenusa entre 2 puntos
forward OnPlayerShootPlayer(shooter,target,Float:damage);
forward hacerElCabra(playerid); //tener que huir cuando pasas por un punto
forward fugitivo();
forward actuVida(); //comprueba si la peña tiene ke estar enroscada
forward SaveVehDuenios();
forward mySetWorldTime(hour);
forward PlaySoundRadius(playerid, soundid, Float:radius);
forward timerEncerrado(playerid);
forward esMoto(_vehid);
forward GetVehicleModelName(modelid, &str, tam);

new timerEncerradoID[MAX_PLAYERS];

// cosas de las escenas
#define ESCENA_INTRO    	0
#define ESCENA_MISION_DROGA 1

forward escenas(playerid, escena);
forward FinEscena(playerid);
forward MostrarEscena(playerid, escena_id);

new escenasID[MAX_PLAYERS];
new tEscena[MAX_PLAYERS];
new PlayerText:EscenaText[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------
new CreatedCars[100];
new CreatedCar = 0;

new MedicTime[MAX_PLAYERS];
new NeedMedicTime[MAX_PLAYERS];
new MedicBill[MAX_PLAYERS];
new PlayerCuffed[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS];
new gPlayerLogTries[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new Spectate[MAX_PLAYERS];
new HidePM[MAX_PLAYERS];
new gPlayerAccount[MAX_PLAYERS];
new motd[256];
new ghour = 0;
new gminute = 0;
new gsecond = 0;
new deathcost = 10;
new realchat = 1;
new timeshift = -1;
new shifthour;
new othtimer;
new synctimer;
new puertatimer; //puertas de la policia
new newmistimer;
new unjailtimer;
new pickuptimer;
new spectatetimer;
new idletimer;
new productiontimer;
new accountstimer[MAX_PLAYERS];
new checkgastimer;
new stoppedvehtimer;
new idletime = 600000; //10 mins
new Float:PlayerPos[MAX_PLAYERS][6];
new Float:TelePos[MAX_PLAYERS][6];
new calculaVel;
new fugitivoTimer;
new pillado[MAX_PLAYERS];
new tiempoTimer;
new muriendo[MAX_PLAYERS];
new enfermo[MAX_PLAYERS];
new ConBandana[MAX_PLAYERS];

new puertas[MAX_PLAYERS];
new trabajo[MAX_PLAYERS]; //almacena temporalmente (hasta que use /acept) el trabajo ke desea realizar alguien

#define SlotObjeto 0

#define GasMax 100
#define RunOutTime 15000
#define RefuelWait 5000

enum Punto
{
	Float:pX,
	Float:pY
}
new ctrlVel[MAX_PLAYERS][Punto];

//-------- cosas para teams

//Barreras 
#define MAX_BARRERA        	10
forward crearBarrera(playerid);
forward eliminarBarrera(playerid);
forward puedePonerBarrera(playerid);

new BarreraID[MAX_PLAYERS][MAX_BARRERA];
new numBarreras[MAX_PLAYERS];

//Avisos
#define MAX_TAM_MENSAJE_AVISO   100

forward crearAviso(creador, msg[]);
forward cerrarAviso(creador);
forward existeAviso(id);
forward infoAviso(playerid, avisoid);
forward mostrarAvisos(playerid);
forward caducarAviso(playerid);

enum tAviso {
	taValido,
	taID,
	taHour,
	taMin,
	taSeg,
	taMensaje[MAX_TAM_MENSAJE_AVISO],
}

new avisos[MAX_PLAYERS][tAviso];
new caducarAvisoID[MAX_PLAYERS];
new pidiendoInfo[MAX_PLAYERS];

//megafono
new megafono[MAX_PLAYERS];

//funciones de mensajes
forward GameTextForTeam(teamID, msg[], time, style, duty);

//-------------cosas de Policia----------
#define MAX_RAZON 		20
#define MULTA_ID    	1
#define MULTA_DINERO    2
#define MULTA_RAZON     3
#define MULTA_CONFIRMAR 4
#define MULTA_PAGANDO   5
#define NUM_COCHES_POLICIA 28
#define NUM_CARCELES    4

forward TimerClear(playerid);
forward TimerFall(playerid);
forward TazerControl(playerid);
forward esCochePolicia(id);

new Float:CoordCarcel[NUM_CARCELES][3] = {
{1553.59, -1665.60, 1719.0},
{1553.18, -1661.84, 1719.0},
{1553.22, -1658.21, 1719.0},
{1553.56, -1654.00, 1719.0}};

new CochesPolicia[NUM_COCHES_POLICIA];
new HaveTaser[MAX_PLAYERS];
new TazerControlID[MAX_PLAYERS];
new requisando[MAX_PLAYERS];
new pincho[MAX_PLAYERS];
new cacheando[MAX_PLAYERS];
new avisando[MAX_PLAYERS];

enum tMulta {
	tmPaso, //MULTA_ID, MULTA_DINERO, MULTA_RAZON, MULTA_CONFIRMAR
	tmDinero,
	tmID,
	tmRazon[MAX_RAZON],
};

new multando[MAX_PLAYERS][tMulta];
new arrestando[MAX_PLAYERS];

new Puerta;
new Puerta1;
new Puerta2;
new Puerta3;
//-------------End----------


// --------------- cosas de bomberos
#define NUM_COCHES_BOMBEROS 12

forward esCocheBomberos(id);

new CochesBomberos[NUM_COCHES_BOMBEROS];

//del tote
//Bomberos
#define MAX_COORDENADAS_BOMBEROS 1

//------------------------bomberos-----------------------------------------------------------------------------------
forward updateRanking(team);
forward temporizadorBombero();

//mision bomberos

new Float:coordBomberosEntrada[MAX_COORDENADAS_BOMBEROS][4] = {
/*{-2155.8428,484.3336,35.1719,98.3884},
    {-2240.3918,577.5201,35.1719,353.4900},
    {-2715.1477,270.9679,4.3342,93.1375},
    {-2491.8411,-56.0927,25.6446,235.7825},
    {-2269.1094,-30.3196,35.3203,264.5085},*/
    {-2278.76, 699.13, 49.44, 90.0}
};

new Float:coordBomberosSalida[MAX_COORDENADAS_BOMBEROS][4] = {
    /*{-2153.2480,484.0311,35.1719,274.7968},
    {-2241.0127,574.8546,35.1719,180.2385},
    {-2712.5444,270.4761,4.3281,271.4258},
    {-2494.3813,-56.4654,25.6339,86.9477},
    {-2266.4758,-30.5328,35.3203,269.9802},*/
    {-2275.65 ,699.07 , 49.44, 270.0}
};
new randCoordBombero;
new timerBomberos;

//fin bomberos tote
#define VERSION "0.4"

#define MAX_FLAMES 300						// maxmimal flames
#define BurnOthers							// Should other players burn, too, if they are touching a burning player?
#define FireMessageColor 0x00FF55FF			// color used for the extinguish-message

#define FLAME_ZONE 					1.0     // radius in which you start burning if you're too close to a flame
#define ONFOOT_RADIUS				2.0		// radius in which you can extinguish the flames by foot
#define PISSING_WAY					2.0		// radius in which you can extinguish the flames by peeing
#define CAR_RADIUS					10.0		// radius in which you can extinguish the flames by firetruck/SWAT Van
#define Z_DIFFERENCE				2.5		// height which is important for the accurancy of extinguishing. please do not change
#define EXTINGUISH_TIME_VEHICLE		1		// time you have to spray at the fire with a firetruck (seconds)
#define EXTINGUISH_TIME_ONFOOT		2		// time you have to spray at the fire onfoot (seconds)
#define EXTINGUISH_TIME_PEEING		10		// time you have to pee at the fire (seconds)
#define EXTINGUISH_TIME_PLAYER		2		// time it takes to extinguish a player (seconds)
#define FIRE_OBJECT_SLOT			1		// the slot used with SetPlayerAttachedObject and RemovePlayerAttachedObject
#define NUM_EXPLOSIONES             8
#define NUM_EXPLOSIONES_NO_CONTROL  8
#define NUM_FUEGOS_TEJADO           34
#define NUM_EXPLOSIONES_GAS_CIUDAD  33
#define NUM_EXPLOSIONES_EDIFICIO   14
#define NUM_EXPLOSIONES_ENFRENTE   20
#define FUEGOS_ESTATICOS            24
#define FUEGOS_DE_CASA              15

#if !defined SPECIAL_ACTION_PISSING
	#define SPECIAL_ACTION_PISSING 68
#endif

forward AddFire(Float:x, Float:y, Float:z);
forward KillFire(id);
forward AddSmoke(Float:x, Float:y, Float:z);
forward KillSmoke(id);
forward DestroyTheSmokeFromFlame(id);
forward OnFireUpdate();
forward FireTimer(playerid, id);
forward SetPlayerBurn(playerid);
forward BurningTimer(playerid);
forward StopPlayerBurning(playerid);
forward timerEventoBombero();
forward crearExplosion();
forward crearExplosionNoControlada();
forward crearFuegoTejado();
forward timerGasCiudad();
forward exploRapida();
forward crearExplosionEdificio();
forward crearExplosionEnfrente();
forward crearFuegosEstaticos();
forward eliminarFuegosEstaticos();
forward crearFuegosDeCasa();
forward eliminarFuegosDeCasa();
forward TimerMediaHora();

enum FlameInfo
{
	Flame_id,
	Flame_Exists,
	Float:Flame_pos[3],
	Smoke[5],
}

new contadorTimerMediaHora;
new TimerMediaHoraID;
new fuegosDeCasaID[FUEGOS_DE_CASA];
new fuegoEstaticoID[FUEGOS_ESTATICOS];
new Flame[MAX_FLAMES][FlameInfo];
new ExtTimer[MAX_PLAYERS];
new PlayerOnFire[MAX_PLAYERS];
new PlayerOnFireTimer[MAX_PLAYERS];
new PlayerOnFireTimer2[MAX_PLAYERS];
new Float:PlayerOnFireHP[MAX_PLAYERS];
new timerEventoBomberoID;
new tiempoEventoBombero;
new fuegoTejadoID[NUM_FUEGOS_TEJADO];
new salvando[MAX_PLAYERS];

new timerGasCiudadID;
new tiempoGasCiudad;
new exploRapidaID;

new Float:fuegoEstatico[FUEGOS_ESTATICOS][3] = {
//-----------------------FUEGO Primer piso
{ -2279.4470,697.0,59.4453},
{ -2279.4470,698.7,59.4453},
{ -2279.4470,700.4,59.4453},
{ -2279.4470,702.1,59.4453},
{ -2279.4470,703.8,59.4453},
{ -2279.4470,704.5,59.4453},
{ -2279.4470,706.2,59.4453},
{ -2279.7373,707.9289,59.4453,},
//------------------------FUEGO segundo piso
{ -2279.4470,697.0,53.4453},
{ -2279.4470,698.7,53.4453},
{ -2279.4470,700.4,53.4453},
{ -2279.4470,702.1,53.4453},
{ -2279.4470,703.8,53.4453},
{ -2279.4470,704.5,53.4453},
{ -2279.4470,706.2,53.4453},
{ -2279.7373,707.9289,53.4453},
//-------------------------FUEGO en el bajo
{ -2279.4470,697.0,48.4453},
{ -2279.4470,698.7,48.4453},
{ -2279.4470,700.4,48.4453},
{ -2279.4470,702.1,48.4453},
{ -2279.4470,703.8,48.4453},
{ -2279.4470,704.5,48.4453},
{ -2279.4470,706.2,48.4453},
{ -2279.7373,707.9289,48.4453}};

new Float:CoordFuegosDeCasa[FUEGOS_DE_CASA][3] = {
{2092.8188,1296.1168,-42.6656},
{2092.4827,1300.8802,-42.6656},
{2093.2109,1304.7227,-42.6656},
{2091.0591,1308.3335,-42.6656},
{2087.8665,1314.0896,-40.6656},
{2091.5461,1314.1838,-39.0641},
{2094.5088,1313.1434,-38.6656},
{2092.8179,1308.2643,-38.6459},
{2092.9436,1305.6357,-38.6438},
{2092.2854,1302.8898,-38.6638},
{2093.7314,1302.1929,-38.6517},
{2092.8831,1300.3459,-38.6587},
{2093.7876,1298.4879,-38.6512},
{2094.9468,1297.8512,-38.6422},
{2096.6494,1298.1720,-38.6422}
};


new Float:CoordExplosionesEnfrente[NUM_EXPLOSIONES_ENFRENTE][3] = {
//UN BAJO Y 2 PLANTAS
{-2245.8035,709.2001,49.5},
{-2245.8035,706.2001,49.5},
{-2245.8035,703.2001,49.5},
{-2245.8035,701.2001,49.5},
{-2245.8035,699.2001,49.5},
{-2245.8035,697.2001,49.5},
{-2245.8035,695.9559,53.5},
{-2245.8035,709.2001,53.5},
{-2245.8035,706.2001,53.5},
{-2245.8035,703.2001,53.5},
{-2245.8035,701.2001,53.5},
{-2245.8035,699.2001,53.5},
{-2245.8035,697.2001,53.5},
{-2245.8035,695.9559,53.5},
{-2245.8035,706.2001,59.5},
{-2245.8035,703.2001,59.5},
{-2245.8035,701.2001,59.5},
{-2245.8035,699.2001,59.5},
{-2245.8035,697.2001,59.5},
{-2245.8035,695.9559,59.5}};

new Float:CoordExplosionesEdificio[NUM_EXPLOSIONES_EDIFICIO][3] = {
{-2279.9470,682.7,48.4453},
{-2279.9470,684.4,48.4453},
{-2279.9470,686.1,48.4453},
{-2279.9470,688.8,48.4453},
{-2279.9470,690.5,48.4453},
{-2279.9470,692.2,48.4453},
{-2279.9373,694.9289,48.4453},
{-2279.9470,682.7,53.4453},
{-2279.9470,684.4,53.4453},
{-2279.9470,686.1,53.4453},
{-2279.9470,688.8,53.4453},
{-2279.9470,690.5,53.4453},
{-2279.9470,692.2,53.4453},
{-2279.9373,694.9289,53.4453}};

new Float:CoordExplosiones[NUM_EXPLOSIONES][3] = {
{-2279.4470,697.0,54.4453},
{-2279.4470,698.7,54.4453},
{-2279.4470,700.4,54.4453},
{-2279.4470,702.1,54.4453},
{-2279.4470,703.8,54.4453},
{-2279.4470,704.5,54.4453},
{-2279.4470,706.2,54.4453},
{-2279.7373,707.9289,54.4453}};

new Float:CoordExplosionesNoControl[NUM_EXPLOSIONES_NO_CONTROL][3] = {
{-2279.4470,697.0,48.4453},
{-2279.4470,698.7,48.4453},
{-2279.4470,700.4,48.4453},
{-2279.4470,702.1,48.4453},
{-2279.4470,703.8,48.4453},
{-2279.4470,704.5,48.4453},
{-2279.4470,706.2,48.4453},
{-2279.7373,707.9289,48.4453}};

new Float:CoordFuegoTejado[NUM_FUEGOS_TEJADO][3] = {
{-2280.5608,708.6389,68.0}, //
{-2280.3857,705.7393,68.0}, //
{-2280.9861,702.5199,68.0}, //
{-2280.8948,698.2893,68.0}, //
{-2282.6223,699.9329,68.0},//
{-2282.8193,702.6772,68.0}, //
{-2282.8359,705.9429,68.0}, //
{-2283.6772,708.5679,68.0}, //
{-2284.9348,709.6349,68.0}, //
{-2285.5496,707.6239,68.0}, //
{-2286.1680,704.4785,68.0}, //
{-2286.3828,701.2206,68.0}, //
{-2288.8047,700.3273,68.0}, //
{-2292.1160,698.0446,68.0}, //
{-2290.1973,696.9883,68.0}, //
{-2280.5608,708.6389,68.0},
{-2294.3684,698.4162,68.0},
{-2294.6956,695.6723,68.0},
{-2295.9470,703.3608,68.0},
{-2295.6560,705.2509,68.0},
{-2293.8271,704.6414,68.0},
{-2293.5840,707.1924,68.0},
{-2295.5571,708.3013,68.0},
{-2293.5361,709.3837,68.0},
{-2291.3398,709.7519,68.0},
{-2291.2734,708.4867,68.0},
{-2289.0432,708.0526,68.0},
{-2288.7217,709.1461,68.0},
{-2286.3220,709.5540,68.0},
{-2280.9431,708.3653,68.0},
{-2281.3975,706.1280,68.0},
{-2280.7324,703.9590,68.0},
{-2282.2529,701.6771,68.0},
{-2281.0527,700.1891,68.0}};

new Float:CoordExplosionGasCiudad[NUM_EXPLOSIONES_GAS_CIUDAD][3] = {
{-2270.4895,678.0,49.2969},
{-2270.4895,680.0,49.2969},
{-2270.4895,682.0,49.2969},
{-2270.4895,684.0,49.2969},
{-2270.4895,686.0,49.2969},
{-2269.4470,688.0,48.4453},
{-2269.4470,690.0,48.4453},
{-2269.4470,692.0,48.4453},
{-2269.4470,694.0,48.4453},
{-2269.4470,696.0,48.4453},
{-2269.4470,698.0,48.4453},
{-2269.4470,700.0,48.4453},
{-2269.7373,702.0,48.4453},
{-2270.6443,703.6854,49.2969},//perpendicular
{-2269.7373,704.0,48.4453},
{-2267.6443,703.6854,49.2969},//perpendicular
{-2269.7373,706.0,48.4453},
{-2264.6443,703.6854,49.2969},//perpendicular
{-2269.7373,708.0,48.4453},
{-2261.6443,703.6854,49.2969},//perpendicular
{-2269.7373,710.0,48.4453},
{-2258.6443,703.6854,49.2969},//perpendicular
{-2269.7373,712.0,48.4453},
{-2255.6443,703.6854,49.2969},//perpendicular
{-2269.7373,714.0,48.4453},
{-2252.6443,703.6854,49.2969},//perpendicular
{-2269.7373,716.0,48.4453},
{-2249.6443,703.6854,49.2969},//perpendicular
{-2269.7373,718.0,48.4453},
{-2247.6443,703.6854,49.2969},//perpendicular
{-2269.7373,720.0,48.4453},
{-2244.6182,703.0166,49.4453},//perpendicular
{-2269.7373,722.0,48.4453}};


//---------------------------TALLER COCHES
#define VV  298
#define VEH 841 // 578
#undef MAX_VEHICLES
#define MAX_VEHICLES 2000
forward IsAtTaller(playerid);
new cobrando[MAX_PLAYERS];

new maletero[MAX_PLAYERS];
new maletero2[MAX_PLAYERS];


//----------------- cosas de todos los jugadores
//items y drops

#define MAX_DROPS   1000
#define TIEMPO_DROP 60 * 5 //5 pq se va a ejecutar cada 200ms
#define SUBIENDO    1
#define BAJANDO     0

forward dropItemInventario(playerid, _idInventario);
forward TimerRecogidaItemInventario(playerid, modelid);
forward TimerTiempoVidaDrop();
forward borrarItem(playerid, indice);
forward insertarItem(playerid, modelid);
forward RegistrarDrop(playerid, modelid, Float:x, Float:y, Float:z);
forward BorrarDrop(_dropid);
forward CrearVariablesItem(playerid);
forward AnimarDrop(objectid);

enum pDrop {
	dropid,
	dropmodel,
	Float:droppos[3],
	dropvida,
	dropdir
};
new drops[MAX_DROPS][pDrop];
new numDrops;
new avisoInventarioLleno[MAX_PLAYERS];
new IndiceDropItem[MAX_PLAYERS];
new traspasando[MAX_PLAYERS];

new numItems[MAX_PLAYERS];
new TimerRecogidaItemInventarioID;
new TimerTiempoVidaDropID;
//new AnimarDropID;

//general
enum pInfo
{
	pID,
	pKey[128],
	pLevel,
	pAdmin,
	pReg,
	pPresentacion,
	pExp,
	pCash,
	pJailed,
	pJailTime,
	Float:pSHealth,
	pInt,
	pJob,
	pTeam,
	pRank,
	pModel,
	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	pWeapon[13], //ids de armas para los 13 slots
	pAmmo[13], //munición para cada slot
	pWanted,
	pLogged,
	pBanda,
	pMisionBanda,
	pPrueba,
	pSkill[NUM_SKILLS],
	pCarKeys[MAX_PLAYER_CAR_KEYS],
	pInventario[MAX_INVENTARIO]
};
new PlayerInfo[MAX_PLAYERS][pInfo];

new darArmas[MAX_PLAYERS] = 0;

//------------------------ estructura bandas 
#define PRECIO_CREAR_BANDA 1000
#define MAX_BANDAS 255
#define MAX_PISOS_FRANCOS 40
#define HORA_SEG 3600
#define SEMANA_EN_SEG 3600*24*7
#define DOS_DIAS_SEG 3600*24*2
#define MAX_COCHES_BANDA 4
#define MAX_NUM_VEHICLES_BANDAS 400

#define BANDA_REP_MAXIMA    1000
#define NUM_GANGZONES 		3
#define REP_BANDA           400
#define REP_ZONES           BANDA_REP_MAXIMA - REP_BANDA

forward loadBandas();
forward saveBandas();
forward SendBandaText(bandaid);
forward loadCochesBandas();
forward saveCochesBandas();
forward TimerBandas(); //actualizar la barra
forward TimerRespuesta();
forward loadpf();
forward savepf();
forward TieneDuenio(idPisoFranco);  //devuelve booleano para saber si un piso franco ya ha sido vendido o no

new contTimerBandas; //cada x segundos, guardamos las bandas (timerBandas())

// ----------------------- coches de las bandas


enum tCoche {
	cTipo,
	cColor[2],
	Float:cAngle,
	Float:cSpawn[3],
	cId
};

new BandaCocheFirstSpawn[MAX_PLAYERS]; //para que spawnear por primera vez el coche

enum tBandaCoche {
	tbcBanda,
	tbcCoche
};
new cambiar_spawn_coche[MAX_NUM_VEHICLES_BANDAS][tBandaCoche];

// --------------------------- bandas en sí
enum pBandas {
	bNombre[MAX_PLAYER_NAME],
	bLider[MAX_PLAYER_NAME],
	bNivel,
	bDinero,
	bMiembros,
	bPisoFranco,              //id del piso franco comprado o alquilado
	bTiempoAlquiler,           //si alquilan un piso, una semana = 3600*24*7
	bNumCoches,
    bCoche1[tCoche],
    bCoche2[tCoche],
    bCoche3[tCoche],
    bCoche4[tCoche],
   	bReputacion[NUM_GANGZONES]
};
new Bandas[MAX_BANDAS][pBandas];
new indiceBandas = 1;             //primera posicion vacia en el array Bandas
new Bar:satisBar[MAX_PLAYERS]; //Text Draws para todos (barra satisfaccion)

enum tRespuesta {
	rTiempo,
	id_lider
};

new responde[MAX_PLAYERS][tRespuesta]; //para el /banda aceptar

// ------------------------------- pisos francos de las bandas
enum eAlquilar {
	aTiempo,
	aPisoFranco
};

new alquilando[MAX_PLAYERS][eAlquilar];
enum pisoFranco {
	pfPrecioAlquiler,              //4000 a la semana
	pfPrecioVenta,                 //50000
	Float:pfEnterPos[3],           //-1877.454833,615.646484,35.171875 prueba
	Float:pfEnterTeleport[3],
	Float:pfEnterOrientation,
	Float:pfExitPos[3],            //2306.044189,1293.826904,-40.599998 prueba
	Float:pfExitTeleport[3],
	Float:pfExitOrientation,
	pfInterior,                    //0
	pfNivel,
};

#define NUM_PISOS_FRANCOS 25
new PisosFrancos[NUM_PISOS_FRANCOS][pisoFranco] = {
{4000,50000,{-2220.9890,100.5910,35.3203},{2308.314453,1294.046904,-40.6000},90.0,{2306.044189,1293.826904,-40.599998},{-2221.2732,102.0061,35.3203},355.4862,0,1},
{4000,50000,{-2430.5212,-27.2973,35.3203},{2308.2627,1334.0454,-40.6000},90.0,{2306.044189,1334.0454,-40.599998},{-2427.0354,-27.0550,35.3203},268.3652,0,1},
{4000,50000,{-2431.0266,-4.8947,35.3203},{2308.314453,1374.826904,-40.6000},90.0,{2306.044189,1374.826904,-40.599998},{-2427.0737,-4.3170,35.3203},274.1563,0,1},
{4000,50000,{-2558.8311,-79.4342,10.8428},{2308.314453,1414.826904,-40.6000},90.0,{2306.044189,1414.826904,-40.599998},{-2558.8555,-76.2152,10.8433},351.0604,0,1},
{4000,50000,{-2576.3999,-82.2307,6.6241},{2308.314453,1454.826904,-40.6000},90.0,{2306.044189,1454.826904,-40.599998},{-2577.0872,-77.5432,6.2938},1.0871,0,1},
{4000,50000,{-2553.9106,718.6354,27.9453},{2308.314453,1494.826904,-40.6000},90.0,{2306.044189,1494.826904,-40.599998},{-2552.8630,714.2886,27.9609},185.8703,0,1},
{4000,50000,{-2581.5186,718.6072,27.9453},{2308.314453,1634.826904,-40.6000},90.0,{2306.044189,1634.826904,-40.599998},{-2580.7947,714.6811,27.9616},183.0269,0,1},
{4000,50000,{-2540.5093,785.1948,46.2017},{2308.314453,1674.826904,-40.599998},90.0,{2306.044189,1674.826904,-40.599998},{-2536.5703,785.5668,46.2867},269.2644,0,1},
{4000,50000,{-2514.5015,830.7490,50.0001},{2308.314453,1714.826904,-40.599998},90.0,{2306.044189,1714.826904,-40.599998},{-2519.9939,830.4088,49.9751},94.6657,0,1},
{4000,50000,{-2514.6880,885.7957,62.7394},{2308.314453,1754.826904,-40.599998},90.0,{2306.044189,1754.826904,-40.599998},{-2518.2549,885.7890,62.4689},90.8638,0,1},
{4000,50000,{-2502.8262,895.8671,65.1931},{2308.314453,1794.826904,-40.599998},90.0,{2306.044189,1794.826904,-40.599998},{-2503.4421,901.2006,64.9015},357.8371,0,1},
{4000,50000,{-2471.9165,919.3974,63.1616},{2308.314453,1834.826904,-40.599998},90.0,{2306.044189,1834.826904,-40.599998},{-2471.2717,914.7639,63.1479},180.4255,0,1},
{4000,50000,{-2449.9880,896.6625,58.0462},{2308.314453,1874.826904,-40.599998},90.0,{2306.044189,1874.826904,-40.599998},{-2450.2068,900.8270,58.0554},354.6171,0,1},
{4000,50000,{-2413.1309,920.5193,45.5123},{2308.314453,1914.826904,-40.599998},90.0,{2306.044189,1914.826904,-40.599998},{-2412.8164,916.0112,45.5911},175.0754,0,1},
{4000,50000,{-2307.3018,945.1077,61.5057},{2308.314453,1954.826904,-40.599998},90.0,{2306.044189,1954.826904,-40.599998},{-2306.9207,949.5977,61.5740},359.7840,0,1},
{4000,50000,{-2280.8442,916.4662,66.6484},{2308.314453,1994.826904,-40.599998},90.0,{2306.044189,1994.826904,-40.599998},{-2276.0918,917.0051,66.6484},269.3285,0,1},
{4000,50000,{-2278.0002,787.8149,49.4453},{2308.314453,2034.826904,-40.599998},90.0,{2306.044189,2034.826904,-40.599998},{-2274.9558,788.1062,49.4453},275.2538,0,1},
{4000,50000,{-2242.0820,753.3340,49.4021},{2308.314453,2074.826904,-40.599998},90.0,{2306.044189,2074.826904,-40.599998},{-2246.8752,753.0804,49.4393},88.2802,0,1},
{4000,50000,{-2066.4575,745.1950,65.0017},{2308.314453,2114.826904,-40.599998},90.0,{2306.044189,2114.826904,-40.599998},{-2065.3672,739.5278,64.3717},188.7037,0,1},
{4000,50000,{-2029.8348,744.6321,49.6713},{2308.314453,2154.826904,-40.599998},90.0,{2306.044189,2154.826904,-40.599998},{-2029.1633,740.9560,49.5735},185.8874,0,1},
{4000,50000,{-2017.3473,831.9691,45.4453},{2308.314453,2194.826904,-40.599998},90.0,{2306.044189,2194.826904,-40.599998},{-2013.6106,832.5733,45.4453},272.8502,0,1},
{4000,50000,{-2015.6849,897.4963,45.4453},{2308.314453,2234.826904,-40.599998},90.0,{2306.044189,2234.826904,-40.599998},{-2012.8169,898.4028,45.4453},267.8368,0,1},
{4000,50000,{-2017.9271,970.0616,45.4453},{2308.314453,2274.826904,-40.599998},90.0,{2306.044189,2274.826904,-40.599998},{-2013.5570,970.3911,45.5896},266.2700,0,1},
{4000,50000,{-1842.0253,1114.4760,45.4453},{2308.314453,2314.826904,-40.599998},90.0,{2306.044189,2314.826904,-40.599998},{-1842.2876,1111.8196,45.4453},181.8607,0,1},
{4000,50000,{-1732.2161,1115.3352,45.4453},{2308.314453,2374.826904,-40.599998},90.0,{2306.044189,2374.826904,-40.599998},{-1731.6362,1112.0623,45.4453},177.4740,0,1}
};

//-------------------- variables/enums generales de las misiones --------------------
//ID NPC que interactuan en las misiones
#define NPC_MECANICO 1
//--- fin id npc

#define MAX_NPC 50
new NPCocupado[MAX_PLAYERS];               //0 npc no ocupado, 1 npc ocupado
new idNPC[MAX_NPC];                        //playerid de los npc

#define EXITO 0
#define FRACASO 1
#define TIEMPO_FIN 2
#define SIN_JUGADORES 3

#define NUM_MISIONES 20                    //numero de misiones totales en el servidor
#define MAX_PLAYERS_MISION MAX_PLAYERS             //aqui ideal poner máximo numero de miembros que podrá tener una banda
#define MAX_OBJECTS_MISION 100             //maximo numero de objetos a mostrar a una sola banda

forward PlayAudioStreamForMission(mID, url[], Float:x, Float:y, Float:z, Float:dist, usepos); //Para poner sonidos a todos
forward startMission(mID, playerid);       //mira la banda en la que está playerid y le añade a mPlayerid. También a los miembros de la banda que estén cerca
forward finishMission(mID, razon);         //finaliza la misión mID con razon: EXITO = 0, FRACASO = 1, TIEMPO_FIN 2
forward sendMissionText(mID, msg [], tiempo);//muestra msg como text a los participantes de la misión mID
forward hideMissionText(mID);               //oculta el texto enviado a los participantes de la misión ID
forward sendMissionGameText(mID, msg[], tiempo);   //envia gametext a los participantes de la misión ID
forward sendMissionMsg(mID, msg []);       //muestra por comando msg a los participantes de la misión mID
forward timerMission();                    //baja el tiempo del que disponen cada seg
forward ShowMissionEscena(mID, escena_id);
forward createMissionTimeText(mID);
forward destroyMissionTimeText(mID);
forward MissionTextDrawSetTimeString(mID, str[]);
forward showMissionTime(mID);              //muestra mTiempoText a los integrantes de la mision mID
forward hideMissionTime(mID);              //oculta mTiempoText a los integrantes de la mision mID
forward setMissionCheckpoint(mID, Float:x, Float:y, Float: z, Float:size); //pone un chkpoint a todos los que estén realizando la misión
forward onPlayerEnterMissionCheckpoint();  //timer que comprueba si un jugador entra en un checkpoint de la misión
forward disableMissionCheckpoint(mID);     //quita checkpoint a los que estén haciendo la misión
forward createMissionObject(mID,modelid,Float:x, Float:y, Float:z, Float: rX, Float:rY, Float:rZ, Float:DrawDistance); //crea un objeto para cada jugador de la misión
forward destroyMissionAllObjects(mID);     //elimina todos los objetos de la misión
forward destroyMissionObject(mID, objectID);  //elimina un objeto concreto de la mision
forward onPlayerEnterObject();            //timer que comprueba si un jugador de la misión pasa por un objeto

new timerMissionID;
new onPlayerEnterObjectT;
new	onPlayerEnterMissionCheckpointT;
new mNumPlayers[NUM_MISIONES];                          //índice de jugadores que están realizando la misión x
new mNumPlayersReales[NUM_MISIONES];
new mPlayerid[NUM_MISIONES][MAX_PLAYERS_MISION];        //ids de los jugadores que están realizando la misión x
new Text:mMsgText[NUM_MISIONES];                        //texto que se enviará a los participantes de misiones
new tiempoMostrarText[NUM_MISIONES];
new PlayerText:mTiempoText[MAX_PLAYERS];                     //contador del tiempo
new tMision[NUM_MISIONES];                              //si tiene tiempo, usar este, bajará cada segundo su valor
new mNumObjects[NUM_MISIONES];
new mObjects[NUM_MISIONES][MAX_OBJECTS_MISION];
new hidden[NUM_MISIONES];

//--------------------Parametro Generales de las Misiones
#define FARDO_DROGA 1579    // bolsa de droga

forward cogerObjeto(playerid, slot, modelo_id);
forward dejarObjeto(playerid);
forward dejandoObjeto(playerid, slot);
forward cargandoObjeto(playerid);

new cargando[MAX_PLAYERS_MISION];          //indica si el jugador i de la misión, está llevando una caja
new TimerCargando[MAX_PLAYERS];
//-------------------- Misión 1: mecanico, primer coche banda ---------------------------------
#define MISION_MECANICO 1//índice de la misión
#define NUM_HERRAMIENTAS 5
#define ID_OBJETO_MISION_MECANICO 3052     // caja repuestos
#define TIEMPO_MISION_MECANICOS 60*5       //5 minutos
#define SLOT_CAJA 0

new herrFaltan;                            //numero herramientas que la banda aun tiene que encontrar
new Float:posChkPnt[3] = {-2102.41,-214.08,35.6};   //checkpoint en el que tendrán que entregar todas las herramientas que encuentren

new Float:herrSpawn[5][3] = {
{-2111.303955,-216.647460,35.320312},
{-2110.303955,-216.647460,35.320312},
{-2109.303955,-216.647460,35.320312},
{-2113.303955,-216.647460,35.320312},
{-2114.303955,-216.647460,35.320312}};

//----------------------- Mision 2: ultima de xoomer
#define MISION_XOOMER_FIN 2
#define M2_TEXTO_INICIO 3
#define M2_TEXTO_SUBIR_COCHE 30
#define M2_MOSTRAR_CABEZA 44
#define M2_CONVERSACION_MAFIOSO 60
#define M2_NUM_OBJETOS 6
#define SLOT_PIEZA_M2 1

forward timerConverXoomer(playerid);
forward timerOpcion(playerid);
forward crearObjetosM2();
forward timerObjetosM2(playerid);
forward timerVolverCoche(playerid);

new timerVolverCocheID[MAX_PLAYERS];
new tiempoVolverCoche[MAX_PLAYERS];

new objetosFaltanM2;
new timerObjetosM2ID;
new idObjetoM2[M2_NUM_OBJETOS];
new Float:objetoM2[M2_NUM_OBJETOS][3] = {
{ -1977.90002, 1335.30005, 6.3},
{ -2006.19995, 1379.90002, 6.3},
{ -1917.69995, 1384.80005, 12.0},
{ -2011.59998, 1360.0, 6.3},
{ -1921.69995, 1387.0, 6.3},
{ -1940.09998, 1347.30005, 6.4}};

new tipoObjetoM2[M2_NUM_OBJETOS] = {
2908,2907,2906,2905,2905,2906};

new cargandoM2;

new timerOpcionID[MAX_PLAYERS];
new eligiendoOpcion[MAX_PLAYERS];
new timerConverXoomerID[MAX_PLAYERS];
new tiempoConverXoomer[MAX_PLAYERS];
new m2opcion[MAX_PLAYERS];
new m2CocheLimpiezaID;
new contChkPnt[MAX_PLAYERS];

new Float:m2posChkPnt[3] = {-1545.3770,1227.0601,7.1875}; //pal checkpoint de la limpieza
//----------------------- Mision 3: Droga
#define MISION_DROGA 15
#define NUM_DROGA 3
#define TIEMPO_MISION_DROGA 60*8       //7 minutos
#define SLOT_DROGA 0
new drogaNPCVeh;
new conductorBarco[NUM_MISIONES];
new m3BarcoID;
new m3TorilloID;
new m3CamionID;
new drogaObj[3];
new drogaFaltan;

new Float:m3posChkPnt[6][3] = {
{-2225.8679,2400.8191,1.0921}, //La lancha
{-1453.1379,1520.8398,1.7254},//El del barco para coger los fardos
{-2201.4534,2422.2605,-0.5291},// La de vuelta del barco
{-2206.2166,2415.0137,1.90},//Donde esta la droga
{-2267.4675,2396.3667,4.9612},//Donde esta el camion
{-2221.99, -134.94, 35.32}};//La de entrega del pale

new Float:drogaSpawn[15][3] = {
{-1474.7554,1486.4730,7.4501},
{-1474.9403,1488.3518,7.4501},
{-1474.8721,1490.3146,7.4578},
{-1474.7986,1492.4594,7.4578},
{-1474.7101,1495.0242,7.4578},
{-1472.6487,1495.1556,7.4578},
{-1472.5037,1493.3842,7.4578},
{-1472.5994,1491.5774,7.4578},
{-1472.4713,1489.3468,7.4501},
{-1472.5953,1486.9945,7.4501},
{-1470.5475,1486.7775,7.4501},
{-1470.3005,1488.5507,7.4501},
{-1470.2915,1489.8726,7.4578},
{-1470.2770,1491.9755,7.4578},
{-1470.2638,1493.9225,7.4578}};
//----------------------- Mision 4: Armas
#define MISION_ARMAS 4
#define NUM_ARMAS 12
#define ID_OBJETO_MISION_ARMAS 3052     // Caja de Armas
#define TIEMPO_MISION_ARMAS 60*7       //7 minutos
#define SLOT_ARMAS 0

new m4conductorCamion[NUM_MISIONES];
new m4CamionID;
new armasFaltan;
new Float:m4posChkPnt[2][3] = {
{-2112.4519,-2428.8086,30.6250},//checkpoint de recoger las armas
{-2221.99, -134.94, 35.32}};//La de entrega de las armas

new Float:armasSpawn[NUM_ARMAS][3] = {
{-2115.6675,-2415.1624,30.4266},
{-2117.3521,-2414.0566,30.4266},
{-2119.3899,-2412.5710,30.4266},
{-2117.9287,-2410.4597,30.4561},
{-2116.2217,-2411.6272,30.4577},
{-2114.3213,-2413.2373,30.4565},
{-2112.5115,-2411.3464,30.4885},
{-2114.3579,-2409.7380,30.4893},
{-2116.2871,-2408.2510,30.4892},
{-2114.4751,-2405.8003,30.4063},
{-2112.4194,-2407.1157,30.4076},
{-2110.5962,-2408.7498,30.4066}};
//----------------------- Mision 5: COCHE DEL TOTE
#define MISION_COCHE 5
#define TIEMPO_MISION_COCHE 60*40       //5 minutos
#define NUM_COCHES_M5 50
#define MAX_COORDENADAS_MISION 113
forward spawnAleatorioCoches();//Asigna coordenadas aleatorias previamente guardadas a los coches de la mision
forward finiquitarCoche(playerid, _veh);

new Float:m5posChkPnt[3] = {-1531.67, 175.03, 3.62};//La de entrega de los coches del tote

enum mCoches{
	mId,
	mDelivered,
}
new CocheMision[NUM_COCHES_M5][mCoches];
new cochesFaltan = 0;
new mTimeBuscar[MAX_PLAYERS];//Cd para usar /buscar

enum mCoords{
	Float:mX,
 	Float:mY,
 	Float:mZ,
 	Float:mAngle,
 	mUsed,
}
new CoordMision[113][mCoords];
//----------------MISION 6: MISON DE INFILTRACION
#define MISION_INFILTRAR 6
#define TIEMPO_MISION_INFILTRAR 60*8       //8 minutos
forward encenderluz1();
forward encenderluz2();
forward encenderluz3();
forward infiltrado();

new Float:m6posChkPnt[3][3] = {
{-1522.2471, 2643.3484, 55.5630},
{-1482.0654,2615.7622,58.7879},
{-1528.2471, 2643.3484, 55.5630}};//La de entrega de los coches del tote

new luz1;
new luz2;
new luz3;
new bomba;
new panel1;
new panel2;
new panel3;
//--------------MISION 7: TRANSPORTAR
#define MISION_TRANSPORTARDROGA 7
#define TIEMPO_MISION_TRANSPORTARDROGA 60*8//8 minutos
#define SLOT_MISION_TRANSPORTARDROGA 0      
new m7CamionID;

new Float:m7posChkPnt[9][3] = {
{-2251.3833,2326.1072,4.8125},
{-2758.7322,218.8880,6.6824},//primer garito
{-2781.2620,218.7447,7.1797},//entrada trasera
{-2216.6631,-125.3551,35.0474},//segundo garito
{-2228.0278,-139.4661,35.3203},//entrada trasera
{-1970.5004,1229.9673,31.3850},//tercero garito
{-1970.2437,1223.4319,31.7346},//entrada trasera
{-2193.8459,967.6199,79.7271},//cuartogarito
{-2182.9456,957.3096,80.0000}};//entrada trasera
//------------------EVENTO POLICIA---------------------------------------------------------------------------------
enum thuye{
	huye,
	Float:d,
	Float:ptox,
	Float:ptoy,
	Float:ptoz,
	p
};
new huyendo[MAX_PLAYERS][thuye];

new Float:alarmas[NUMALARMAS][3] = {
{-1993.1353,-54.2543,35.3137},{-1993.2783,-35.8689,35.2818},{-1993.2040,-13.6522,34.8312},{-1993.3091,11.5477,33.6456},
{-1993.3885,30.9620,32.8443},{-1992.9227,48.5071,30.7723},{-1993.3917,68.6583,28.3206},{-1990.0344,-87.9968,36.0432},
{-1989.3752,-106.7212,34.7622},{-1989.8140,-120.6450,34.8968},{-1989.8724,-137.3986,34.9250},{-1990.3241,-152.7185,35.0533},
{-1990.4803,-165.8864,35.1012},{-1990.6769,-181.0915,35.2407},{-1990.8865,-194.9312,35.3771},{-1991.0565,-206.1993,35.3944},
{-1991.2069,-216.1720,35.4136},{-2388.5298,-87.1939,35.3203},{-2387.5388,-101.6960,35.3203},{-2388.0000,-117.0512,35.3203},
{-2388.2749,-130.6201,35.3203},{-2388.5500,-146.4411,35.3203},{-2386.9590,-160.9077,35.3125},{-2383.9333,-174.2081,35.3125},
{-2378.3154,-184.3883,35.3203},{-2411.8098,-201.8369,35.3203},{-2407.6775,-186.3360,35.3125},{-2406.5542,-169.3537,35.3203},
{-2406.5244,-145.0276,35.3203},{-2406.5061,-125.6561,35.3203},{-2407.2490,-106.1561,35.3203},{-2407.0798,-87.7454,35.3203},
{-2396.6018,-85.9287,35.3203},{-2385.1394,-54.3435,35.3125},{-2385.8359,-41.4035,35.3125},{-2386.2202,-28.3665,35.3125},
{-2386.1414,-13.6028,35.3125},{-2386.5452,-1.2218,35.3125},{-2386.3792,8.4378,35.2683},{-2385.6174,21.9550,35.2759},
{-2383.3057,36.5011,35.2302},{-2377.5933,47.2027,35.2416},{-2367.9341,54.9434,35.3203},{-2355.3999,61.3180,35.3047},
{-2338.9417,65.7351,35.3047},{-2329.0881,65.7164,35.3125},{-2315.3696,65.6946,35.3125},{-2301.2964,65.5106,35.3047},
{-2291.2224,65.1734,35.3125},{-2288.6494,77.3639,35.3047},{-2288.4875,96.7734,35.3125},{-2288.6194,111.1733,35.3125},
{-2288.5388,124.7301,35.3125},{-2288.0393,142.6827,35.3125},{-2288.4729,155.8951,35.3056},{-2285.4736,173.3902,35.3125},
{-2285.9519,188.7811,35.3125},{-2286.4482,207.5822,35.3125},{-2285.7976,224.5517,35.3115},{-2272.5562,225.2155,35.3151},
{-2265.8701,233.7137,35.3089},{-2265.9087,243.5781,35.3203},{-2266.0781,253.0721,35.3203},{-2266.2444,262.5664,35.3203},
{-2266.2620,274.0143,35.3203},{-2266.3230,285.6904,35.3203},{-2266.5837,296.2705,35.3203},{-2268.4067,304.4913,35.3203},
{-2284.2917,304.3235,36.4103},{-2299.0879,303.1003,36.8019},{-2314.4397,300.9130,37.6661},{-2330.2686,295.4764,37.4624},
{-2344.0632,286.7165,36.0005},{-2358.6826,276.6120,34.7905},{-2398.6533,265.3172,36.3813},{-2400.8486,256.9350,36.6866},
{-2400.4731,240.4412,36.1055},{-2400.3499,223.6024,36.1268},{-2400.8413,209.4551,35.5953},{-2401.8774,192.4729,35.2354},
{-2404.7092,174.8842,35.2191},{-2405.6960,157.4719,35.2110},{-2405.9346,144.2796,35.2137},{-2405.9248,124.1908,35.2138},
{-2405.9248,116.2839,35.2138},{-2406.4204,106.0752,35.2089},{-2405.8826,90.6500,35.2142},{-2406.5088,73.0339,35.2081},
{-2406.5520,59.7249,35.1641},{-2406.5837,40.6318,35.1641},{-2406.4438,23.8390,35.2103},{-2406.2385,10.1125,35.3064},
{-2406.3613,-5.7482,35.3203},{-2406.3613,-23.2123,35.3203},{-2406.3613,-41.5533,35.3203},{-2406.0276,-53.9542,35.3203},
{-2396.5022,-56.3332,35.3203},{-2025.3501,585.0366,36.7102},{-2035.5531,584.9290,36.4027},{-2049.7896,584.8826,36.8435},
{-2067.3350,584.8998,37.2361},{-2074.2556,587.4614,38.3125},{-2074.4854,603.6608,44.6698},{-2074.0144,624.5864,51.7385},
{-2071.4592,653.0598,52.6171},{-2071.4976,680.9548,60.6773},{-2071.9221,709.7319,66.9154},{-2062.1243,713.5726,63.2004},
{-2048.4648,714.1800,58.3935},{-2037.1853,714.7967,53.4313},{-2024.5995,714.8391,47.9328},{-2022.0061,703.2266,47.4174},
{-2021.4515,687.6649,47.5175},{-2021.6162,672.1098,46.2994},{-2021.8307,653.7266,43.0910},{-2021.5956,642.7328,41.0599},
{-2021.5413,627.3589,38.2866},{-2021.5413,613.8231,36.9913},{-2021.7327,595.2989,36.3954}};
//-----------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

new Peds[217][1] = {
{264},
{288},//TEAM_ADMIN
{286},{287},{228},{113},{120},{147},{294},{227},{61},{171},
{247},//CIVILIANS DOWN HERE
{248},{100},{256},{263},{262},{261},{260},{259},{258},{257},{256},{255},
{253},{252},{251},{249},{246},{245},{244},{243},{242},{241},{240},{239},
{238},{237},{236},{235},{234},{233},{232},{231},{230},{229},
{226},{225},{173},{174},{175},{224},{223},{222},{221},{220},{219},{218},
{217},{216},{215},{214},{213},{212},{211},{210},{209},
{207},{206},{205},{204},{203},{202},{201},{200},{199},{198},{197},{196},
{195},{194},{193},{192},{191},{190},{189},{185},{184},{183},
{182},{181},{180},{179},{178},{176},{172},{170},{168},{167},{162},
{161},{160},{159},{158},{157},{156},{155},{154},{153},{152},{151},
{146},{145},{144},{143},{142},{141},{140},{139},{138},{137},{136},{135},
{134},{133},{132},{131},{130},{129},{128},{254},{99},{97},{96},{95},{94},
{92},{90},{89},{88},{87},{85},{84},{83},{82},{81},{80},{79},{78},{77},{76},
{75},{73},{72},{69},{68},{67},{66},{64},{63},{62},{58},{57},{56},{55},
{54},{53},{52},{51},{50},{49},{45},{44},{43},{41},{39},{38},{37},{36},{35},
{34},{33},{32},{31},{30},{29},{28},{27},{26},{25},{24},{23},{22},{21},{20},
{19},{18},{17},{16},{15},{14},{13},{12},{11},{10},{1},{2},
{290},//ROSE
{291},//PAUL
{292},//CESAR
{293},//OGLOC
{187},
{296},//JIZZY
{297},//MADDOGG
{298},//CAT
{299}//ZERO
};

new Text:textVTA;

new door1, door2, door3, door4, door5;
//-----------------------------------------------------------------------------------------------------------------------

//---- Que te diga la distancia entre jugadores
Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
//---- Que te diga el Jugador que esta mas cerca
GetClosestPlayer(p1) {
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for (x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x) && !IsPlayerNPC(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
}
//----------------------------COGER ID DE UN JUGADOR A PARTIR DE PARTE DEL NOMBRE
stock GetPlayerID(const playername[], partofname=0)
{
   new i;
   new playername1[64];
   for (i=0;i<MAX_PLAYERS;i++)
   {
      if (IsPlayerConnected(i))
      {
         GetPlayerName(i,playername1,sizeof(playername1));
         if (strcmp(playername1,playername,true)==0)
         {
            return i;
         }
      }
   }
   new correctsigns_userid=-1;
   new tmpuname[128];
   new hasmultiple=-1;
   if(partofname)
   {
      for (i=0;i<MAX_PLAYERS;i++)
      {
         if (IsPlayerConnected(i))
         {
            GetPlayerName(i,tmpuname,sizeof(tmpuname));

            if(!strfind(tmpuname,playername1[partofname],true, 0))
            {
               hasmultiple++;
               correctsigns_userid=i;
            }
            if (hasmultiple>0)
            {
               return -2;
            }
         }
      }
   }
   return correctsigns_userid;
}

stock Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
	new Float:TGTDistance;

	// get distance from camera to target
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

	new Float:tmpX, Float:tmpY, Float:tmpZ;

	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;

	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

  new Float:DX, Float:DY;
  new Float:angle;

  DX = floatabs(floatsub(x2,X));
  DY = floatabs(floatsub(y2,Y));

  if (DY == 0.0 || DX == 0.0) {
    if(DY == 0 && DX > 0) angle = 0.0;
    else if(DY == 0 && DX < 0) angle = 180.0;
    else if(DY > 0 && DX == 0) angle = 90.0;
    else if(DY < 0 && DX == 0) angle = 270.0;
    else if(DY == 0 && DX == 0) angle = 0.0;
  }
  else {
    angle = atan(DX/DY);

    if(X > x2 && Y <= y2) angle += 90.0;
    else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    else if(X < x2 && Y >= y2) angle -= 90.0;
    else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
  }

  return floatadd(angle, 90.0);
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) {
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius) {
	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
 	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

	new Float:vertical, Float:horizontal;

	switch (GetPlayerWeapon(playerid)) {
	  case 34,35,36: {
	  if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
	  return false;
	  }
	  case 30,31: {vertical = 4.0; horizontal = -1.6;}
	  case 33: {vertical = 2.7; horizontal = -1.0;}
	  default: {vertical = 6.0; horizontal = -2.2;}
	}

	new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
 	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
 	GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
  	return false;
}

stock IsPlayerAimingAtPlayer(playerid, targetplayerid) {
  new Float:x, Float:y, Float:z;
  GetPlayerPos(targetplayerid, x, y, z);
  return IsPlayerAimingAt(playerid, x, y, z, 1.1);
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, &Float:z, &Float:a, Float:distance)
{
	GetPlayerPos(playerid, x, y ,z);
	if(IsPlayerInAnyVehicle(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid),a);
	}
	else
	{
		GetPlayerFacingAngle(playerid, a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return 0;
}

stock Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) //By Gabriel "Larcius" Cordes
{
	return floatadd(floatadd(floatsqroot(floatpower(floatsub(x1,x2),2)),floatsqroot(floatpower(floatsub(y1,y2),2))),floatsqroot(floatpower(floatsub(z1,z2),2)));
}

//------------------------------------------------------------------------------------------------------

main()
{
	print(" Vendetta's Revenge");
	print("_____________________");
	print(" By Los Vendetta");
	print(" ");
}

//------------------------------------------------------------------------------------------------------

//----Pones el nombre y te da la id
public GetPlayerByName(name[MAX_PLAYER_NAME]){
  for (new i = 0; i < MAX_PLAYERS; i++){
    new auxn[MAX_PLAYER_NAME];
    GetPlayerName(i,auxn,sizeof(auxn));
    if (strcmp(auxn,name) == 0)
      return i;
  }
  return -1;
}

//----Encryptar la contraseña
public Encrypt(string[])
{
	for(new x=0; x < strlen(string); x++)
	  {
		  string[x] += (3^x) * (x % 15);
		  if(string[x] > (0xff))
		  {
			  string[x] -= 256;
		  }
	  }
	return 1;
}


stock RemovePlayerWeapon(playerid, weaponid) {
	new plyWeapons[12];
	new plyAmmo[12];
	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);
		if(wep != weaponid)
		{
		  GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}
	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}


//----Saber la distacia entre una persona y un coche en el espacio.
public DistanciaCoche(Float:radi, playerid, carid)
{
	new Float:x, Float:y, Float:z;
    new Float:x2, Float:y2, Float:z2;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetVehiclePos(carid,x,y,z);
	GetPlayerPos(playerid,x2,y2,z2);
	tempposx = (x -x2);
	tempposy = (y -y2);
	tempposz = (z -z2);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}

	return 0;
}

public timerVolverCoche(playerid) {
	if (tiempoVolverCoche[playerid] == 1) {
	    if (m2opcion[playerid] == 2 && contChkPnt[playerid] == 1) {
	        m2opcion[playerid] = 0;
		    contChkPnt[playerid] = 0;
	        NPCocupado[MISION_XOOMER_FIN] = 0;
	        tiempoConverXoomer[playerid] = 0;
	        if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PIEZA_M2))
	            RemovePlayerAttachedObject(playerid,SLOT_PIEZA_M2);
	        GameTextForPlayer(playerid, "Fracaso mision", 6000, 4);
			KillTimer(timerVolverCocheID[playerid]);
		}
		else if (PlayerInfo[playerid][pMisionBanda] == MISION_DROGA) {
            finishMission(MISION_DROGA, 2);
			KillTimer(timerVolverCocheID[playerid]);
		}
		else if (PlayerInfo[playerid][pMisionBanda] == MISION_ARMAS) {
            finishMission(MISION_ARMAS, 2);
			KillTimer(timerVolverCocheID[playerid]);
		}
	}
	if (tiempoVolverCoche[playerid] > 1)
		tiempoVolverCoche[playerid]--;
}

//----Un player entra en un vehiculo
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

	//tif (ispassenger == 1 || PlayerInfo[playerid][pAdmin] == SA) return 1;

	for (new i = 0; i < CreatedCar; i++) {
	    if (vehicleid == CreatedCars[i]) {
	        if (PlayerInfo[playerid][pAdmin] < SA) {
				SendClientMessage(playerid, COLOR_RED, "Coche admin");
    	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
			} else {
				SendClientMessage(playerid, COLOR_RED, "Coche admin");
    	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
			}
			return 1;
	    }
	}

	if (esCocheBomberos(vehicleid) && PlayerInfo[playerid][pTeam] != BOMBEROS) {
//		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		CerrarVeh(vehicleid);
		SetTimerEx("AbrirVeh", 4000,0, "d", vehicleid);
	} else if (esCochePolicia(vehicleid) && PlayerInfo[playerid][pTeam] != POLI) {
		CerrarVeh(vehicleid);
//		SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
		SetTimerEx("AbrirVeh", 4000,0, "d", vehicleid);
	}
	if (PlayerInfo[playerid][pTeam] == POLI && HaveTaser[playerid] == 1) {
		RemovePlayerAttachedObject(playerid,0);
		HaveTaser[playerid] = 0;
		KillTimer(TazerControlID[playerid]);
	}

	if (m2opcion[playerid] > 0 && vehicleid == m2CocheLimpiezaID) {  //entró al vehiculo mision 2
	    if (tiempoVolverCoche[playerid] > 1) {
	        SetPlayerCheckpoint(playerid,-1979.9841,1342.7650,7.1875,2.0);
	        tiempoVolverCoche[playerid] = 0;
	        KillTimer(timerVolverCocheID[playerid]);
	    }
	    if (contChkPnt[playerid] == 0) {
    		crearObjetosM2();
   			contChkPnt[playerid] = 1;
			SetPlayerCheckpoint(playerid,-1979.9841,1342.7650,7.1875,2.0);
		}
	}
	if (PlayerInfo[playerid][pMisionBanda] == MISION_DROGA) {
		if( vehicleid == m3BarcoID){	//salió del barco de la mision de la droga
		    conductorBarco[MISION_DROGA] = 1;
		    setMissionCheckpoint(MISION_DROGA, m3posChkPnt[1][0], m3posChkPnt[1][1], m3posChkPnt[1][2], 4.0);
		    sendMissionGameText(MISION_DROGA,"Ok continuemos", 4000);
			tiempoVolverCoche[playerid] = 0;
			KillTimer(timerVolverCocheID[playerid]);
		}
    }
    if (PlayerInfo[playerid][pMisionBanda] == MISION_ARMAS) {
		if( vehicleid == m4CamionID){	//entro al camion de la mision de las armas
		    m4conductorCamion[MISION_ARMAS] = 1;
		    setMissionCheckpoint(MISION_ARMAS, m4posChkPnt[0][0], m4posChkPnt[0][1], m4posChkPnt[0][2], 4.0);
		    sendMissionGameText(MISION_ARMAS,"Ok continuemos", 4000);
			tiempoVolverCoche[playerid] = 0;
			KillTimer(timerVolverCocheID[playerid]);
		}
    }

	new index = searchCar(vehicleid);
	if (index == -1) return 1;

	new tieneLlave = false;
    for (new i = 0; i < MAX_PLAYER_CAR_KEYS; i++) {
	    if (car[index][vehkey] == PlayerInfo[playerid][pCarKeys][i]) {
	        tieneLlave = true;
	        break;
		}
    }
 
    if (!tieneLlave) {
	    if (car[index][vehdoors] == 1) {
    		CerrarVeh(vehicleid);
//	        SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	        SetTimerEx("AbrirVeh", 3000,0, "d", vehicleid);
	        new sendername[MAX_PLAYER_NAME];
	        new string[200];
	        GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "Suena la alarma porque %s intentó abrir el coche!", sendername);
			ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			tiempoAlarmaCoche[vehicleid] = 10;
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, engine, lights, 1, doors, bonnet, boot, objective);
		   	timerAlarmaCocheID[vehicleid] = SetTimerEx("timerAlarmaCoche",1000,1,"d",vehicleid);
		}
	} else {
		if (car[index][vehdoors] == 1) {
			SendClientMessage(playerid, COLOR_RED, "Tienes que abrir primero la puerta..");
	     //   SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
     		CerrarVeh(vehicleid);
	        SetTimerEx("AbrirVeh", 3000,0, "d", vehicleid);
		}
	}
    
	return 1;
}

public CerrarVeh(vehicleid) {
	for (new i = 0; i < MAX_PLAYERS; i++)
	    if (IsPlayerConnected(i) && !IsPlayerNPC(i)) {
	         SetVehicleParamsForPlayer(vehicleid, i, 0, 1);
	         SendClientMessage(i, COLOR_YELLOW, "Cerrado");
		}
}

public AbrirVeh(vehicleid){
	for (new i = 0; i < MAX_PLAYERS; i++)
	    if (IsPlayerConnected(i) && !IsPlayerNPC(i)) {
	         SetVehicleParamsForPlayer(vehicleid, i, 0, 0);
	         SendClientMessage(i, COLOR_YELLOW, "Abierto");
		}
}

public OnPlayerExitVehicle(playerid, vehicleid) {
	if (m2opcion[playerid] > 0 && vehicleid == m2CocheLimpiezaID && contChkPnt[playerid] == 1) { 		//salió del vehiculo haciendo mision 2
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid,"Vuelve al coche..",4000,6);
		tiempoVolverCoche[playerid] = 11;
		timerVolverCocheID[playerid] = SetTimerEx("timerVolverCoche",1000,1,"d",playerid);
	}
	if (PlayerInfo[playerid][pMisionBanda] == MISION_DROGA) {
		if( vehicleid == m3BarcoID && conductorBarco[MISION_DROGA] == 1){	//salió del barco de la mision de la droga
		    conductorBarco[MISION_DROGA] = 0;
			disableMissionCheckpoint(MISION_DROGA);
		    sendMissionGameText(MISION_DROGA,"Vuelve al Barco", 4000);
			tiempoVolverCoche[playerid] = 11;
			timerVolverCocheID[playerid] = SetTimerEx("timerVolverCoche",1000,1,"d",playerid);
		}
    }
    if (PlayerInfo[playerid][pMisionBanda] == MISION_ARMAS) {
		if( vehicleid == m4CamionID && m4conductorCamion[MISION_ARMAS] == 1 && GetPlayerState(playerid) == 2){	//salió del camion de la mision de las armas
		    m4conductorCamion[MISION_ARMAS] = 0;
			disableMissionCheckpoint(MISION_ARMAS);
		    sendMissionGameText(MISION_ARMAS,"Vuelve al Camion", 4000);
			tiempoVolverCoche[playerid] = 11;
			timerVolverCocheID[playerid] = SetTimerEx("timerVolverCoche",1000,1,"d",playerid);
		}
    }
	return 1;
}

//-----------------------------------------------------------------------------------------------------
//-------------------------------------------- SI ESTA EN UNA TIENDA ----------------------------------
//-----------------------------------------------------------------------------------------------------

public IsAtClothShop(playerid)
{
    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
        if(PlayerToPoint(25.0,playerid,207.5627,-103.7291,1005.2578) || PlayerToPoint(25.0,playerid,203.9068,-41.0728,1001.8047))
		{//Binco & Suburban
		    return 1;
		}
		else if(PlayerToPoint(30.0,playerid,214.4470,-7.6471,1001.2109) || PlayerToPoint(50.0,playerid,161.3765,-83.8416,1001.8047))
		{//Zip & Victim
		    return 1;
		}
	}
	return 0;
}

public IsAtGasStation(playerid)
{
    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		if(PlayerToPoint(6.0,playerid,1004.0070,-939.3102,42.1797) || PlayerToPoint(6.0,playerid,1944.3260,-1772.9254,13.3906))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-90.5515,-1169.4578,2.4079) || PlayerToPoint(6.0,playerid,-1609.7958,-2718.2048,48.5391))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-2029.4968,156.4366,28.9498) || PlayerToPoint(8.0,playerid,-2408.7590,976.0934,45.4175))
		{//SF
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,-2243.9629,-2560.6477,31.8841) || PlayerToPoint(8.0,playerid,-1676.6323,414.0262,6.9484))
		{//Between LS and SF
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,2202.2349,2474.3494,10.5258) || PlayerToPoint(10.0,playerid,614.9333,1689.7418,6.6968))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1328.8250,2677.2173,49.7665) || PlayerToPoint(6.0,playerid,70.3882,1218.6783,18.5165))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,2113.7390,920.1079,10.5255) || PlayerToPoint(6.0,playerid,-1327.7218,2678.8723,50.0625))
		{//LV
		    return 1;
		}
	}
	return 0;
}

public IsAtBar(playerid)
{
    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		if(PlayerToPoint(4.0,playerid,495.7801,-76.0305,998.7578) || PlayerToPoint(4.0,playerid,499.9654,-20.2515,1000.6797))
		{//In grove street bar (with girlfriend), and in Havanna
		    return 1;
		}
		else if(PlayerToPoint(4.0,playerid,1215.9480,-13.3519,1000.9219) || PlayerToPoint(10.0,playerid,-2658.9749,1407.4136,906.2734))
		{//PIG Pen
		    return 1;
		}
	}
	return 0;
}

//-----------------------------------------------------------------------------------------------------
//-------------------------------------------- SI ESTA EN UN TALLER ----------------------------------
//-----------------------------------------------------------------------------------------------------
public IsAtTaller(playerid)
{
    if(IsPlayerConnected(playerid))
	{
  		if(PlayerToPoint(50.0,playerid,-1871.3744,909.0146,35.1719))
		{// ZOOMER
		    return 1;
		}

    }
	return 0;
 }

forward mostrarLogin(playerid);
public mostrarLogin(playerid){

	if (IsPlayerNPC(playerid)) return 1;

    new plname[MAX_PLAYER_NAME];
 	new string[MAX_PLAYER_NAME];
	new aux[255];

	GetPlayerName(playerid, plname, sizeof(plname));
	format(string, sizeof(string), "%s.ini", plname);

//======================== DB LOGIN ==========================
    new nrows;
	new strQuery[512];
	new query[512]; 
	
	strcat(strQuery, "SELECT * FROM `players` WHERE `Name`='%s'");
	format(query, sizeof( query ), strQuery, plname);
	mysql_query( mysql, query );
	nrows = cache_get_row_count();
	
	
	if( nrows > 0)
	{
		gPlayerAccount[playerid] = 1;
		format(aux, sizeof(aux), "\n{7FFFD4}Nick: {1E90FF}%s Registrado\n\n{FFFFFF} Contraseña\n", plname);
    	ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "Login", aux, "Login", "Salir");
    }
	else
	{
		gPlayerAccount[playerid] = 0;
		format(aux, sizeof(aux), "\n{7FFFD4}Nick: {1E90FF}%s No registrado\n\n{FFFFFF} ¿Qué contraseña le quieres poner a tu cuenta?\n", plname);
		ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_PASSWORD, "Registro", aux, "Registrate!", "Salir");
	}
	
	/*
	format(strQuery, sizeof( strQuery ), "Filas: %i", nrows);
	print( strQuery );
	
	new error[128];
	format(error, sizeof(error), "DB_ERROR: %i", mysql_errno( mysql ));
	print( error );
	*/
	
	
//============================================================
 	
	return 1;
 }

//------------------------------------------------------------------------------------------------------------------------

public OnPlayerConnect(playerid) {
    //PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/daal0lwkpno1nyj/Baauer%20-%20Harlem%20Shake.mp3?");
	SetSpawnInfo(playerid, 1, 1,1461.0984,1533.7355,32.5241,180.0,0,0,0,0,0,0); //cartel principal de los vendetta
   	TogglePlayerSpectating(playerid,1);
	SpawnPlayer(playerid);
	
	OnDuty[playerid] = 0;
	multando[playerid][tmPaso] = 0;
	requisando[playerid] = 0;
	pincho[playerid] = 0;
	for (new i = 0; i < MAX_PLAYER_CAR_KEYS; i++)
		PlayerInfo[playerid][pCarKeys][i] = 0;
	
	for (new i = 0; i < 13; i++) {
        PlayerInfo[playerid][pWeapon][i] = 0;
        PlayerInfo[playerid][pAmmo][i] = 0;
    }
    
    for (new i = 0; i < NUM_SKILLS; i++) {
        PlayerInfo[playerid][pSkill][i] = 0;
    }
    
	numItems[playerid] = 0;
	IndiceDropItem[playerid] = -1;
	
	gPlayerLogged[playerid] = 0;
	gPlayerLogTries[playerid] = 0;
	GivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);
	PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pReg] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pPos_x] = 2246.6;
	PlayerInfo[playerid][pPos_y] = -1161.9;
	PlayerInfo[playerid][pPos_z] = 1029.7;
	PlayerInfo[playerid][pInt] = 15;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pTeam] = 0;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pModel] = 0;
	PlayerInfo[playerid][pWanted] = 0;
	PlayerInfo[playerid][pLogged] = 0;
	PlayerInfo[playerid][pBanda] = 0;
	PlayerInfo[playerid][pMisionBanda] = 0;
	SetPlayerColor(playerid,INVISIBLE);

	SetTimerEx("mostrarLogin",7000,0,"d",playerid);

  	EscenaText[playerid] = CreatePlayerTextDraw(playerid, 320.0, 380.0,"_");
	PlayerTextDrawTextSize(playerid, EscenaText[playerid], 50.0, 400.0);
	PlayerTextDrawFont(playerid, EscenaText[playerid],2);
	PlayerTextDrawSetShadow(playerid, EscenaText[playerid],1);
	PlayerTextDrawSetOutline(playerid, EscenaText[playerid],1);
	PlayerTextDrawBackgroundColor(playerid, EscenaText[playerid],0x000000FF);
	PlayerTextDrawColor(playerid, EscenaText[playerid],0xFFFFFFFF);
	PlayerTextDrawAlignment(playerid, EscenaText[playerid],2);
	PlayerTextDrawHide(playerid, EscenaText[playerid]);

	mMsgText[playerid] = TextDrawCreate(100.0, 5.0,"_");
	TextDrawTextSize(mMsgText[playerid], 20.0, 150.0);
	TextDrawFont(mMsgText[playerid],2);
	TextDrawSetShadow(mMsgText[playerid],1);
	TextDrawSetOutline(mMsgText[playerid],1);
	TextDrawBackgroundColor(mMsgText[playerid],0x000000FF);
	TextDrawColor(mMsgText[playerid],0xFFFFFFFF);
	TextDrawAlignment(mMsgText[playerid],2);
	TextDrawHideForPlayer(playerid, mMsgText[playerid]);

	textVTA = TextDrawCreate(500.0, 430.0,"Vendetta's Revenge");
	TextDrawFont(textVTA,0);
	TextDrawSetShadow(textVTA,1);
	TextDrawSetOutline(textVTA,1);
	TextDrawBackgroundColor(textVTA,0x000000FF);
	TextDrawColor(textVTA,0xFFFFFFFF);
	TextDrawHideForPlayer(playerid,textVTA);

	//-----------------------ICONOS EN EL MAPA
	SetPlayerMapIcon(playerid, 1, -1968.1526,1374.9717,7.1875, 23, 1, MAPICON_LOCAL);//Icono Barrio Aztecas
	SetPlayerMapIcon(playerid, 2, -2160.1692,-217.8206,35.3265, 27, 1, MAPICON_LOCAL);//Icono Mecanicos
	SetPlayerMapIcon(playerid, 3, 1560.6787109375, -1684.51171875, 1725.4956054688, 30, 1, MAPICON_LOCAL);//Icono Policia
	SetPlayerMapIcon(playerid, 4, 521.6583,-1285.7435,16.8683, 9, 1, MAPICON_LOCAL);//Icono Puerto

	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
    if (tiempoConverXoomer[playerid] > 0) { // Comprueba si tiene la mision activa
        tiempoConverXoomer[playerid] = 0; //Le saca de la mision
        NPCocupado[MISION_XOOMER_FIN] = 0; //El NPC se reactiva para todo el mundo
        KillTimer(timerConverXoomerID[playerid]);
		for (new i = 0; i < M2_NUM_OBJETOS; i++)
			DestroyObject(idObjetoM2[i]); //Destruye lso objetos de la mision
    }
    
    gPlayerLogged[playerid] = 0;

	darArmas[playerid] = 0;
	PlayerInfo[playerid][pLogged] = 0;
	KillTimer(accountstimer[playerid]);
	OnPlayerUpdate(playerid);
	
	KillTimer(TazerControlID[playerid]);
	KillTimer(timerEncerradoID[playerid]);
	huyendo[playerid][huye] = 0;
	trabajo[playerid] = 0;
	muriendo[playerid] = 0;
	m2opcion[playerid] = 0;
	
	OnDuty[playerid] = 0;

//	TextDrawDestroy(indText[playerid][textIntro]);
	tEscena[playerid] = 0; //deja de ver el palike
    PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
//	PlayerInfo[playerid][pParking] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pPresentacion] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pPos_x] = 0.0;
	PlayerInfo[playerid][pPos_y] = 0.0;
	PlayerInfo[playerid][pPos_z] = 0.0;
	PlayerInfo[playerid][pInt] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pTeam] = 0;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pModel] = 0;
	PlayerInfo[playerid][pWanted] = 0;
	PlayerInfo[playerid][pBanda] = 0;
	if (mNumPlayersReales[PlayerInfo[playerid][pMisionBanda]] == 1) {
	    finishMission(PlayerInfo[playerid][pMisionBanda],SIN_JUGADORES);
	} else mNumPlayersReales[PlayerInfo[playerid][pMisionBanda]]--;
	PlayerInfo[playerid][pMisionBanda] = 0;

	
	HideProgressBarForPlayer(playerid, satisBar[playerid]);
	PlayerTextDrawDestroy(playerid, mTiempoText[playerid]);
	PlayerTextDrawDestroy(playerid, EscenaText[playerid]);
	
	//Limpia los timers de la ESCENA_INTRO
	tEscena[playerid] = 0;
	FinEscena(playerid);
	
	return 1;
}
//---------------------------------------DONDE SPAWNEA UN JUGADOR SEGUN EL EQUIPO-----------------------------------------
public SetPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	
	if(IsPlayerConnected(playerid)) {
	
	    if (darArmas[playerid] == 0) {
			for (new i = 0; i < 13; i++) {
		    	if (PlayerInfo[playerid][pWeapon][i] > 0) {
			    	GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon][i],PlayerInfo[playerid][pAmmo][i]);
				}
			}
			darArmas[playerid] = 1;
		}
	
	   	if (PlayerInfo[playerid][pJailTime] > 0) {
			new ale = random(NUM_CARCELES);
			SetPlayerPos(playerid,CoordCarcel[ale][0],CoordCarcel[ale][1],CoordCarcel[ale][2]);
			if (timerEncerradoID[playerid] == 0)
				timerEncerradoID[playerid] = SetTimerEx("timerEncerrado",1000,1,"d",playerid);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pModel]);
		}
	    else if(PlayerInfo[playerid][pTeam] == POLI)//Spawn Policia
		{
  			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid,-1618.9457,681.3729,7.1901);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pModel]);
			return 1;
        }
	    else if(PlayerInfo[playerid][pTeam] == BOMBEROS)//Spawn Bombero
		{
  			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid,-2034.44, -255.11, 35.5);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pModel]);
			return 1;
		}
		else if(MedicBill[playerid] == 1 && PlayerInfo[playerid][pJailed] == 0 )
		{
		    new string[256];
		    new cut = deathcost; //PlayerInfo[playerid][pLevel]*deathcost;
			GivePlayerMoney(playerid, -cut);
			format(string, sizeof(string), "DOC: Your Medical Bill comes to $%d, Have a nice day.", cut);
			SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
			MedicBill[playerid] = 0;
			MedicTime[playerid] = 0;
			NeedMedicTime[playerid] = 0;
			SetPlayerHealth(playerid, 25.0);
		}
	    else if (PlayerInfo[playerid][pTeam] == 0)
	    {
			SetPlayerColor(playerid,INVISIBLE);
			
			SetPlayerPos(playerid, -1871.3744,909.0146,35.1719); // EN FRENTE DEL XOOMER
			SetPlayerFacingAngle(playerid, 344.6770);
			SetPlayerInterior(playerid,0);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pModel]);
			InterpolateCameraPos(playerid,-1884.3433,909.3839,34.5719,-1871.2828,906.7007,34.5719,5000,CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,-1865.2594,939.9731,45.1719,-1865.2594,939.9731,45.1719,5000,CAMERA_CUT);
			SetTimerEx("centrarCamara",5500,0,"d",playerid);
			PlayerInfo[playerid][pInt] = 0;
			return 1;
		}
		else if (PlayerInfo[playerid][pTeam] == MECANICO)
	    {
			SetPlayerColor(playerid,INVISIBLE);

			SetPlayerPos(playerid, -1871.3744,909.0146,35.1719); // EN FRENTE DEL XOOMER MECANICOS
			SetPlayerFacingAngle(playerid, 344.6770);
			SetPlayerInterior(playerid,0);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pModel]);
			InterpolateCameraPos(playerid,-1884.3433,909.3839,34.5719,-1871.2828,906.7007,34.5719,5000,CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,-1865.2594,939.9731,45.1719,-1865.2594,939.9731,45.1719,5000,CAMERA_CUT);
			SetTimerEx("centrarCamara",5500,0,"d",playerid);
			PlayerInfo[playerid][pInt] = 0;
			return 1;
		}
 	}
  	return 1;
}

public centrarCamara(playerid) {
	SetCameraBehindPlayer(playerid);
}

public OnPlayerDeath(playerid, killerid, reason) {
	//Limpia la mision principal
    if (tiempoConverXoomer[playerid] > 0) { // Comprueba si tiene la mision activa
        tiempoConverXoomer[playerid] = 0; //Le saca de la mision
        NPCocupado[MISION_XOOMER_FIN] = 0; //El NPC se reactiva para todo el mundo
        KillTimer(timerConverXoomerID[playerid]);
		for (new i = 0; i < M2_NUM_OBJETOS; i++)
			DestroyObject(idObjetoM2[i]); //Destruye lso objetos de la mision
    }

    GameTextForPlayer(playerid, "~b~GAME OVER", 1000, 5);

	OnDuty[playerid] = 0;
	PoliciasDisparan[playerid]=0;
	
	if(PlayerOnFire[playerid]) {
		SendClientMessage(playerid, 0xff000000, "Te quemaste!");
		StopPlayerBurning(playerid);
	}
	
	return 1;
}
//--------------Log de las transferencias y los pagos
public PayLog(string[]) {
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("pay.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
//-------------Apuntar a todos los que se echan del server
public KickLog(string[]) {
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("kick.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}
//-------------Apuntar a todos los que se banean
public BanLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("ban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public OnPlayerEnterCheckpoint(playerid) {
	if(m2opcion[playerid] > 0 && contChkPnt[playerid] == 0) {
		tiempoConverXoomer[playerid] = M2_TEXTO_SUBIR_COCHE;
		timerConverXoomerID[playerid] = SetTimerEx("timerConverXoomer",1000,1,"d",playerid);
	    DisablePlayerCheckpoint(playerid);
	} else if (m2opcion[playerid] > 0 && contChkPnt[playerid] == 1 && IsPlayerInVehicle(playerid,m2CocheLimpiezaID)) {
	    tiempoConverXoomer[playerid] = M2_MOSTRAR_CABEZA;
		timerConverXoomerID[playerid] = SetTimerEx("timerConverXoomer",1000,1,"d",playerid);
	    DisablePlayerCheckpoint(playerid);
	} else if (m2opcion[playerid] > 0 && contChkPnt[playerid] == 2) {
		tiempoConverXoomer[playerid] = M2_CONVERSACION_MAFIOSO;
		timerConverXoomerID[playerid] = SetTimerEx("timerConverXoomer",1000,1,"d",playerid);
	    DisablePlayerCheckpoint(playerid);
	} else if (m2opcion[playerid] > 0 && contChkPnt[playerid] == 3 && cargandoM2 == 1) {
		cargandoM2 = 0;
		objetosFaltanM2--;
		RemovePlayerAttachedObject(playerid, SLOT_PIEZA_M2);
		new str[20];
		if (objetosFaltanM2 > 0)
			format(str,sizeof(str),"Faltan %d piezas", objetosFaltanM2);
		else {
			NPCocupado[MISION_XOOMER_FIN] = 0;
			tiempoConverXoomer[playerid] = 0;
			format(str,sizeof(str),"Completado!", objetosFaltanM2);
		}
		GameTextForPlayer(playerid,str,3000,6);
		return 1;
  	}
	if(PlayerInfo[playerid][pTeam] == BOMBEROS && OnDuty[playerid] == 1) {
		if(PlayerToPoint(3.0,playerid,coordBomberosEntrada[randCoordBombero][0],coordBomberosEntrada[randCoordBombero][1],coordBomberosEntrada[randCoordBombero][2])) {
    		SetPlayerPos(playerid, 2092.9502,1291.2554,-42.6625);
    		SetPlayerCheckpoint(playerid, 2097.1680,1295.4927,-39.0, 2.0);
		} else if(PlayerToPoint(3.0,playerid,2092.9502,1291.2554,-42.6625)){
    		SetPlayerPos(playerid, coordBomberosSalida[randCoordBombero][0],coordBomberosSalida[randCoordBombero][1],coordBomberosSalida[randCoordBombero][2]);
			if (salvando[playerid] == 1) {
				GameTextForPlayer(playerid, "Salvaste al tote!", 6000, 6);
				GivePlayerMoney(playerid,200);
			}
			else
				GameTextForPlayer(playerid, "Fracasaste!", 6000, 4);
			salvando[playerid] = 0;
    		DisablePlayerCheckpoint(playerid);
		} else if(PlayerToPoint(2.0, playerid, 2097.1680, 1295.4927, -39.0)) {
			GameTextForPlayer(playerid, "Coge al tote y sal de aquí!", 6000, 6);
    		salvando[playerid] = 1;
    		SetPlayerCheckpoint(playerid, 2092.9502,1291.2554,-42.6625, 2.0);
		}
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid) {
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

//------------------Cuando el jugador cambia de estado
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	ctrlVel[playerid][pX] = 0.0;
	ctrlVel[playerid][pY] = 0.0;
	if (IsPlayerNPC(playerid)) return 1;


	if(newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
    	if (esCochePolicia(vehicleid) && PlayerInfo[playerid][pTeam] != POLI) {
			if (esMoto(vehicleid)) {
			    RemovePlayerFromVehicle(playerid);
			}
		}
        for(new i = 0; i < sizeof(SpikeInfo); i++)
       {
           if(IsPlayerInRangeOfPoint(playerid, 3.0, SpikeInfo[i][sX], SpikeInfo[i][sY], SpikeInfo[i][sZ]))
            {
               if(SpikeInfo[i][sCreated] == 1)
               {
                   new panels, doors, lights, tires;
                   new carid = GetPlayerVehicleID(playerid);
           		   GetVehicleDamageStatus(carid, panels, doors, lights, tires);
		           tires = encode_tires(1, 1, 1, 1);
		           UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
                   return 0;
               }
           }
       }
   	}
	
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	}
	else if(newstate == PLAYER_STATE_PASSENGER)
	{

	}
	if(newstate == PLAYER_STATE_SPAWNED)
	{
		
	}
	return 1;
}

public timerEncerrado(playerid) {
	if (PlayerInfo[playerid][pJailTime] > 0)
		PlayerInfo[playerid][pJailTime]--;
	if (PlayerInfo[playerid][pJailTime] == 0) {
	    SetPlayerPos(playerid, 1557.39, -1660.04, 1718.90);
     	GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Vuelves a ser libre!", 5000, 6);
	    KillTimer(timerEncerradoID[playerid]);
	}
	else if (PlayerInfo[playerid][pJailTime] % 60 == 0){
	    new str[100];
	    format(str,sizeof(str)," ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Queda %d minuto/s",PlayerInfo[playerid][pJailTime]/60);
	    GameTextForPlayer(playerid, str, 5000, 6);
	}
}
/*
public OnPlayerRequestSpawn(playerid)
{
 SpawnPlayer(playerid);
    return 1;
}*/

//----------------Ponerle la skin que quieras
public OnPlayerRequestClass(playerid, classid) {
	if (IsPlayerNPC(playerid)){
		return 1;
	}
	SpawnPlayer(playerid);
	return 1;
}

//---------------------------------------------------------


//----------- Teleport
public Teleport()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
			if(PlayerToPoint(20, i,2015.4500,1017.0900,996.8750))
			{//Four Dragons
			    GameTextForPlayer(i, "~r~Closed", 5000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1022.599975,-1123.699951,23.799999);
			}
			else if(PlayerToPoint(1, i,-1535.7219,503.7461,7.1797))//Entrada a los mecanicos
			{
			    GameTextForPlayer(i, "~r~Mecanico", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1633.0251,492.1463,-9.8378);
			}
			else if(PlayerToPoint(1, i,-1630.5013,491.8348,-9.8378))//Salida de los mecanicos
			{
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1537.4730,504.3498,7.1797);
			}
			else if(PlayerToPoint(20, i,2233.9099,1710.7300,1011.2987))
			{//Caligula
			    GameTextForPlayer(i, "~r~Closed", 5000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1022.599975,-1123.699951,23.799999);
			}
			else if(PlayerToPoint(10, i,2265.7900,1619.5800,1090.4453))
			{//Caligula Roof 1
			    GameTextForPlayer(i, "~r~Closed", 5000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1022.599975,-1123.699951,23.799999);
			}
			else if(PlayerToPoint(10, i,2265.7800,1675.9301,1090.4453))
			{//Caligula Roof 2
			    GameTextForPlayer(i, "~r~Closed", 5000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1022.599975,-1123.699951,23.799999);
			}
			else if(PlayerToPoint(20, i,1133.0699,-9.5731,1000.6797))
			{//West Casino place
			    GameTextForPlayer(i, "~r~Closed", 5000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1022.599975,-1123.699951,23.799999);
			}
			else if(PlayerToPoint(20, i,292.0274,-36.0291,1001.5156))
			{//Ammunation 1
			    GameTextForPlayer(i, "~r~Jailed for going to ammunation", 5000, 1);
			    SetPlayerInterior(i, 6);
				SetPlayerPos(i,264.6288,77.5742,1001.0391);
				PlayerInfo[i][pJailTime] = 300;
				PlayerInfo[i][pJailed] = 1;
			}
			else if(PlayerToPoint(20, i,308.2740,-141.2833,999.6016))
			{//Ammunation 2
			    GameTextForPlayer(i, "~r~Jailed for going to ammunation", 5000, 1);
			    SetPlayerInterior(i, 6);
				SetPlayerPos(i,264.6288,77.5742,1001.0391);
				PlayerInfo[i][pJailTime] = 300;
				PlayerInfo[i][pJailed] = 1;
			}
			else if(PlayerToPoint(20, i,294.3212,-108.7869,1001.5156))
			{//Ammunation 3 (small one's)
			    GameTextForPlayer(i, "~r~Jailed for going to ammunation", 5000, 1);
			    SetPlayerInterior(i, 6);
				SetPlayerPos(i,264.6288,77.5742,1001.0391);
				PlayerInfo[i][pJailTime] = 300;
				PlayerInfo[i][pJailed] = 1;
			}
			else if(PlayerToPoint(20, i,288.8592,-80.4535,1001.5156))
			{//Ammunation 4 (small one's)
			    GameTextForPlayer(i, "~r~Jailed for going to ammunation", 5000, 1);
			    SetPlayerInterior(i, 6);
				SetPlayerPos(i,264.6288,77.5742,1001.0391);
				PlayerInfo[i][pJailTime] = 300;
				PlayerInfo[i][pJailed] = 1;
			}
			else if(PlayerToPoint(20, i,316.9583,-165.4707,999.6010))
			{//Ammunation 5 (Unprotected)
			    GameTextForPlayer(i, "~r~Jailed for going to ammunation", 5000, 1);
			    SetPlayerInterior(i, 6);
				SetPlayerPos(i,264.6288,77.5742,1001.0391);
				PlayerInfo[i][pJailTime] = 300;
				PlayerInfo[i][pJailed] = 1;
			}
			else if(PlayerToPoint(1, i, -1600.1012,897.7770,9.2266))//Entrada al Banco
			{
			    GameTextForPlayer(i, "~r~Banco de San Fierro", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,322.3076,113.2059,1003.2194);
			}
			else if(PlayerToPoint(1, i, 322.5192,110.6958,1003.2194))//Salida del Banco
			{
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1600.3373,900.6572,9.2266);
			}
			else if(PlayerToPoint(1, i, -1576.9860,685.8707,7.1875))//Entrada desde el Parking de la Comisaria
			{
			    GameTextForPlayer(i, "~r~Comisaria", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1567.5000,-1685.1322,1723.1050);
			}
			else if(PlayerToPoint(1, i, -1606.1873,672.8557,-5.2422))//Entrada desde el Parking subterraneo a los Calabozos
			{
			    GameTextForPlayer(i, "~r~Calabozos de la Comisaria", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1563.7960,-1654.0327,1718.9019);
			}
			else if(PlayerToPoint(1, i, -1605.4998,712.2133,13.8672))//Entrada desde La calle a la comisaria
			{
			    GameTextForPlayer(i, "~r~Comisaria de San Fierro", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,1552.7485,-1684.6361,1723.1119);
			}
			else if(PlayerToPoint(1, i, 1551.4326,-1684.7999,1723.1050))//Salida a la Calle desde dentro
			{
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1605.8561,715.2835,12.4013);
			}
			else if(PlayerToPoint(1, i, 1569.1306,-1685.0431,1723.1050))//Aparcamiento de la policia
			{
			    GameTextForPlayer(i, "~r~Aparcamiento de la Comisaria", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1577.2506,683.9733,7.1875);
			}
			else if(PlayerToPoint(1, i, 1564.1056,-1652.7848,1718.9019))//Aparcamiento de la policia
			{
			    GameTextForPlayer(i, "~r~Aparcamiento Subterraneo", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1606.2388,675.4425,-5.2422);
			}
			else if(PlayerToPoint(1, i, -1871.4950,942.1711,35.1719))//Entrada Xoomer
			{
			    GameTextForPlayer(i, "~r~Xoomer", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1859.1669,948.3348,36.2719);
			} else if(PlayerToPoint(1, i, -1859.1592,946.3453,36.2719))//Salida Xoomer
			{
			    GameTextForPlayer(i, "~r~Salida", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-1871.3955,940.3954,35.1719);
			}
			else if(PlayerToPoint(1, i,-2020.7366,-257.7191,35.5577))//Entrada a los bomberos
			{
			    GameTextForPlayer(i, "~r~Oficinas", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-2024.5902,-228.5035,14.5899);
			}
			else if(PlayerToPoint(1, i,-2014.0322,-228.4552,16.5776))//Salida a los bomberos
			{
			    GameTextForPlayer(i, "~r~Parque de Bomberos", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-2020.7627,-255.4600,35.3203);
			}
			else if(PlayerToPoint(1, i,-2162.2017,2719.7742,-58.9922))//Salida de la casa de la droga
			{
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-2318.4592,2358.5923,4.9964);
			}
			else if(PlayerToPoint(1, i,-2319.6567,2356.4233,4.9948))//Entrada de la casa de la droga
			{
			    GameTextForPlayer(i, "~r~Casa del Puto Ambro", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-2161.5186,2720.9094,-59.0000);
			}
			else if(PlayerToPoint(1, i,-2184.4470,2715.6892,-58.9430))//Salida de la oficina
			{
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-2238.7285,2352.1958,4.9801);
			}
			else if(PlayerToPoint(1, i,-2237.2307,2353.7515,4.9808))//Entrada a la oficina
			{
			    GameTextForPlayer(i, "~r~Oficina del Puto Ambro", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i, -2184.1755,2718.0723,-58.9430);
			}
			else if(PlayerToPoint(1, i,-2373.0454,2367.7961,-3.0160))//Salida del almacen
			{
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i,-2277.8662,2319.7693,4.9667);
			}
			else if(PlayerToPoint(1, i,-2280.8262,2319.4668,4.9633))//Entrada del almacen
			{
			    GameTextForPlayer(i, "~r~Almacen de la Droga", 2000, 1);
			    SetPlayerInterior(i, 0);
			    SetPlayerPos(i, -2373.1870,2369.8984,-3.0234);
			}
			else
			{
       			for (new j = 0; j < NUMALARMAS; j++)
				{
			        if (PlayerToPoint(5,i,alarmas[j][0],alarmas[j][1],alarmas[j][2]))
			            hacerElCabra(i);
			    }
			    for (new j = 0; j < NUM_PISOS_FRANCOS; j++) {
			        if (PlayerToPoint(1, i, PisosFrancos[j][pfEnterPos][0], PisosFrancos[j][pfEnterPos][1], PisosFrancos[j][pfEnterPos][2])) {
			            if (GetPlayerState(i) != PLAYER_STATE_ONFOOT) {
			            	GameTextForPlayer(i,"~w~ Sal del coche para ver +info" , 2500, 5);
			            }
		            	if (PlayerInfo[i][pBanda] > 0) {
				          if (j == Bandas[PlayerInfo[i][pBanda]][bPisoFranco]) {
	      		    		 SetPlayerPos(i,PisosFrancos[j][pfEnterTeleport][0], PisosFrancos[j][pfEnterTeleport][1], PisosFrancos[j][pfEnterTeleport][2]);
							 SetPlayerFacingAngle(i,PisosFrancos[j][pfEnterOrientation]);
			        	  } else {
			        	    if (Bandas[PlayerInfo[i][pBanda]][bPisoFranco] != -1) {
				        	    GameTextForPlayer(i,"~w~ Tu banda ya tiene un piso franco", 5000, 5);
							} else {
		       		      		if (!TieneDuenio(j)){
		       		      		    new string[255];
		       		      		    format(string,sizeof(string),"~w~ Este piso franco se puede alquilar por ~r~%d$~w~ a la semana. ~n~Es de nivel ~r~%d",
										 PisosFrancos[j][pfPrecioAlquiler],
										 PisosFrancos[j][pfNivel]);
									GameTextForPlayer(i, string, 7500, 5);
									alquilando[i][aTiempo] = 10;
									alquilando[i][aPisoFranco] = j;
					            } else {
									GameTextForPlayer(i,"~w~ Este piso franco ya tiene propietario" , 5000, 5);
					            }
							 }
   						  }
			     		} else {
							GameTextForPlayer(i,"~w~ No banda, no party" , 2500, 5);
				        }
		    	    } else if (PlayerToPoint(1, i, PisosFrancos[j][pfExitPos][0], PisosFrancos[j][pfExitPos][1], PisosFrancos[j][pfExitPos][2])) {
						SetPlayerPos(i,PisosFrancos[j][pfExitTeleport][0], PisosFrancos[j][pfExitTeleport][1], PisosFrancos[j][pfExitTeleport][2]);
						SetPlayerFacingAngle(i,PisosFrancos[j][pfExitOrientation]);
		            }
			    }
			}
	}
}

//---------------------------------------------------------
public GameModeInitExitFunc()
{
	new string[128];
	format(string, sizeof(string), "Viajando...");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			DisablePlayerCheckpoint(i);
			GameTextForPlayer(i, string, 4000, 5);
			SetPlayerCameraPos(i,1460.0, -1324.0, 287.2);
			SetPlayerCameraLookAt(i,1374.5, -1291.1, 239.0);
			PlayerInfo[i][pLogged] = 0;
			OnPlayerUpdate(i);
			gPlayerLogged[i] = 0;
		}
	}
	SetTimer("GameModeExitFunc", 4000, 0);
	return 1;
}

public GameModeExitFunc() {
	KillTimer(puertatimer);
	KillTimer(synctimer);
	KillTimer(newmistimer);
	KillTimer(unjailtimer);
	KillTimer(othtimer);
	KillTimer(checkgastimer);
	KillTimer(idletimer);
	KillTimer(pickuptimer);
	KillTimer(productiontimer);
	KillTimer(spectatetimer);
	KillTimer(stoppedvehtimer);
	KillTimer(calculaVel);
	KillTimer(fugitivoTimer);
	KillTimer(tiempoTimer);
//	KillTimer(introTimerT);
	KillTimer(timerMissionID);
	KillTimer(TimerRecogidaItemInventarioID);
	KillTimer(TimerTiempoVidaDropID);
//	KillTimer(AnimarDropID);
//	KillTimer(peliTimerT);
	KillTimer(onPlayerEnterObjectT);
	KillTimer(onPlayerEnterMissionCheckpointT);
	
	for(new i; i < MAX_FLAMES; i++) {
	    KillFire(i);
	}
	for(new playerid; playerid < MAX_PLAYERS; playerid++) {
		if(PlayerOnFire[playerid] && !CanPlayerBurn(playerid, 1)) {
			StopPlayerBurning(playerid);
		}
	}

	saveBandas();
	saveCochesBandas();
	
	GameModeExit();
}

public PuertaCheck()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
    	if(IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] == POLI) // Puertas Policia
		{
		    if(IsPlayerInRangeOfPoint(i, 4.0, 1560.1309774200, -1651.7266845703, 1719.5637207031)) {
	 			MoveObject(door5,1560.1309774200, -1651.7266845703, 1719.5637207031,1.50);
	 			puertas[i] = 6;
			} else if (puertas[i] ==6) {
                MoveObject(door5,1560.1090087891, -1653.4477539063, 1719.5637207031,1.50);
				puertas[i] = 0;
  			}
		    if(IsPlayerInRangeOfPoint(i, 4.0, 1549.6147460938, -1691.4772949219, 1722.1081542969)) {
	 			MoveObject(door3,1549.6147460938, -1691.4772949219, 1722.1081542969,1.50);
            	MoveObject(door4,1554.2923583984, -1691.4328613281, 1722.1081542969,1.50);
	 			puertas[i] = 5;
			} else if (puertas[i] == 5) {
  				MoveObject(door3,1550.4266357422, -1691.5009765625, 1722.1081542969,1.50);
            	MoveObject(door4,1553.4294433594, -1691.4515380859, 1722.1081542969,1.50);
				puertas[i] = 0;
  			}
		    if(IsPlayerInRangeOfPoint(i, 4.0, 1558.1387939453, -1677.8883056641, 1722.1081542969)) {
	 			MoveObject(door1,1558.1387939453, -1677.8883056641, 1722.1081542969,1.50);
            	MoveObject(door2,1562.7950439453, -1677.8798828125, 1722.1081542969,1.50);
	 			puertas[i] = 4;
			} else if (puertas[i] == 4) {
  				MoveObject(door1,1558.970703125, -1677.9114990234, 1722.1081542969,1.50);
            	MoveObject(door2,1561.9755859375, -1677.8798828125, 1722.1081542969,1.50);
				puertas[i] = 0;
  			}
  			if(IsPlayerInRangeOfPoint(i, 4.0, -1618.00, 681.00, 7.00)) {
  			    SetObjectRot( Puerta, 0.0 , 0.0, 0.0);
  			    puertas[i] = 1;
			} else if (puertas[i] == 1) {
  			    SetObjectRot( Puerta, 0.0 , 0.0, 90);
  			    puertas[i] = 0;
  			}
      		if(IsPlayerInRangeOfPoint(i, 15.0, -1572.792236, 667.409363, 6.354377)) {
        		MoveObject(Puerta1, -1572.806641, 676.091797, 6.349410, 3.0);
        		puertas[i] = 2;
			} else if (puertas[i] == 2) {
        		MoveObject(Puerta1, -1572.792236, 667.409363, 6.354377, 3.0);
        		puertas[i] = 0;
  			}
      		if(IsPlayerInRangeOfPoint(i, 8.0, -1631.00, 688.00, 7.00)) {
	 			SetObjectRot( Puerta2, 0.0 , 0.0, 90.0 );
	 			SetObjectRot( Puerta3, 0.0 , 0.0, 90.0 );
	 			puertas[i] = 3;
			} else if (puertas[i] == 3) {
  				SetObjectRot( Puerta2, 0.0 , 0.0, 0.0 );
				SetObjectRot( Puerta3, 0.0 , 0.0, 180.0 );
				puertas[i] = 0;
  			}
    	}
	}
}
//------------------------------------------------------------------------------------------------------
public OnGameModeInit() {

// ========================== DB Connection ===========================
    mysql = mysql_connect(DBHOST, DBUSER, DBNAME, DBPASS);
    mysql_log(LOG_ERROR | LOG_WARNING, LOG_TYPE_HTML); //logs errors and warnings into a nice HTML file
    new stats[150];
	mysql_stat(stats);
	print("========= DB INFO =========");
	print(stats);
	print("===========================");
// ====================================================================


    ConnectNPC("vendetta_drogacocheNPC","vendetta_drogacoche");
  	drogaNPCVeh= CreateVehicle(530, 0.0, 0.0, 5.0, 0.0, 0, 0, 5000);
	ConnectNPC("muelle_andaNPC","muelle_anda");
	ConnectNPC("muelle_fumaNPC","muelle_fuma");
	ConnectNPC("muelle_armado1NPC","muelle_armado1");
	ConnectNPC("muelle_armado2NPC","muelle_armado2");
	ConnectNPC("muelle_armado3NPC","muelle_armado3");
	ConnectNPC("muelle_armado4NPC","muelle_armado4");
	ConnectNPC("muelle_pizarraNPC","muelle_pizarra");
	ConnectNPC("lider_mecanicoNPC","lider_mecanico");
	ConnectNPC("mecanico1NPC","mecanico1");
	ConnectNPC("mecanico2NPC","mecanico2");
	ConnectNPC("entierro_unoNPC","entierro_uno");
	ConnectNPC("entierro_dosNPC","entierro_dos");
	ConnectNPC("entierro_tresNPC","entierro_tres");
	ConnectNPC("entierro_cuatroNPC","entierro_cuatro");
	ConnectNPC("entierro_cincoNPC","entierro_cinco");
	ConnectNPC("entierro_seisNPC","entierro_seis");
	ConnectNPC("entierro_sieteNPC","entierro_siete");
    ConnectNPC("entierro_mafiosoNPC","entierro_mafioso");
    ConnectNPC("entierro_mafioso1NPC","entierro_mafioso1");
    ConnectNPC("entierro_curaNPC","entierro_cura");
    ConnectNPC("entierro_protaNPC","entierro_prota");
    ConnectNPC("create_bandaNPC","create_banda");
    ConnectNPC("create_banda1NPC","create_banda1");
    ConnectNPC("create_bandabossNPC","create_bandaboss");
    ConnectNPC("bomberoNPC","bombero");
    ConnectNPC("bombero_bossNPC","bombero_boss");
    ConnectNPC("tirao1NPC","tirao1");
	ConnectNPC("banqueroNPC","banquero");
	ConnectNPC("banquero1NPC","banquero1");
	ConnectNPC("banquero2NPC","banquero2");
	ConnectNPC("poli_1NPC","poli_1");
	ConnectNPC("poli_2NPC","poli_2");
	ConnectNPC("poli_3NPC","poli_3");
	ConnectNPC("poli_4NPC","poli_4");
	ConnectNPC("poli_5NPC","poli_5");
	ConnectNPC("poli_6NPC","poli_6");
	ConnectNPC("policia_controlNPC","policia_control");
	ConnectNPC("policia_control1NPC","policia_control1");
	ConnectNPC("policia_control2NPC","policia_control2");
	ConnectNPC("policia_control3NPC","policia_control3");
	ConnectNPC("policia_control4NPC","policia_control4");
	ConnectNPC("policia_control5NPC","policia_control5");
	
	ConnectNPC("vendetta_drogaNPC","vendetta_droga");
	ConnectNPC("vendetta_droga1NPC","vendetta_droga1");
	ConnectNPC("vendetta_droga2NPC","vendetta_droga2");
	ConnectNPC("vendetta_droga3NPC","vendetta_droga3");
	ConnectNPC("vendetta_droga4NPC","vendetta_droga4");
	ConnectNPC("vendetta_droga5bossNPC","vendetta_droga5boss");
	ConnectNPC("vendetta_droga6NPC","vendetta_droga6");
	ConnectNPC("vendetta_droga7NPC","vendetta_droga7");
	ConnectNPC("vendetta_droga8NPC","vendetta_droga8");
	ConnectNPC("vendetta_droga9bossNPC","vendetta_droga9boss");
	ConnectNPC("vendetta_droga10NPC","vendetta_droga10");
	ConnectNPC("vendetta_droga11bossNPC","vendetta_droga11boss");
	ConnectNPC("vendetta_drogagirlNPC","vendetta_drogagirl");
	ConnectNPC("vendetta_drogagirl1NPC","vendetta_drogagirl1");
	
	ConnectNPC("vendetta_armasNPC","vendetta_armas");
	ConnectNPC("vendetta_armas1NPC","vendetta_armas1");
	ConnectNPC("vendetta_armas2NPC","vendetta_armas2");
	ConnectNPC("vendetta_armas3NPC","vendetta_armas3");

    SetTimer("Cuidar",200,true);//para el control
    SetTimer("infiltrado",500,true);//para la mison infliltrado.

	loadVeh();
  	loadBandas();
  	loadCochesBandas();
  	SetTimer("TimerBandas", 1000, 1);
  	timerMissionID = SetTimer("timerMission", 1000, 1);

    onPlayerEnterObjectT = SetTimer("onPlayerEnterObject",500,1);
 	onPlayerEnterMissionCheckpointT = SetTimer("onPlayerEnterMissionCheckpoint",500,1);
 	
 	TimerRecogidaItemInventarioID = SetTimer("TimerRecogidaItemInventario",200,1);
 	TimerTiempoVidaDropID = SetTimer("TimerTiempoVidaDrop", 200, 1);
// 	AnimarDropID = SetTimer("AnimarDrop", 1001,1);
  	
  	for (new i = 0; i < MAX_PLAYERS; i++){
  	    satisBar[i] = CreateProgressBar(500.0, 105.0, 100.0, 3.5, COLOR_YELLOW, 100.0);
  	}
  	
	SetTimer("OnFireUpdate", 500, 1);
	for(new i; i < MAX_PLAYERS; i++)
	{
	    ExtTimer[i] = -1;
	}
	
	timerEventoBomberoID = SetTimer("timerEventoBombero",1000,1);
   	
	SetGameModeText("Vendetta's Revengue");
	format(motd, sizeof(motd), "Bienvenido a la venganza de los Vendetta");
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	SetPDistance(1);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	// CreatedCars check
	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
	    CreatedCars[i] = 0;
	}
	// Player Class's
	for(new i = 0; i < sizeof(Peds); i++) {
		AddPlayerClass(Peds[i][0],-2000.0,-50.0,-36.33,0.0,-1,-1,-1,-1,-1,-1);
	}
//------------------------------------OBJETOS DEL GAMEMODE-------------------------------------------------
// Focos
   	luz1 = CreateObject(18656, -1484.80005, 2660.3999, 67.6, 240, 0.0, 45);
	luz2 = CreateObject(18656, -1455.20002, 2661.19995, 68.1, 230.999, 0.0, 300.999);
	luz3 = CreateObject(18656, -1456.19995, 2625, 67.9, 250.999, 0.0, 253.997); //295.999, 179.995, 253.997
//----------------------------MECANICOS Y GASOLINERAS
	CreateObject(7520, -1534.27002, 524.20001, 6.1, 0, 0, 270);
	CreateObject(14776, -1637.18005, 494.89001, -4.33, 0, 0, 268);
//------------------------BANKO---------------
    CreateObject(14847, 322.27, 119.84, 1005.61,   0.00, 0.00, 180.00);
	CreateObject(16760, 333.44, 123.50, 1011.29,   0.00, 0.00, 90.00);
	CreateObject(14852, 322.39, 108.75, 1007.69,   0.00, 0.00, 180.00);
//----------------------------------ENTRAS Y SALIDAS
    CreateObject(19197, -1600.1012,897.7770,9.2266, 0.0 ,0.0, 0.0);//Entrada banco
	CreateObject(19197, 322.5192,110.6958,1003.2194, 0.0 ,0.0, 0.0);//Salida banco
	CreateObject(19197, -1871.4950,942.1711,35.1719, 0.0 ,0.0, 0.0);//Entrada xoomer
	CreateObject(19197, -1859.1592,946.3453,36.2719, 0.0 ,0.0, 0.0);//Salida xoomer
	CreateObject(19197, -2020.7366,-257.7191,35.5577, 0.0 ,0.0, 0.0);//Entrada a los bomberos
	CreateObject(19197, -2014.0322,-228.4552,16.5776, 0.0 ,0.0, 0.0);//Salida de los bomberos
	
	CreateObject(19197, -1576.9860,685.8707,7.1875, 0.0 ,0.0, 0.0);//Policia Aparcamiento exterior
	CreateObject(19197, -1606.1873,672.8557,-5.2422, 0.0 ,0.0, 0.0);//Policia Aparcamiento subterraneo
	CreateObject(19197, -1605.4998,712.2133,13.8672, 0.0 ,0.0, 0.0);//Policia entrada principal fuera
	CreateObject(19197, 1551.4326,-1684.7999,1723.1050, 0.0 ,0.0, 0.0);//Policia entrada principal dentro
	CreateObject(19197, 1569.1306,-1685.0431,1723.1050, 0.0 ,0.0, 0.0);//Policia Salida a paraking exterior
	CreateObject(19197, 1564.1056,-1652.7848,1718.9019, 0.0 ,0.0, 0.0);//Policia Celdas
	
	CreateObject(19197, -2237.2307,2353.7515,4.9808, 0.0 ,0.0, 0.0);//Entrada a la oficina droga
	CreateObject(19197, -2184.4470,2715.6892,-58.9430, 0.0 ,0.0, 0.0);//Salida a la oficina droga
	CreateObject(19197, -2280.8262,2319.4668,4.9633, 0.0 ,0.0, 0.0);//Entrada al almacen droga
	CreateObject(19197, -2373.0454,2367.7961,-3.0160, 0.0 ,0.0, 0.0);//Salida del almacen droga
	CreateObject(19197, -2319.6567,2356.4233,4.9948, 0.0 ,0.0, 0.0);//Entrada a la casa droga
	CreateObject(19197, -2162.2017,2719.7742,-58.9922, 0.0 ,0.0, 0.0);//Salida de la casa de la droga
	
	CreateObject(19197, -1535.7219,503.7461,7.1797, 0.0 ,0.0, 0.0);//Entrada a los mecanicos
	CreateObject(19197, -1630.5013,491.8348,-9.8378, 0.0 ,0.0, 0.0);//salida de los mecanicos

	CreateObject(1559, -1542.9645,503.0986,7.1797, 0.0 ,0.0, 0.0);//Repostar gasolina
 	Create3DTextLabel("Repostar", 0xC2A2DAAA,-1542.9645,503.0986,7.1797, 30.0, 0, 0);

	CreateObject(1559, -2061.1614,-76.0913,35.3203, 0.0 ,0.0, 0.0);//Parada de Autobus
	Create3DTextLabel("Parada de Autobus", 0xC2A2DAAA, -2061.1614,-76.0913,35.3203, 30.0, 0, 0);
	CreateObject(1559, -1551.2161,531.6494,7.1797, 0.0 ,0.0, 0.0);//Parada de Autobus
	Create3DTextLabel("Parada de Autobus", 0xC2A2DAAA, -1551.2161,531.6494,7.1797, 30.0, 0, 0);
	CreateObject(1559, -1567.5522,643.7037,7.1875, 0.0 ,0.0, 0.0);//Parada de Autobus
	Create3DTextLabel("Parada de Autobus", 0xC2A2DAAA,-1567.5522,643.7037,7.1875, 30.0, 0, 0);

	CreateObject(1559, -2015.7301,-90.1018,35.3866, 0.0 ,0.0, 0.0);//Cabina de Telefonos
	Create3DTextLabel("Cabina de Telefonos", 0xC2A2DAAA, -2015.7301,-90.1018,35.3866, 30.0, 0, 0);
	CreateObject(1559, -1549.7607,523.1124,7.1764, 0.0 ,0.0, 0.0);//Cabina de Telefonos
	Create3DTextLabel("Cabina de Telefonos", 0xC2A2DAAA, -1549.7607,523.1124,7.1764, 30.0, 0, 0);
	CreateObject(1559, -1568.3171,671.6844,7.1875, 0.0 ,0.0, 0.0);//Cabina de Telefonos
	Create3DTextLabel("Cabina de Telefonos", 0xC2A2DAAA,-1568.3171,671.6844,7.1875, 30.0, 0, 0);

/*18688	fire: Meteorito
18689	fire_bike: Fuego Pequeño
18690	fire_car: Fuego del Coche
18691	fire_large: Fuego Grande
18692	fire_med : Fuego Pequeño con humo
18693	Flame99 : Llama pequeña que cabe en la palma de la mano.
18694	flamethrower: Llama que sale del Lanzallamas tambien parece como si hubiera un escape*/
//-----------------------Escenario fuego
	CreateObject(2992, 2365.8999, -1660.69995, 12.6, 0, 0, 0);
	CreateObject(1337, -2244.19995, 710.90002, 49.1, 0, 0, 264);
	CreateObject(1226, -2248.6001, 696, 52.2, 0, 0, 352);
	CreateObject(1226, -2248.3999, 711.40002, 52.2, 0, 0, 351.996);
	CreateObject(1226, -2248.39941, 711.39941, 52.2, 0, 0, 351.996);
	CreateObject(1226, -2274.19995, 689.70001, 52.3, 0, 0, 178);
	CreateObject(1226, -2273.6001, 717, 52.2, 0, 0, 171.998);
	CreateObject(1257, -2247, 706.5, 49.5, 0, 0, 0);
	CreateObject(1271, -2245.3999, 699.70001, 55.7, 358, 0, 0);
	CreateObject(1271, -2245.3999, 701.70001, 55.7, 357.995, 0, 0);
	CreateObject(1271, -2245.3999, 705.40002, 55.7, 357.995, 0, 0);
	CreateObject(1271, -2276.1001, 693.29999, 56, 0, 0, 0);
	CreateObject(1271, -2276.69995, 689.59998, 56, 0, 0, 0);
	CreateObject(1271, -2276.3999, 683.40002, 56, 0, 0, 0);
//------------------------GANGZONEDROGA
	CreateObject(14718, -2165, 2723.89941, -60, 0, 0, 359.747);
	CreateObject(14479, -2180.7998, 2725.2998, -58.3, 0, 0, 0);
	CreateObject(14794, -2380.42993, 2377.55005, -1.6, 0, 0, 0);
//------------------------ INTERIOR BOMBEROS --------------
	CreateObject(14577, -2067.6001, -226.3, 20.5, 0, 0, 0);
//------------------------ INTERIOR HOSPITAL ---------------
	CreateObject(16656, -2681.30005, 670.90002, -92.6, 0, 0, 0);
//-------------------------Suelo de enfrente de la autoescuela el que estaba bug
    CreateObject(11156, -2056.55, -91.42, 34.49,   0.00, 0.00, 0.00);
//-------------------------INTERIOR XOOMER-----------------------
    CreateObject(14593, -1865.80005, 959, 37.6, 0, 0, 0);
//-------------------------Casa mision bomberos incendiandose -----------------
	CreateObject(14708, 2094, 1299.69922, -41.9, 0, 0, 0);
    
//-------------------------Policia de San fierro
    //-------------------------------- puertas
	door1 = CreateObject(1495, 1558.970703125, -1677.9114990234, 1722.1081542969, 0, 0, 0); // PUERTA
    door2 = CreateObject(1495, 1561.9755859375, -1677.8798828125, 1722.1081542969, 0, 0, 179.99450683594); // PUERTA
    door3 = CreateObject(1495, 1550.4266357422, -1691.5009765625, 1722.1081542969, 0, 0, 0); //PUERTA
    door4 = CreateObject(1495, 1553.4294433594, -1691.4515380859, 1722.1081542969, 0, 0, 180); //PUERTA
    door5 = CreateObject(10252, 1560.1090087891, -1653.4477539063, 1719.5637207031, 0, 0, 270.25); //PUERTA
    CreateObject(14847, 1560.6787109375, -1684.51171875, 1725.4956054688, 0, 0, 90);//INTERIOR
	CreateObject(14848, 1563.0815429688, -1682.9155273438, 1723.4973144531, 0, 0, 90);//INTERIOR
	CreateObject(14852, 1549.5620117188, -1684.634765625, 1727.5771484375, 0, 0, 90);//INTERIOR
	CreateObject(14892, 1571.1171875, -1688.1083984375, 1728.3790283203, 0, 0, 90);//INTERIOR
	CreateObject(14851, 1561.0231933594, -1684.5346679688, 1726.2297363281, 0, 0, 90);//INTERIOR
	Puerta =  CreateObject(1495, -1618.698608, 680.912170, 6.199722, 0.0000, 0.0000, 0.0000);
	Puerta1 =  CreateObject(976, -1572.792236, 667.409363, 6.354377, 0.0000, 0.0000, 270.0000);
	Puerta2 =  CreateObject(976, -1640.531738, 688.593018, 6.428231, 0.0000, 0.0000, 0.0000);
	Puerta3 =  CreateObject(976, -1623.031006, 688.687927, 6.410405, 0.0000, 0.0000, 180.0000);
//------------------------------------COCHES DEL GAMEMODE---------------------------------------------------
//------------------------------Bomberos ----------------------------

	CochesBomberos[0] = AddStaticVehicle(599, -2088.3184,-246.5362,35.3203,86.0203, 3, 0);
	CochesBomberos[1] = AddStaticVehicle(599, -2088.3792,-240.9344,35.3203,88.8403, 3, 0);
	CochesBomberos[2] = AddStaticVehicle(599, -2088.6650,-236.5305,35.3203,88.8403, 3, 0);
	CochesBomberos[3] = AddStaticVehicle(599, -2088.5488,-230.9215,35.3203,88.8403, 3, 0);
	CochesBomberos[4] = AddStaticVehicle(599, -2088.8057,-225.1161,35.3203,88.8403, 3, 0);
	CochesBomberos[5] = AddStaticVehicle(417, -2075.0657,-265.8472,37.6281,226.9982, 3, 0); //helicoptero
	CochesBomberos[6] = AddStaticVehicle(407,-2017.2769,-243.2078,35.7144,178.2439,3,0); // camion
	//-------------------------Sirena
	new sirena = CreateObject(18646, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirena, CochesBomberos[6], 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros arriba
	new foco = CreateObject(19280, 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco, CochesBomberos[6], 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	new foco1 = CreateObject(19280, -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco1, CochesBomberos[6], -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	//------------------------Focos Traseros arriba
	new foco3 = CreateObject(19280, 0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco3, CochesBomberos[6], 0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	new foco4 = CreateObject(19280, -0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco4, CochesBomberos[6], -0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	//------------------------Focos delanteros al medio
	new foco5 = CreateObject(19280, 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco5, CochesBomberos[6], 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	new foco6 = CreateObject(19280, -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco6, CochesBomberos[6], -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros al medio bajos
	new foco7 = CreateObject(19280, 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco7, CochesBomberos[6], 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	new foco8 = CreateObject(19280, -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco8, CochesBomberos[6], -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	
	CochesBomberos[7] = AddStaticVehicle(407,-2058.7095,-228.5928,35.5570,359.6455,3,0); // camion
	//-------------------------Sirena
	new sirenabis = CreateObject(18646, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenabis, CochesBomberos[7], 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros arriba
	new focobis = CreateObject(19280, 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(focobis, CochesBomberos[7], 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	new foco1bis = CreateObject(19280, -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco1bis, CochesBomberos[7], -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	//------------------------Focos Traseros arriba
	new foco3bis = CreateObject(19280, 0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco3bis, CochesBomberos[7], 0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	new foco4bis = CreateObject(19280, -0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco4bis, CochesBomberos[7], -0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	//------------------------Focos delanteros al medio
	new foco5bis = CreateObject(19280, 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco5bis, CochesBomberos[7], 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	new foco6bis = CreateObject(19280, -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco6bis, CochesBomberos[7], -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros al medio bajos
	new foco7bis = CreateObject(19280, 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco7bis, CochesBomberos[7], 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	new foco8bis = CreateObject(19280, -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco8bis, CochesBomberos[7], -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	
	CochesBomberos[8] = AddStaticVehicle(407,-2052.5063,-225.5900,35.5561,180.3379,3,0); // camion
	//-------------------------Sirena
	new sirenabis1 = CreateObject(18646, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenabis1, CochesBomberos[8], 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros arriba
	new focobis1 = CreateObject(19280, 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(focobis1, CochesBomberos[8], 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	new foco1bis1 = CreateObject(19280, -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco1bis1, CochesBomberos[8], -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	//------------------------Focos Traseros arriba
	new foco3bis1 = CreateObject(19280, 0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco3bis1, CochesBomberos[8], 0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	new foco4bis1 = CreateObject(19280, -0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco4bis1, CochesBomberos[8], -0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	//------------------------Focos delanteros al medio
	new foco5bis1 = CreateObject(19280, 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco5bis1, CochesBomberos[8], 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	new foco6bis1 = CreateObject(19280, -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco6bis1, CochesBomberos[8], -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros al medio bajos
	new foco7bis1 = CreateObject(19280, 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco7bis1, CochesBomberos[8], 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	new foco8bis1 = CreateObject(19280, -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco8bis1, CochesBomberos[8], -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	
	CochesBomberos[9] = AddStaticVehicle(407,-2026.9554,-205.8903,35.5552,359.9466,3,0); // camion
	//-------------------------Sirena
	new sirenabis12 = CreateObject(18646, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenabis12, CochesBomberos[9], 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros arriba
	new focobis12 = CreateObject(19280, 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(focobis12, CochesBomberos[9], 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	new foco1bis12 = CreateObject(19280, -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco1bis12, CochesBomberos[9], -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	//------------------------Focos Traseros arriba
	new foco3bis12 = CreateObject(19280, 0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco3bis12, CochesBomberos[9], 0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	new foco4bis12 = CreateObject(19280, -0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco4bis12, CochesBomberos[9], -0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	//------------------------Focos delanteros al medio
	new foco5bis12 = CreateObject(19280, 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco5bis12, CochesBomberos[9], 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	new foco6bis12 = CreateObject(19280, -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco6bis12, CochesBomberos[9], -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros al medio bajos
	new foco7bis12 = CreateObject(19280, 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco7bis12, CochesBomberos[9], 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	new foco8bis12 = CreateObject(19280, -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco8bis12, CochesBomberos[9], -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	
	CochesBomberos[10] = AddStaticVehicle(407,-2018.8748,-203.3829,35.5611,1.4596,3,0); // camion
	//-------------------------Sirena
	new sirenabis123 = CreateObject(18646, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenabis123, CochesBomberos[10], 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros arriba
	new focobis123 = CreateObject(19280, 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(focobis123, CochesBomberos[10], 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	new foco1bis123 = CreateObject(19280, -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco1bis123, CochesBomberos[10], -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	//------------------------Focos Traseros arriba
	new foco3bis123 = CreateObject(19280, 0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco3bis123, CochesBomberos[10], 0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	new foco4bis123 = CreateObject(19280, -0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco4bis123, CochesBomberos[10], -0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	//------------------------Focos delanteros al medio
	new foco5bis123 = CreateObject(19280, 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco5bis123, CochesBomberos[10], 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	new foco6bis123 = CreateObject(19280, -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco6bis123, CochesBomberos[10], -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros al medio bajos
	new foco7bis123 = CreateObject(19280, 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco7bis123, CochesBomberos[10], 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	new foco8bis123 = CreateObject(19280, -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco8bis123, CochesBomberos[10], -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	
	CochesBomberos[11] = AddStaticVehicle(407,-2070.6433,-202.3857,35.5487,358.3443,3,0); // camion
		//-------------------------Sirena
	new sirenabis1234 = CreateObject(18646, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenabis1234, CochesBomberos[11], 0.0, 0.0, 1.05, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros arriba
	new focobis1234 = CreateObject(19280, 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(focobis1234, CochesBomberos[11], 0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	new foco1bis1234 = CreateObject(19280, -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco1bis1234, CochesBomberos[11], -0.8, 3.5, 1.35, 0.0, 0.0, 0.0);
	//------------------------Focos Traseros arriba
	new foco3bis1234 = CreateObject(19280, 0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco3bis1234, CochesBomberos[11], 0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	new foco4bis1234 = CreateObject(19280, -0.8, -3.2, 1.35, 0.0, 0.0, 180.0);
	AttachObjectToVehicle(foco4bis1234, CochesBomberos[11], -0.8, -3.2, 1.25, 0.0, 0.0, 180.0);
	//------------------------Focos delanteros al medio
	new foco5bis1234 = CreateObject(19280, 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco5bis1234, CochesBomberos[11], 0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	new foco6bis1234 = CreateObject(19280, -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco6bis1234, CochesBomberos[11], -0.8, 4.2, 0.0, 0.0, 0.0, 0.0);
	//------------------------Focos delanteros al medio bajos
	new foco7bis1234 = CreateObject(19280, 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco7bis1234, CochesBomberos[11], 0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	new foco8bis1234 = CreateObject(19280, -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(foco8bis1234, CochesBomberos[11], -0.8, 4.5, -0.60, 0.0, 0.0, 0.0);
	//si añadimos, cambiar NUM_COCHES_BOMBEROS
//--------------------------TUTORIAL
	AddStaticVehicle(445,-2030.1656,-56.2843,35.3415,232.7235,0,0);
	AddStaticVehicle(445,-2020.5018,-49.7068,35.3426,7.1215,0,0);
//------------------------------Cementerio--------------------------
    AddStaticVehicle(477,-1591.9269,-1520.2963,38.0859,250.9486,0,0);
	AddStaticVehicle(442,-1559.0500,-1564.9220,37.6692,167.6010,0,0);
	AddStaticVehicle(507,-1559.3815,-1586.6814,38.0859,57.3067,0,0);
	AddStaticVehicle(507,-1564.8918,-1592.0754,38.0859,26.5997,0,0);
	AddStaticVehicle(507,-1571.1781,-1593.4614,38.0859,21.5863,0,0);
//------------------------------------Coches de los Mecanicos para vender a las bandas------------------

	AddStaticVehicle(507,-2111.4966,-201.9016,35.3203,271.9284,3,0); // coche1
	AddStaticVehicle(492,-2105.3345,-242.4220,35.3203,204.5611,1,0); // coche2
	AddStaticVehicle(529,-2111.8958,-243.5007,35.3203,171.6608,0,0); // coche3
	AddStaticVehicle(536,-2120.4163,-243.7406,35.3203,170.0941,21,0); // coche4
	AddStaticVehicle(551,-2129.4517,-228.0494,35.3203,178.2172,65,0); // coche14
//------------------------------------Coches de Policias----------------------------------------------------
	CochesPolicia [0] = AddStaticVehicle(427,-1623.4177,654.8157,-5.4957,359.1355,0,1); // Furgoneta Policia
	CochesPolicia [1] =AddStaticVehicle(490,-1637.8772,657.6839,-5.4976,89.0660,0,0); // FBI Ranchera
	CochesPolicia [2] =AddStaticVehicle(490,-1638.2383,661.8864,-5.4945,90.3994,0,0); // FBI Ranchera
	CochesPolicia [3] = AddStaticVehicle(490,-1639.0183,666.1380,-5.4982,88.8787,0,0); // FBI Ranchera
	CochesPolicia [4] = AddStaticVehicle(528,-1638.7058,678.0543,-5.4941,91.1925,0,0); // FBI Auto
	CochesPolicia [5] = AddStaticVehicle(528,-1638.6053,682.2739,-5.4941,90.7887,0,0); // FBI Auto
	CochesPolicia [6] = AddStaticVehicle(528,-1638.9282,686.2639,-5.4966,89.1310,0,0); // FBI Auto
	CochesPolicia [7] = AddStaticVehicle(601,-1632.6870,692.7595,-5.4941,176.7220,0,1); // Hydra
	CochesPolicia [8] = AddStaticVehicle(601,-1628.6552,692.3799,-5.4948,177.2496,0,1); // Hydra
	CochesPolicia [9] = AddStaticVehicle(599,-1599.7748,676.6509,-5.4947,0.7218,0,1); // Coche Normal
	CochesPolicia [10] = AddStaticVehicle(599,-1612.6637,692.6605,-5.4953,1.2418,0,1); // Coche Normal
	CochesPolicia [11] = AddStaticVehicle(596,-1604.5637,691.8191,-5.5018,0.3056,0,1); // Coche Normal
	CochesPolicia [12] = AddStaticVehicle(596,-1573.9034,709.8478,-5.4953,270.8439,0,1); // Coche Normal
	CochesPolicia [13] = AddStaticVehicle(597,-1574.3136,718.6707,-5.4992,270.1696,0,1); // Coche Normal
	CochesPolicia [14] = AddStaticVehicle(597,-1573.9756,726.6252,-5.4986,269.0248,0,1); // Coche Normal
	CochesPolicia [15] = AddStaticVehicle(598,-1573.4784,734.6503,-5.4990,269.1850,0,1); // Coche Normal
	CochesPolicia [16] = AddStaticVehicle(598,-1573.8279,742.9561,-5.4968,270.9276,0,1); // Coche Normal
	CochesPolicia [17] = AddStaticVehicle(523,-1589.0138,710.4902,-5.4953,94.4531,0,1); // Moto de Policia
	CochesPolicia [18] = AddStaticVehicle(523,-1589.0822,706.9816,-5.4909,94.2651,0,1); // Moto de Policia
	CochesPolicia [19] = AddStaticVehicle(523,-1612.4291,676.9690,-5.1642,177.7474,0,1); // Moto de Policia
	CochesPolicia [20] = AddStaticVehicle(523,-1611.3381,672.8439,6.9345,0.1316,0,1); // Moto de Policia
	CochesPolicia [21] = AddStaticVehicle(523,-1608.4130,673.6833,6.9338,356.5217,0,1); // Moto de Policia
	CochesPolicia [22] = AddStaticVehicle(598,-1599.6090,651.6207,6.9343,180.9091,0,1); // Coche Normal
	CochesPolicia [23] = AddStaticVehicle(598,-1594.5923,651.5497,6.9316,183.7946,0,1); // Coche Normal
	CochesPolicia [24] = AddStaticVehicle(497,-1632.0781,654.2662,6.9336,294.4157,0,1); // Helicoptero
	
	//CONCHES DE POLICIA EN EL CONTROL
	CochesPolicia [25] = AddStaticVehicle(598,-2694.2251,1259.7609,55.4297,198.1512,0,1); // Coche Normal
	//sirena
	new sirenapoli1 = CreateObject(18646, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenapoli1, CochesPolicia [25], 0.0, 0.0, 0.5, 0.0, 0.0, 0.0);
	CochesPolicia [26] = AddStaticVehicle(598,-2668.6895,1291.2058,55.4297,3.9054,0,1); // Coche Normal
	//sirena
	new sirenapoli2 = CreateObject(18646, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenapoli2, CochesPolicia [26], 0.0, 0.0, 0.5, 0.0, 0.0, 0.0);
	CochesPolicia [27] = AddStaticVehicle(598,-2680.0242,1242.3098,55.6849,5.4723,0,1); // Coche Normal
	//sirena
	new sirenapoli3 = CreateObject(18646, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(sirenapoli3, CochesPolicia [27], 0.0, 0.0, 0.5, 0.0, 0.0, 0.0);

// ------------------------- Pinchos control policial -----------------------------
	CreateStrip(-2668.63965, 1283.84961, 54.43,272);
	CreateStrip(-2694.70996, 1265.73926, 54.43, 272);
	CreateObject(2892, -2668.63965, 1283.84961, 54.43, 0, 0, 272);
	CreateObject(2892, -2694.70996, 1265.73926, 54.43, 0, 0, 272);
	
// ------------------------- coches trabajo eleccion xoomer
	AddStaticVehicle(408,-1548.8604,1200.5436,7.7384,268.0421,0,0);
	AddStaticVehicle(408,-1549.1573,1196.5126,7.7322,271.6244,0,0);
 	m2CocheLimpiezaID = AddStaticVehicle(574,-1545.5125,1207.7062,7.1875,270.3373,0,0);
	//AddStaticVehicle(574,-1545.8099,1210.4993,7.1875,270.3373,0,0);
	//AddStaticVehicle(574,-1545.6102,1219.1438,7.1875,272.5304,0,0);
	//AddStaticVehicle(574,-2428.7354,-52.3524,35.3125,1.0385,0,0);
//---------------------------------------MISION DE LA DROGA
	m3BarcoID = AddStaticVehicle(472,-2225.6448,2400.1958,-0.6269,227.2910,0,0);
	m3TorilloID = AddStaticVehicle(530,-2254.8557,2389.1313,4.9565,221.1686,0,0); // torillo
	m3CamionID = AddStaticVehicle(456,-2270.9944,2393.1387,4.9491,132.4946,0,1);
	
	AddStaticVehicle(472, -2248.7480,2425.0059,0.1342,50.4909, 0, 0);//barco
	AddStaticVehicle(472, -2232.1611,2393.8213,-0.0327,221.7649, 0, 0);//barco
	
	m7CamionID = AddStaticVehicle(498, -2253.1636,2338.3735,4.8125,269.8956, 0, 1);//camion normal
	AddStaticVehicle(498, -2252.7561,2332.6553,4.8125,268.1063, 0, 1);//camion normal
	AddStaticVehicle(498, -2253.1829,2327.1724,4.8125,269.6494, 0, 1);//camion normal
	
	AddStaticVehicle(456, -2274.2139,2398.7327,4.9381,133.0023, 0, 1);//camion normal
	AddStaticVehicle(530, -2260.0955,2307.3550,4.8125,183.1597, 0, 0);//torillo
	AddStaticVehicle(530, -2256.0513,2306.7034,4.8125,186.6064, 0, 0);//torillo
	/*AddStaticVehicle(539, -2269.4092,2280.6011,4.9818,1.3305, 0, 0);//aerodelizador
	AddStaticVehicle(539, -2265.8057,2281.1152,4.9759,1.3305, 0, 0);//aerodelizador
	AddStaticVehicle(539, -2261.8999,2281.1387,4.9758,1.3305, 0, 0);//aerodelizador
	AddStaticVehicle(539, -2259.0562,2281.1443,4.9758,1.3305, 0, 0);//aerodelizador*/
	//AddStaticVehicle(578, -2252.3940,2327.2563,4.8125,5.8114, 0, 0);//trailer
	AddStaticVehicle(487, -2228.2959,2326.3801,7.5469,301.8908, 0, 0);//helicoptero
//--------------------------------------MISION DE LAS ARMAS

    m4CamionID = AddStaticVehicle(456,-2498.8528,775.5662,34.7439,95.3636,0,1); // camion
//--------------------------------------Coches del Hospital----------------------------------------------------

    AddStaticVehicle(416,-2630.1008,609.2003,14.1992,179.3923,3,1);
	AddStaticVehicle(416,-2634.6465,609.7317,14.1990,179.0011,3,1);
	AddStaticVehicle(416,-2640.6897,609.8565,14.2009,180.9553,3,1);
	AddStaticVehicle(416,-2678.0291,611.5274,14.1980,179.1153,3,1);
	AddStaticVehicle(416,-2684.9795,609.2565,14.1979,179.3851,3,1);
	AddStaticVehicle(416,-2685.2007,628.1043,14.2014,113.6259,3,1);
	AddStaticVehicle(598,-2699.7170,615.3413,14.1993,156.2309,0,1);
	AddStaticVehicle(563,-2645.0066,603.8007,68.9808,281.3847,3,1);//Helicoptero
	AddStaticVehicle(563,-2643.9124,636.6965,68.9808,102.4697,3,1);//Helicoptero
	
	
//------------------------------ MISION COCHES ---------------------------------------------------
	//Coordenadas de los coches de la mision
	CoordMision[0][mX] = -2449.830078;CoordMision[0][mY] = -165.960006;CoordMision[0][mZ] = 35.299999;CoordMision[0][mAngle] = 93.989997;
	CoordMision[1][mX] = -1336.180053;CoordMision[1][mY] = 319.410003;CoordMision[1][mZ] = 7.179999;CoordMision[1][mAngle] = 292.119995;
	CoordMision[2][mX] = -2459.540039;CoordMision[2][mY] = -18.340000;CoordMision[2][mZ] = 32.799999;CoordMision[2][mAngle] = 94.400001;
	CoordMision[3][mX] = -2463.989990;CoordMision[3][mY] = -95.160003;CoordMision[3][mZ] = 25.850000;CoordMision[3][mAngle] = 268.589996;
	CoordMision[4][mX] = -1619.140014;CoordMision[4][mY] = 584.190002;CoordMision[4][mZ] = 29.709999;CoordMision[4][mAngle] = 34.279998;
	CoordMision[5][mX] = -2447.239990;CoordMision[5][mY] = -123.169998;CoordMision[5][mZ] = 26.129999;CoordMision[5][mAngle] = 89.910003;
	CoordMision[6][mX] = -1440.420043;CoordMision[6][mY] = 968.539978;CoordMision[6][mZ] = 7.179999;CoordMision[6][mAngle] = 356.600006;
	CoordMision[7][mX] = -2617.379882;CoordMision[7][mY] = -143.949996;CoordMision[7][mZ] = 4.329999;CoordMision[7][mAngle] = 271.200012;
	CoordMision[8][mX] = -1672.880004;CoordMision[8][mY] = 1208.510009;CoordMision[8][mZ] = 32.930000;CoordMision[8][mAngle] = 283.079986;
	CoordMision[9][mX] = -2646.290039;CoordMision[9][mY] = -290.359985;CoordMision[9][mZ] = 7.519999;CoordMision[9][mAngle] = 316.820007;
	CoordMision[10][mX] = -1705.119995;CoordMision[10][mY] = 1220.229980;CoordMision[10][mZ] = 30.069999;CoordMision[10][mAngle] = 4.840000;
	CoordMision[11][mX] = -2796.060058;CoordMision[11][mY] = -158.020004;CoordMision[11][mZ] = 7.179999;CoordMision[11][mAngle] = 90.889999;
	CoordMision[12][mX] = -1976.050048;CoordMision[12][mY] = 1226.099975;CoordMision[12][mZ] = 31.639999;CoordMision[12][mAngle] = 88.839996;
	CoordMision[13][mX] = -2756.439941;CoordMision[13][mY] = 76.139999;CoordMision[13][mZ] = 7.179999;CoordMision[13][mAngle] = 270.709991;
	CoordMision[14][mX] = -1807.439941;CoordMision[14][mY] = 1303.680053;CoordMision[14][mZ] = 59.729999;CoordMision[14][mAngle] = 157.399993;
	CoordMision[15][mX] = -2791.149902;CoordMision[15][mY] = 241.100006;CoordMision[15][mZ] = 7.179999;CoordMision[15][mAngle] = 178.160003;
	CoordMision[16][mX] = -2177.000000;CoordMision[16][mY] = 1225.900024;CoordMision[16][mZ] = 33.919998;CoordMision[16][mAngle] = 276.299987;
	CoordMision[17][mX] = -2177.000000;CoordMision[17][mY] = 1225.900024;CoordMision[17][mZ] = 33.919998;CoordMision[17][mAngle] = 276.299987;
	CoordMision[18][mX] = -2107.810058;CoordMision[18][mY] = 977.239990;CoordMision[18][mZ] = 71.510002;CoordMision[18][mAngle] = 358.250000;
	CoordMision[19][mX] = -2853.629882;CoordMision[19][mY] = 870.780029;CoordMision[19][mZ] = 43.909999;CoordMision[19][mAngle] = 270.600006;
	CoordMision[20][mX] = -2703.419921;CoordMision[20][mY] = 1461.050048;CoordMision[20][mZ] = 7.119999;CoordMision[20][mAngle] = 98.790000;
	CoordMision[21][mX] = -2324.639892;CoordMision[21][mY] = 1031.609985;CoordMision[21][mZ] = 50.689998;CoordMision[21][mAngle] = 98.580001;
	CoordMision[22][mX] = -2917.310058;CoordMision[22][mY] = 1170.270019;CoordMision[22][mZ] = 13.529999;CoordMision[22][mAngle] = 186.289993;
	CoordMision[23][mX] = -2945.979980;CoordMision[23][mY] = 1098.900024;CoordMision[23][mZ] = 6.190000;CoordMision[23][mAngle] = 124.059997;
	CoordMision[24][mX] = -2986.649902;CoordMision[24][mY] = 466.269989;CoordMision[24][mZ] = 4.909999;CoordMision[24][mAngle] = 68.309997;
	CoordMision[25][mX] = -2189.459960;CoordMision[25][mY] = 1033.849975;CoordMision[25][mZ] = 80.000000;CoordMision[25][mAngle] = 186.720001;
	CoordMision[26][mX] = -1983.880004;CoordMision[26][mY] = 1227.979980;CoordMision[26][mZ] = 31.639999;CoordMision[26][mAngle] = 270.579986;
	CoordMision[27][mX] = -2032.859985;CoordMision[27][mY] = 1227.989990;CoordMision[27][mZ] = 31.639999;CoordMision[27][mAngle] = 91.360000;
	CoordMision[28][mX] = -1768.790039;CoordMision[28][mY] = 1206.390014;CoordMision[28][mZ] = 25.120000;CoordMision[28][mAngle] = 176.309997;
	CoordMision[29][mX] = -2785.510009;CoordMision[29][mY] = -243.899993;CoordMision[29][mZ] = 7.179999;CoordMision[29][mAngle] = 350.549987;
	CoordMision[30][mX] = -2793.399902;CoordMision[30][mY] = -374.130004;CoordMision[30][mZ] = 7.030000;CoordMision[30][mAngle] = 46.950000;
	CoordMision[31][mX] = -1674.579956;CoordMision[31][mY] = 439.170013;CoordMision[31][mZ] = 7.170000;CoordMision[31][mAngle] = 314.399993;
	CoordMision[32][mX] = -2518.899902;CoordMision[32][mY] = -704.140014;CoordMision[32][mZ] = 139.320007;CoordMision[32][mAngle] = 178.860000;
	CoordMision[33][mX] = -1886.599975;CoordMision[33][mY] = -934.010009;CoordMision[33][mZ] = 32.020000;CoordMision[33][mAngle] = 86.900001;
	CoordMision[34][mX] = -2135.830078;CoordMision[34][mY] = -769.349975;CoordMision[34][mZ] = 32.020000;CoordMision[34][mAngle] = 269.369995;
	CoordMision[35][mX] = -2044.270019;CoordMision[35][mY] = -1061.410034;CoordMision[35][mZ] = 32.090000;CoordMision[35][mAngle] = 268.399993;
	CoordMision[36][mX] = -2111.360107;CoordMision[36][mY] = -396.799987;CoordMision[36][mZ] = 35.529998;CoordMision[36][mAngle] = 308.899993;
	CoordMision[37][mX] = -1373.119995;CoordMision[37][mY] = -524.940002;CoordMision[37][mZ] = 14.170000;CoordMision[37][mAngle] = 300.299987;
	CoordMision[38][mX] = -1675.890014;CoordMision[38][mY] = -631.809997;CoordMision[38][mZ] = 14.140000;CoordMision[38][mAngle] = 337.299987;
	CoordMision[39][mX] = -2128.979980;CoordMision[39][mY] = 227.979995;CoordMision[39][mZ] = 35.459999;CoordMision[39][mAngle] = 171.889999;
	CoordMision[40][mX] = -2450.439941;CoordMision[40][mY] = 971.349975;CoordMision[40][mZ] = 45.290000;CoordMision[40][mAngle] = 177.800003;
	CoordMision[41][mX] = -2409.979980;CoordMision[41][mY] = 1138.560058;CoordMision[41][mZ] = 55.720001;CoordMision[41][mAngle] = 348.510009;
	CoordMision[42][mX] = -1978.420043;CoordMision[42][mY] = 436.779998;CoordMision[42][mZ] = 26.299999;CoordMision[42][mAngle] = 0.740000;
	CoordMision[43][mX] = -2568.340087;CoordMision[43][mY] = 1219.219970;CoordMision[43][mZ] = 41.209999;CoordMision[43][mAngle] = 280.130004;
	CoordMision[44][mX] = -1703.060058;CoordMision[44][mY] = 1028.199951;CoordMision[44][mZ] = 17.579999;CoordMision[44][mAngle] = 269.850006;
	CoordMision[45][mX] = -1705.089965;CoordMision[45][mY] = 1056.979980;CoordMision[45][mZ] = 17.579999;CoordMision[45][mAngle] = 358.519989;
	CoordMision[46][mX] = -1736.150024;CoordMision[46][mY] = 1019.900024;CoordMision[46][mZ] = 17.579999;CoordMision[46][mAngle] = 90.309997;
	CoordMision[47][mX] = -2833.209960;CoordMision[47][mY] = 1108.430053;CoordMision[47][mZ] = 29.409999;CoordMision[47][mAngle] = 160.169998;
	CoordMision[48][mX] = -2157.520019;CoordMision[48][mY] = 1228.229980;CoordMision[48][mZ] = 33.919998;CoordMision[48][mAngle] = 272.079986;
	CoordMision[49][mX] = -2412.969970;CoordMision[49][mY] = 1273.900024;CoordMision[49][mZ] = 25.690000;CoordMision[49][mAngle] = 357.799987; /*fail*/
	CoordMision[50][mX] = -2412.969970;CoordMision[50][mY] = 1273.900024;CoordMision[50][mZ] = 25.690000;CoordMision[50][mAngle] = 357.799987; /*fail*/
	CoordMision[51][mX] = -2091.889892;CoordMision[51][mY] = 1077.310058;CoordMision[51][mZ] = 66.510002;CoordMision[51][mAngle] = 252.729995;
	CoordMision[52][mX] = -1842.810058;CoordMision[52][mY] = 1044.329956;CoordMision[52][mZ] = 46.080001;CoordMision[52][mAngle] = 252.089996;
	CoordMision[53][mX] = -1473.760009;CoordMision[53][mY] = 345.459991;CoordMision[53][mZ] = 7.179999;CoordMision[53][mAngle] = 5.019999;
	CoordMision[54][mX] = -1702.849975;CoordMision[54][mY] = 1016.580017;CoordMision[54][mZ] = 17.579999;CoordMision[54][mAngle] = 86.519996;
	CoordMision[55][mX] = -1804.069946;CoordMision[55][mY] = 536.159973;CoordMision[55][mZ] = 35.159999;CoordMision[55][mAngle] = 92.819999;
	CoordMision[56][mX] = -1978.540039;CoordMision[56][mY] = 442.040008;CoordMision[56][mZ] = 27.020000;CoordMision[56][mAngle] = 183.729995;
	CoordMision[57][mX] = -1971.209960;CoordMision[57][mY] = 171.050003;CoordMision[57][mZ] = 27.489999;CoordMision[57][mAngle] = 270.239990;
	CoordMision[58][mX] = -1989.979980;CoordMision[58][mY] = 187.110000;CoordMision[58][mZ] = 27.350000;CoordMision[58][mAngle] = 87.400001;
	CoordMision[59][mX] = -1951.979980;CoordMision[59][mY] = 258.829986;CoordMision[59][mZ] = 40.849998;CoordMision[59][mAngle] = 35.240001;
	CoordMision[60][mX] = -1747.329956;CoordMision[60][mY] = 532.969970;CoordMision[60][mZ] = 38.419998;CoordMision[60][mAngle] = 318.309997;
	CoordMision[61][mX] = -1786.089965;CoordMision[61][mY] = 778.799987;CoordMision[61][mZ] = 24.690000;CoordMision[61][mAngle] = 0.079999;
	CoordMision[62][mX] = -1740.640014;CoordMision[62][mY] = 955.489990;CoordMision[62][mZ] = 24.610000;CoordMision[62][mAngle] = 258.660003;
	CoordMision[63][mX] = -1731.449951;CoordMision[63][mY] = 1026.500000;CoordMision[63][mZ] = 44.860000;CoordMision[63][mAngle] = 180.919998;
	CoordMision[64][mX] = -1681.079956;CoordMision[64][mY] = 1047.520019;CoordMision[64][mZ] = 54.409999;CoordMision[64][mAngle] = 358.730010;
	CoordMision[65][mX] = -1830.410034;CoordMision[65][mY] = 668.250000;CoordMision[65][mZ] = 30.129999;CoordMision[65][mAngle] = 359.920013;
	CoordMision[66][mX] = -2102.310058;CoordMision[66][mY] = 650.059997;CoordMision[66][mZ] = 52.069999;CoordMision[66][mAngle] = 269.549987;
	CoordMision[67][mX] = -1956.349975;CoordMision[67][mY] = 768.419982;CoordMision[67][mZ] = 55.430000;CoordMision[67][mAngle] = 359.790008;
	CoordMision[68][mX] = -2072.459960;CoordMision[68][mY] = 1001.140014;CoordMision[68][mZ] = 62.619998;CoordMision[68][mAngle] = 271.399993;
	CoordMision[69][mX] = -2568.090087;CoordMision[69][mY] = 1147.300048;CoordMision[69][mZ] = 55.430000;CoordMision[69][mAngle] = 158.190002;
	CoordMision[70][mX] = -2541.989990;CoordMision[70][mY] = 1141.439941;CoordMision[70][mZ] = 55.430000;CoordMision[70][mAngle] = 171.669998;
	CoordMision[71][mX] = -2510.209960;CoordMision[71][mY] = 1139.329956;CoordMision[71][mZ] = 55.430000;CoordMision[71][mAngle] = 179.050003;
	CoordMision[72][mX] = -2485.639892;CoordMision[72][mY] = 1138.579956;CoordMision[72][mZ] = 55.430000;CoordMision[72][mAngle] = 181.380004;
	CoordMision[73][mX] = -2444.620117;CoordMision[73][mY] = 1138.060058;CoordMision[73][mZ] = 55.430000;CoordMision[73][mAngle] = 175.759994;
	CoordMision[74][mX] = -2390.850097;CoordMision[74][mY] = 1127.420043;CoordMision[74][mZ] = 55.430000;CoordMision[74][mAngle] = 164.009994;
	CoordMision[75][mX] = -2426.840087;CoordMision[75][mY] = 1001.039978;CoordMision[75][mZ] = 50.090000;CoordMision[75][mAngle] = 271.549987;
	CoordMision[76][mX] = -2460.260009;CoordMision[76][mY] = 779.000000;CoordMision[76][mZ] = 34.869998;CoordMision[76][mAngle] = 94.230003;
	CoordMision[77][mX] = -2461.560058;CoordMision[77][mY] = 786.659973;CoordMision[77][mZ] = 34.869998;CoordMision[77][mAngle] = 93.790000;
	CoordMision[78][mX] = -2461.199951;CoordMision[78][mY] = 793.880004;CoordMision[78][mZ] = 34.880001;CoordMision[78][mAngle] = 88.470001;
	CoordMision[79][mX] = -2509.250000;CoordMision[79][mY] = 760.530029;CoordMision[79][mZ] = 34.869998;CoordMision[79][mAngle] = 92.000000;
	CoordMision[80][mX] = -2510.879882;CoordMision[80][mY] = 776.890014;CoordMision[80][mZ] = 34.869998;CoordMision[80][mAngle] = 269.429992;
	CoordMision[81][mX] = -2477.679931;CoordMision[81][mY] = 742.140014;CoordMision[81][mZ] = 34.720001;CoordMision[81][mAngle] = 180.270004;
	CoordMision[82][mX] = -2455.540039;CoordMision[82][mY] = 741.419982;CoordMision[82][mZ] = 34.720001;CoordMision[82][mAngle] = 0.109999;
	CoordMision[83][mX] = -2589.110107;CoordMision[83][mY] = 657.719970;CoordMision[83][mZ] = 14.149999;CoordMision[83][mAngle] = 270.869995;
	CoordMision[84][mX] = -2573.000000;CoordMision[84][mY] = 647.659973;CoordMision[84][mZ] = 14.159999;CoordMision[84][mAngle] = 267.519989;
	CoordMision[85][mX] = -2546.870117;CoordMision[85][mY] = 632.190002;CoordMision[85][mZ] = 14.159999;CoordMision[85][mAngle] = 91.190002;
	CoordMision[86][mX] = -2679.300048;CoordMision[86][mY] = 455.600006;CoordMision[86][mZ] = 4.039999;CoordMision[86][mAngle] = 89.480003;
	CoordMision[87][mX] = -2796.590087;CoordMision[87][mY] = 205.820007;CoordMision[87][mZ] = 6.889999;CoordMision[87][mAngle] = 91.150001;
	CoordMision[88][mX] = -2796.370117;CoordMision[88][mY] = 180.759994;CoordMision[88][mZ] = 6.889999;CoordMision[88][mAngle] = 91.400001;
	CoordMision[89][mX] = -2796.469970;CoordMision[89][mY] = 135.419998;CoordMision[89][mZ] = 6.889999;CoordMision[89][mAngle] = 91.870002;
	CoordMision[90][mX] = -2796.409912;CoordMision[90][mY] = 17.510000;CoordMision[90][mZ] = 6.889999;CoordMision[90][mAngle] = 91.959999;
	CoordMision[91][mX] = -2796.270019;CoordMision[91][mY] = -92.309997;CoordMision[91][mZ] = 6.889999;CoordMision[91][mAngle] = 90.669998;
	CoordMision[92][mX] = -2694.159912;CoordMision[92][mY] = -108.919998;CoordMision[92][mZ] = 4.039999;CoordMision[92][mAngle] = 90.569999;
	CoordMision[93][mX] = -2682.800048;CoordMision[93][mY] = -22.670000;CoordMision[93][mZ] = 4.039999;CoordMision[93][mAngle] = 0.920000;
	CoordMision[94][mX] = -2666.510009;CoordMision[94][mY] = -35.450000;CoordMision[94][mZ] = 4.039999;CoordMision[94][mAngle] = 180.369995;
	CoordMision[95][mX] = -2630.290039;CoordMision[95][mY] = -54.669998;CoordMision[95][mZ] = 4.039999;CoordMision[95][mAngle] = 2.190000;
	CoordMision[96][mX] = -2617.129882;CoordMision[96][mY] = -22.459999;CoordMision[96][mZ] = 4.039999;CoordMision[96][mAngle] = 2.009999;
	CoordMision[97][mX] = -2485.370117;CoordMision[97][mY] = 59.650001;CoordMision[97][mZ] = 25.610000;CoordMision[97][mAngle] = 358.750000;
	CoordMision[98][mX] = -2491.149902;CoordMision[98][mY] = 93.120002;CoordMision[98][mZ] = 25.319999;CoordMision[98][mAngle] = 90.180000;
	CoordMision[99][mX] = -2218.570068;CoordMision[99][mY] = 368.220001;CoordMision[99][mZ] = 35.020000;CoordMision[99][mAngle] = 271.040008;
	CoordMision[100][mX] = -2081.090087;CoordMision[100][mY] = 262.149993;CoordMision[100][mZ] = 35.310001;CoordMision[100][mAngle] = 88.720001;
	CoordMision[101][mX] = -2029.680053;CoordMision[101][mY] = 124.809997;CoordMision[101][mZ] = 28.799999;CoordMision[101][mAngle] = 357.970001;
	CoordMision[102][mX] = -2024.050048;CoordMision[102][mY] = 125.199996;CoordMision[102][mZ] = 28.799999;CoordMision[102][mAngle] = 1.399999;
	CoordMision[103][mX] = -2064.229980;CoordMision[103][mY] = -84.376396;CoordMision[103][mZ] = 35.801242;CoordMision[103][mAngle] = 1.090006;
	CoordMision[104][mX] = -2076.989990;CoordMision[104][mY] = -84.573600;CoordMision[104][mZ] = 35.801242;CoordMision[104][mAngle] = 181.270019;
	CoordMision[105][mX] = -2089.719970;CoordMision[105][mY] = -84.559997;CoordMision[105][mZ] = 35.860000;CoordMision[105][mAngle] = 180.419998;
	CoordMision[106][mX] = -1875.050048;CoordMision[106][mY] = -151.470001;CoordMision[106][mZ] = 11.600000;CoordMision[106][mAngle] = 179.419998;
	CoordMision[107][mX] = -1882.239990;CoordMision[107][mY] = -165.250000;CoordMision[107][mZ] = 11.609999;CoordMision[107][mAngle] = 183.300003;
	CoordMision[108][mX] = -1869.280029;CoordMision[108][mY] = -175.009994;CoordMision[108][mZ] = 8.899999;CoordMision[108][mAngle] = 271.329986;
	CoordMision[109][mX] = -1819.359985;CoordMision[109][mY] = -183.729995;CoordMision[109][mZ] = 9.100000;CoordMision[109][mAngle] = 266.799987;
	CoordMision[110][mX] = -1824.829956;CoordMision[110][mY] = -160.630004;CoordMision[110][mZ] = 9.100000;CoordMision[110][mAngle] = 358.809997;
	CoordMision[111][mX] = -2149.590087;CoordMision[111][mY] = -811.750000;CoordMision[111][mZ] = 31.729999;CoordMision[111][mAngle] = 272.579986;
	CoordMision[112][mX] = -2125.530029;CoordMision[112][mY] = -935.140014;CoordMision[112][mZ] = 31.729999;CoordMision[112][mAngle] = 270.549987;

	
//--------------------------------------PICKSUP DEL GAMEMODE---------------------------------------------------
//------http://weedarr.wikidot.com/pickups
//1240 --> Corazon
//1242 --> Armadura
//1239 --> Información
//1272 --> Casa azul
//1273 --> Casa Verde
//1212 --> Dinero
//1654 --> Explosivo
//......
    AddStaticPickup(1313, 1, -2163.0181,2724.0085,-58.9922);//Calavera del de la droga
    AddStaticPickup(1313, 1, -2183.1243,2720.2258,-58.9430);//Calavera del de la droga
	AddStaticPickup(1313, 1, -2268.0435,2315.3955,4.8202);//Calavera del de la droga
    AddStaticPickup(1313, 1, -1527.96,149.21,3.55);//Calavera del Puto Ambro
    AddStaticPickup(1313, 1,-2107.4812,-221.7151,35.3203);//Calavera del mecanico
    AddStaticPickup(1313, 1,-2506.1765,769.4029,35.1719);//Calavera del mecanico
    
    AddStaticPickup(1313, 1,-2251.6724,2323.6042,4.8125);//Calavera dela mision de la droga (Transportar a los garitos)
    Create3DTextLabel("Usa el comanbdo /informacion", 0xFFFFFFAA,-2251.6724,2323.6042,4.8125, 20.0, 0, 0);
    
    AddStaticPickup(1313, 1,-2259.2664,2387.0713,4.9892);//Calavera de la misión de la droga (Carga y Descarga)
    Create3DTextLabel("Usa el comanbdo /informacion", 0xFFFFFFAA,-2259.2664,2387.0713,4.9892, 20.0, 0, 0);
    
    
    AddStaticPickup(1247, 1, -1591.5914,716.2670,-5.2422);//Aqui cogen las armas

	AddStaticPickup(1314, 1, -1615.9277,686.4177,7.1875);//i de las camaras de policia

	AddStaticPickup(1247, 1,-1862.4753,961.7531,36.2719);// Trabajos Xoomer
	
	AddStaticPickup(1314, 1,322.4866,119.6555,1003.2194);//comandos del Banco
	AddStaticPickup(1314, 1,1561.0171,-1684.6732,1723.1050);//join policia
	AddStaticPickup(1314, 1,1565.4065,-1672.1458,1723.1050);//duty policia
	
	AddStaticPickup(1314, 1,-2048.5483, -255.8789, 35.3203);// /join bomberos
	AddStaticPickup(1314, 1,-2030.8715,-223.8672,14.5783);//duty
	
	AddStaticPickup(1272, 1, -1536.1254,524.2009,7.1797);//Negocio Mecanicos
	
	for (new i = 0; i < NUM_PISOS_FRANCOS; i++) {
		AddStaticPickup(1313, 1, PisosFrancos[i][pfEnterPos][0],PisosFrancos[i][pfEnterPos][1],PisosFrancos[i][pfEnterPos][2]);
	}
	
	new tmphour;
	new tmpminute;
	new tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	mySetWorldTime(tmphour);

	puertatimer = SetTimer("PuertaCheck", 1000, 1); //Puerta Automaticas
	synctimer = SetTimer("SyncUp", 3600000, 1);
	unjailtimer = SetTimer("Teleport", 1000, 1);
	pickuptimer = SetTimer("CustomPickups", 1000, 1);
	idletimer = SetTimer("IdleKick", idletime, 1);
	productiontimer = SetTimer("Production", 300000, 1); //5 mins (300000)
	checkgastimer = SetTimer("CheckGas", RunOutTime, 1);
    stoppedvehtimer = SetTimer("StoppedVehicle", RunOutTime, 1);
    fugitivoTimer = SetTimer("fugitivo", 1000, 1);
    tiempoTimer = SetTimer("tiempo", 1000, 1);
   // introTimerT = SetTimer("introTimer",1000,1);
    



   // peliTimerT = SetTimer("peliTimer",500,1);

	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
  	{
    	new npcname[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, npcname, sizeof(npcname));
       
    	if(!strcmp(npcname, "vendetta_drogacocheNPC", true)) //Chequea si el nombre del NPC es Correcto.
    	{
     		PutPlayerInVehicle(playerid, drogaNPCVeh, 0); //Pone al NPC en su respectivo automovil.
     		SetPlayerSkin(playerid, 50);
		 	return 1;
   		}
	    if(!strcmp(npcname, "muelle_fumaNPC", true)){SetPlayerSkin(playerid, 249);return 1;}
   	    if(!strcmp(npcname, "muelle_andaNPC", true)){SetPlayerSkin(playerid, 165);return 1;}
   	    if(!strcmp(npcname, "muelle_armado1NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
   	    if(!strcmp(npcname, "muelle_armado2NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
   	    if(!strcmp(npcname, "muelle_armado3NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
   	    if(!strcmp(npcname, "muelle_armado4NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
   	    if(!strcmp(npcname, "muelle_pizarraNPC", true)){SetPlayerSkin(playerid, 165);return 1;}
       	if(!strcmp(npcname, "lider_mecanicoNPC", true)){SetPlayerSkin(playerid, 50);return 1;}
		if(!strcmp(npcname, "mecanico1NPC", true)){SetPlayerSkin(playerid, 50);return 1;}
    	if(!strcmp(npcname, "mecanico2NPC", true)){SetPlayerSkin(playerid, 50);return 1;}
    	
    	if(!strcmp(npcname, "entierro_unoNPC", true)){SetPlayerSkin(playerid, 9);return 1;}
    	if(!strcmp(npcname, "entierro_dosNPC", true)){SetPlayerSkin(playerid, 17);return 1;}
    	if(!strcmp(npcname, "entierro_tresNPC", true)){SetPlayerSkin(playerid, 60);return 1;}
    	if(!strcmp(npcname, "entierro_cuatroNPC", true)){SetPlayerSkin(playerid, 43);return 1;}
    	if(!strcmp(npcname, "entierro_cincoNPC", true)){SetPlayerSkin(playerid, 9);return 1;}
    	if(!strcmp(npcname, "entierro_seisNPC", true)){SetPlayerSkin(playerid, 60);return 1;}
    	if(!strcmp(npcname, "entierro_sieteNPC", true)){SetPlayerSkin(playerid, 43);return 1;}
    	if(!strcmp(npcname, "entierro_mafiosoNPC", true)){SetPlayerSkin(playerid, 117);return 1;}
    	if(!strcmp(npcname, "entierro_mafioso1NPC", true)){SetPlayerSkin(playerid, 111);return 1;}
    	if(!strcmp(npcname, "entierro_curaNPC", true)){SetPlayerSkin(playerid, 68);return 1;}
    	if(!strcmp(npcname, "entierro_protaNPC", true)){SetPlayerSkin(playerid, 126);return 1;}
    	
   		if(!strcmp(npcname, "create_bandaNPC", true)){SetPlayerSkin(playerid, 105);return 1;}
    	if(!strcmp(npcname, "create_banda1NPC", true)){SetPlayerSkin(playerid, 106);return 1;}
    	if(!strcmp(npcname, "create_bandabossNPC", true)){SetPlayerSkin(playerid, 107);return 1;}   	
		if(!strcmp(npcname, "bomberoNPC", true)){SetPlayerSkin(playerid, 279);return 1;}
    	if(!strcmp(npcname, "bombero_bossNPC", true)){SetPlayerSkin(playerid, 279);return 1;}
    	if(!strcmp(npcname, "tirao1NPC", true)){SetPlayerSkin(playerid, 1);return 1;}//El npc que esta en el suelo del incendio
        if(!strcmp(npcname, "banqueroNPC", true)){SetPlayerSkin(playerid, 76);return 1;}
    	if(!strcmp(npcname, "banquero1NPC", true)){SetPlayerSkin(playerid, 98);return 1;}
    	if(!strcmp(npcname, "banquero2NPC", true)){SetPlayerSkin(playerid, 76);return 1;}
    	if(!strcmp(npcname, "poli_1NPC", true)){SetPlayerSkin(playerid, 281);return 1;}
    	if(!strcmp(npcname, "poli_2NPC", true)){SetPlayerSkin(playerid, 282);return 1;}
    	if(!strcmp(npcname, "poli_3NPC", true)){SetPlayerSkin(playerid, 283);return 1;}
    	if(!strcmp(npcname, "poli_4NPC", true)){SetPlayerSkin(playerid, 281);return 1;}
        if(!strcmp(npcname, "poli_5NPC", true)){SetPlayerSkin(playerid, 281);return 1;}
        if(!strcmp(npcname, "poli_6NPC", true)){SetPlayerSkin(playerid, 282);return 1;}
        if(!strcmp(npcname, "policia_controlNPC", true)){SetPlayerSkin(playerid, 281);return 1;}
	    if(!strcmp(npcname, "policia_control1NPC", true)){SetPlayerSkin(playerid, 281);return 1;}
    	if(!strcmp(npcname, "policia_control2NPC", true)){SetPlayerSkin(playerid, 282);return 1;}
    	if(!strcmp(npcname, "policia_control3NPC", true)){SetPlayerSkin(playerid, 281);return 1;}
	    if(!strcmp(npcname, "policia_control4NPC", true)){SetPlayerSkin(playerid, 281);return 1;}
    	if(!strcmp(npcname, "policia_control5NPC", true)){SetPlayerSkin(playerid, 282);return 1;}
    	
    	if(!strcmp(npcname, "vendetta_drogaNPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga1NPC", true)){SetPlayerSkin(playerid, 249);return 1;}
	    if(!strcmp(npcname, "vendetta_droga2NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga3NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga4NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga5bossNPC", true)){SetPlayerSkin(playerid, 249);return 1;}
	    if(!strcmp(npcname, "vendetta_droga6NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga7NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga8NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_droga9bossNPC", true)){SetPlayerSkin(playerid, 249);return 1;}
    	if(!strcmp(npcname, "vendetta_droga10NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
	    if(!strcmp(npcname, "vendetta_droga11bossNPC", true)){SetPlayerSkin(playerid, 249);return 1;}
    	if(!strcmp(npcname, "vendetta_drogagirlNPC", true)){SetPlayerSkin(playerid, 145);return 1;}
    	if(!strcmp(npcname, "vendetta_drogagirl1NPC", true)){SetPlayerSkin(playerid, 145);return 1;}
    	
    	if(!strcmp(npcname, "vendetta_armasNPC", true)){SetPlayerSkin(playerid, 249);return 1;}
    	if(!strcmp(npcname, "vendetta_armas1NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
	    if(!strcmp(npcname, "vendetta_armas2NPC", true)){SetPlayerSkin(playerid, 165);return 1;}
    	if(!strcmp(npcname, "vendetta_armas3NPC", true)){SetPlayerSkin(playerid, 249);return 1;}
    	
  	}

	if (gPlayerLogged[playerid] == 0){
    	
    	InterpolateCameraPos(playerid,1461.0984,1533.7355,32.5241,1461.0984,1533.4355,32.5241,4000,CAMERA_MOVE);
		InterpolateCameraLookAt(playerid,1458.582397, 1549.558838, 36.825127,1458.582397, 1549.558838, 36.925127,4000,CAMERA_CUT);
    	
        return 1;
	}

	ConBandana[playerid] = 0;
    RemovePlayerAttachedObject(playerid, SlotObjeto);

	SetPlayerSpawn(playerid);
	return 1;
}

public SyncUp()
{
	SyncTime();
}

public mySetWorldTime(hour) {
	if (hour == 14)
	    SetWorldTime(18);
	else if (hour == 15)
	    SetWorldTime(19);
	else if (hour == 16)
	    SetWorldTime(20);
	else if (hour == 5)
	    SetWorldTime(4);
  	else if (hour == 6)
	    SetWorldTime(5);
  	else if (hour == 7)
	    SetWorldTime(6);
   	else if (hour == 8)
	    SetWorldTime(7);
	else if (hour >= 17 || hour < 5)
		SetWorldTime(1);
	else
	    SetWorldTime(10);


}

public SyncTime()
{
	new string[64];
	new tmphour;
	new tmpminute;
	new tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23))
	{
		format(string, sizeof(string), "SERVER: The time is now %d:00 hours",tmphour);
		BroadCast(COLOR_WHITE,string);
		ghour = tmphour;
		mySetWorldTime(tmphour);
	}
}


public OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
			new string3[32];
			new playername3[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername3, sizeof(playername3));
			format(string3, sizeof(string3), "%s.ini", playername3);
			new File: hFile = fopen(string3, io_write);
			if (hFile)
			{
			    strmid(PlayerInfo[playerid][pKey], password, 0, strlen(password), 255);
			    new var[32];
				format(var, 32, "Key=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
				format(var, 32, "Level=%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, 32, "AdminLevel=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, 32, "Registered=%d\n",PlayerInfo[playerid][pReg]);fwrite(hFile, var);
				format(var, 32, "Presentacion=%d\n",PlayerInfo[playerid][pPresentacion]);fwrite(hFile, var);
				format(var, 32, "Exp=%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, 32, "Money=%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				format(var, 32, "Jailed=%d\n",PlayerInfo[playerid][pJailed]);fwrite(hFile, var);
				format(var, 32, "JailTime=%d\n",PlayerInfo[playerid][pJailTime]);fwrite(hFile, var);
				format(var, 32, "Int=%d\n",PlayerInfo[playerid][pInt]);fwrite(hFile, var);
				format(var, 32, "Job=%d\n",PlayerInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, 32, "Team=%d\n",PlayerInfo[playerid][pTeam]);fwrite(hFile, var);
				format(var, 32, "rank=%d\n",PlayerInfo[playerid][pRank]);fwrite(hFile, var);
				format(var, 32, "Model=%d\n",PlayerInfo[playerid][pModel]);fwrite(hFile, var);
				if ((PlayerInfo[playerid][pPos_x]==0.0 && PlayerInfo[playerid][pPos_y]==0.0 && PlayerInfo[playerid][pPos_z]==0.0))
				{
					PlayerInfo[playerid][pPos_x] = 1684.9;
					PlayerInfo[playerid][pPos_y] = -2244.5;
					PlayerInfo[playerid][pPos_z] = 13.5;
				}

				format(var, 32, "Pos_x=%.1f\n",PlayerInfo[playerid][pPos_x]);fwrite(hFile, var);
				format(var, 32, "Pos_y=%.1f\n",PlayerInfo[playerid][pPos_y]);fwrite(hFile, var);
				format(var, 32, "Pos_z=%.1f\n",PlayerInfo[playerid][pPos_z]);fwrite(hFile, var);
				format(var, 32, "Wanted=%d\n",PlayerInfo[playerid][pWanted]);fwrite(hFile, var);
				fclose(hFile);
			//	SendClientMessage(playerid, COLOR_YELLOW, "Account registered, you can login now (/login [password]).");
			}
			
			// ============================================== DB REGISTER ===================================================
			new string[1024];
			new query[1024];
			strcat(string, "INSERT INTO `players`(`uID`, `Name`, `Password`, `Email`, `Sex`, `Race`, `Age`,");
			strcat(string, "`Level`, `Admin`, `Registered`, `RegisterDate`, `Experience`, `Money`, `Jailed`,"); 
			strcat(string, "`JailedTime`, `Interior`, `Job`, `Team`, `Rank`, `Model`, `Pos_X`, `Pos_Y`, `Pos_Z`,");
			strcat(string, "`Wanted`, `Band`, `MissionBand`, `LastGameLogin`, `LastPcuLogin`) VALUES (");
			strcat(string, " 0, '%s', '%s', 'a@a.com', 'hombre', 'humano', 10, ");
			strcat(string, " 0, 0, 1, now(), 0, 0, 0, ");
			strcat(string, " 0, 0, 0, 0, 0, 0, 1684, -2244, 13, ");
			strcat(string, " 0, 0, 0, now(), 0);");
			format(query, sizeof(query), string, playername3, PlayerInfo[playerid][pKey]);
			mysql_query(mysql, query);
			
			new error[128];
			format(error, sizeof(error), "DB_ERROR: %i", mysql_errno( mysql ));
			print( error );
			// ==============================================================================================================
			
	}
	return 1;
}

public OnPlayerUpdate(playerid) {

	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		if(gPlayerLogged[playerid])
		{
		    if (darArmas[playerid] == 1) {
			    for (new i = 0; i < 13; i++) {
					GetPlayerWeaponData(playerid, i, PlayerInfo[playerid][pWeapon][i], PlayerInfo[playerid][pAmmo][i]);
				}
			}
			new string3[32];
			new playername3[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playername3, sizeof(playername3));
			format(string3, sizeof(string3), "%s.ini", playername3);
			new File: hFile = fopen(string3, io_write);
			if (hFile)
			{
				new var[30];
				format(var, sizeof(var), "Key=%s\n", PlayerInfo[playerid][pKey]);fwrite(hFile, var);
				PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
				format(var, sizeof(var), "Level=%d\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
				format(var, sizeof(var), "AdminLevel=%d\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
				format(var, sizeof(var), "Registered=%d\n",PlayerInfo[playerid][pReg]);fwrite(hFile, var);
				format(var, sizeof(var), "Presentacion=%d\n",PlayerInfo[playerid][pPresentacion]);fwrite(hFile, var);
				format(var, sizeof(var), "Exp=%d\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
				format(var, sizeof(var), "Money=%d\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
				format(var, sizeof(var), "Jailed=%d\n",PlayerInfo[playerid][pJailed]);fwrite(hFile, var);
				format(var, sizeof(var), "JailTime=%d\n",PlayerInfo[playerid][pJailTime]);fwrite(hFile, var);
				format(var, sizeof(var), "Int=%d\n",PlayerInfo[playerid][pInt]);fwrite(hFile, var);
				format(var, sizeof(var), "Job=%d\n",PlayerInfo[playerid][pJob]);fwrite(hFile, var);
				format(var, sizeof(var), "Team=%d\n",PlayerInfo[playerid][pTeam]);fwrite(hFile, var);
				format(var, sizeof(var), "rank=%d\n",PlayerInfo[playerid][pRank]);fwrite(hFile, var);
				format(var, sizeof(var), "Model=%d\n",PlayerInfo[playerid][pModel]);fwrite(hFile, var);
				if ((PlayerInfo[playerid][pPos_x]==0.0 && PlayerInfo[playerid][pPos_y]==0.0 && PlayerInfo[playerid][pPos_z]==0.0))
				{
					PlayerInfo[playerid][pPos_x] = 1684.9;
					PlayerInfo[playerid][pPos_y] = -2244.5;
					PlayerInfo[playerid][pPos_z] = 13.5;
				}

				fwrite(hFile,"Weapon=");
				for (new i = 0; i < 13; i++) {
				    format(var,sizeof(var), "%d ",PlayerInfo[playerid][pWeapon][i]);
				    fwrite(hFile, var);
				}
				fwrite(hFile,"\n");

				fwrite(hFile,"Ammo=");
				for (new i = 0; i < 13; i++) {
				    format(var,sizeof(var), "%d ",PlayerInfo[playerid][pAmmo][i]);
				    fwrite(hFile, var);
				}
				fwrite(hFile,"\n");

				format(var, sizeof(var), "Pos_x=%.1f\n",PlayerInfo[playerid][pPos_x]);fwrite(hFile, var);
				format(var, sizeof(var), "Pos_y=%.1f\n",PlayerInfo[playerid][pPos_y]);fwrite(hFile, var);
				format(var, sizeof(var), "Pos_z=%.1f\n",PlayerInfo[playerid][pPos_z]);fwrite(hFile, var);
				format(var, sizeof(var), "Wanted=%d\n",PlayerInfo[playerid][pWanted]);fwrite(hFile, var);
				format(var, sizeof(var), "Banda=%d\n",PlayerInfo[playerid][pBanda]);fwrite(hFile, var);
				format(var, sizeof(var), "MisionBanda=%d\n",PlayerInfo[playerid][pMisionBanda]);fwrite(hFile, var);
				
				fwrite(hFile,"Skill=");
				for (new i = 0; i < NUM_SKILLS; i++) {
				    format(var,sizeof(var), "%d ",PlayerInfo[playerid][pSkill][i]);
				    fwrite(hFile, var);
				}
				fwrite(hFile,"\n");
				
				fwrite(hFile,"CarKeys=");
				for (new i = 0; i < MAX_PLAYER_CAR_KEYS; i++) {
				    format(var,sizeof(var), "%d ",PlayerInfo[playerid][pCarKeys][i]);
				    fwrite(hFile, var);
				}
				fwrite(hFile,"\n");

				fwrite(hFile,"Inventario=");
				for (new i = 0; i < MAX_INVENTARIO; i++) {
				    format(var,sizeof(var), "%d ",PlayerInfo[playerid][pInventario][i]);
				    fwrite(hFile, var);
				}
				fwrite(hFile,"\n");

				fclose(hFile);
			}
		}
	}
	return 1;
}


public OnPlayerLogin(playerid,password[])
{
    new string2[64];
	new playername2[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername2, sizeof(playername2));
	format(string2, sizeof(string2), "%s.ini", playername2);

//============================================= DB LOGIN ==========================================================================================
	new strQuery[512];
	new query[512];
	new error[512];
	strcat( strQuery, "SELECT * FROM `players` WHERE `Name`='%s' AND `Password`='%s'");
	format(query, sizeof( query ), strQuery, playername2, password);
	new Cache:result = mysql_query( mysql, query );

	new nrows;
	nrows = cache_get_row_count();

	if( nrows > 0){
	    new nFields;
	    new fName[64];
	    nFields = cache_get_field_count();

	    //Get player info
	    for(new i=0 ; i<nFields ; i++){
	        cache_get_field_name( i, fName, mysql, sizeof( fName ) );
	        if( strcmp( fName, "uID", true) == 0 ){ PlayerInfo[playerid][pID] = cache_get_field_content_int(0, "uID"); }
	        if( strcmp( fName, "Level", true) == 0 ){ PlayerInfo[playerid][pLevel] = cache_get_field_content_int(0, "Level"); }
	        if( strcmp( fName, "Admin", true) == 0 ){ PlayerInfo[playerid][pAdmin] = cache_get_field_content_int(0, "Admin"); }
	        if( strcmp( fName, "Registered", true) == 0 ){ PlayerInfo[playerid][pReg] = cache_get_field_content_int(0, "Registered"); }
	        if( strcmp( fName, "Intro", true) == 0 ){ PlayerInfo[playerid][pPresentacion] = cache_get_field_content_int(0, "Intro"); }
	        if( strcmp( fName, "Experience", true) == 0 ){ PlayerInfo[playerid][pExp] = cache_get_field_content_int(0, "Experience"); }
	        if( strcmp( fName, "Money", true) == 0 ){ PlayerInfo[playerid][pCash] = cache_get_field_content_int(0, "Money"); }
	        if( strcmp( fName, "Jailed", true) == 0 ){ PlayerInfo[playerid][pJailed] = cache_get_field_content_int(0, "Jailed"); }
	        if( strcmp( fName, "JailTime", true) == 0 ){ PlayerInfo[playerid][pJailed] = cache_get_field_content_int(0, "JailTime"); }
	        if( strcmp( fName, "Interior", true) == 0 ){ PlayerInfo[playerid][pInt] = cache_get_field_content_int(0, "Interior"); }
	        if( strcmp( fName, "Job", true) == 0 ){ PlayerInfo[playerid][pJob] = cache_get_field_content_int(0, "Job"); }
	        if( strcmp( fName, "Team", true) == 0 ){ PlayerInfo[playerid][pTeam] = cache_get_field_content_int(0, "Team"); }
	        if( strcmp( fName, "Rank", true) == 0 ){ PlayerInfo[playerid][pRank] = cache_get_field_content_int(0, "Rank"); }
	        if( strcmp( fName, "Model", true) == 0 ){ PlayerInfo[playerid][pModel] = cache_get_field_content_int(0, "Model"); }
	        if( strcmp( fName, "Pos_X", true) == 0 ){ PlayerInfo[playerid][pPos_x] = cache_get_field_content_float(0, "Pos_X"); }
	        if( strcmp( fName, "Pos_Y", true) == 0 ){ PlayerInfo[playerid][pPos_y] = cache_get_field_content_float(0, "Pos_Y"); }
	        if( strcmp( fName, "Pos_Z", true) == 0 ){ PlayerInfo[playerid][pPos_z] = cache_get_field_content_float(0, "Pos_Z"); }
	        if( strcmp( fName, "Wanted", true) == 0 ){ PlayerInfo[playerid][pWanted] = cache_get_field_content_int(0, "Wanted"); }
	        if( strcmp( fName, "Band", true) == 0 ){ PlayerInfo[playerid][pBanda] = cache_get_field_content_int(0, "Band"); }
	    }
	    cache_delete( result, mysql );

	    //Get weapon info
	    new slot[64];
		new ammo[64];
		strQuery = "";
	    strcat( strQuery, "SELECT * FROM `weapons` WHERE `uID`='%d'");
		format(query, sizeof( query ), strQuery, PlayerInfo[playerid][pID]);
		result = mysql_query( mysql, query );

		

		nrows = cache_get_row_count();
		nFields = cache_get_field_count();
	    for(new i=0 ; i<nFields ; i++){
	        cache_get_field_name( i, fName, mysql, sizeof( fName ) );
	        format(slot, sizeof( slot ), "Slot_%i", i - 1 );
	        format(ammo, sizeof( ammo ), "Ammo_%i", i - 1 );
	        if( strcmp( fName, slot, true) == 0 ){ PlayerInfo[playerid][pWeapon][i - 1] = cache_get_field_content_int(0, fName); }
	        if( strcmp( fName, ammo, true) == 0 ){ PlayerInfo[playerid][pAmmo][i - 1] = cache_get_field_content_int(0, fName); }
	    }
	    cache_delete( result, mysql );
	    
	    //Get skill info
	    new skill[64];
	    strQuery = "";
	    strcat( strQuery, "SELECT * FROM `skills` WHERE `uID`='%d'");
		format(query, sizeof( query ), strQuery, PlayerInfo[playerid][pID]);
		result = mysql_query( mysql, query );
		
		nrows = cache_get_row_count();
		nFields = cache_get_field_count();
		for(new i=0 ; i<nFields ; i++){
	        cache_get_field_name( i, fName, mysql, sizeof( fName ) );
	        format(skill, sizeof( skill ), "Skill_%i", i - 1 );
	        if( strcmp( fName, skill, true) == 0 ){ PlayerInfo[playerid][pSkill][i - 1] = cache_get_field_content_int(0, fName); }
	    }
	    cache_delete( result, mysql );
	    
	    //get car keys info
	    strQuery = "";
	    strcat( strQuery, "SELECT * FROM `keys` WHERE `uID`='%d'");
		format(query, sizeof( query ), strQuery, PlayerInfo[playerid][pID]);
		result = mysql_query( mysql, query );

		nrows = cache_get_row_count();
		nFields = cache_get_field_count();
		for(new i=0 ; i<nrows ; i++){
		    for(new j=0 ; j<nFields ; j++){
		        cache_get_field_name( j, fName, mysql, sizeof( fName ) );
		        if( strcmp( fName, "Key", true) == 0 ){ PlayerInfo[playerid][pCarKeys][i] = cache_get_field_content_int(i, fName); }
	        }
	    }
	    cache_delete( result, mysql );

//=======================================================================================================================================

        PlayerInfo[playerid][pLogged] = 1;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);
		if(PlayerInfo[playerid][pReg] == 0)
		{
			PlayerInfo[playerid][pLevel] = 1;
			PlayerInfo[playerid][pPos_x] = -2000.6;
			PlayerInfo[playerid][pPos_y] = -50.9;
			PlayerInfo[playerid][pPos_z] = 37.7;
			PlayerInfo[playerid][pInt] = 15;
			PlayerInfo[playerid][pTeam] = 0;
			PlayerInfo[playerid][pModel] = 0;
			PlayerInfo[playerid][pReg] = 1;
			GivePlayerMoney(playerid, 5000);
		}

        SetPlayerSkin(playerid,PlayerInfo[playerid][pModel]);
		printf("%s has logged in",playername2);

		if (PlayerInfo[playerid][pAdmin] > 0)
		{
			format(string2, sizeof(string2), "SERVER: You are logged in as a Level %d Admin.",PlayerInfo[playerid][pAdmin]);
			SendClientMessage(playerid, COLOR_WHITE,string2);
		}

		gPlayerLogged[playerid] = 1;
		TogglePlayerControllable(playerid,1);
	    MostrarEscena(playerid, ESCENA_INTRO);
 	}
	else{
	    SendClientMessage(playerid, COLOR_WHITE, "SERVER: Contraseña incorrecta.");
        gPlayerLogTries[playerid] += 1;
        if(gPlayerLogTries[playerid] == 4) { Ban(playerid); }
		new aux[255];
    	format(aux, sizeof(aux), "\n{7FFFD4}Nick: {1E90FF}%s Registered\n\n{FFFFFF} Contraseña\n", playername2);
        ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "Login", aux, "Login", "Cancelar");

        return 1;
	}
	return 1;
}
// ------------------------------------ [ funciones bandas ] -------------------------------------
public loadBandas() {
    printf("Cargando bandas ");
    printf("-------------------------");
	new idx = 1;
	new string[32] = "Bandas.cfg";
	new File: hFile;
    hFile = fopen(string, io_read);
	if(hFile)
    {
        new strLine[8+NUM_GANGZONES][256];                 //ojo aqui si añadimos o quitamos
        new line[256];
        while ( fread( hFile , line , sizeof( line ) ) )
        {
            split(line, strLine, '|');
			strmid(Bandas[idx][bNombre], strLine[0], 0, strlen(strLine[0]), 255);
			strmid(Bandas[idx][bLider], strLine[1], 0, strlen(strLine[1]), 255);
      		Bandas[idx][bNivel] = strval(strLine[2]);
      		Bandas[idx][bDinero] = strval(strLine[3]);
      		Bandas[idx][bMiembros] = strval(strLine[4]);
			Bandas[idx][bPisoFranco] = strval(strLine[5]);
			Bandas[idx][bTiempoAlquiler] = strval(strLine[6]);
			Bandas[idx][bNumCoches] = strval(strLine[7]);
			for (new i = 0; i < NUM_GANGZONES; i++) {
				Bandas[idx][bReputacion][i] = strval(strLine[8+i]);
			}
			
			
			printf("%d: %s,%s,%d,%d,%d,%d,%d,%d,%d",
				idx,
				Bandas[idx][bNombre],
				Bandas[idx][bLider],
				Bandas[idx][bNivel],
				Bandas[idx][bDinero],
				Bandas[idx][bMiembros],
				Bandas[idx][bPisoFranco],
				Bandas[idx][bTiempoAlquiler],
				Bandas[idx][bNumCoches]);

			idx++;
        }
        indiceBandas = idx;
        fclose(hFile);
    }
    printf("\n***** %d BANDAS CARGADAS ******\n\n",idx-1);
    return 1;
}

public saveBandas() {
	new idx = 1;
	new File: hFile;
	while (idx < indiceBandas)
	{
	    new strLine[256];
		format(strLine, sizeof(strLine), "%s|%s|%d|%d|%d|%d|%d|",
      			Bandas[idx][bNombre],
      			Bandas[idx][bLider],
	      		Bandas[idx][bNivel],
    	  		Bandas[idx][bDinero],
      			Bandas[idx][bMiembros],
				Bandas[idx][bPisoFranco],
				Bandas[idx][bTiempoAlquiler]
				);
	    
		if(idx == 1) {
			hFile = fopen("Bandas.cfg", io_write);
		}
		else {
			hFile = fopen("Bandas.cfg", io_append);
		}
		fwrite(hFile, strLine);
		for(new i = 0; i < NUM_GANGZONES; i++) {
		    new str[20];
		    if (i == NUM_GANGZONES-1)
			    format(str, sizeof(str), "%d\n", Bandas[idx][bReputacion][i]);
			else
				format(str, sizeof(str), "%d|", Bandas[idx][bReputacion][i]);
			fwrite(hFile, str);
		}
		
		
		fclose(hFile);
		idx++;
    }
	return 1;
}

public loadCochesBandas() {
	printf("Cargando coches bandas ");
    printf("-------------------------");
	new idx = 1;
	new string[32] = "Coches_bandas.cfg";
	new File: hFile;
    hFile = fopen(string, io_read);
	if(hFile)
    {
        new strLine[28][20];                 //ojo aqui si añadimos o quitamos
        new line[512];
        while ( fread( hFile , line , sizeof( line ) ) )
        {
            split(line, strLine, '|');
      		Bandas[idx][bCoche1][cTipo] = strval(strLine[0]);
      		Bandas[idx][bCoche1][cColor][0] = strval(strLine[1]);
      		Bandas[idx][bCoche1][cColor][1] = strval(strLine[2]);
      		Bandas[idx][bCoche1][cAngle] = floatstr(strLine[3]);
      		Bandas[idx][bCoche1][cSpawn][0] = floatstr(strLine[4]);
      		Bandas[idx][bCoche1][cSpawn][1] = floatstr(strLine[5]);
      		Bandas[idx][bCoche1][cSpawn][2] = floatstr(strLine[6]);

      		Bandas[idx][bCoche2][cTipo] = strval(strLine[7]);
      		Bandas[idx][bCoche2][cColor][0] = strval(strLine[8]);
      		Bandas[idx][bCoche2][cColor][1] = strval(strLine[9]);
      		Bandas[idx][bCoche2][cAngle] = floatstr(strLine[10]);
      		Bandas[idx][bCoche2][cSpawn][0] = floatstr(strLine[11]);
      		Bandas[idx][bCoche2][cSpawn][1] = floatstr(strLine[12]);
      		Bandas[idx][bCoche2][cSpawn][2] = floatstr(strLine[13]);

      		Bandas[idx][bCoche3][cTipo] = strval(strLine[14]);
      		Bandas[idx][bCoche3][cColor][0] = strval(strLine[15]);
      		Bandas[idx][bCoche3][cColor][1] = strval(strLine[16]);
      		Bandas[idx][bCoche3][cAngle] = floatstr(strLine[17]);
      		Bandas[idx][bCoche3][cSpawn][0] = floatstr(strLine[18]);
      		Bandas[idx][bCoche3][cSpawn][1] = floatstr(strLine[19]);
      		Bandas[idx][bCoche3][cSpawn][2] = floatstr(strLine[20]);

      		Bandas[idx][bCoche4][cTipo] = strval(strLine[21]);
      		Bandas[idx][bCoche4][cColor][0] = strval(strLine[22]);
      		Bandas[idx][bCoche4][cColor][1] = strval(strLine[23]);
      		Bandas[idx][bCoche4][cAngle] = floatstr(strLine[24]);
      		Bandas[idx][bCoche4][cSpawn][0] = floatstr(strLine[25]);
      		Bandas[idx][bCoche4][cSpawn][1] = floatstr(strLine[26]);
      		Bandas[idx][bCoche4][cSpawn][2] = floatstr(strLine[27]);
      		
      		if (Bandas[idx][bCoche1][cTipo] > 0) {
      			Bandas[idx][bCoche1][cId] = CreateVehicle(Bandas[idx][bCoche1][cTipo],
															Bandas[idx][bCoche1][cSpawn][0],
															Bandas[idx][bCoche1][cSpawn][1],
															Bandas[idx][bCoche1][cSpawn][2],
															Bandas[idx][bCoche1][cAngle],
															Bandas[idx][bCoche1][cColor][0],
															Bandas[idx][bCoche1][cColor][1],
															60000);
				printf("Spawneado coche1(%d) banda %s(%d)",Bandas[idx][bCoche1][cTipo],Bandas[idx][bNombre],idx);
      		}
      		if (Bandas[idx][bCoche2][cTipo] > 0) {
				Bandas[idx][bCoche2][cId] = CreateVehicle(Bandas[idx][bCoche2][cTipo],
															Bandas[idx][bCoche2][cSpawn][0],
															Bandas[idx][bCoche2][cSpawn][1],
															Bandas[idx][bCoche2][cSpawn][2],
															Bandas[idx][bCoche2][cAngle],
															Bandas[idx][bCoche2][cColor][0],
															Bandas[idx][bCoche2][cColor][1],
															60000);
				printf("Spawneado coche2(%d) banda %s(%d)",Bandas[idx][bCoche2][cTipo],Bandas[idx][bNombre],idx);
			}
      		if (Bandas[idx][bCoche3][cTipo] > 0) {
      			Bandas[idx][bCoche3][cId] = CreateVehicle(Bandas[idx][bCoche3][cTipo],
															Bandas[idx][bCoche3][cSpawn][0],
															Bandas[idx][bCoche3][cSpawn][1],
															Bandas[idx][bCoche3][cSpawn][2],
															Bandas[idx][bCoche3][cAngle],
															Bandas[idx][bCoche3][cColor][0],
															Bandas[idx][bCoche3][cColor][1],
															60000);
				printf("Spawneado coche3(%d) banda %s(%d)",Bandas[idx][bCoche3][cTipo],Bandas[idx][bNombre],idx);
      		}
      		if (Bandas[idx][bCoche4][cTipo] > 0) {
				Bandas[idx][bCoche4][cId] = CreateVehicle(Bandas[idx][bCoche4][cTipo],
															Bandas[idx][bCoche4][cSpawn][0],
															Bandas[idx][bCoche4][cSpawn][1],
															Bandas[idx][bCoche4][cSpawn][2],
															Bandas[idx][bCoche4][cAngle],
															Bandas[idx][bCoche4][cColor][0],
															Bandas[idx][bCoche4][cColor][1],
															60000);
				printf("Spawneado coche4(%d) banda %s(%d)",Bandas[idx][bCoche4][cTipo],Bandas[idx][bNombre],idx);
      		}

			idx++;
        }
        fclose(hFile);
    }
    printf("\n***** COCHES DE BANDAS CARGADOS ******\n\n");
    return 1;

}

public saveCochesBandas() {
	new idx = 1;
	new File: hFile;
	while (idx < indiceBandas)
	{
	    new strLine[500];
		format(strLine, sizeof(strLine), "%d|%d|%d|%f|%f|%f|%f|%d|%d|%d|%f|%f|%f|%f|%d|%d|%d|%f|%f|%f|%f|%d|%d|%d|%f|%f|%f|%f\n",
      		Bandas[idx][bCoche1][cTipo],
      		Bandas[idx][bCoche1][cColor][0],
      		Bandas[idx][bCoche1][cColor][1],
      		Bandas[idx][bCoche1][cAngle],
      		Bandas[idx][bCoche1][cSpawn][0],
      		Bandas[idx][bCoche1][cSpawn][1],
      		Bandas[idx][bCoche1][cSpawn][2],

      		Bandas[idx][bCoche2][cTipo],
      		Bandas[idx][bCoche2][cColor][0],
      		Bandas[idx][bCoche2][cColor][1],
      		Bandas[idx][bCoche2][cAngle],
      		Bandas[idx][bCoche2][cSpawn][0],
      		Bandas[idx][bCoche2][cSpawn][1],
      		Bandas[idx][bCoche2][cSpawn][2],

      		Bandas[idx][bCoche3][cTipo],
      		Bandas[idx][bCoche3][cColor][0],
      		Bandas[idx][bCoche3][cColor][1],
      		Bandas[idx][bCoche3][cAngle],
      		Bandas[idx][bCoche3][cSpawn][0],
      		Bandas[idx][bCoche3][cSpawn][1],
      		Bandas[idx][bCoche3][cSpawn][2],

      		Bandas[idx][bCoche4][cTipo],
      		Bandas[idx][bCoche4][cColor][0],
      		Bandas[idx][bCoche4][cColor][1],
      		Bandas[idx][bCoche4][cAngle],
      		Bandas[idx][bCoche4][cSpawn][0],
      		Bandas[idx][bCoche4][cSpawn][1],
      		Bandas[idx][bCoche4][cSpawn][2]);
		if(idx == 1) {
			hFile = fopen("Coches_bandas.cfg", io_write);
		}
		else {
			hFile = fopen("Coches_bandas.cfg", io_append);
		}
		fwrite(hFile, strLine);
		fclose(hFile);
		idx++;
    }
	return 1;
}

public TimerBandas(){
	for (new i = 0; i < MAX_PLAYERS; i++){
	    if (IsPlayerConnected(i) && !IsPlayerNPC(i)) {
			if (PlayerInfo[i][pBanda] > 0) {               //barra satisfaccion con los vendetta
//			    new indBanda = PlayerInfo[i][pBanda];
		    /*	if (Bandas[indBanda][bSatisfaccion] > 80)
			    	SetProgressBarColor(satisBar[i],COLOR_GREEN);
				else if (Bandas[indBanda][bSatisfaccion] > 60)
				    SetProgressBarColor(satisBar[i],COLOR_YELLOW);
				else
				    SetProgressBarColor(satisBar[i],COLOR_RED);

	            SetProgressBarValue(satisBar[i], Bandas[indBanda][bSatisfaccion]);
    	        ShowProgressBarForPlayer(i, satisBar[i]);*/
			} else 	if (responde[i][rTiempo] > 0) {            //aceptando invitacion a la banda
				responde[i][rTiempo]--;
				if (responde[i][rTiempo] == 0) {
				    SendClientMessage(i, COLOR_RED, "No respondiste a tiempo");
			    	SendClientMessage(responde[i][id_lider], COLOR_RED, "No respondió");
				}
			} else if (alquilando[i][aTiempo] > 0) {           //alquilando un piso franco
			    alquilando[i][aTiempo]--;
			}
		}
	}
	for (new i = 0; i < MAX_BANDAS; i++) {          //comprobando alquiler
	    if (Bandas[i][bNivel] > 0) {
			if (Bandas[i][bTiempoAlquiler] > 1)
				Bandas[i][bTiempoAlquiler]--;
			if (Bandas[i][bTiempoAlquiler] == 1) {     //ultimo segundo, si pusiera 0 le pillaría siempre a todos los que no tengan el tiempo corriendo
			    printf("Tiempo alquiler a 1");
			    for (new j = 0; j < MAX_PLAYERS; j++) {
			        if (IsPlayerConnected(j) && !IsPlayerNPC(j) && PlayerInfo[j][pBanda] == i) {
			            SendClientMessage(j,COLOR_RED,"El lider de la banda no ha pagado el alquiler y el dueño se ha hartado.");
						SendClientMessage(j,COLOR_RED,"FUERA DE AQUÍ DESGRACIADOS!! fue lo que me pareció oirle decir mientras pegaba un portazo..");
					}
			    }
			    Bandas[i][bPisoFranco] = -1;
			    Bandas[i][bTiempoAlquiler]--;
			}
			new resto = Bandas[i][bTiempoAlquiler] % HORA_SEG;
			if (Bandas[i][bTiempoAlquiler] < DOS_DIAS_SEG && resto == 0 && Bandas[i][bTiempoAlquiler] > 1) { //para que avise cada hora
			    new string[255];
			    new auxn[MAX_PLAYER_NAME];
	    		strmid(auxn, Bandas[i][bLider], 0, strlen(Bandas[i][bLider]), 255);
			    if (IsPlayerConnected(GetPlayerByName(auxn))) {
	   			    format(string,sizeof(string),"Aún no has pagado el alquiler de la próxima semana y quedan %d horas para que el dueño os eche de casa",Bandas[i][bTiempoAlquiler]/HORA_SEG);
				    SendClientMessage(GetPlayerByName(auxn),COLOR_RED,string);
				}
			}
	    }
	}
	contTimerBandas++;              //actualizamos las bandas cada 15 segundos, sobre todo para lo que es el tiempo de alquiler
	if (contTimerBandas == 15) {
	    saveBandas();
	    saveCochesBandas();
	    contTimerBandas = 0;
 	}
}

// --------------------------------------------- [funciones mision ] ---------------------------------------------


//mira la banda en la que está playerid y le añade a mPlayerid. También a los miembros de la banda que estén cerca
public startMission(mID, playerid) {
    new Float:x, Float:y, Float:z;
    mPlayerid[mID][0] = playerid;
	PlayerInfo[playerid][pMisionBanda] = mID;
	mNumPlayers[mID] = 1;
	SendClientMessage(playerid,COLOR_GREEN, "Empiezas una nueva misión con tu banda");
	if (mID == MISION_MECANICO) {
	    NPCocupado[MISION_MECANICO] = 1; //npc ocupado hasta que termine
		GetPlayerPos(playerid,x,y,z);
	}
	else if (mID == MISION_DROGA) {
	    NPCocupado[MISION_DROGA] = 1; //npc ocupado hasta que termine
		GetPlayerPos(playerid,x,y,z);
	}
	else if (mID == MISION_ARMAS) {
	    NPCocupado[MISION_ARMAS] = 1; //npc ocupado hasta que termine
		GetPlayerPos(playerid,x,y,z);
	}
	else if (mID == MISION_COCHE) {
	    NPCocupado[MISION_COCHE] = 1; //npc ocupado hasta que termine
		GetPlayerPos(playerid,x,y,z);
	}
	else if (mID == MISION_INFILTRAR) {
	    NPCocupado[MISION_INFILTRAR] = 1; //npc ocupado hasta que termine
		GetPlayerPos(playerid,x,y,z);
	}
	else if (mID == MISION_TRANSPORTARDROGA) {
	    NPCocupado[MISION_TRANSPORTARDROGA] = 1; //npc ocupado hasta que termine
		GetPlayerPos(playerid,x,y,z);
	}
    new idbanda = PlayerInfo[playerid][pBanda];
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i) && !IsPlayerNPC(i) && i != playerid && PlayerInfo[i][pBanda] == idbanda) {
			if (PlayerToPoint(20.0, i, x, y, z)) {            //20 metros cerca del npc
	            mPlayerid[mID][mNumPlayers[mID]] = i;
				PlayerInfo[i][pMisionBanda] = mID;
    	        mNumPlayers[mID]++;
    	       	if (mNumPlayers[mID] > MAX_PLAYERS_MISION) {
    	            printf("lleno ***************************************************");
    	            SendClientMessage(playerid, COLOR_RED, "Límite de jugadores por misión alcanzado");
    	            break;
    	        }
    	        SendClientMessage(i,COLOR_GREEN, "Empiezas una nueva misión con tu banda");
			} else {
			    SendClientMessage(i,COLOR_RED, "Tu banda ha empezado una misión sin ti");
			}
        }
    }

	mNumPlayersReales[mID] = mNumPlayers[mID];

	createMissionTimeText(mID);

    if (mID == MISION_MECANICO) {
        tMision[mID] = TIEMPO_MISION_MECANICOS;
		sendMissionGameText(mID, "Empieza la mision", 4000);
		setMissionCheckpoint(mID, posChkPnt[0], posChkPnt[1], posChkPnt[2], 1.0);
		herrFaltan = NUM_HERRAMIENTAS;
		for (new i = 0; i < NUM_HERRAMIENTAS; i++) {
			createMissionObject(mID,ID_OBJETO_MISION_MECANICO,herrSpawn[i][0],herrSpawn[i][1],herrSpawn[i][2], 0.0, 0.0, 0.0, 20.0);
		}
	}
	else if (mID == MISION_DROGA) {
        tMision[mID] = TIEMPO_MISION_DROGA;
		sendMissionGameText(mID, "Empieza la mision", 4000);
		setMissionCheckpoint(mID, m3posChkPnt[0][0], m3posChkPnt[0][1], m3posChkPnt[0][2], 4.0);
		drogaFaltan = NUM_DROGA;
		for (new i = 0; i < NUM_DROGA; i++) {
			createMissionObject(mID,FARDO_DROGA,drogaSpawn[i][0],drogaSpawn[i][1],drogaSpawn[i][2], 0.0, 0.0, 0.0, 20.0);
		}
	}
	else if (mID == MISION_ARMAS) {
        tMision[mID] = TIEMPO_MISION_ARMAS;
		sendMissionGameText(mID, "Empieza la mision", 4000);
		setMissionCheckpoint(mID, m4posChkPnt[0][0], m4posChkPnt[0][1], m4posChkPnt[0][2], 4.0);
		armasFaltan = NUM_ARMAS;
		for (new i = 0; i < NUM_ARMAS; i++) {
			createMissionObject(mID,ID_OBJETO_MISION_ARMAS,armasSpawn[i][0],armasSpawn[i][1],armasSpawn[i][2], 0.0, 0.0, 0.0, 20.0);
		}
	}
	else if (mID == MISION_INFILTRAR) {
        tMision[mID] = TIEMPO_MISION_INFILTRAR;
		sendMissionGameText(mID, "Empieza la mision", 4000);
		setMissionCheckpoint(mID, m6posChkPnt[0][0], m6posChkPnt[0][1], m6posChkPnt[0][2], 4.0);
	}
	else if (mID == MISION_TRANSPORTARDROGA) {
        tMision[mID] = TIEMPO_MISION_TRANSPORTARDROGA;
		sendMissionGameText(mID, "Empieza la mision", 4000);
		setMissionCheckpoint(mID, m7posChkPnt[0][0], m7posChkPnt[0][1], m7posChkPnt[0][2], 4.0);
	}
	else if (mID == MISION_COCHE) {
		for(new i=0 ; i < NUM_COCHES_M5 ; i++){CocheMision[i][mDelivered] = 0;}
		for(new i=0 ; i < MAX_COORDENADAS_MISION ; i++){CoordMision[i][mUsed] = 0;}
		spawnAleatorioCoches();
		
        tMision[mID] = TIEMPO_MISION_COCHE;
        cochesFaltan = NUM_COCHES_M5;
		sendMissionGameText(mID, "Empieza la mision", 4000);
		setMissionCheckpoint(mID, m5posChkPnt[0], m5posChkPnt[1], m5posChkPnt[2], 15.0);
	}

    return 1;
}
 //finaliza la misión mID con razon: EXITO = 0, FRACASO = 1, TIEMPO_FIN 2, SIN_JUGADORES 3
public finishMission(mID, razon) {
	if (razon == SIN_JUGADORES) {
		destroyMissionAllObjects(mID);
	    mNumPlayers[mID] = 0;
    	mNumPlayersReales[mID] = 0;
	    NPCocupado[mID] = 0;
	    return 1;
	}
	tMision[mID] = 0;
	hideMissionTime(mID);
	
	if (razon == 0) {
		sendMissionGameText(mID, "MISION COMPLETADA", 7000);
	} else if (razon == 1) {
		sendMissionGameText(mID, "Fracasaste", 4000);
	} else if (razon == 2) {
		sendMissionGameText(mID, "El tiempo se ha acabado", 4000);
	}

	if (mID == MISION_MECANICO || mID == MISION_DROGA || mID == MISION_ARMAS) {
	    disableMissionCheckpoint(mID);
		destroyMissionAllObjects(mID);
	} else if (mID == MISION_COCHE || mID == MISION_INFILTRAR || mID == MISION_TRANSPORTARDROGA ) {
	    disableMissionCheckpoint(mID);
	}

    for (new i = 0; i < mNumPlayers[mID]; i++) {
        if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
            PlayerInfo[mPlayerid[mID][i]][pMisionBanda] = 0;
            if (mID == MISION_MECANICO || mID == MISION_DROGA || mID == MISION_ARMAS) {
                if (cargando[mPlayerid[mID][i]] == 1) {
					dejarObjeto(mPlayerid[mID][i]);
				}
            } else if (mID == MISION_COCHE) {
       		    for (new j = 0; j < NUM_COCHES_M5; j++) {
				    if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == CocheMision[j][mId]) {
						finiquitarCoche(i, CocheMision[j][mId]);
		    		}
				}
			}
        }
    }
    
   	destroyMissionTimeText(mID);
    
    mNumPlayers[mID] = 0;
    mNumPlayersReales[mID] = 0;
	if (mID == MISION_MECANICO) {
		NPCocupado[MISION_MECANICO] = 0;
	}
	else if (mID == MISION_DROGA) {
		NPCocupado[MISION_DROGA] = 0;
	}
	else if (mID == MISION_ARMAS) {
		NPCocupado[MISION_ARMAS] = 0;
	} else if (mID == MISION_COCHE) {
		NPCocupado[MISION_COCHE] = 0;
	} else if (mID == MISION_INFILTRAR) {
		NPCocupado[MISION_INFILTRAR] = 0;
	} else if (mID == MISION_TRANSPORTARDROGA) {
		NPCocupado[MISION_TRANSPORTARDROGA] = 0;
	}
	return 1;
}

public sendMissionText(mID, msg [], tiempo) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	    	TextDrawSetString(mMsgText[i],msg);
	        TextDrawShowForPlayer(mPlayerid[mID][i],mMsgText[mID]);
			tiempoMostrarText[mID] = tiempo;
	    }
	}
	return 1;
}

public hideMissionText(mID) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        TextDrawHideForPlayer(mPlayerid[mID][i],mMsgText[mID]);
	    }
	}
	return 1;
}


public sendMissionMsg(mID, msg []){

	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        SendClientMessage(mPlayerid[mID][i],COLOR_GRAD1,msg);
	    }
	}
	return 1;
}

public createMissionTimeText(mID) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    new playerid = mPlayerid[mID][i];
	    if (IsPlayerConnected(playerid) && PlayerInfo[playerid][pMisionBanda] == mID) {
	       	mTiempoText[playerid] = CreatePlayerTextDraw(playerid, 320.0, 380.0,"_");
			PlayerTextDrawTextSize(playerid, mTiempoText[playerid], 10.0, 20.0);
			PlayerTextDrawFont(playerid, mTiempoText[playerid],2);
			PlayerTextDrawSetShadow(playerid, mTiempoText[playerid],1);
			PlayerTextDrawSetOutline(playerid, mTiempoText[playerid],1);
			PlayerTextDrawBackgroundColor(playerid, mTiempoText[playerid],0x000000FF);
			PlayerTextDrawColor(playerid, mTiempoText[playerid],0xFFFFFFFF);
			PlayerTextDrawAlignment(playerid, mTiempoText[playerid],2);
			PlayerTextDrawHide(playerid, mTiempoText[playerid]);
	    }
	}
	return 1; 
}

public destroyMissionTimeText(mID) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    new playerid = mPlayerid[mID][i];
	    if (IsPlayerConnected(playerid) && PlayerInfo[playerid][pMisionBanda] == mID) {
     		PlayerTextDrawDestroy(playerid, mTiempoText[playerid]);
			mTiempoText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	    }
	}
	return 1;
}

public MissionTextDrawSetTimeString(mID, str[]) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    new playerid = mPlayerid[mID][i];
	    if (IsPlayerConnected(playerid) && PlayerInfo[playerid][pMisionBanda] == mID) {
			PlayerTextDrawSetString(playerid, mTiempoText[playerid],str);
	    }
	}
	return 1;
}

public showMissionTime(mID) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        PlayerTextDrawShow(mPlayerid[mID][i],mTiempoText[mPlayerid[mID][i]]);
	    }
	}
	hidden[mID] = 0;
	return 1;
}

public hideMissionTime(mID) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
		    printf("ocultando tiempo para %d",mPlayerid[mID][i]);
	        PlayerTextDrawHide(mPlayerid[mID][i],mTiempoText[mPlayerid[mID][i]]);
	        printf("con exito");
	    }
	}
	hidden[mID] = 1;
	return 1;
}

public ShowMissionEscena(mID, escena_id) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        MostrarEscena(mPlayerid[mID][i], escena_id);
	    }
	}
	return 1;
}


public sendMissionGameText(mID, msg[], tiempo) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        GameTextForPlayer(mPlayerid[mID][i],msg, tiempo, 6);
	    }
	}
	return 1;
}

public setMissionCheckpoint(mID, Float:x, Float:y, Float: z, Float:size) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        SetPlayerCheckpoint(mPlayerid[mID][i],x,y,z,size);
	    }
	}
	return 1;
}

public disableMissionCheckpoint(mID) {
	for (new i = 0; i < mNumPlayers[mID]; i++) {
	    if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
	        DisablePlayerCheckpoint(mPlayerid[mID][i]);
	    }
	}
	return 1;
}

public createMissionObject(mID,modelid,Float:x, Float:y, Float:z, Float: rX, Float:rY, Float:rZ, Float:DrawDistance) {
    mObjects[mID][mNumObjects[mID]] = CreateObject(modelid, x, y, z, rX, rY, rZ, DrawDistance);
    mNumObjects[mID]++;
	return 1;
}

public destroyMissionAllObjects(mID) {
	for (new i = 0; i < mNumObjects[mID]; i++) {
 		if (IsValidObject( mObjects[mID][i]) == 1) {
 			DestroyObject(mObjects[mID][i]);
 			mObjects[mID][i] = -1;
		}
 	}
 	mNumObjects[mID] = 0;
 	return 1;
}

public destroyMissionObject(mID, objectID) {
	for (new i = 0; i < mNumObjects[mID]; i++) {
 		if (IsValidObject(mObjects[mID][i]) == 1 && objectID == mObjects[mID][i]) {
 			DestroyObject(mObjects[mID][i]);
 			mObjects[mID][i] = -1;
		}
 	}
 	return 1;
}

public cogerObjeto(playerid, slot, modelo_id){
	cargando[playerid] = 1;
    KillTimer(TimerCargando[playerid]);
    TimerCargando[playerid] = SetTimerEx("cargandoObjeto",1000,1,"d",playerid);
    ApplyAnimation(playerid,"CARRY","liftup",1,0,0,0,0,0);
	return SetPlayerAttachedObject(playerid, slot, modelo_id, 5, -0.045800, 0.005297, 0.213481, 276.266876, 0.722662, 119.390830, 0.825105, 0.976897, 0.840149 );
}

public dejarObjeto(playerid) {
    ApplyAnimation(playerid,"CARRY","putdwn",1,0,0,0,0,0);
    SetTimerEx("dejandoObjeto",1000,0,"d",playerid);
    cargando[playerid] = 0;
    return KillTimer(TimerCargando[playerid]);
}

public dejandoObjeto(playerid, slot) {
	return RemovePlayerAttachedObject(playerid, slot);
}

public cargandoObjeto(playerid) {
    ApplyAnimation(playerid,"CARRY","crry_prtial",10,7,5,1,1,1);
    return 1;
}

public onPlayerEnterObject() {
	for (new misionid = MISION_MECANICO; misionid < NUM_MISIONES; misionid++) {
	    for (new playerindex = 0; playerindex < mNumPlayers[misionid]; playerindex++) {

	        new playerid = mPlayerid[misionid][playerindex];
		    if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
				if (PlayerInfo[playerid][pMisionBanda] == MISION_MECANICO) {
		        	if (cargando[playerid] == 0) {
	            		for (new obj = 0; obj < NUM_HERRAMIENTAS; obj++) {
	                		if (PlayerToPoint(1.0, playerid, herrSpawn[obj][0], herrSpawn[obj][1], herrSpawn[obj][2])) {
								if (mObjects[MISION_MECANICO][obj] != -1) {
									cogerObjeto(playerid, SLOT_CAJA, ID_OBJETO_MISION_MECANICO);
									destroyMissionObject(MISION_MECANICO,mObjects[MISION_MECANICO][obj]);
								}
							}
	                	}
	            	}
	        	}
	        	else if (PlayerInfo[playerid][pMisionBanda] == MISION_DROGA) {
		        	if (cargando[playerid] == 0) {
	            		for (new obj = 0; obj < NUM_DROGA; obj++) {
	                		if (PlayerToPoint(1.0, playerid,drogaSpawn[obj][0], drogaSpawn[obj][1], drogaSpawn[obj][2])) {
								if (mObjects[MISION_DROGA][obj] != -1) {
									cogerObjeto(playerid, SLOT_DROGA, FARDO_DROGA);
									destroyMissionObject(MISION_DROGA,mObjects[MISION_DROGA][obj]);
								}
							}
	                	}
	            	}
	        	}
	        	else if (PlayerInfo[playerid][pMisionBanda] == MISION_ARMAS) {
		        	if (cargando[playerid] == 0) {
	            		for (new obj = 0; obj < NUM_ARMAS; obj++) {
	                		if (PlayerToPoint(1.0, playerid,armasSpawn[obj][0], armasSpawn[obj][1], armasSpawn[obj][2])) {
								if (mObjects[MISION_ARMAS][obj] != -1) {
									cogerObjeto(playerid, SLOT_ARMAS, ID_OBJETO_MISION_ARMAS);
									destroyMissionObject(MISION_ARMAS,mObjects[MISION_ARMAS][obj]);
								}
							}
	                	}
	            	}
	        	}
            }
	    }
	}
	return 1;
}

public onPlayerEnterMissionCheckpoint() {
	for (new misionid = MISION_MECANICO; misionid < NUM_MISIONES; misionid++) {
	    for (new playerindex = 0; playerindex < mNumPlayers[misionid]; playerindex++) {
 			new playerid = mPlayerid[misionid][playerindex];
	    	if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
				if (PlayerInfo[playerid][pMisionBanda] > 0) {
	        		if (PlayerInfo[playerid][pMisionBanda] == MISION_MECANICO) {
	            		if (PlayerToPoint(1.0, playerid, posChkPnt[0], posChkPnt[1], posChkPnt[2])) {
	            			if (cargando[playerid] == 1) {
	                			herrFaltan--;
			                	new str[50];
			                	dejarObjeto(playerid);
	    		            	if (herrFaltan > 0) {
		    		            	format(str,sizeof(str),"Ya solo quedan %d cajas",herrFaltan);
		        		        	sendMissionGameText(MISION_MECANICO,str, 4000);
								} else
									finishMission(MISION_MECANICO,EXITO);
							}
    					}
					}//m3BarcoID
					else if (PlayerInfo[playerid][pMisionBanda] == MISION_DROGA) {
                        new Float:Xx=0,Float:Yy=0,Float:Zz=0;
						GetVehiclePos(m3BarcoID,Xx,Yy,Zz);
						if (PlayerToPoint(4.0, playerid, m3posChkPnt[0][0], m3posChkPnt[0][1], m3posChkPnt[0][2])) {
						    setMissionCheckpoint(MISION_DROGA, m3posChkPnt[1][0], m3posChkPnt[1][1], m3posChkPnt[1][2], 4.0);
						    sendMissionGameText(MISION_DROGA,"Ve al barco y recoge la droga", 4000);
                        }
	            		else if (PlayerToPoint(4.0, playerid, m3posChkPnt[1][0], m3posChkPnt[1][1], m3posChkPnt[1][2])) {
	            			if (cargando[playerid] == 1 && conductorBarco[MISION_DROGA] == 1 && GetDistanceBetweenPoints(Xx,Yy,Zz,m3posChkPnt[1][0],m3posChkPnt[1][1],m3posChkPnt[1][2])<10) {
	                			drogaFaltan--;
			                	new str[50];
			                	dejarObjeto(playerid);
	    		            	if (drogaFaltan > 0) {
		    		            	format(str,sizeof(str),"Ya solo quedan %d fardos de cocaina",drogaFaltan);
		        		        	sendMissionGameText(MISION_DROGA,str, 4000);
								} else {
									setMissionCheckpoint(MISION_DROGA, m3posChkPnt[2][0], m3posChkPnt[2][1], m3posChkPnt[2][2], 4.0);
									drogaObj[0] = CreateObject(1685, 0.0, 2.0, 1.05, 0.0, 0.0, 0.0);
									AttachObjectToVehicle(drogaObj[0], m3BarcoID, 0.0, 2.0, 1.05, 0.0, 0.0, 0.0);
									sendMissionGameText(MISION_DROGA,"Ok perfecto, vuelve al muelle y descarga la droga", 4000);
//									finishMission(MISION_DROGA,EXITO);
								}
							}
    					}
    					else if (PlayerToPoint(4.0, playerid, m3posChkPnt[2][0], m3posChkPnt[2][1], m3posChkPnt[2][2])) {
    					    if (GetPlayerVehicleID(playerid) == m3BarcoID) {
								conductorBarco[MISION_DROGA] = 0;
								DestroyObject(drogaObj[0]);
								setMissionCheckpoint(MISION_DROGA, m3posChkPnt[3][0], m3posChkPnt[3][1], m3posChkPnt[3][2], 4.0);
								drogaObj[1] = CreateObject(1685, -2206.2166,2415.0137,1.90, 0.0, 0.0, 0.0);//En el muelle la droga
								sendMissionGameText(MISION_DROGA,"Coge un montacargas para recoger el pale de cocaina", 4000);
	   						}
    					}
    					else if (PlayerToPoint(4.0, playerid, m3posChkPnt[3][0], m3posChkPnt[3][1], m3posChkPnt[3][2])) {
    					    if (GetPlayerVehicleID(playerid) == m3TorilloID){
    					        DestroyObject(drogaObj[1]);
								setMissionCheckpoint(MISION_DROGA, m3posChkPnt[4][0], m3posChkPnt[4][1], m3posChkPnt[4][2], 4.0);
								drogaObj[2] = CreateObject(1685, 0.0, 1.0, 1.00, 0.0, 0.0, 0.0);//En el muelle la droga
								AttachObjectToVehicle(drogaObj[2], m3TorilloID, 0.0, 1.0, 1.00, 0.0, 0.0, 0.0);
								sendMissionGameText(MISION_DROGA,"Lleva la cocaina a los camiones", 4000);
                            }
    					}
    					else if (PlayerToPoint(4.0, playerid, m3posChkPnt[4][0], m3posChkPnt[4][1], m3posChkPnt[4][2])) {
    					    if (GetPlayerVehicleID(playerid) == m3TorilloID){
								setMissionCheckpoint(MISION_DROGA, m3posChkPnt[5][0], m3posChkPnt[5][1], m3posChkPnt[5][2], 4.0);
								DestroyObject(drogaObj[2]);
								sendMissionGameText(MISION_DROGA,"La droga esta en el camion, llevalo al garito!", 4000);
                            }
    					}
    					else if (PlayerToPoint(4.0, playerid, m3posChkPnt[5][0], m3posChkPnt[5][1], m3posChkPnt[5][2])) {
    					    if (GetPlayerVehicleID(playerid) == m3CamionID){
								finishMission(MISION_DROGA, EXITO);
                            }
    					}

					}
					else if (PlayerInfo[playerid][pMisionBanda] == MISION_TRANSPORTARDROGA) {
                        new Float:Xx=0,Float:Yy=0,Float:Zz=0;
						GetVehiclePos(m7CamionID,Xx,Yy,Zz);
						if (PlayerToPoint(4.0, playerid, m7posChkPnt[0][0], m7posChkPnt[0][1], m7posChkPnt[0][2])) {
						    setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[1][0], m7posChkPnt[1][1], m7posChkPnt[1][2], 4.0);
						    sendMissionGameText(MISION_TRANSPORTARDROGA,"Ve al garito a dejar la droga", 4000);
                        }
	            		else if (PlayerToPoint(4.0, playerid, m7posChkPnt[1][0], m7posChkPnt[1][1], m7posChkPnt[1][2]) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
	            		    RemovePlayerFromVehicle(playerid);
	            		    SetPlayerAttachedObject(playerid, SLOT_MISION_TRANSPORTARDROGA, FARDO_DROGA, 5, -0.045800, 0.005297, 0.213481, 276.266876, 0.722662, 119.390830, 0.825105, 0.976897, 0.840149 );
							ApplyAnimation(playerid,"CARRY","liftup",1,0,0,0,0,0);
							sendMissionGameText(MISION_TRANSPORTARDROGA,"Deja la droga en la puerta del garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[2][0], m7posChkPnt[2][1], m7posChkPnt[2][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[2][0], m7posChkPnt[2][1], m7posChkPnt[2][2])) {
    					    dejarObjeto(playerid);
    					    sendMissionGameText(MISION_TRANSPORTARDROGA,"Ok ve al siguiente garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[3][0], m7posChkPnt[3][1], m7posChkPnt[3][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[3][0], m7posChkPnt[3][1], m7posChkPnt[3][2]) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
    					    RemovePlayerFromVehicle(playerid);
	            		    SetPlayerAttachedObject(playerid, SLOT_MISION_TRANSPORTARDROGA, FARDO_DROGA, 5, -0.045800, 0.005297, 0.213481, 276.266876, 0.722662, 119.390830, 0.825105, 0.976897, 0.840149 );
							ApplyAnimation(playerid,"CARRY","liftup",1,0,0,0,0,0);
							sendMissionGameText(MISION_TRANSPORTARDROGA,"Deja la droga en la puerta del garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[4][0], m7posChkPnt[4][1], m7posChkPnt[4][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[4][0], m7posChkPnt[4][1], m7posChkPnt[4][2])) {
    					    dejarObjeto(playerid);
    					    sendMissionGameText(MISION_TRANSPORTARDROGA,"Ok ve al siguiente garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[5][0], m7posChkPnt[5][1], m7posChkPnt[5][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[5][0], m7posChkPnt[5][1], m7posChkPnt[5][2]) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
    					    RemovePlayerFromVehicle(playerid);
	            		    SetPlayerAttachedObject(playerid, SLOT_MISION_TRANSPORTARDROGA, FARDO_DROGA, 5, -0.045800, 0.005297, 0.213481, 276.266876, 0.722662, 119.390830, 0.825105, 0.976897, 0.840149 );
							ApplyAnimation(playerid,"CARRY","liftup",1,0,0,0,0,0);
							sendMissionGameText(MISION_TRANSPORTARDROGA,"Deja la droga en la puerta del garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[6][0], m7posChkPnt[6][1], m7posChkPnt[6][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[6][0], m7posChkPnt[6][1], m7posChkPnt[6][2])) {
    					    dejarObjeto(playerid);
    					    sendMissionGameText(MISION_TRANSPORTARDROGA,"Ok ve al siguiente garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[7][0], m7posChkPnt[7][1], m7posChkPnt[7][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[7][0], m7posChkPnt[7][1], m7posChkPnt[7][2]) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) {
    					    RemovePlayerFromVehicle(playerid);
	            		    SetPlayerAttachedObject(playerid, SLOT_MISION_TRANSPORTARDROGA, FARDO_DROGA, 5, -0.045800, 0.005297, 0.213481, 276.266876, 0.722662, 119.390830, 0.825105, 0.976897, 0.840149 );
							ApplyAnimation(playerid,"CARRY","liftup",1,0,0,0,0,0);
							sendMissionGameText(MISION_TRANSPORTARDROGA,"Deja la droga en la puerta del garito", 4000);
							setMissionCheckpoint(MISION_TRANSPORTARDROGA, m7posChkPnt[8][0], m7posChkPnt[8][1], m7posChkPnt[8][2], 4.0);
    					}
    					else if (PlayerToPoint(4.0, playerid, m7posChkPnt[8][0], m7posChkPnt[8][1], m7posChkPnt[8][2])) {
    					    dejarObjeto(playerid);
							finishMission(MISION_TRANSPORTARDROGA, EXITO);
    					}
					}
					else if (PlayerInfo[playerid][pMisionBanda] == MISION_ARMAS) {
					    new Float:Xx=0,Float:Yy=0,Float:Zz=0;
						GetVehiclePos(m4CamionID,Xx,Yy,Zz);
	            		if (PlayerToPoint(1.0, playerid, m4posChkPnt[0][0], m4posChkPnt[0][1], m4posChkPnt[0][2])) {
	            			if (cargando[playerid] == 1 && m4conductorCamion[MISION_ARMAS] == 1 && GetDistanceBetweenPoints(Xx,Yy,Zz,m4posChkPnt[0][0],m4posChkPnt[0][1],m4posChkPnt[0][2])<10) {
	                			armasFaltan--;
			                	new str[50];
			                	dejarObjeto(playerid);
	    		            	if (armasFaltan > 0) {
		    		            	format(str,sizeof(str),"Ya solo quedan %d cajas de armas",armasFaltan);
		        		        	sendMissionGameText(MISION_ARMAS,str, 4000);
								} else {
									setMissionCheckpoint(MISION_ARMAS, m4posChkPnt[1][0], m4posChkPnt[1][1], m4posChkPnt[1][2], 4.0);
									sendMissionGameText(MISION_ARMAS,"Volver a San Fierro a dejar las armas!", 4000);
//									finishMission(MISION_DROGA,EXITO);
								}
							}
    					}
    					else if (PlayerToPoint(4.0, playerid, m4posChkPnt[1][0], m4posChkPnt[1][1], m4posChkPnt[1][2])) {
    					    if (GetPlayerVehicleID(playerid) == m4CamionID) {
								m4conductorCamion[MISION_ARMAS] = 0;
								finishMission(MISION_ARMAS,EXITO);
	   						}
    					}
                    }
                    else if (PlayerInfo[playerid][pMisionBanda] == MISION_INFILTRAR) {
	            		if (PlayerToPoint(3.0, playerid, m6posChkPnt[0][0], m6posChkPnt[0][1], m6posChkPnt[0][2])) {
							setMissionCheckpoint(MISION_INFILTRAR, m6posChkPnt[1][0], m6posChkPnt[1][1], m6posChkPnt[1][2], 4.0);
							insertarItem(playerid, 1654);
							sendMissionGameText(MISION_INFILTRAR,"Haz que explote esa mercancia, pero antes apaga los focos!", 4000);
						}
						else if (PlayerToPoint(3.0, playerid, m6posChkPnt[1][0], m6posChkPnt[1][1], m6posChkPnt[1][2])) {
							setMissionCheckpoint(MISION_INFILTRAR, m6posChkPnt[2][0], m6posChkPnt[2][1], m6posChkPnt[2][2], 4.0);
							sendMissionGameText(MISION_INFILTRAR,"Plantaste la bomba, corre!", 4000);
						    bomba = 1;
                        }
    					else if (bomba == 1) {
    					    bomba = 0;
							finishMission(MISION_INFILTRAR,EXITO);
    					}
                    }
					else if (PlayerInfo[playerid][pMisionBanda] == MISION_COCHE && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
	            		if (PlayerToPoint(15.0, playerid, m5posChkPnt[0], m5posChkPnt[1], m5posChkPnt[2])) {
	            		
		              		for(new j = 0 ; j < NUM_COCHES_M5 ; j++)//Recorre todos los coches de la mision
						    {
						        if(GetPlayerVehicleID(playerid) == CocheMision[j][mId] && CocheMision[j][mDelivered] == 0)//Entrega un coche si no ha sido entregado antes
						        {
						            CocheMision[j][mDelivered] = 1;//pone el coche como entregado
									RemovePlayerFromVehicle(playerid);// saca al tio del coche
									//SetVehicleToRespawn(CocheMision[j][mId]);// vuelve a respawnear el coche.
									DestroyVehicle(CocheMision[j][mId]);
									tMision[MISION_COCHE] += 60 * 2; //Se AÃ±aden 2 minutos al contador
									cochesFaltan--;
									if(cochesFaltan == 0)//comprueba si la mision ha terminado
									{
									    finishMission(MISION_COCHE, EXITO);
									} else {
										new msg[40];
										format(msg,sizeof(msg), "Faltan %d coches", cochesFaltan);
										sendMissionGameText(MISION_COCHE, msg, 4000);
									}
						        }
								else if(GetPlayerVehicleID(playerid) == CocheMision[j][mId] && CocheMision[j][mDelivered] == 1)
								{
								    SendClientMessage(playerid,COLOR_RED,"-ElPutoAmbro dice: Ese coche ya me lo has traido, si me la intentas jugar otra vez te mato");
									finiquitarCoche(playerid, CocheMision[j][mId]);
								    tMision[MISION_COCHE] -= 5 * 60;
								}
						    }
						}
                    }
   				}
   			}
		}
    }
	return 1;
}

public PlayAudioStreamForMission(mID, url[], Float:x, Float:y, Float:z, Float:dist, usepos) {
    for (new i = 0; i < mNumPlayers[mID]; i++) {
        if (IsPlayerConnected(mPlayerid[mID][i]) && PlayerInfo[mPlayerid[mID][i]][pMisionBanda] == mID) {
            printf("sonando para %d", mPlayerid[mID][i]);
            PlayAudioStreamForPlayer(mPlayerid[mID][i],url, x,y,z,dist,usepos);
        }
    }
}
public MostrarEscena(playerid, escena_id) {
	tEscena[playerid] = 0;
	escenasID[playerid] = SetTimerEx("escenas",1000,1,"dd", playerid, escena_id);
}

public FinEscena(playerid) {
	tEscena[playerid] = 0;
	KillTimer(escenasID[playerid]);
}

public escenas(playerid, escena){
	if (escena == ESCENA_INTRO) {
	    //Si el jugador ya ha visto la intro se la salta
	    if(PlayerInfo[playerid][pPresentacion] > 0)
		    tEscena[playerid] = 54;
		
	 	if (tEscena[playerid] == 6){
   			SetPlayerCameraPos(playerid,-1554.1179,-1584.5360,60.0822);
			SetPlayerCameraLookAt(playerid,-1578.3025,-1566.2902,35.9852);
            PlayerTextDrawSetString(playerid, EscenaText[playerid],"Estamos aqui reunidos...");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        }
        else if (tEscena[playerid] == 10){
   			SetPlayerCameraPos(playerid,-1554.1179,-1584.5360,60.0822);
			SetPlayerCameraLookAt(playerid,-1578.3025,-1566.2902,35.9852);
		    PlayerTextDrawSetString(playerid,EscenaText[playerid],"para darle el ultimo adios a Kate.");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 14){
   			SetPlayerCameraPos(playerid,-1554.1179,-1584.5360,60.0822);
			SetPlayerCameraLookAt(playerid,-1578.3025,-1566.2902,35.9852);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"guardemos un minuto de silencio.");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 18){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"Aun estando en el funeral de mi esposa..");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 22){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"no dejo de pensar en quien ha podido hacer esto.");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 26){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"Dijeron que no encontraron pistas y que habia sido un accidente..");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 30){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"no puede ser, las deudas, las llamadas a medianoche..");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 34){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
           	PlayerTextDrawSetString(playerid,EscenaText[playerid],"todo debe estar relacionado.");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 38){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"Encontrare al que te hizo esto Kate.");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 42){
   			SetPlayerCameraPos(playerid,-1581.11,-1570.59,37.0);
			SetPlayerCameraLookAt(playerid,-1583.52,-1572.22,37.0);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"Te lo prometo.");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
	 	}  else if (tEscena[playerid] == 46){
   			SetPlayerCameraPos(playerid,-1554.1179,-1584.5360,60.0822);
			SetPlayerCameraLookAt(playerid,-1578.3025,-1566.2902,35.9852);
            PlayerTextDrawSetString(playerid,EscenaText[playerid],"Descansa en paz");
            PlayerTextDrawShow(playerid, EscenaText[playerid]);
        } else if (tEscena[playerid] == 50){
   			SetPlayerCameraPos(playerid,-1580.59,-1535.66,38.0);
			SetPlayerCameraLookAt(playerid,-1588.11,-1523.58,40.08);
			PlayerTextDrawHide(playerid, EscenaText[playerid]);
        }
	    else if (tEscena[playerid] == 54){
	    	PlayerTextDrawHide(playerid, EscenaText[playerid]);
    		TextDrawShowForPlayer(playerid, textVTA);
		    new tmp2[256];
			new playername2[MAX_PLAYER_NAME];
			TogglePlayerSpectating(playerid,0);
			SpawnPlayer(playerid);
			GetPlayerName(playerid,playername2,sizeof(playername2));
			format(tmp2, sizeof(tmp2), "~w~Bienvenido ~n~~y~   %s", playername2);
			GameTextForPlayer(playerid, tmp2, 5000, 1);
			SendClientMessage(playerid, COLOR_YELLOW, motd);
		    if (Bandas[PlayerInfo[playerid][pBanda]][bNivel] == -1) {
		        SendClientMessage(playerid,COLOR_RED, "El líder de tu banda ha disuelto la misma, asi que te quedas sin banda");
		        PlayerInfo[playerid][pBanda] = 0;
		    }
		    PlayerInfo[playerid][pPresentacion] = 1;
		    FinEscena(playerid);
	    }
	} else if (escena == ESCENA_MISION_DROGA) {
	    if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)) {
	        if (tEscena[playerid] == 1){
	        	hideMissionTime(PlayerInfo[playerid][pMisionBanda]);
	   			SetPlayerCameraPos(playerid,-2258.000,2386.000,5.700);
				SetPlayerCameraLookAt(playerid,-2257.000,2384.000,5.700);
                PlayerTextDrawSetString(playerid, EscenaText[playerid],"Vosotros sois los nuevos...");
                PlayerTextDrawShow(playerid, EscenaText[playerid]);
	        }
	        else if (tEscena[playerid] == 6){
	   			SetPlayerCameraPos(playerid,-1463.000,1652.000,60.000);
				SetPlayerCameraLookAt(playerid,-1400.000,1400.000,0.000);
			    PlayerTextDrawSetString(playerid,EscenaText[playerid],"Ya sabeis que teneis que hacer, el barco no puede entrar en el puerto, la policia sospecharia.");
                PlayerTextDrawShow(playerid, EscenaText[playerid]);
	        } else if (tEscena[playerid] == 14){
	   			SetPlayerCameraPos(playerid,-2223.000,2393.000,6.00);
				SetPlayerCameraLookAt(playerid,-2225.000,2400.000,0.000);
                PlayerTextDrawSetString(playerid,EscenaText[playerid],"Coged la lancha que esta en el muelle.");
                PlayerTextDrawShow(playerid, EscenaText[playerid]);
	        } else if (tEscena[playerid] == 20){
	   			SetPlayerCameraPos(playerid,-2258.000,2386.000,5.700);
				SetPlayerCameraLookAt(playerid,-2257.000,2384.000,5.700);
                PlayerTextDrawSetString(playerid,EscenaText[playerid],"Y traer la droga aqui, no me falleis.");
                PlayerTextDrawShow(playerid, EscenaText[playerid]);
	        } else if (tEscena[playerid] == 25){
		        PlayerTextDrawHide(playerid, EscenaText[playerid]);
	        	showMissionTime(PlayerInfo[playerid][pMisionBanda]);
	            SetCameraBehindPlayer(playerid);
	            FinEscena(playerid);
            }
	    }
	} else {
	    FinEscena(playerid);
	}
	tEscena[playerid]++;
}
public timerMission(){
	new str[255];
	new minTM;
	new segTM;
	for (new i = MISION_MECANICO; i < NUM_MISIONES; i++){
		if (tMision[i] == 1) {
	        finishMission(i,TIEMPO_FIN);
	        tMision[i] = 0;
		}
     	if (tMision[i] > 1) {
	        tMision[i]--;
	        minTM = tMision[i] / 60;
	        segTM = tMision[i] % 60;
			if (minTM > 9) {
                if (segTM > 9)
                    format(str,sizeof(str),"%d:%d",minTM,segTM);
                else
                    format(str,sizeof(str),"%d:0%d",minTM,segTM);
            } else {
                if (segTM > 9)
                    format(str,sizeof(str),"0%d:%d",minTM,segTM);
                else
                    format(str,sizeof(str),"0%d:0%d",minTM,segTM);
            }
			if (hidden[i] == 0) {
			    MissionTextDrawSetTimeString(i, str);
//		        PlayerTextDrawSetString(i, mTiempoText[i],str);
	       		showMissionTime(i);
	       	}
     	}
     	if(mTimeBuscar[i] >= 0) {
		 	mTimeBuscar[i]--; //cuando usan el /buscar de la mision de coches del tote
			if (mTimeBuscar[i] == 0)
			    SetPlayerCheckpoint(i, m5posChkPnt[0], m5posChkPnt[1], m5posChkPnt[2], 3.0);
		}
     	if (tiempoMostrarText[i] > 0) {
			tiempoMostrarText[i]--;
			if (tiempoMostrarText[i] == 0) {
			    hideMissionText(i);
			}
     	}
	}
}
//Luces de la mision de infiltracion
/*	luz1 = CreateObject(18656, -1484.80005, 2660.3999, 67.6, 240, 0.0, 45);
	luz2 = CreateObject(18656, -1455.20002, 2661.19995, 68.1, 230.999, 0.0, 300.999);
	luz3 = CreateObject(18656, -1456.19995, 2625, 67.9, 250.999, 0.0, 253.997); //295.999, 179.995, 253.997*/
public encenderluz1()
{
	if(panel1 == 1)
	{
		panel1 = 0;
		luz1 = CreateObject(18656, -1484.80005, 2660.3999, 67.6, 240, 0.0, 45);
	}
}

public encenderluz2()
{
	if(panel2 == 1)
	{
		panel2=0;
		luz2 = CreateObject(18656, -1455.20002, 2661.19995, 68.1, 230.999, 0.0, 300.999);
    }
}


public encenderluz3()
{
    if(panel3 == 1)
	{
		panel3=0;
		luz3 = CreateObject(18656, -1456.19995, 2625, 67.9, 250.999, 0.0, 253.997);
    }
}

public infiltrado()
{
	for(new i = 0;i < MAX_PLAYERS;i++)
	{
	    if(panel1 == 0 || panel2 == 0 || panel3 == 0){
			if(PlayerToPoint(15.0,i,-1470.25, 2645.83, 58.78) ||
			PlayerToPoint(3.0,i,-1481.19, 2657.40, 55.83) ||
			PlayerToPoint(3.0,i,-1458.58, 2657.91, 55.83) ||
			PlayerToPoint(3.0,i,-1459.68, 2624.47, 55.83) ||
			PlayerToPoint(3.0,i,-1472.80, 2624.05, 55.83) ||
			PlayerToPoint(5.0,i,-1480.95, 2616.39, 58.78) ||
			PlayerToPoint(5.0,i,-1481.00, 2627.16, 58.78) ||
			PlayerToPoint(5.0,i,-1481.64, 2636.63, 58.78) ||
			PlayerToPoint(5.0,i,-1472.84, 2616.51, 58.78) ||
			PlayerToPoint(7.0,i,-1466.21, 2629.08, 58.77))
			{
   				SetPlayerHealth(i,0);
   				finishMission(MISION_INFILTRAR,FRACASO);
			}
   		}
	}
	

}
//-------------------------- Public Mision Coches---------------------------------------------------------------------
public spawnAleatorioCoches(){
	for(new i = 0; i < NUM_COCHES_M5; i++)
	{
	    new randNumber = random(MAX_COORDENADAS_MISION);
	    if(CoordMision[randNumber][mUsed] == 1)
	    {
	        while(CoordMision[randNumber][mUsed] == 1)
		    {
		       	printf("Repetido %d", randNumber);
		        randNumber = random(MAX_COORDENADAS_MISION);
		        if(CoordMision[randNumber][mUsed] == 0)
				{
				    printf("1Creado %d", randNumber);
					CocheMision[i][mId] = AddStaticVehicle(451,CoordMision[i][mX],CoordMision[i][mY],CoordMision[i][mZ],CoordMision[i][mAngle],random(MAX_COORDENADAS_MISION),random(MAX_COORDENADAS_MISION));
					CoordMision[randNumber][mUsed] = 1;
					break;
				}
		    }
	    }
	    else
	    {
	        printf("2Creado %d",randNumber);
	        CocheMision[i][mId] = AddStaticVehicle(451,CoordMision[randNumber][mX],CoordMision[randNumber][mY],CoordMision[randNumber][mZ],CoordMision[randNumber][mAngle],random(MAX_COORDENADAS_MISION),random(MAX_COORDENADAS_MISION));
			CoordMision[randNumber][mUsed] = 1;
	    }
	}
}

public finiquitarCoche(playerid, _veh) {
    RemovePlayerFromVehicle(playerid);
    SetVehicleToRespawn(_veh);
}

//--------------------------FIN Public Mision Coches---------------------------------------------------------------------


// -------------
public OnVehicleSpawn(vehicleid) {
    if (cambiar_spawn_coche[vehicleid][tbcCoche] == 1) {
        DestroyVehicle(vehicleid);
		new idbanda = cambiar_spawn_coche[vehicleid][tbcBanda];
   		Bandas[idbanda][bCoche1][cId] = CreateVehicle(Bandas[idbanda][bCoche1][cTipo],
						Bandas[idbanda][bCoche1][cSpawn][0],
						Bandas[idbanda][bCoche1][cSpawn][1],
						Bandas[idbanda][bCoche1][cSpawn][2],
						Bandas[idbanda][bCoche1][cAngle],
						Bandas[idbanda][bCoche1][cColor][0],
						Bandas[idbanda][bCoche1][cColor][1], 60000);
	} else if (cambiar_spawn_coche[vehicleid][tbcCoche] == 2) {
		DestroyVehicle(vehicleid);
		new idbanda = cambiar_spawn_coche[vehicleid][tbcBanda];
   		Bandas[idbanda][bCoche2][cId] = CreateVehicle(Bandas[idbanda][bCoche1][cTipo],
						Bandas[idbanda][bCoche2][cSpawn][0],
						Bandas[idbanda][bCoche2][cSpawn][1],
						Bandas[idbanda][bCoche2][cSpawn][2],
						Bandas[idbanda][bCoche2][cAngle],
						Bandas[idbanda][bCoche2][cColor][0],
						Bandas[idbanda][bCoche2][cColor][1], 60000);
	} else if (cambiar_spawn_coche[vehicleid][tbcCoche] == 3) {
	    DestroyVehicle(vehicleid);
		new idbanda = cambiar_spawn_coche[vehicleid][tbcBanda];
   		Bandas[idbanda][bCoche3][cId] = CreateVehicle(Bandas[idbanda][bCoche1][cTipo],
						Bandas[idbanda][bCoche3][cSpawn][0],
						Bandas[idbanda][bCoche3][cSpawn][1],
						Bandas[idbanda][bCoche3][cSpawn][2],
						Bandas[idbanda][bCoche3][cAngle],
						Bandas[idbanda][bCoche3][cColor][0],
						Bandas[idbanda][bCoche3][cColor][1], 60000);
	} else if (cambiar_spawn_coche[vehicleid][tbcCoche] == 4) {
	    DestroyVehicle(vehicleid);
		new idbanda = cambiar_spawn_coche[vehicleid][tbcBanda];
   		Bandas[idbanda][bCoche4][cId] = CreateVehicle(Bandas[idbanda][bCoche1][cTipo],
						Bandas[idbanda][bCoche4][cSpawn][0],
						Bandas[idbanda][bCoche4][cSpawn][1],
						Bandas[idbanda][bCoche4][cSpawn][2],
						Bandas[idbanda][bCoche4][cAngle],
						Bandas[idbanda][bCoche4][cColor][0],
						Bandas[idbanda][bCoche4][cColor][1], 60000);

    }
    return 1;
}

public TieneDuenio(idPisoFranco) {
	for (new i = 1; i < indiceBandas; i++) {
	    if (Bandas[i][bNivel] > -1 && Bandas[i][bPisoFranco] == idPisoFranco) {
	        return true;
	    }
	}
	return false;
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

stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

public BroadCast(color,const string[])
{
	SendClientMessageToAll(color, string);
	return 1;
}

public ABroadCast(color,const string[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			if (PlayerInfo[i][pAdmin] >= level)
			{
				SendClientMessage(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}

public SendTeamMessage(team, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    if(PlayerInfo[i][pTeam] == team)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

//cuando duty vale 0, le envia el mensaje tb a los que estan onduty, cuando vale 1, solo a los que estan onduty
public GameTextForTeam(teamID, msg[], time, style, duty) {
   	for (new i = 0; i < MAX_PLAYERS; i++) {
	   	if (PlayerInfo[i][pTeam] == teamID) {
   		    if (duty == 1) {
   		        if (OnDuty[i] == 1)
	  				GameTextForPlayer(i, msg, time, style);
			} else
			    GameTextForPlayer(i, msg, time, style);
		}
	}
}


public SendAdminMessage(color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    if(PlayerInfo[i][pAdmin] >= MOD)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

stock SetPlayerFacingPlayer(playerid, facingid)
{
	new Float:Px, Float:Py, Float: Pa;
 	new Float:x,Float:y,Float:z;
  	GetPlayerPos(facingid,x,y,z);
   	#pragma unused z
   	GetPlayerPos(playerid, Px, Py, Pa);
   	Pa = floatabs(atan((y-Py)/(x-Px)));
   	if (x <= Px && y >= Py) Pa = floatsub(180, Pa);
   	else if (x < Px && y < Py) Pa = floatadd(Pa, 180);
   	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
   	Pa = floatsub(Pa, 90.0);
   	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
   	return SetPlayerFacingAngle(playerid, Pa);
}


//---------------------------------CONTROL DE POLICIA DEL PUENTE DE SAN FIERRO
public Cuidar()
{
	new Float:health;//Creamos Una Variable Para Generar La Salud del jugador.
	for(new i = 0; i < MAX_PLAYERS; i++)//creamos un loop para todos los jugadores
	{
		if (IsPlayerConnected(i) && IsPlayerNPC(i)!=1)//chequea si el jugador esta conectado
		{
  			new npcid = GetPlayerID("policia_controlNPC");//Aca entre comillas "" colocan el nombre de su npc (el que va a disparar) en mi caso Chori_Pan.
			new npcid1 = GetPlayerID("policia_control1NPC");//Aca entre comillas "" colocan el nombre de su npc (el que va a disparar) en mi caso Chori_Pan.
			new npcid2 = GetPlayerID("policia_control2NPC");//Aca entre comillas "" colocan el nombre de su npc (el que va a disparar) en mi caso Chori_Pan.
			new npcid3 = GetPlayerID("policia_control3NPC");//Aca entre comillas "" colocan el nombre de su npc (el que va a disparar) en mi caso Chori_Pan.
			new npcid4 = GetPlayerID("policia_control4NPC");//Aca entre comillas "" colocan el nombre de su npc (el que va a disparar) en mi caso Chori_Pan.
			new npcid5 = GetPlayerID("policia_control5NPC");//Aca entre comillas "" colocan el nombre de su npc (el que va a disparar) en mi caso Chori_Pan.
			new Float:Xx=0,Float:Yy=0,Float:Zz=0;
			new Float:Xxx=500,Float:Yyy=500,Float:Zzz=500;
			GetPlayerPos(i, Xx,Yy,Zz);
			GetPlayerPos(npcid, Xxx,Yyy,Zzz);
			new Float:distanciapunto = GetDistanceBetweenPoints(-2677.1584,1274.2866,55.4297,Xx,Yy,Zz);
			if(distanciapunto <= 10 && PoliciasDisparan[i]==0 && GetPlayerState(i)==2)
			{
				GameTextForPlayer(i,"Usa: /control",2000,6);
				cocheEntran[i]=GetPlayerVehicleID(i);
				PoliciasDisparan[i]=1;
				for(new j=0;j < MAX_PLAYERS;j++)
				{
					if(GetPlayerState(j)==3 && cocheEntran[i]==GetPlayerVehicleID(j))
					{
					    PoliciasDisparan[j]=1;
					}
				}
			}
			if(distanciapunto >  20 && PoliciasDisparan[i]==1)
			{
				GameTextForPlayer(i,"Te estan disparando corre!",2000,6);
				PoliciasDisparan[i]=2;
			}
			if(distanciapunto > 130 && distanciapunto < 150 && PoliciasDisparan[i]==2)
			{
				GameTextForPlayer(i,"Escapaste pero han dado el aviso!",2000,6);
				PoliciasDisparan[i]=0;
				Disparando = 0;
			}
			if(distanciapunto > 130 && PoliciasDisparan[i]==3)
			{
				PoliciasDisparan[i]=0;
				Disparando = 0;
			}
			if(GetDistanceBetweenPoints(Xx,Yy,Zz,Xxx,Yyy,Zzz) < 125 && PoliciasDisparan[i]==2)//chequea si el jugador esta a 125 metros de distancia del bot(NPC).
			{
				new last = random(20);//aca generan un valor aleatorio que le restara vida
  				SetPlayerFacingPlayer(npcid,i);//Le setea al npc que lo mire al jugador a si es mas "real" a la hora de dispararle
				SetPlayerFacingPlayer(npcid1,i);//Le setea al npc que lo mire al jugador a si es mas "real" a la hora de dispararle
				SetPlayerFacingPlayer(npcid2,i);//Le setea al npc que lo mire al jugador a si es mas "real" a la hora de dispararle
				SetPlayerFacingPlayer(npcid3,i);//Le setea al npc que lo mire al jugador a si es mas "real" a la hora de dispararle
				SetPlayerFacingPlayer(npcid4,i);//Le setea al npc que lo mire al jugador a si es mas "real" a la hora de dispararle
				SetPlayerFacingPlayer(npcid5,i);//Le setea al npc que lo mire al jugador a si es mas "real" a la hora de dispararle
				PlayerPlaySound(i, 1131, 0.0,0.0,0.0);
				GetPlayerHealth(i, health);//ve la vida del jugador
				SetPlayerHealth(i, health - last);//le va restando vida a medida que esta en el rango del bot(npc)
				if (Disparando == 0)
				{
					ApplyAnimation(npcid,"RIFLE","RIFLE_fire",5,1,1,1,0,0);//hace la animacion de disparar
					ApplyAnimation(npcid1,"RIFLE","RIFLE_fire",5,1,1,1,0,0);//hace la animacion de disparar
					ApplyAnimation(npcid2,"RIFLE","RIFLE_fire",5,1,1,1,0,0);//hace la animacion de disparar
					ApplyAnimation(npcid3,"RIFLE","RIFLE_fire",5,1,1,1,0,0);//hace la animacion de disparar
					ApplyAnimation(npcid4,"RIFLE","RIFLE_fire",5,1,1,1,0,0);//hace la animacion de disparar
					ApplyAnimation(npcid5,"RIFLE","RIFLE_fire",5,1,1,1,0,0);//hace la animacion de disparar
					Disparando = 1;
  				}
			}
			else
			{
				ClearAnimations(npcid);
				ClearAnimations(npcid1);
				ClearAnimations(npcid2);
				ClearAnimations(npcid3);
				ClearAnimations(npcid4);
				ClearAnimations(npcid5);
			}
		}
	}
}


//--------------------------Public Bomberos--------------------------------------------------------------------------

public temporizadorBombero(){
	for(new i=0 ; i<MAX_PLAYERS ; i++){
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i)){
	        if(PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1)
	        {
		        if(IsPlayerInCheckpoint(i))
		        {
		            DisablePlayerCheckpoint(i);
		        }
		        if(PlayerToPoint(1.0, i, 2097.1680, 1295.4927, -38.6422))
		        {
		            SendClientMessage(i, COLOR_ORANGE, "Coge al mongo y sal pitando");
		            KillTimer(timerBomberos);
		        }
			}
	    }
	}
}

stock IsPlayerLookingAtPoint(playerid,Float:X,Float:Y,Float:Z,Float:ViewWidth,Float:ViewHeight)
{
	new Float:cx,Float:cy,Float:cz,Float:pa1,Float:pa2,Float:ca1,Float:ca2,Float:px,Float:py,Float:pz;
	GetPlayerCameraFrontVector(playerid,cx,cy,cz);
	GetPlayerPos(playerid,px,py,pz);
	pz+=2.0;
	cx=floatadd(cx,px);
	cy=floatadd(cy,py);
	cz=floatadd(cz,pz);
	pa1=atan2(X-px,Y-py);
	if(pa1>360)pa1=floatsub(pa1,360);
	if(pa1<0)pa1=floatadd(pa1,360);
	pa2=atan2(Y-py,Z-pz);
	if(pa2>360)pa2=floatsub(pa2,360);
	if(pa2<0)pa2=floatadd(pa2,360);
	ca1=atan2(cx-px,cy-py);
	if(ca1>360)ca1=floatsub(ca1,360);
	if(ca1<0)ca1=floatadd(ca1,360);
	ca2=atan2(cy-py,cz-pz);
	if(ca2>360)ca2=floatsub(ca2,360);
	if(ca2<0)ca2=floatadd(ca2,360);
	if((ca1>(pa1-ViewWidth))&&(ca1<(pa1+ViewWidth))&&(ca2>(pa2-ViewHeight))&&(ca2<(pa2+ViewHeight)))return 1;
	if((pa1-ViewWidth)<0)
	{
	    ca1-=360.0;
		if((ca1>(pa1-ViewWidth))&&(ca1<(pa1+ViewWidth))&&(ca2>(pa2-ViewHeight))&&(ca2<(pa2+ViewHeight)))return 1;
	}
	if((pa1+ViewWidth)>360)
	{
	    ca1+=360.0;
		if((ca1>(pa1-ViewWidth))&&(ca1<(pa1+ViewWidth))&&(ca2>(pa2-ViewHeight))&&(ca2<(pa2+ViewHeight)))return 1;
	}
	return 0;
}
/*
public updateRanking(team){
	new File:rFile;
	if(team == BOMBEROS){
	    for(i < MAX_PLAYERS)
		{
		    if(IsPlayerConnected(i) && !isPlayerNPC(i))
		    {
		        if(PlayerInfo[i][pTeam] == BOMBEROS)
		        {
					new bNombre[256];
		            new strLine[256];
					format(strLine, sizeof(strLine), "%s|%d\n", GetPlayerName(i, bNombre, sizeof(bNombre)),PlayerInfo[i][pMisionesCompletas],);
		        }
		    }


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
	}
}*/
/*
icono -2155.47,484.211,35.17
salida -2152.78,484.61,35.17
*/
//--------------------------FIN Public Bomberos--------------------------------------------------------------------------

//------------------------------------------------------------------------------------------------------------
//---------------------------<[ OnPlayerCommandText ]>--------------------------------------------------------

//------------------------------------------------------------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
//	new playername[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	new giveplayerid, moneys, idx;
	cmd = strtok(cmdtext, idx);
//-----------------------Comando Mision 6 Apagar focos
	if(strcmp(cmd, "/apagar", true) == 0)
	{
		if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(PlayerInfo[playerid][pMisionBanda] == MISION_INFILTRAR)
	    	{
	    	    if(PlayerToPoint(1.0,playerid,-1487.8070,2645.5720,55.8359))
	    		{
	    		    DestroyObject(luz1);
	    		    SetTimer("encenderluz1",30000,false);
	    		    panel1 = 1;
				}
				if(PlayerToPoint(1.0,playerid,-1454.0955,2662.7083,55.8359))
	    		{
                    DestroyObject(luz2);
                    SetTimer("encenderluz2",30000,false);
                    panel2 = 1;
				}
				if(PlayerToPoint(1.0,playerid,-1452.9021,2623.7588,55.8359))
	    		{
                    DestroyObject(luz3);
                    SetTimer("encenderluz3",30000,false);
                    panel3 = 1;
				}
			}else{SendClientMessage(playerid, COLOR_RED,"No estas en la mision");}
		}
	}
//--------------------------------------------
	if(strcmp(cmd, "/control", true) == 0)
	{
		if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			new Float:Xx=0,Float:Yy=0,Float:Zz=0;
			GetPlayerPos(playerid, Xx,Yy,Zz);
			new Float:distanciapunto = GetDistanceBetweenPoints(-2677.1584,1274.2866,55.4297,Xx,Yy,Zz);
			if(distanciapunto <=10 && GetPlayerState(playerid)==2 )
			{
				PoliciasDisparan[playerid]=3;
				for(new i=0;i < MAX_PLAYERS;i++)
				{
					if(GetPlayerState(i)==3 && cocheEntran[playerid]==GetPlayerVehicleID(i))
					{
					    PoliciasDisparan[i]=3;
					}
				}
				SendClientMessage(playerid, COLOR_PURPLE, "La policia no encontro nada en el vehiculo, puedes continuar");
    		}else{SendClientMessage(playerid, COLOR_RED,"No estas en el control");}
 		}
 		return 1;
	}
//------------------------------<[ ADMIN COMMAND ]>-----------------------------------------------------------
//---/haceradmin : Comando para hacer a un jugador administrador y meterlo a la familia de los Vendetta.
	if(strcmp(cmd, "/haceradmin", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USA: /haceradmin [playerid/PartOfName] [level(1-3)]");
				return 1;
			}
			new para1;
			new level;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
			    if(IsPlayerConnected(para1) && !IsPlayerNPC(para1))
			    {
			        if(para1 != INVALID_PLAYER_ID)
                    {
                        if(level >=1 && level <= 3)
                        {
                            GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            PlayerInfo[para1][pAdmin] = level;
                            PlayerInfo[para1][pRank] = level;
                            printf("AdmCmd: %s ha sido ascendido %s al nivel %d de administrador.", sendername, giveplayer, level);
                            format(string, sizeof(string), "Has sido ascendido al nivel %d de administrador por %s", level, sendername);
                            SendClientMessage(para1, COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "%s ha ascendido al nivel %d de administrador.", giveplayer,level);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GRAD2, "USA: /haceradmin [playerid/PartOfName] [level(1-3)]");
                        }
                    }
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Lo sentimos, no estas autorizado a usar este comando.");
			}
		}
		return 1;
	}
//---/admin : Comando para chatear entre los administradores.
	if(strcmp(cmd, "/admin", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USA: (/a)dmin [Texto]");
				return 1;
			}
			new rank[64];
			if(PlayerInfo[playerid][pAdmin] == MOD)
				rank = "Mod";
			if(PlayerInfo[playerid][pAdmin] == GM)
				rank = "GM";
			if(PlayerInfo[playerid][pAdmin] == SA)
				rank = "SA";
			format(string, sizeof(string), "*%s Admin %s: %s", rank, sendername, result);
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
				SendAdminMessage(COLOR_YELLOW, string);
			}
			printf("Admin %s: %s", sendername, result);
		}
		return 1;
	}
//---/global : mensaje en la mitad de la pantalla para todo el mundo.
	if(strcmp(cmd, "/global", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= GM)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessage(playerid, COLOR_GRAD2, "USA: /global [global textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
					return 1;
				}
				format(string, sizeof(string), "~b~%s: ~w~%s",sendername,result);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && !IsPlayerNPC(i))
					{
     					GameTextForPlayer(i, string, 5000, 6);
					}
				}
				return 1;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Lo sentimos, no estas autorizado a usar este comando.");
				return 1;
			}
		}
		return 1;
	}
//---/logoutpl: Comando para guardar los datos de la cuenta de todos los usuarios conectados.
	if (strcmp(cmd, "/logoutpl", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USA: /logoutpl [playerid/PartOfName]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= GM)
			{
			    if(IsPlayerConnected(giveplayerid)&&giveplayerid != INVALID_PLAYER_ID)
			    {
					OnPlayerUpdate(playerid);
					gPlayerLogged[giveplayerid] = 0;
					SendClientMessage(playerid, COLOR_GRAD1, "Los datos fueron guardados");
					SendClientMessage(giveplayerid, COLOR_GRAD1, "Se estan cambiando los datos de tu cuenta, por favor logeate en 2 minutos");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Lo sentimos, no estas autorizado a usar este comando.");
			}
		}
		return 1;
	}
//---/logoutall: Comando para guardar los datos de la cuenta de todos los usuarios conectados.
	if (strcmp(cmd, "/logoutall", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= GM)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && !IsPlayerNPC(i))
					{
						OnPlayerUpdate(i);
						gPlayerLogged[i] = 0;
					}
				}
				SendClientMessage(playerid, COLOR_GRAD1, "Has guardado los datos de los jugadores.");
				for(new i = 0; i < MAX_PLAYERS ; i++)
                {
                    if(playerid != i)
                        SendClientMessage(i, COLOR_GRAD1, "Todos los datos han sido guardados, podeis desconetar del servidor sin peligro.");
                }
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Lo sentimos, no estas autorizado a usar este comando.");
			}
		}
		return 1;
	}
//---/tod: para cambiar la hora del dia en el servidor.
	if(strcmp(cmd, "/tod", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USA: /tod [Horadeldia] (0-23)");
				return 1;
			}
			new hour;
			hour = strval(tmp);
			if(PlayerInfo[playerid][pAdmin] >= GM)
            {
                if(hour >= 0 && hour <= 23 && isNumeric(tmp))
                {

					mySetWorldTime(hour);

	    			format(string, sizeof(string), "La hora a cambiado a las %d Horas.", hour);
                	BroadCast(COLOR_GRAD1, string);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GRAD2, "USA: /tod [Horadeldia] (0-23)");
					return 1;
                }
            }
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Lo sentimos, no estas autorizado a usar este comando.");
			}
		}
		return 1;
	}

//-------------------------------
//-------------------------------
//------------------------------ [comandos prueba megamenu] ----------------------------------
	if(strcmp("/skill", cmd, true) == 0)
	{
 		// If there was a previously created selection menu, destroy it
		DestroySelectionMenu(playerid);

	    SetPVarInt(playerid, "menu_pestanas", PESTANA_SKILL);
		new titulo[50];
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(titulo,sizeof(titulo),"%s - Nivel %d",sendername,PlayerInfo[playerid][pLevel]);
		new skills[NUM_SKILLS];
		for (new i = 0; i < NUM_SKILLS; i++)
		    skills[i] = PlayerInfo[playerid][pSkill][i];
	    CreateSelectionMenuSkill(playerid,titulo, PESTANA_SKILL, skills);
	    return 1;
	}

//-------------------------- [Comandos bandas]----------------------------------------------------------------
	if (strcmp("/nameoff", cmdtext, true) == 0)
	{
		for(new i = 0; i < MAX_PLAYERS; i++) 
			ShowPlayerNameTagForPlayer(playerid, i, false);
		GameTextForPlayer(playerid, "~W~Nametags ~R~off", 5000, 5);
		return 1;
	}

	if(strcmp("/fire", cmd, true) == 0){
		new Float:x, Float:y, Float:z, Float:a;
		GetXYInFrontOfPlayer(playerid, x, y, z, a, 2.5);
		AddFire(x, y, z);
		return 1;
	}
	
	    //-------------------------- [maletero del nacho] -----------------------------------------------

	if (strcmp("/maletero", cmdtext, true, 10) == 0) {
		GetPlayerName(playerid, sendername, sizeof(sendername));//Esto es para que al poner %s aparesca el nombre del usuario al usar el comando
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, -1 ,"Solo el Conductor puede abrir el maletero.");//La funcion de que solo el conductor pueda usar el comando
		new mot, lu, alar, por, cap, porma, ob;
		new carro = GetPlayerVehicleID(playerid);
		if(carro != INVALID_VEHICLE_ID) {
			if(maletero[playerid] == 0) {
				GetVehicleParamsEx(carro, mot, lu, alar, por, cap, porma, ob);
				SetVehicleParamsEx(carro, mot, lu, alar, por, cap, VEHICLE_PARAMS_ON, ob);
				maletero[playerid] = 1;
				maletero2[playerid]=GetPlayerVehicleID(playerid);
				format(string, sizeof(string), "%s abre el maletero.", sendername, sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				format(string, sizeof(string), "{00ABFF} %s (( maletero abierto ))", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			} else {
				SendClientMessage(playerid, COLOR_GRAD2, "Ya hay uno abierto");
			}

		}
		return 1;
	}

	if (strcmp("/cmaletero", cmdtext, true, 10) == 0) {
		GetPlayerName(playerid, sendername, sizeof(sendername));//Esto es para que al poner %s aparesca el nombre del usuario al usar el comando
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendClientMessage(playerid, -1 ,"Solo el Conductor puede cerrar el maletero.");//La funcion de que solo el conductor pueda usar el comando
		new mot, lu, alar, por, cap, porma, ob;
		new carro = GetPlayerVehicleID(playerid);
		if(carro != INVALID_VEHICLE_ID) {
			if(maletero[playerid] == 1) {
				GetVehicleParamsEx(carro, mot, lu, alar, por, cap, porma, ob);
				SetVehicleParamsEx(carro, mot, lu, alar, por, cap, VEHICLE_PARAMS_OFF, ob);
				maletero[playerid] = 0;
				format(string, sizeof(string), "%s cierra el maletero.", sendername, sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				format(string, sizeof(string), "{00ABFF} %s (( maletero cerrado ))", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		return 1;
	}
	if (strcmp("/mascara", cmdtext, true) == 0) {
		new Float:Xx=0,Float:Yy=0,Float:Zz=0;
		new Float:Xxx=500,Float:Yyy=500,Float:Zzz=500;

	    GetPlayerPos(playerid, Xx,Yy,Zz);
    	for(new i=0;i<MAX_PLAYERS;i++) {
		    if(maletero[i] == 1) {
			    new Rr=maletero2[i];
			    new Float:angle;
				GetVehicleZAngle(Rr,angle);

			    GetVehiclePos(Rr,Xxx,Yyy,Zzz);

			    if((angle>=0 || angle<=90) && ( GetDistanceBetweenPoints(Xx,Yy,Zz,Xxx+2.2,Yyy-0.5,Zzz) < 2.5))

//     if( GetDistanceBetweenPoints(Xx,Yy,Zz,Xxx+1,Yyy-1,Zzz) < 1)
				{
					SetPlayerAttachedObject(playerid, 3,19472 ,2, 0.01600, 0.148001, 0, 90.110733, 81.638343, 4.973568, 0.887882, 1.139873, 1.000000);// mascara
					SendClientMessage(playerid, COLOR_GRAD2, "Te pones una mascara de gas");

//format(string, sizeof(string), "%f Angulo Coche ", angle);
//printf("%s", string);
//SendClientMessage(playerid, COLOR_PURPURA ,string);

				}
			}
		}
		return 1;

	}
	if(strcmp(cmd, "/tienda", true) == 0) {
		SetPVarInt(playerid, "menu_tiendas", 1);
        CreateTiendaSelectionMenu(playerid, 0);
		return 1;
	}
	
	if(strcmp(cmd, "/bolsa", true) == 0) {
	    for (new i = 0; i < 10; i++)
			SetPlayerAttachedObject(playerid, i, 1265, i);
		return 1;
	}
	
	if(strcmp(cmd, "/meteritem", true) == 0) {
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GRAD1, "USO: /item modelid");
			return 1;
		}
		if (!insertarItem(playerid, strval(tmp)))
		    SendClientMessage(playerid, COLOR_GRAD1, "No funcó");
		return 1;
	}
	
	if(strcmp(cmd, "/quitaritem", true) == 0) {
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GRAD1, "USO: /item modelid");
			return 1;
		}
		borrarItem(playerid, strval(tmp));
		return 1;
	}
	
	
	if(strcmp(cmd, "/vehpuerta", true) == 0) {
	
	    for (new i = 0; i < MAX_PLAYER_CAR_KEYS; i++) {
	        new index;
	        new llave = PlayerInfo[playerid][pCarKeys][i];
	        if (isKeyCopy(llave))
	            llave = llave / 10;
	        if (llave > 0 && searchKey(llave, index)){
				new _veh = car[index][vehid];
				if (DistanciaCoche(3.0, playerid, _veh)) {
				    if (car[index][vehdoors] == 0) {
					    SendClientMessage(playerid, COLOR_RED, "Puertas cerradas");
					    car[index][vehdoors] = 1;
				    } else {
						SendClientMessage(playerid, COLOR_RED, "Puertas abiertas");
					    car[index][vehdoors] = 0;
				    }
    				new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(_veh, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(_veh, engine, lights, alarm, car[index][vehdoors], bonnet, boot, objective);
				    return 1;
				}
	        }
	    }
	    SendClientMessage(playerid, COLOR_RED, "Ningún coche propio cerca");
	    return 1;
	}
	if(strcmp(cmd, "/vehllave", true) == 0) {
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GRAD1, "USO: /vehllave modelid");
			return 1;
		}
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid,x,y,z);
		GetXYInFrontOfPoint(x,y,z,2.0);
		new Float:ang;
		GetPlayerFacingAngle(playerid,ang);
		new llave = CreatePropCar(strval(tmp),x,y,z,ang-90.0,random(126),random(126));
		if (giveKeys(playerid, llave)) {
			format(string,sizeof(string),"LLave: %d",llave);
			SendClientMessage(playerid, COLOR_GREEN, string);
			saveVeh();
		} else {
		    DestroyPropCarByKey(llave);
		}
		return 1;
		
	}
	
	if(strcmp(cmd, "/destruirllave", true) == 0) {
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
			SendClientMessage(playerid, COLOR_GRAD1, "USO: /destruirllave llave");
			return 1;
		}
		DestroyPropCarByKey(strval(tmp));
		saveVeh();
		return 1;

	}
	
	if(strcmp(cmd, "/banda", true) == 0) {
	    if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)) {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda ayuda");
				return 1;
			}
			if(strcmp(tmp, "crear", true) == 0) {                                                         //CREAR BANDA
			    if (indiceBandas == MAX_BANDAS) {
					SendClientMessage(playerid, COLOR_GRAD1, "Máximo número de bandas alcanzado, avisa a un admin");
					return 1;
				}                                                                                       
			    if (PlayerInfo[playerid][pBanda] > 0) {
    	    		SendClientMessage(playerid, COLOR_GRAD1, "Ya estás en una banda.. (/banda ayuda)");
					return 1;
	    	    }
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda crear [nombre sin espacios]");
					return 1;
				}
				new dinero_jugador = GetPlayerMoney(playerid);
				if (dinero_jugador < PRECIO_CREAR_BANDA) {
					format(string,sizeof(string),"No tienes suficiente dinero como para crear una banda %d",PRECIO_CREAR_BANDA);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					return 1;
				}
				
				new auxn[MAX_PLAYER_NAME];
				strmid(Bandas[indiceBandas][bNombre], tmp, 0, strlen(tmp), 255);
				
				for( new i = 1; i < indiceBandas; i++) {
				    if ((strcmp(Bandas[i][bNombre], Bandas[indiceBandas][bNombre], true) == 0) && Bandas[i][bNivel] > -1) {
					    SendClientMessage(playerid, COLOR_RED, "Ese nombre ya está registrado");
					    return 1;
					}
   			    }
   			    GivePlayerMoney(playerid,-PRECIO_CREAR_BANDA);
		    	GetPlayerName(playerid,auxn,sizeof(auxn));
	    		strmid(Bandas[indiceBandas][bLider], auxn, 0, strlen(auxn), 255);
				Bandas[indiceBandas][bNivel] = 1;
				Bandas[indiceBandas][bDinero] = 0;
				PlayerInfo[playerid][pBanda] = indiceBandas;
				Bandas[indiceBandas][bMiembros] = 1;
				Bandas[indiceBandas][bPisoFranco] = -1;
				Bandas[indiceBandas][bTiempoAlquiler] = 0;
				indiceBandas++;
				saveBandas();
				SendClientMessage(playerid, COLOR_GREEN, "Banda registrada correctamente /banda ayuda para más info");
				return 1;
			} else if(PlayerInfo[playerid][pBanda] > 0 && strcmp(tmp, "borrar", true) == 0) {            //BORRAR BANDA
				new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
			    	Bandas[PlayerInfo[playerid][pBanda]][bNivel] = -1;
			    	Bandas[PlayerInfo[playerid][pBanda]][bMiembros]--;
			    	Bandas[PlayerInfo[playerid][pBanda]][bTiempoAlquiler] = 0;
			    	saveBandas();
			    	PlayerInfo[playerid][pBanda] = 0;
		    		SendClientMessage(playerid, COLOR_GREEN, "Tu banda ha sido eliminada");
		    		HideProgressBarForPlayer(playerid, satisBar[playerid]);
		    	}
		    	return 1;
			} else if(PlayerInfo[playerid][pBanda] > 0 && strcmp(tmp, "salir", true) == 0) {                //SALIR BANDA
				new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
				if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) != 0) { //si no es lider
					PlayerInfo[playerid][pBanda] = 0;
			    	Bandas[PlayerInfo[playerid][pBanda]][bMiembros]--;
			    	SendClientMessage(playerid, COLOR_GREEN, "Has salido de la banda con éxito");
			    	HideProgressBarForPlayer(playerid, satisBar[playerid]);
		    	}
		    	return 1;
			} else if(PlayerInfo[playerid][pBanda] > 0 && strcmp(tmp, "echar", true) == 0) {             //ECHAR A ALGUIEN DE LA BANDA
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda echar id");
					return 1;
				}
			    if (playerid != strval(tmp)) {  //que no sea él mismo
					new auxn[MAX_PLAYER_NAME];
					GetPlayerName(playerid,auxn,sizeof(auxn));
				    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
				        if (PlayerInfo[strval(tmp)][pBanda] == PlayerInfo[playerid][pBanda]) { //si pertenecen a la misma banda
				    		PlayerInfo[strval(tmp)][pBanda] = 0;
   					    	Bandas[PlayerInfo[playerid][pBanda]][bMiembros]--;
			    			SendClientMessage(strval(tmp), COLOR_RED, "Te han echado de la banda, dale las gracias a tu líder, bueno, ex-líder.");
			    			SendClientMessage(playerid, COLOR_GREEN, "A la mierda con ese, total, no hacía nada útil.");
			    			HideProgressBarForPlayer(strval(tmp), satisBar[strval(tmp)]);
						} else {
							SendClientMessage(playerid, COLOR_RED, "No está en tu banda, comprueba el id");
						}
			    	}
    			} else {
    				SendClientMessage(playerid, COLOR_RED, "Que cachondo..");
    			}
		    	return 1;
			} else if(PlayerInfo[playerid][pBanda] > 0 && strcmp(tmp, "invitar", true) == 0) {                 //INVITAR A LA BANDA
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda invitar id");
					return 1;
				}
			    if (playerid != strval(tmp)) {  //que no sea él mismo
					new auxn[MAX_PLAYER_NAME];
					GetPlayerName(playerid,auxn,sizeof(auxn));
				    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
				        if (PlayerInfo[strval(tmp)][pBanda] == 0) { //si no está en ninguna banda
				            format(string,sizeof(string),"Te han invitado a entrar a la banda %s dirigida por %s",Bandas[PlayerInfo[playerid][pBanda]][bNombre],auxn);
			    			SendClientMessage(strval(tmp), COLOR_GREEN, string);
			    			SendClientMessage(strval(tmp), COLOR_GREEN, "Si quieres entrar, escribe /banda aceptar, tienes 20 segundos desde ya!");
			    			SendClientMessage(playerid, COLOR_GREEN, "Invitado está, a ver que dice..");
			    			responde[strval(tmp)][id_lider] = playerid;
			    			responde[strval(tmp)][rTiempo] = 20;
						} else {
							SendClientMessage(playerid, COLOR_RED, "Ya tiene banda este tio");
						}
			    	}
    			} else {
    				SendClientMessage(playerid, COLOR_RED, "Que cachondo..");
    			}
		    	return 1;
			} else if(strcmp(tmp, "aceptar", true) == 0) {                                             //ACEPTAR LA INVITACION
			    if (responde[playerid][rTiempo] > 0) {
			        PlayerInfo[playerid][pBanda] = PlayerInfo[responde[playerid][id_lider]][pBanda];
			    	Bandas[PlayerInfo[playerid][pBanda]][bMiembros]++;
				    new auxn[MAX_PLAYER_NAME];
					GetPlayerName(playerid,auxn,sizeof(auxn));
		 			format(string,sizeof(string),"%s ha aceptado la invitación",auxn);
			    	SendClientMessage(responde[playerid][id_lider], COLOR_GREEN, string);
		    		SendClientMessage(playerid, COLOR_GREEN, "Bienvenido a la banda");
		    		responde[playerid][rTiempo] = 0;
			    }
				return 1;
			} else if(strcmp(tmp, "online", true) == 0) {                                             //VER MIEMBROS ONLINE
				new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider

				    SendClientMessage(playerid, COLOR_GRAD1, "Miembros online: ");
				    for (new i = 0; i < MAX_PLAYERS; i++) {
				        if (IsPlayerConnected(i) && PlayerInfo[playerid][pBanda] == PlayerInfo[i][pBanda]) {
							GetPlayerName(i,auxn,sizeof(auxn));
							format(string,sizeof(string),"(%d) %s",GetPlayerByName(auxn),auxn);
							SendClientMessage(playerid, COLOR_GRAD1, auxn);
						}
			    	}
				}
				return 1;
	 		} else if(strcmp(tmp, "info", true) == 0) {                                              //MUESTRA INFORMACION DE LA BANDA
	 		    if (PlayerInfo[playerid][pBanda] > 0) {
		 		    format(string,sizeof(string),"** Información de la banda %s",Bandas[PlayerInfo[playerid][pBanda]][bNombre]);
		 			SendClientMessage(playerid, COLOR_GRAD1, string);
		 		    format(string,sizeof(string),"Miembros: %d",Bandas[PlayerInfo[playerid][pBanda]][bMiembros]);
		 			SendClientMessage(playerid, COLOR_GRAD1, string);
		 		    format(string,sizeof(string),"Nivel: %d",Bandas[PlayerInfo[playerid][pBanda]][bNivel]);
		 			SendClientMessage(playerid, COLOR_GRAD1, string);
		 		    format(string,sizeof(string),"Dinero: %d",Bandas[PlayerInfo[playerid][pBanda]][bDinero]);
		 			SendClientMessage(playerid, COLOR_GRAD1, string);
				}
	 			return 1;
	 		} else if(strcmp(tmp, "lider", true) == 0) {                                              //CAMBIAR DE LIDER
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda lider id");
					return 1;
				}
			    if (playerid != strval(tmp)) {  //que no sea él mismo
					new auxn[MAX_PLAYER_NAME];
					GetPlayerName(playerid,auxn,sizeof(auxn));
				    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
				        if (PlayerInfo[strval(tmp)][pBanda] == PlayerInfo[playerid][pBanda]) { //si están en la misma banda
					        GetPlayerName(strval(tmp),auxn,sizeof(auxn));
				    		strmid(Bandas[indiceBandas][bLider], auxn, 0, strlen(auxn), 255);
				            format(string,sizeof(string),"%s es ahora el lider de %s",auxn,Bandas[PlayerInfo[playerid][pBanda]][bNombre]);
			    			SendClientMessage(playerid, COLOR_GREEN, string);
			    			SendClientMessage(strval(tmp), COLOR_GREEN, "Ahora eres el lider de la banda");
						} else {
							SendClientMessage(playerid, COLOR_RED, "No está en tu banda");
						}
			    	}
    			} else {
    				SendClientMessage(playerid, COLOR_RED, "Que cachondo..");
    			}
	 			return 1;
	 		} else if(strcmp(tmp, "AlquilarPiso", true) == 0) {                                               //ALQUILAR PISO FRANCO
	 			new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
 	 			if (alquilando[playerid][aTiempo] > 0 && (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) ) {
 			        if (Bandas[PlayerInfo[playerid][pBanda]][bDinero] < PisosFrancos[alquilando[playerid][aPisoFranco]][pfPrecioAlquiler]) {
 	 			        SendClientMessage(playerid, COLOR_RED, "Lo sentimos, pero tu banda no tiene el dinero necesario para poder alquilar este piso franco");
      	 			    return 1;
 			        }
 			        Bandas[PlayerInfo[playerid][pBanda]][bPisoFranco] = alquilando[playerid][aPisoFranco];
 			        Bandas[PlayerInfo[playerid][pBanda]][bDinero] -= PisosFrancos[alquilando[playerid][aPisoFranco]][pfPrecioAlquiler];
 			        Bandas[PlayerInfo[playerid][pBanda]][bTiempoAlquiler] = SEMANA_EN_SEG;
				    SendClientMessage(playerid, COLOR_GREEN, "Piso alquilado por una semana, usa /banda info para más información");
 	 			} else {
 	 			    SendClientMessage(playerid, COLOR_RED, "No estás donde debes estar");
 	 			}
 	 			return 1;
			} else if(strcmp(tmp, "coche", true) == 0) {                                               //RELACIONADO CON COCHE
				new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp)) {
						SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda coche [comprar|setSpawn]");
						return 1;
					}
					if(strcmp(tmp, "comprar", true) == 0) {                                            //COMPRAR UN COCHE
					    if (Bandas[PlayerInfo[playerid][pBanda]][bPisoFranco] == -1) {
						    SendClientMessage(playerid, COLOR_RED, "No puedes comprar coches si no tienes un piso franco para la banda");
					        return 1;
					    }
					    if (Bandas[PlayerInfo[playerid][pBanda]][bNivel] == 1 && Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 1) {
					   	 	SendClientMessage(playerid, COLOR_RED, "A nivel uno de banda solo se puede tener un coche");
					        return 1;
					    }
					    if (Bandas[PlayerInfo[playerid][pBanda]][bNivel] == 2 && Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 2) {
					   	 	SendClientMessage(playerid, COLOR_RED, "A nivel dos de banda solo se puede tener dos coches");
					        return 1;
					    }
					    if (Bandas[PlayerInfo[playerid][pBanda]][bNivel] == 3 && Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 3) {
					   	 	SendClientMessage(playerid, COLOR_RED, "A nivel tres de banda solo se puede tener tres coches");
					        return 1;
					    }
					    if (Bandas[PlayerInfo[playerid][pBanda]][bNivel] == 4 && Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 4) {
					   	 	SendClientMessage(playerid, COLOR_RED, "A nivel cuatro de banda solo se puede tener cuatro coches");
					        return 1;
					    }

						tmp = strtok(cmdtext, idx);
						if(!strlen(tmp)) {
							SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda coche comprar color1 color2");
							return 1;
						}
					    new color1 = strval(tmp);
					    tmp = strtok(cmdtext, idx);
						if(!strlen(tmp)) {
							SendClientMessage(playerid, COLOR_GRAD1, "USO: /banda coche comprar color1 color2");
							return 1;
						}
					    new color2 = strval(tmp);

					    if (Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 0) {
					        //falta el tipo, angle y spawn cuando haga el /spawn
					        Bandas[PlayerInfo[playerid][pBanda]][bCoche1][cTipo] = 411;   //tipo del coche
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche1][cColor][0] = color1;
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche1][cColor][1] = color2;
							Bandas[PlayerInfo[playerid][pBanda]][bNumCoches]++;
							BandaCocheFirstSpawn[playerid] = 1;
						    SendClientMessage(playerid,COLOR_GREEN,"Bien! Has comprado un coche para la banda (falta cobrar a la banda)");
						    SendClientMessage(playerid,COLOR_GREEN,"Usa /banda coche setSpawn cerca de tu base para que aparezca en la posición en la que estés.");
						} else if (Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 1) {
					        //falta el tipo, angle y spawn cuando haga el /spawn
					        Bandas[PlayerInfo[playerid][pBanda]][bCoche2][cTipo] = 411;   //tipo del coche
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche2][cColor][0] = color1;
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche2][cColor][1] = color2;
							Bandas[PlayerInfo[playerid][pBanda]][bNumCoches]++;
							BandaCocheFirstSpawn[playerid] = 2;
						    SendClientMessage(playerid,COLOR_GREEN,"Bien! Has comprado un coche para la banda (falta cobrar a la banda)");
						    SendClientMessage(playerid,COLOR_GREEN,"Usa /banda coche setSpawn cerca de tu base para que aparezca en la posición en la que estés.");
						} else if (Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 2) {
					        //falta el tipo, angle y spawn cuando haga el /spawn
					        Bandas[PlayerInfo[playerid][pBanda]][bCoche3][cTipo] = 411;   //tipo del coche
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche3][cColor][0] = color1;
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche3][cColor][1] = color2;
							Bandas[PlayerInfo[playerid][pBanda]][bNumCoches]++;
    						BandaCocheFirstSpawn[playerid] = 3;
						    SendClientMessage(playerid,COLOR_GREEN,"Bien! Has comprado un coche para la banda ");
						    SendClientMessage(playerid,COLOR_GREEN,"Usa /banda coche setSpawn cerca de tu base para que aparezca en la posición en la que estés.");
						} else if (Bandas[PlayerInfo[playerid][pBanda]][bNumCoches] == 3) {
					        //falta el tipo, angle y spawn cuando haga el /spawn
   						    Bandas[PlayerInfo[playerid][pBanda]][bCoche4][cTipo] = 411;   //tipo del coche
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche4][cColor][0] = color1;
						    Bandas[PlayerInfo[playerid][pBanda]][bCoche4][cColor][1] = color2;
							Bandas[PlayerInfo[playerid][pBanda]][bNumCoches]++;
							BandaCocheFirstSpawn[playerid] = 4;
						    SendClientMessage(playerid,COLOR_GREEN,"Bien! Has comprado un coche para la banda");
						    SendClientMessage(playerid,COLOR_GREEN,"Usa /banda coche setSpawn cerca de tu base para que aparezca en la posición en la que estés.");
						}
						return 1;
					} else if(strcmp(tmp, "setSpawn", true) == 0) {                    //COLOCAR SPAWN COCHE
						if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
							new Float:pfX,Float:pfY,Float:pfZ;
							new Float:plX,Float:plY,Float:plZ,Float:plAng;
							new idBanda = PlayerInfo[playerid][pBanda];
							pfX = PisosFrancos[Bandas[idBanda][bPisoFranco]][pfEnterPos][0];
							pfY = PisosFrancos[Bandas[idBanda][bPisoFranco]][pfEnterPos][1];
							pfZ = PisosFrancos[Bandas[idBanda][bPisoFranco]][pfEnterPos][2];
						    if (BandaCocheFirstSpawn[playerid] == 1 && PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
	    						GetPlayerPos(playerid,plX,plY,plZ);
						        GetPlayerFacingAngle(playerid,plAng);
						        new tipo = Bandas[PlayerInfo[playerid][pBanda]][bCoche1][cTipo];
						        new color1 = Bandas[idBanda][bCoche1][cColor][0];
						        new color2 = Bandas[idBanda][bCoche1][cColor][1];
						        Bandas[idBanda][bCoche1][cId] = CreateVehicle(tipo, plX,plY,plZ, plAng, color1, color2, 60000);
						        Bandas[idBanda][bCoche1][cSpawn][0] = plX;
						        Bandas[idBanda][bCoche1][cSpawn][1] = plY;
						        Bandas[idBanda][bCoche1][cSpawn][2] = plZ;
						        Bandas[idBanda][bCoche1][cAngle] = plAng;
						        BandaCocheFirstSpawn[playerid] = 0;
						        SendClientMessage(playerid,COLOR_GRAD1,"Para cambiar el coche de spawn, subete y /banda coche setSpawn");
						    } else  if (BandaCocheFirstSpawn[playerid] == 2 && PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
	    						GetPlayerPos(playerid,plX,plY,plZ);
						        GetPlayerFacingAngle(playerid,plAng);
						        new tipo = Bandas[PlayerInfo[playerid][pBanda]][bCoche2][cTipo];
						        new color1 = Bandas[idBanda][bCoche2][cColor][0];
						        new color2 = Bandas[idBanda][bCoche2][cColor][1];
						        Bandas[idBanda][bCoche2][cId] = CreateVehicle(tipo, plX,plY,plZ, plAng, color1, color2, 60000);
						        Bandas[idBanda][bCoche2][cSpawn][0] = plX;
						        Bandas[idBanda][bCoche2][cSpawn][1] = plY;
						        Bandas[idBanda][bCoche2][cSpawn][2] = plZ;
						        Bandas[idBanda][bCoche2][cAngle] = plAng;
						        BandaCocheFirstSpawn[playerid] = 0;
						        SendClientMessage(playerid,COLOR_GRAD1,"Para cambiar el coche de spawn, subete y /banda coche setSpawn");
						    } else  if (BandaCocheFirstSpawn[playerid] == 3 && PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
	    						GetPlayerPos(playerid,plX,plY,plZ);
						        GetPlayerFacingAngle(playerid,plAng);
						        new tipo = Bandas[PlayerInfo[playerid][pBanda]][bCoche3][cTipo];
						        new color1 = Bandas[idBanda][bCoche3][cColor][0];
						        new color2 = Bandas[idBanda][bCoche3][cColor][1];
						        Bandas[idBanda][bCoche3][cId] = CreateVehicle(tipo, plX,plY,plZ, plAng, color1, color2, 60000);
						        Bandas[idBanda][bCoche3][cSpawn][0] = plX;
						        Bandas[idBanda][bCoche3][cSpawn][1] = plY;
						        Bandas[idBanda][bCoche3][cSpawn][2] = plZ;
						        Bandas[idBanda][bCoche3][cAngle] = plAng;
						        BandaCocheFirstSpawn[playerid] = 0;
						        SendClientMessage(playerid,COLOR_GRAD1,"Para cambiar el coche de spawn, subete y /banda coche setSpawn");
						    } else  if (BandaCocheFirstSpawn[playerid] == 4 && PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
	    						GetPlayerPos(playerid,plX,plY,plZ);
						        GetPlayerFacingAngle(playerid,plAng);
						        new tipo = Bandas[PlayerInfo[playerid][pBanda]][bCoche4][cTipo];
						        new color1 = Bandas[idBanda][bCoche4][cColor][0];
						        new color2 = Bandas[idBanda][bCoche4][cColor][1];
						        Bandas[idBanda][bCoche4][cId] = CreateVehicle(tipo, plX,plY,plZ, plAng, color1, color2, 60000);
						        Bandas[idBanda][bCoche4][cSpawn][0] = plX;
						        Bandas[idBanda][bCoche4][cSpawn][1] = plY;
						        Bandas[idBanda][bCoche4][cSpawn][2] = plZ;
						        Bandas[idBanda][bCoche4][cAngle] = plAng;
						        BandaCocheFirstSpawn[playerid] = 0;
						        SendClientMessage(playerid,COLOR_GRAD1,"Para cambiar el coche de spawn, subete, colocalo donde quieras y /banda coche setSpawn");
						    } else{
						        SendClientMessage(playerid,COLOR_GRAD1,"No estás a menos de 30 metros de tu piso franco.");
						    }
							return 1;
						} else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
						    new vehID = GetPlayerVehicleID(playerid);
   							new Float:pfX,Float:pfY,Float:pfZ;
							new Float:vehX,Float:vehY,Float:vehZ,Float:vehAng;
							new idBanda = PlayerInfo[playerid][pBanda];
						    for (new i = 0; i < MAX_BANDAS; i++) {
						    	if (cambiar_spawn_coche[vehID][tbcBanda] == idBanda && cambiar_spawn_coche[vehID][tbcCoche] > 0) {
						    	    SendClientMessage(playerid,COLOR_GREEN,"Ya has realizado un setSpawn, espera a que se haga efectivo.");
						    	    return 1;
		    	    			}
						    }
							pfX = PisosFrancos[Bandas[idBanda][bPisoFranco]][pfEnterPos][0];
							pfY = PisosFrancos[Bandas[idBanda][bPisoFranco]][pfEnterPos][1];
							pfZ = PisosFrancos[Bandas[idBanda][bPisoFranco]][pfEnterPos][2];
						    if (vehID == Bandas[idBanda][bCoche1][cId]) {
						    	GetVehiclePos(vehID,vehX,vehY,vehZ);
						    	GetVehicleZAngle(vehID,vehAng);
						    	if (PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
							    	Bandas[idBanda][bCoche1][cSpawn][0] = vehX;
							        Bandas[idBanda][bCoche1][cSpawn][1] = vehY;
							        Bandas[idBanda][bCoche1][cSpawn][2] = vehZ;
							        Bandas[idBanda][bCoche1][cAngle] = vehAng;
							        saveCochesBandas();
							        cambiar_spawn_coche[vehID][tbcBanda] = idBanda;
							        cambiar_spawn_coche[vehID][tbcCoche] = 1;
							        SendClientMessage(playerid,COLOR_GREEN,"Spawn cambiado con éxito.");
						    	} else {
						    		SendClientMessage(playerid,COLOR_GRAD1,"No estás a menos de 30 metros de tu piso franco.");
						    	}
						    } else if (vehID == Bandas[idBanda][bCoche2][cId]) {
						    	GetVehiclePos(vehID,vehX,vehY,vehZ);
						    	GetVehicleZAngle(vehID,vehAng);
						    	if (PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
							    	Bandas[idBanda][bCoche2][cSpawn][0] = vehX;
							        Bandas[idBanda][bCoche2][cSpawn][1] = vehY;
							        Bandas[idBanda][bCoche2][cSpawn][2] = vehZ;
							        Bandas[idBanda][bCoche2][cAngle] = vehAng;
							        saveCochesBandas();
							        cambiar_spawn_coche[vehID][tbcBanda] = idBanda;
							        cambiar_spawn_coche[vehID][tbcCoche] = 1;
							        SendClientMessage(playerid,COLOR_GREEN,"Spawn cambiado con éxito.");
						    	} else {
						    		SendClientMessage(playerid,COLOR_GRAD1,"No estás a menos de 30 metros de tu piso franco.");
						    	}
						    } else if (vehID == Bandas[idBanda][bCoche3][cId]) {
						    	GetVehiclePos(vehID,vehX,vehY,vehZ);
						    	GetVehicleZAngle(vehID,vehAng);
						    	if (PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
							    	Bandas[idBanda][bCoche3][cSpawn][0] = vehX;
							        Bandas[idBanda][bCoche3][cSpawn][1] = vehY;
							        Bandas[idBanda][bCoche3][cSpawn][2] = vehZ;
							        Bandas[idBanda][bCoche3][cAngle] = vehAng;
							        saveCochesBandas();
							        cambiar_spawn_coche[vehID][tbcBanda] = idBanda;
							        cambiar_spawn_coche[vehID][tbcCoche] = 1;
							        SendClientMessage(playerid,COLOR_GREEN,"Spawn cambiado con éxito.");
						    	} else {
						    		SendClientMessage(playerid,COLOR_GRAD1,"No estás a menos de 30 metros de tu piso franco.");
						    	}
						    } else if (vehID == Bandas[idBanda][bCoche4][cId]) {
						    	GetVehiclePos(vehID,vehX,vehY,vehZ);
						    	GetVehicleZAngle(vehID,vehAng);
						    	if (PlayerToPoint(30.0,playerid, pfX, pfY, pfZ)) {
							    	Bandas[idBanda][bCoche4][cSpawn][0] = vehX;
							        Bandas[idBanda][bCoche4][cSpawn][1] = vehY;
							        Bandas[idBanda][bCoche4][cSpawn][2] = vehZ;
							        Bandas[idBanda][bCoche4][cAngle] = vehAng;
							        saveCochesBandas();
							        cambiar_spawn_coche[vehID][tbcBanda] = idBanda;
							        cambiar_spawn_coche[vehID][tbcCoche] = 1;
							        SendClientMessage(playerid,COLOR_GREEN,"Spawn cambiado con éxito.");
						    	} else {
						    		SendClientMessage(playerid,COLOR_GRAD1,"No estás a menos de 30 metros de tu piso franco.");
						    	}
						    }
						    return 1;
						}
					} else {
					    SendClientMessage(playerid,COLOR_GRAD1,"USO: /banda coche [comprar|setSpawn]");
					}

				}
 	 			return 1;
			} else if(strcmp(tmp, "ayuda", true) == 0) {
 	 			SendClientMessage(playerid, COLOR_GRAD1, "** Comandos lider banda");
	  			SendClientMessage(playerid, COLOR_GRAD1, "/banda invitar id --------------> Invita al jugador id a entrar a la banda.");
 				SendClientMessage(playerid, COLOR_GRAD1, "/banda echar id ----------------> Echa al jugador id de la banda.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda borrar ------------------> Elimina sin preguntar, así que cuidadín.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda online ------------------> Muestra los miembros de la banda conectados.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda lider id ----------------> Cambia lider de la banda.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda coche comprar -----------> Comprar coche para la banda");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda coche setSpawn ----------> Colocar spawn del coche (solo una vez después de comprarlo)");
				SendClientMessage(playerid, COLOR_GRAD1, "** Comandos miembro banda");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda salir -------------------> Salir de la banda, sin preguntar.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda info --------------------> Muestra menú stats.");
			//	SendClientMessage(playerid, COLOR_GRAD1, "/banda ingresar cantidad -------> Ingresa cantidad de dinero limpio en las cuentas de la banda.");
				SendClientMessage(playerid, COLOR_GRAD1, "** Otros");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda crear nombreSinEspacios -> Crea una banda cobrando lo correspondiente ** IMPORTANTE ** NOMBRE SIN ESPACIOS.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda aceptar -----------------> Aceptar invitación recibida anteriormente por el líder.");
				SendClientMessage(playerid, COLOR_GRAD1, "/banda AlquilarPiso ------------> Para alquilar el piso, es necesario estar en la entrada a un piso franco.");
			}
		}
		return 1;
	}

//-------------------------------
	if(strcmp("/bandana", cmdtext, true, 10) == 0) {
    	if(ConBandana[playerid] == 0) {
		// Sureños
        	new SkinA = GetPlayerSkin(playerid);
	        ConBandana[playerid] = 1;
			if(SkinA == 115) SetPlayerAttachedObject(playerid, SlotObjeto,18917, 2, 0.075032, 0.039259, -0.009051, 272.667022, 0.000000, 268.155487); // Mask7 - skinsur115
			else if(SkinA == 114) SetPlayerAttachedObject(playerid, SlotObjeto,18917, 2, 0.075032, 0.039259, -0.009051, 272.667022, 0.000000, 268.155487); // Mask7 - skinsur114
			else if(SkinA == 116) SetPlayerAttachedObject(playerid, SlotObjeto,18917, 2, 0.075032, 0.039259, -0.009051, 272.667022, 0.000000, 268.155487); // Mask7 - skinsur116
			else if(SkinA == 173) SetPlayerAttachedObject(playerid, SlotObjeto,18917, 2, 0.073774, 0.042118, -0.003368, 273.422515, 0.243100, 267.547058); // Mask7 - skinsur116
			else if(SkinA == 174) SetPlayerAttachedObject(playerid, SlotObjeto,18917, 2, 0.073774, 0.042118, -0.003368, 273.422515, 0.243100, 267.547058); // Mask7 - skinsur116
			else if(SkinA == 175) SetPlayerAttachedObject(playerid, SlotObjeto,18917, 2, 0.073774, 0.042118, -0.003368, 273.422515, 0.243100, 267.547058); // Mask7 - skinsur116
		    //groves
	        else if(SkinA == 271) SetPlayerAttachedObject(playerid, SlotObjeto,18913, 2, 0.073522, 0.015061, -0.005912, 277.060668, 9.697027, 264.330200); // Mask3 - saveskinryder
			else if(SkinA == 270) SetPlayerAttachedObject(playerid, SlotObjeto,18913, 2, 0.083064, 0.015061, 0.003734, 270.357788, 2.187248, 264.330200); // Mask3 - 270sweet
			else if(SkinA == 269) SetPlayerAttachedObject(playerid, SlotObjeto,18913, 2, 0.083064, 0.017489, 0.002312, 270.357788, 2.187248, 266.944274); // Mask3 - smoke269
			else if(SkinA == 105) SetPlayerAttachedObject(playerid, SlotObjeto,18913, 2, 0.078534, 0.041857, -0.001727, 268.970458, 1.533374, 269.223754); // Mask3 - tapadoskin 105 grove
			else if(SkinA == 106) SetPlayerAttachedObject(playerid, SlotObjeto,18913, 2, 0.084321, 0.032509, -0.006748, 268.970458, 1.533374, 269.223754); // Mask3 - skin 106grove
			else if(SkinA == 107) SetPlayerAttachedObject(playerid, SlotObjeto,18913, 2, 0.084321, 0.035590, -0.004405, 268.970458, 1.533374, 269.223754); // Mask3 - skin 107grove
			//Latinos
	        else if(SkinA == 108) SetPlayerAttachedObject(playerid, SlotObjeto,18916, 2, 0.084809, 0.026987, 0.000924, 273.545745, 0.572601, 264.837554 ); // Mask6 - skinvago108
			else if(SkinA == 109) SetPlayerAttachedObject(playerid, SlotObjeto,18916, 2, 0.081629, 0.035036, -0.006385, 273.545745, 0.572601, 264.837554 ); // Mask6 - skinvago 109
			else if(SkinA == 110) SetPlayerAttachedObject(playerid, SlotObjeto,18916, 2, 0.073774, 0.042118, -0.003368, 273.422515, 0.243100, 267.547058 ); // Mask6 - skinvago110
			//Ballas
			else if(SkinA == 102) SetPlayerAttachedObject(playerid, SlotObjeto,18915, 2, 0.076758, 0.034728, -0.001697, 267.582092, 359.936279, 265.333801 ); // Mask5 - skin102balla
			else if(SkinA == 103) SetPlayerAttachedObject(playerid, SlotObjeto,18915, 2, 0.076758, 0.042026, 0.000579, 267.582092, 359.936279, 265.333801 ); // Mask5 - 103balla
			else if(SkinA == 104) SetPlayerAttachedObject(playerid, SlotObjeto,18915, 2, 0.076758, 0.042026, 0.000579, 267.582092, 359.936279, 265.333801 ); // Mask5 - skin 104 balla
			else if(SkinA == 293) SetPlayerAttachedObject(playerid, SlotObjeto,18915, 2, 0.079601, 0.019614, -0.006095, 272.025512, 0.136046, 268.165863 ); // Mask5 - oglock
			//Blood
			else if(SkinA == 7) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.086248, 0.036498, -0.004328, 270.304412, 359.126678, 266.091674 ); // Mask2 - blood - 7
			else if(SkinA == 67) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.086248, 0.020672, 0.001285, 270.304412, 359.126678, 266.091674 ); // Mask2 - blood - 67
			else if(SkinA == 180) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.084799, 0.039217, -0.007458, 270.304412, 359.126678, 271.452209 ); // Mask2 - blood- 180
			else if(SkinA == 19) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.081000, 0.026039, -0.004144, 270.304412, 359.126678, 271.452209 ); // Mask2 - blood - 19
			else if(SkinA == 144) SetPlayerAttachedObject(playerid, SlotObjeto,18892, 2, 0.110470, 0.043788, -0.002435, 266.909606, 358.832275, 267.704956 ); // Bandana2 - 144 - blood
			else if(SkinA == 21) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.081000, 0.026039, -0.004144, 270.304412, 359.126678, 271.452209 ); // Mask2 - blood - 19
			else if(SkinA == 25) SetPlayerAttachedObject(playerid, SlotObjeto,18892, 2, 0.110470, 0.043788, -0.002435, 266.909606, 358.832275, 267.704956 ); // Bandana2 - 144 - blood

			    //Moteros
			else if(SkinA == 23) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.082504, 0.038338, -0.005320, 271.407196, 356.295104, 267.907989 ); // Mask2 - skin 100 motero
			else if(SkinA == 247) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.088066, 0.038264, 0.000398, 271.407196, 356.295104, 267.907989 ); // Mask2 - skin 247 - motoquero
			else if(SkinA == 248) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.088066, 0.038264, 0.000398, 271.407196, 356.295104, 267.907989 ); // Mask2 - skin 248 - motoquero
			else if(SkinA == 100) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.088066, 0.038264, 0.000398, 271.407196, 356.295104, 267.907989 ); // Mask2 - skin 248 - motoquero
			else if(SkinA == 33) SetPlayerAttachedObject(playerid, SlotObjeto,18912, 2, 0.041866, 0.015547, -0.001428, 271.371276, 356.919921, 269.937591 ); // Mask2 - skin BIEN 33
			if(IsPlayerAttachedObjectSlotUsed(playerid, SlotObjeto)) ConBandana[playerid] = 1;
			return 1;
		}
		else if(ConBandana[playerid] == 1) {
			ConBandana[playerid] = 0;
		    RemovePlayerAttachedObject(playerid, SlotObjeto);
		    return 1;
		}
	}

//----------------------------- COMANDOs MISION COCHES ---------------------------
    if(strcmp(cmd, "/cogermision", true) == 0)//El lider de la mafia coge la mision de los VTAs
    {
        if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
        {       //COCHES
            if (PlayerToPoint(10, playerid, -1527.96,149.21,3.55)) {
               	new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					if (NPCocupado[MISION_COCHE] == 0 &&
			    		PlayerInfo[playerid][pMisionBanda] == 0 &&
				 		PlayerInfo[playerid][pBanda] > 0
						) {
							SendClientMessage(playerid,COLOR_RED," Empieza mision");
							startMission(MISION_COCHE,playerid);
					} else if (PlayerInfo[playerid][pBanda] != PlayerInfo[mPlayerid[MISION_COCHE][0]][pBanda]) {
							GameTextForPlayer(playerid, "~w~Intentalo mas tarde chico", 3000, 6);
					}
					return 1;
				} else {
		    		GameTextForPlayer(playerid, "~w~Solo lider banda", 3000, 6);
				}
            }
            //----------------------------------
			else if (PlayerToPoint(10, playerid, -2107.4812,-221.7151,35.3203)) {
               	new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					if (NPCocupado[MISION_MECANICO] == 0 &&
			    		PlayerInfo[playerid][pMisionBanda] == 0 &&
				 		PlayerInfo[playerid][pBanda] > 0
						) {
							SendClientMessage(playerid,COLOR_RED," Empieza mision");
							startMission(MISION_MECANICO,playerid);
					} else if (PlayerInfo[playerid][pBanda] != PlayerInfo[mPlayerid[MISION_MECANICO][0]][pBanda]) {
							GameTextForPlayer(playerid, "~w~Intentalo mas tarde chico", 3000, 6);
					}
					return 1;
				} else {
		    		GameTextForPlayer(playerid, "~w~Solo lider banda", 3000, 6);
				}
            }
            else if (PlayerToPoint(10, playerid, -2268.0466,2315.2368,4.8202)) {
               	new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					if (NPCocupado[MISION_INFILTRAR] == 0 &&
			    		PlayerInfo[playerid][pMisionBanda] == 0 &&
				 		PlayerInfo[playerid][pBanda] > 0
						) {
							SendClientMessage(playerid,COLOR_RED," Empieza mision");
							startMission(MISION_INFILTRAR,playerid);
					} else if (PlayerInfo[playerid][pBanda] != PlayerInfo[mPlayerid[MISION_INFILTRAR][0]][pBanda]) {
							GameTextForPlayer(playerid, "~w~Intentalo mas tarde chico", 3000, 6);
					}
					return 1;
				} else {
		    		GameTextForPlayer(playerid, "~w~Solo lider banda", 3000, 6);
				}
            }
			else if (PlayerToPoint(10, playerid, -2251.6724,2323.6042,4.8125)) {
               	new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					if (NPCocupado[MISION_TRANSPORTARDROGA] == 0 &&
			    		PlayerInfo[playerid][pMisionBanda] == 0 &&
				 		PlayerInfo[playerid][pBanda] > 0
						) {
							SendClientMessage(playerid,COLOR_RED," Empieza mision");
							startMission(MISION_TRANSPORTARDROGA,playerid);
							PlayAudioStreamForMission(MISION_TRANSPORTARDROGA, "https://dl.dropbox.com/s/a99ltysi20p4pmr/empezarmision.mp3",-2261.62, 2386.097, 4.98, 10, 1);
							//ShowMissionEscena(MISION_TRANSPORTARDROGA, ESCENA_MISION_TRANSPORTARDROGA);
					} else if (PlayerInfo[playerid][pBanda] != PlayerInfo[mPlayerid[MISION_TRANSPORTARDROGA][0]][pBanda]) {
							GameTextForPlayer(playerid, "~w~Intentalo mas tarde chico", 3000, 6);
					} else {
					    GameTextForPlayer(playerid, "~w~Seguro que estas en una banda?", 3000, 6);
					}
					return 1;
				} else {
		    		GameTextForPlayer(playerid, "~w~Solo lider banda", 3000, 6);
				}
			} else if (PlayerToPoint(10, playerid, -2268.3833,2315.1072,4.8125)) {
               	new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					if (NPCocupado[MISION_DROGA] == 0 &&
			    		PlayerInfo[playerid][pMisionBanda] == 0 &&
				 		PlayerInfo[playerid][pBanda] > 0
						) {
							SendClientMessage(playerid,COLOR_RED," Empieza mision");
							startMission(MISION_DROGA,playerid);
							PlayAudioStreamForMission(MISION_DROGA, "https://dl.dropbox.com/s/a99ltysi20p4pmr/empezarmision.mp3",-2261.62, 2386.097, 4.98, 10, 1);
							ShowMissionEscena(MISION_DROGA, ESCENA_MISION_DROGA);
					} else if (PlayerInfo[playerid][pBanda] != PlayerInfo[mPlayerid[MISION_DROGA][0]][pBanda]) {
							GameTextForPlayer(playerid, "~w~Intentalo mas tarde chico", 3000, 6);
					} else {
					    GameTextForPlayer(playerid, "~w~Seguro que estas en una banda?", 3000, 6);
					}
					return 1;
				} else {
		    		GameTextForPlayer(playerid, "~w~Solo lider banda", 3000, 6);
				}
            } else if (PlayerToPoint(10, playerid, -2506.1765,769.4029,35.1719)) {
               	new auxn[MAX_PLAYER_NAME];
				GetPlayerName(playerid,auxn,sizeof(auxn));
			    if (strcmp(auxn, Bandas[PlayerInfo[playerid][pBanda]][bLider], true) == 0) { //solo si es el lider
					if (NPCocupado[MISION_ARMAS] == 0 &&
			    		PlayerInfo[playerid][pMisionBanda] == 0 &&
				 		PlayerInfo[playerid][pBanda] > 0
						) {
							SendClientMessage(playerid,COLOR_RED," Empieza mision");
							startMission(MISION_ARMAS,playerid);
					} else if (PlayerInfo[playerid][pBanda] != PlayerInfo[mPlayerid[MISION_ARMAS][0]][pBanda]) {
							GameTextForPlayer(playerid, "~w~Intentalo mas tarde chico", 3000, 6);
					}
					return 1;
				} else {
		    		GameTextForPlayer(playerid, "~w~Solo lider banda", 3000, 6);
				}
            } else {
                SendClientMessage(playerid, COLOR_RED, "No puedes iniciar esta mision.");
                return 1;
            }
        }
        return 1;
    }

    if(strcmp(cmd, "/informacion", true) == 0)
    {
        if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
        {
            if(PlayerToPoint(10, playerid, -1527.96,149.21,3.55))//Mision Coches
        	{
        	    ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "La Lista Negra:", "Lider de una mafia\nUsa Comando: /cogermision\nDeberá contratar una banda\nComando:/darmision+ID Da la mision a una banda que este cerca de ti\nEl lider de la banda Usa:/aceptarmision\nTienen 20min para robar 50 coches,coche entregado +2min,coche erroneo -5m\nLa banda Usara:/buscar y les mostrará un coche durante 10segs", "Aceptar", "Cerrar");
        	}
        	else if(PlayerToPoint(10, playerid, -2107.4812,-221.7151,35.3203))//LOS MECANICOS
        	{
        	    ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Conseguir Coche para la Banda:", "Lider de la Banda\nPara conseguir el primer coche de la banda debeis de hacer la primera mision que te manda el lider de los mecanicos\nUsa Comando: /cogermision\nTodos los miembros de la banda que se encuentren en un radio de 10 metros podran ayudar a hacer la misión", "Aceptar", "Cerrar");
        	}
        	else if(PlayerToPoint(10, playerid, -2259.2664,2387.0713,4.9892))//Mision Droga
        	{
        	    ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Transporta la Droga:", "Lider de la Banda\nUsa Comando: /cogermision\nTodos los miembros de la banda que se encuentren en un radio de 10 metros podran ayudar a hacer la misión\nSiempre tiene que estar un miembro conduciendo la lancha\nLa lancha tiene que muy cerca de donde cargas la droga", "Aceptar", "Cerrar");
        	}
        	else if(PlayerToPoint(10, playerid, -2506.1765,769.4029,35.1719))//Mision Armas
        	{
        	    ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Transporta las Armas:", "Lider de la Banda\nUsa Comando: /cogermision\nTodos los miembros de la banda que se encuentren en un radio de 10 metros podran ayudar a hacer la misión", "Aceptar", "Cerrar");
        	}
        	else if(PlayerToPoint(10, playerid, -2251.6724,2323.6042,4.8125))//Mision Droga (Transportar)
        	{
        	    ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Transporta las Armas:", "Miembro de la Banda\nUsa Comando: /cogermision\nTodos los miembros de la banda que se encuentren en un radio de 10 metros podran ayudar a hacer la misión", "Aceptar", "Cerrar");
        	}
        }
        return 1;
    }
    if(strcmp(cmd, "/buscar", true) == 0)//Comandos mision coches tote
    {
        if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
        {
            if(mTimeBuscar[playerid] <= 0 && PlayerInfo[playerid][pMisionBanda] == MISION_COCHE)
			{
   				new Float:coordX; new Float:coordY; new Float:coordZ;
	          	DisablePlayerCheckpoint(playerid);//Quita el checkpoint de entregar coches
                new rand;
                new j = 0;
                while (j < NUM_COCHES_M5) {
					rand = random(MAX_COORDENADAS_MISION);
					if (CocheMision[rand][mDelivered] == 0)
						j = NUM_COCHES_M5;
					j++;
                }
                if (j >= NUM_COCHES_M5) {
                    for(new i = 0 ; i < NUM_COCHES_M5 ; i++)
	                {
    	           	 	if(CocheMision[i][mDelivered] == 0)
        	        	{
							GetVehiclePos(CocheMision[i][mId], coordX, coordY, coordZ);//busca un coche
						}
					}
				} else {
                    GetVehiclePos(CocheMision[rand][mId], coordX, coordY, coordZ);//busca un coche
				}
                SetPlayerCheckpoint(playerid, coordX, coordY, coordZ, 10);//le pone el checkpoint al coche encontrado
	            mTimeBuscar[playerid] = 20;
		    }
            else
            {
                format(string, sizeof(string), "Debes esperar %d segundos para volver a usar este comando.", mTimeBuscar[playerid]);
                SendClientMessage(playerid, COLOR_RED, string);
            }
        }
        return 1;
    }
//-------------------------------[Pay]--------------------------------------------------------------------------
	if(strcmp(cmd, "/pay", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /pay [playerid/PartOfName] [amount]");
				return 1;
			}
			//giveplayerid = strval(tmp);
	        giveplayerid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /pay [playerid/PartOfName] [amount]");
				return 1;
			}
			moneys = strval(tmp);
			if(moneys > 1000 && PlayerInfo[playerid][pLevel] < 3)
			{
				SendClientMessage(playerid, COLOR_GRAD1, "You must be level 3 to pay over 1000");
				return 1;
			}
			if(moneys < 1 || moneys > 99999)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "Dont go below 1, or above 99999 at once.");
			    return 1;
			}
			if (IsPlayerConnected(giveplayerid) && !IsPlayerNPC(playerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(5.0, playerid, giveplayerid))
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						playermoney = GetPlayerMoney(playerid);
						if (moneys > 0 && playermoney >= moneys)
						{
							GivePlayerMoney(playerid, (0 - moneys));
							GivePlayerMoney(giveplayerid, moneys);
							format(string, sizeof(string), "   You have sent %s(player: %d), $%d.", giveplayer,giveplayerid, moneys);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "   You have recieved $%d from %s(player: %d).", moneys, sendername, playerid);
							SendClientMessage(giveplayerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "%s has paid $%d to %s", sendername, moneys, giveplayer);
							PayLog(string);
							if(moneys >= 1000000)
							{
								ABroadCast(COLOR_YELLOW,string,1);
							}
							PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "* %s takes out some cash, and hands it to %s.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						}
						else
						{
							SendClientMessage(playerid, COLOR_GRAD1, "   Invalid transaction amount.");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GRAD1, "   Your too far away.");
					}
				}//invalid id
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/charity", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /charity [amount]");
				return 1;
			}
			moneys = strval(tmp);
			if(moneys < 0)
			{
				SendClientMessage(playerid, COLOR_GRAD1, "That is not enough.");
				return 1;
			}
			if(GetPlayerMoney(playerid) < moneys)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "You don't have that much money.");
				return 1;
			}
			GivePlayerMoney(playerid, -moneys);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s Thank you for you donation of, $%d.",sendername, moneys);
			printf("%s", string);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GRAD1, string);
			PayLog(string);
		}
		return 1;
	}
//-------------------------------[Stats]--------------------------------------------------------------------------
	if (strcmp(cmd, "/stats", true) == 0)
	{
	   
	}

//-------------------------------[Check]--------------------------------------------------------------------------
	if (strcmp(cmd, "/check", true) == 0)
	{

	}
//-------------------------------[BuyLevel]--------------------------------------------------------------------------
//-------------------------------[Login]--------------------------------------------------------------------------
	if (strcmp(cmd, "/login", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        new tmppass[64];
			if(gPlayerLogged[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "SERVER: You are already logged in.");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /login [password]");
				return 1;
			}
			strmid(tmppass, tmp, 0, strlen(cmdtext), 255);
			//Encrypt(tmppass);
			OnPlayerLogin(playerid,tmppass);
		}
		return 1;
	}
	if (strcmp(cmd, "/rumano", true) ==0 )
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_WHITE, "SERVER: You are already logged in.");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s.ini", sendername);
			new File: hFile = fopen(string, io_read);
			if (hFile)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "That Username is already taken, please choose a different one.");
				fclose(hFile);
				return 1;
			}
	        new tmppass[64];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /register [password]");
				return 1;
			}
			strmid(tmppass, tmp, 0, strlen(cmdtext), 255);
			//Encrypt(tmppass);
			OnPlayerRegister(playerid,tmppass);
		}
		return 1;
	}

//----------------------------------[Emote]-----------------------------------------------
	if(strcmp(cmd, "/me", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You havent logged in yet !");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /me [action]");
				return 1;
			}
		    new actiontext[MAX_CHATBUBBLE_LENGTH+1];
	    	format(actiontext,MAX_CHATBUBBLE_LENGTH,"* %s",result);
	       	SetPlayerChatBubble(playerid,actiontext,0xEE66EEFF,30.0,10000);
    		SendClientMessage(playerid,0xEE66EEFF,actiontext);
			format(string, sizeof(string), "* %s %s", sendername, result);
			//ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			printf("%s", string);
		}
		return 1;
	}
//----------------------------------[Local]-----------------------------------------------
	if(strcmp(cmd, "/local", true) == 0 || strcmp(cmd, "/l", true) == 0 || strcmp(cmd, "/say", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You havent logged in yet !");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: (/l)ocal [local chat]");
				return 1;
			}
			format(string, sizeof(string), "%s dice: %s", sendername, result);
			ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			printf("%s", string);
		}
		return 1;
	}
	if(strcmp(cmd, "/b", true) == 0)//local ooc
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You havent logged in yet !");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /b [local ooc chat]");
				return 1;
			}
			format(string, sizeof(string), "%s dice: (( %s ))", sendername, result);
			ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			printf("%s", string);
		}
		return 1;
	}
	if(strcmp(cmd, "/close", true) == 0 || strcmp(cmd, "/c", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You havent logged in yet !");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /(c)lose [close chat text]");
				return 1;
			}
			format(string, sizeof(string), "%s dice: %s", sendername, result);
			ProxDetector(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			printf("%s", string);
		}
		return 1;
	}
//----------------------------------[Shout]-----------------------------------------------
	if(strcmp(cmd, "/gritar", true) == 0 || strcmp(cmd, "/s", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You havent logged in yet !");
	            return 1;
	        }
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: (/s)hout [local chat]");
				return 1;
			}
			format(string, sizeof(string), "%s grita: %s!!", sendername, result);
			ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
			printf("%s", string);
		}
		return 1;
	}
//----------------------------------[offduty]-----------------------------------------------
	if(strcmp(cmd, "/duty", true) == 0) {
	    if ( PlayerInfo[playerid][pTeam] == BOMBEROS) {
			if (OnDuty[playerid] == 0 /*PlayerToPoint(2.0, playerid, -2030.8715,-223.8672,14.5783)*/){
		    	new skinsFIRE[] = {277,278,279};

		        OnDuty[playerid] = 1;
		        SetPlayerHealth(playerid, 100);
	    	    SetPlayerColor(playerid, COLOR_RED);
	        	GivePlayerWeapon(playerid, 42, 99999);
		        SetPlayerSkin(playerid,skinsFIRE[random(3)]);

		        GameTextForPlayer(playerid, "EL DEBER TE LLAMA!", 3500, 6);
		    	return 1;
			} else {
			    OnDuty[playerid] = 0;
			    RemovePlayerWeapon(playerid, 42);
		    	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
		    	return 1;
			}
		} else  if ( PlayerInfo[playerid][pTeam] == POLI) {
		    if (OnDuty[playerid] == 0) {
		        new skinsPOLI[] = {265,266,267,280,281,282,283,284};
		        
		        OnDuty[playerid] = 1;
		        SetPlayerHealth(playerid, 100);
	    	   	SetPlayerSkin(playerid, skinsPOLI[random(8)]);

		        GameTextForPlayer(playerid, "EL DEBER TE LLAMA!", 3500, 6);
				return 1;
		    } else {
		    	OnDuty[playerid] = 0;
		    	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
		    	return 1;
		    }
		}
		return 1;
	}

//----------------------------------[Wisper]-----------------------------------------------
	if(strcmp(cmd, "/wisper", true) == 0 || strcmp(cmd, "/w", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   You havent logged in yet !");
	            return 1;
	        }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: (/w)isper [playerid/PartOfName] [whisper text]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (IsPlayerConnected(giveplayerid) && !IsPlayerNPC(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(HidePM[giveplayerid] > 0)
			        {
			            SendClientMessage(playerid, COLOR_GREY, "   That player is blocking Whispers !");
			            return 1;
			        }
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					if(giveplayerid == playerid)
					{
						format(string, sizeof(string), "* %s mutters somthing.", sendername);
						ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessage(playerid, COLOR_GRAD2, "USAGE: (/w)isper [playerid/PartOfName] [whisper text]");
						return 1;
					}
					format(string, sizeof(string), "%s(ID: %d) whispers: %s", sendername, playerid, (result));
					SendClientMessage(giveplayerid, COLOR_YELLOW, string);
					format(string, sizeof(string), "Wisper sent to %s(ID: %d).", giveplayer, giveplayerid);
					SendClientMessage(playerid,  COLOR_YELLOW, string);
				//	SBizzInfo[2][sbTill] += txtcost / 2;
//					ExtortionSBiz(2, txtcost / 2);
					return 1;
				}
			}
			else
			{
					format(string, sizeof(string), "   %d is not an active player.", giveplayerid);
					SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}

	if(strcmp(cmd, "/fuego", true) == 0)
	{
		CreateObject(18691,-1994.0,36.0,32.0,0.0,0.0,0.0);
		return 1;
	}
	
//----------------------------------[TIME]-----------------------------------------------

	if(strcmp(cmd, "/time", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
		{
		    new mtext[20];
			new year, month,day;
			getdate(year, month, day);
			if(month == 1) { mtext = "January"; }
			else if(month == 2) { mtext = "February"; }
			else if(month == 3) { mtext = "March"; }
			else if(month == 4) { mtext = "April"; }
			else if(month == 5) { mtext = "May"; }
			else if(month == 6) { mtext = "June"; }
			else if(month == 7) { mtext = "Juli"; }
			else if(month == 8) { mtext = "August"; }
			else if(month == 9) { mtext = "September"; }
			else if(month == 10) { mtext = "October"; }
			else if(month == 11) { mtext = "November"; }
			else if(month == 12) { mtext = "December"; }
		    new hour,minuite,second;
			gettime(hour,minuite,second);
			FixHour(hour);
			hour = shifthour;
			if (minuite < 10)
			{
				if (PlayerInfo[playerid][pJailTime] > 0)
				{
					format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:0%d~g~|~n~~w~Jail Time Left: %d sec", day, mtext, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
				}
				else
				{
					format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:0%d~g~|", day, mtext, hour, minuite);
				}
			}
			else
			{
				if (PlayerInfo[playerid][pJailTime] > 0)
				{
					format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d~g~|~n~~w~Jail Time Left: %d sec", day, mtext, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
				}
				else
				{
					format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d~g~|", day, mtext, hour, minuite);
				}
			}
			GameTextForPlayer(playerid, string, 5000, 1);
		}
		return 1;
	}
//----------------------------------[RECON]-----------------------------------------------
	if(strcmp(cmd, "/bigears", true) == 0 && PlayerInfo[playerid][pAdmin] >= GM)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if (!BigEar[playerid])
			{
				BigEar[playerid] = 1;
				SendClientMessage(playerid, COLOR_GRAD2, "   Your Ears Have Grown");
			}
			else if (BigEar[playerid])
			{
				BigEar[playerid] = 0;
				SendClientMessage(playerid, COLOR_GRAD2, "   Your Ears Have Shrank");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/id", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /id [playerid/PartOfName]");
				return 1;
			}
			new target;
			target = ReturnUser(tmp);
			new sstring[256];
			if(IsPlayerConnected(target) && !IsPlayerNPC(target))
			{
			    if(target != INVALID_PLAYER_ID)
			    {
					GetPlayerName(target, giveplayer, sizeof(giveplayer));
					format(sstring, sizeof(sstring), "ID: (%d) %s",target,giveplayer);
					SendClientMessage(playerid, COLOR_GRAD1, sstring);
				}
			}
		}
		return 1;
	}

//[ADMIN]______________________________________________________________________________
//-----------------------------------[JAIL]-------------------------------------------------------------------------
	if(strcmp(cmd, "/prison",true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < GM)
	        {
	            SendClientMessage(playerid, COLOR_GREY, "   you are not authorized to use this command !");
	            return 1;
	        }
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /prison [playerid/PartOfName]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
		    if(IsPlayerConnected(giveplayerid) && !IsPlayerNPC(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
		            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* You placed %s in Fort DeMorgan.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* You were placed in Fort DeMorgan by Admin %s.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTRED, string);
					GameTextForPlayer(giveplayerid, "~w~Welcome to ~n~~r~Fort DeMorgan", 5000, 3);
					//WantedPoints[giveplayerid] = 0;
					//WantedLevel[giveplayerid] = 0;
					PlayerInfo[giveplayerid][pJailed] = 2;
					PlayerInfo[giveplayerid][pJailTime] = 3600;
		            SetPlayerPos(giveplayerid, 107.2300,1920.6311,18.5208);
					SetPlayerWorldBounds(giveplayerid, 337.5694,101.5826,1940.9759,1798.7453); //285.3481,96.9720,1940.9755,1799.0811
		        }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "   That player is Offline !");
			    return 1;
			}
	    }
	    return 1;
	}
	if(strcmp(cmd, "/jail", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /jail [playerid/PartOfName] [time(minutes)]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= GM)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
				        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* You Jailed %s.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTRED, string);
						format(string, sizeof(string), "* You were Jailed by Admin %s.", sendername);
						SendClientMessage(playa, COLOR_LIGHTRED, string);
						ResetPlayerWeapons(playa);
						//WantedPoints[playa] = 0;
						PlayerInfo[playa][pJailed] = 1;
						PlayerInfo[playa][pJailTime] = money*60;
						SetPlayerInterior(playa, 6);
						SetPlayerPos(playa, 264.6288,77.5742,1001.0391);
						format(string, sizeof(string), "You are jailed for %d minutes.   Bail: Unable", money);
						SendClientMessage(playa, COLOR_LIGHTBLUE, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
//----------------------------------[Kill]-------------------------------------------------
	if(strcmp(cmd, "/setint", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /kill [playerid]");
				return 1;
			}
			new killid;
			killid = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
				SetPlayerHealth(killid, 0);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GRAD2, "  you are not authorized to use that command!");
			}
		}
		return 1;
	}
//----------------------------------[SETINT]-----------------------------------------------
	if(strcmp(cmd, "/setint", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /setint [interiorid]");
				return 1;
			}
			new intid;
			intid = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
				SetPlayerInterior(playerid,intid);
				PlayerInfo[playerid][pInt] = intid;
				format(string, sizeof(string), "   interiorid %d.", intid);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   You are not authorized to use that command !");
			}
		}
		return 1;
	}
//----------------------------------[GOTO]-----------------------------------------------
	if(strcmp(cmd, "/gotols", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if(PlayerInfo[playerid][pAdmin] >= SA)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
				}
				else
				{
					SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
				}
				SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported !");
				SetPlayerInterior(playerid,0);
				PlayerInfo[playerid][pInt] = 0;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   You are not authorized to use that command !");
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/gotoxoomer", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if(PlayerInfo[playerid][pAdmin] >= SA)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -1881.0, 940.0, 35.40);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
				}
				else
				{
					SetPlayerPos(playerid, -1881.0, 940.0, 35.40);
				}
				SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported !");
				SetPlayerInterior(playerid,0);
				PlayerInfo[playerid][pInt] = 0;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   You are not authorized to use that command !");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotolv", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
				}
				else
				{
					SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
				}
				SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported");
				SetPlayerInterior(playerid,0);
				PlayerInfo[playerid][pInt] = 0;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotosf", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -1417.0,-295.8,14.1);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
				}
				else
				{
					SetPlayerPos(playerid, -1417.0,-295.8,14.1);
				}
				SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported");
				SetPlayerInterior(playerid,0);
				PlayerInfo[playerid][pInt] = 0;
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotocar", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /gotocar [carid]");
				return 1;
			}
			new testcar = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
				new Float:cwx2,Float:cwy2,Float:cwz2;
				GetVehiclePos(testcar, cwx2, cwy2, cwz2);
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, cwx2, cwy2, cwz2);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
				}
				else
				{
					SetPlayerPos(playerid, cwx2, cwy2, cwz2);
				}
				SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported");
				SetPlayerInterior(playerid,0);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
	
	if(strcmp(cmd, "/crear", true) == 0) {
	    if (PlayerInfo[playerid][pAdmin] >= SA) {
			new Float:x, Float:y, Float:z, Float:a;
		    GetXYInFrontOfPlayer(playerid,x,y,z,a,2.0);
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /crear modelid");
				return 1;
			}
			new modelid = strval(tmp);
			new salida = CreateObject(modelid,x,y,z,0.0,0.0,0.0);
			format(string,sizeof(string),"Creado objeto %d",salida);
			SendClientMessage(playerid, COLOR_GREEN, string);
			
	        return 1;
	    }
	}
	
	if(strcmp(cmd, "/destruir", true) == 0) {
	    if (PlayerInfo[playerid][pAdmin] >= SA) {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /destruir idobjeto");
				return 1;
			}
			new objeto = strval(tmp);
			if (IsValidObject(objeto)) {
			    DestroyObject(objeto);
				format(string,sizeof(string),"Destruido objeto %d",objeto);
				SendClientMessage(playerid, COLOR_GREEN, string);
			}
	        return 1;
	    }
	}
	
	if(strcmp(cmd, "/oiroff", true) == 0) {
	    if (PlayerInfo[playerid][pAdmin] >= SA) {

	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /oiron soundid");
				return 1;
			}
			new soundid = strval(tmp);
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid,x,y,z);
			PlayerPlaySound(playerid,soundid,x,y,z);

	        return 1;
	    }
	}
	
	if(strcmp(cmd, "/oiroff", true) == 0) {
	    if (PlayerInfo[playerid][pAdmin] >= SA) {
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid,x,y,z);
			PlayerPlaySound(playerid,1184,x,y,z);

	        return 1;
	    }
	}
	

	if(strcmp(cmd, "/goto", true) == 0)
	{
	    if(IsPlayerConnected(playerid) /*&& !IsPlayerNPC(playerid)*/)
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /goto [playerid/PartOfName]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = ReturnUser(tmp);
			if (IsPlayerConnected(plo)/* && !IsPlayerNPC(plo)*/)
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (PlayerInfo[playerid][pAdmin] >= MOD)
					{
						if(Spectate[playerid] != 255)
						{
							Spectate[playerid] = 256;
						}
						GetPlayerPos(plo, plocx, plocy, plocz);
						if(PlayerInfo[plo][pInt] > 0)
						{
							SetPlayerInterior(playerid,PlayerInfo[plo][pInt]);
							PlayerInfo[playerid][pInt] = PlayerInfo[plo][pInt];
						}
						if(PlayerInfo[playerid][pInt] == 0)
						{
							SetPlayerInterior(playerid,0);
						}
						if(plocz > 530.0 && PlayerInfo[plo][pInt] == 0) //the highest land point in sa = 526.8
						{
							SetPlayerInterior(playerid,1);
							PlayerInfo[playerid][pInt] = 1;
						}
						if (GetPlayerState(playerid) == 2)
						{
							new tmpcar = GetPlayerVehicleID(playerid);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
							TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
						}
						else
						{
							SetPlayerPos(playerid,plocx,plocy+2, plocz);
						}
						SendClientMessage(playerid, COLOR_GRAD1, "   You have been teleported");
					}
					else
					{
						SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", plo);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
//----------------------------------[GETHERE]-----------------------------------------------
	if(strcmp(cmd, "/gethere", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /gethere [playerid/PartOfName]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = ReturnUser(tmp);
			if (IsPlayerConnected(plo) && !IsPlayerNPC(plo))
			{
			    if(plo != INVALID_PLAYER_ID)
			    {
					if (PlayerInfo[plo][pAdmin] >= SA)
					{
						SendClientMessage(playerid, COLOR_GRAD1, "Ask the admin to goto you.");
						return 1;
					}
					if (PlayerInfo[playerid][pAdmin] >= SA)
					{
						GetPlayerPos(playerid, plocx, plocy, plocz);
						if(PlayerInfo[playerid][pInt] > 0)
						{
							SetPlayerInterior(plo,PlayerInfo[playerid][pInt]);
							PlayerInfo[plo][pInt] = PlayerInfo[playerid][pInt];
						}
						if(PlayerInfo[playerid][pInt] == 0)
						{
							SetPlayerInterior(plo,0);
						}
						if(plocz > 930.0 && PlayerInfo[playerid][pInt] == 0) //the highest land point in sa = 526.8
						{
							SetPlayerInterior(plo,1);
							PlayerInfo[plo][pInt] = 1;
						}
						if (GetPlayerState(plo) == 2)
						{
							TelePos[plo][0] = 0.0;
							TelePos[plo][1] = 0.0;
							new tmpcar = GetPlayerVehicleID(plo);
							SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
						}
						else
						{
							SetPlayerPos(plo,plocx,plocy+2, plocz);
						}
						SendClientMessage(plo, COLOR_GRAD1, "   You have been teleported");
					}
					else
					{
						SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", plo);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/getcar", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /getcar [carid]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			plo = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
				GetPlayerPos(playerid, plocx, plocy, plocz);
				SetVehiclePos(plo,plocx,plocy+4, plocz);
			}
		}
		return 1;
	}
//----------------------------------[GiveGun]------------------------------------------------
	if(strcmp(cmd, "/givegun", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /givegun [playerid/PartOfName] [weaponid(eg. 46 = Parachute)] [ammo]");
				return 1;
			}
			new playa;
			new gun;
			new ammo;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			gun = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "USAGE: /givegun [playerid/PartOfName] [weaponid] [ammo]");
				SendClientMessage(playerid, COLOR_GRAD4, "3(Club) 4(knife) 5(bat) 6(Shovel) 7(Cue) 8(Katana) 10-13(Dildo) 14(Flowers) 16(Grenades) 18(Molotovs) 22(Pistol) 23(SPistol)");
				SendClientMessage(playerid, COLOR_GRAD3, "24(Eagle) 25(shotgun) 29(MP5) 30(AK47) 31(M4) 33(Rifle) 34(Sniper) 37(Flamethrower) 41(spray) 42(exting) 43(Camera) 46(Parachute)");
				return 1;
			}
			if(gun < 1||gun > 46||gun==1||gun==2||gun==9||gun==17||gun==19||gun==20||gun==21||gun==36||gun==39||gun==40||gun==44||gun==45)
			{ SendClientMessage(playerid, COLOR_GRAD1, "   wrong WeaponID!"); return 1; }
			tmp = strtok(cmdtext, idx);
			ammo = strval(tmp);
			if(ammo <1||ammo > 999)
			{ SendClientMessage(playerid, COLOR_GRAD1, "   dont go below 1 or above 999 bullets!"); return 1; }
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						GivePlayerWeapon(playa, gun, ammo);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
//----------------------------------[sethp]------------------------------------------------
	if(strcmp(cmd, "/sethp", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /sethp [playerid/PartOfName] [health]");
				return 1;
			}
			new playa;
			new health;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerHealth(playa, health);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/setarmor", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /setarmor [playerid/PartOfName] [armor]");
				return 1;
			}
			new playa;
			new health;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						SetPlayerArmour(playa, health);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/veh", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if (PlayerInfo[playerid][pAdmin] < SA)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /veh [carid] [color1] [color2]");
				return 1;
			}
			new auxcar;
			auxcar = strval(tmp);
			if(auxcar < 400 || auxcar > 611) { SendClientMessage(playerid, COLOR_GREY, "   Vehicle Number can't be below 400 or above 611 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /veh [carid] [color1] [color2]");
				return 1;
			}
			new color1;
			color1 = strval(tmp);
			if(color1 < 0 || color1 > 126) { SendClientMessage(playerid, COLOR_GREY, "   Color Number can't be below 0 or above 126 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /veh [carid] [color1] [color2]");
				return 1;
			}
			new color2;
			color2 = strval(tmp);
			if(color2 < 0 || color2 > 126) { SendClientMessage(playerid, COLOR_GREY, "   Color Number can't be below 0 or above 126 !"); return 1; }
			new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid, X,Y,Z);
			new carid = CreateVehicle(auxcar, X,Y,Z, 0.0, color1, color2, 60000);
			CreatedCars[CreatedCar] = carid;
			CreatedCar ++;
			format(string, sizeof(string), "   Vehicle %d spawned.", carid);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/fixveh", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < SA)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			    return 1;
			}
			if(IsPlayerInAnyVehicle(playerid))
			{
			    SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
			    SendClientMessage(playerid, COLOR_GREY, "   Vehicle Fixed !");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/destroycars", true) == 0)
	{
	    if(IsPlayerConnected(playerid && !IsPlayerNPC(playerid)))
	    {
	        if(PlayerInfo[playerid][pAdmin] < SA)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			    return 1;
			}
			for(new i = 0; i < sizeof(CreatedCars ); i++)
			{
				if(i != 0)
				{
			    	DestroyVehicle(i);
				}
			}
			SendClientMessage(playerid, COLOR_GREY, "   Created Vehicles destroyed !");
		}
		return 1;
	}
	if(strcmp(cmd, "/weather", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < SA)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			    SendClientMessage(playerid, COLOR_WHITE, "USAGE: /weather [weatherid]");
			    return 1;
			}
			new weather;
			weather = strval(tmp);
			if(weather < 0||weather > 45) { SendClientMessage(playerid, COLOR_GREY, "   Weather ID can't be below 0 or above 45 !"); return 1; }
			SetPlayerWeather(playerid, weather);
			SendClientMessage(playerid, COLOR_GREY, "   Weather Set !");
		}
		return 1;
	}
	if(strcmp(cmd, "/weatherall", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] < SA)
			{
			    SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
			    SendClientMessage(playerid, COLOR_WHITE, "USAGE: /weatherall [weatherid]");
			    return 1;
			}
			new weather;
			weather = strval(tmp);
			if(weather < 0||weather > 45) { SendClientMessage(playerid, COLOR_GREY, "   Weather ID can't be below 0 or above 45 !"); return 1; }
			SetWeather(weather);
			SendClientMessage(playerid, COLOR_GREY, "   Weather Set to everyone !");
		}
		return 1;
	}
//----------------------------------[Money]------------------------------------------------
	if(strcmp(cmd, "/money", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /money [playerid/PartOfName] [money]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						ResetPlayerMoney(playa);
						GivePlayerMoney(playa, money);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
//----------------------------------[GiveMoney]------------------------------------------------
	if(strcmp(cmd, "/givemoney", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /givemoney [playerid/PartOfName] [money]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			money = strval(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
						GivePlayerMoney(playa, money);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
//-----------------------------------[Slap]-----------------------------------------------
	if(strcmp(cmd, "/slap", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /slap [playerid/PartOfName]");
				return 1;
			}
			new playa;
			new Float:shealth;
			new Float:slx, Float:sly, Float:slz;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
				        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						GetPlayerHealth(playa, shealth);
						SetPlayerHealth(playa, shealth-5);
						GetPlayerPos(playa, slx, sly, slz);
						SetPlayerPos(playa, slx, sly, slz+5);
						PlayerPlaySound(playa, 1130, slx, sly, slz+5);
						printf("AdmCmd: %s slapped %s",sendername,  giveplayer);
						format(string, sizeof(string), "AdmCmd: %s was slapped by %s",giveplayer ,sendername);
						ABroadCast(COLOR_LIGHTRED,string,1);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/mute", true) == 0)
	{

		return 1;
	}

//----------------------------------[Kick]------------------------------------------------
    if(strcmp(cmd, "/kick", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /kick [playerid/PartOfName] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
				if(IsPlayerConnected(giveplayerid) && !IsPlayerNPC(playerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[64];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /kick [playerid/PartOfName] [reason]");
							return 1;
						}
						new year, month,day;
						getdate(year, month, day);
						format(string, sizeof(string), "AdmCmd: %s was kicked by %s, reason: %s (%d-%d-%d)", giveplayer, sendername, (result),month,day,year);
						KickLog(string);
						Kick(giveplayerid);
						format(string, sizeof(string), "AdmCmd: %s was kicked by %s, reason: %s", giveplayer, sendername, (result));
						SendClientMessageToAll(COLOR_LIGHTRED, string);
						return 1;
					}
				}
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/skick", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /skick [playerid/PartOfName]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
				if(IsPlayerConnected(giveplayerid) && !IsPlayerNPC(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
				        Kick(giveplayerid);
				    }
				}
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/kickres", true) == 0)
	{

		return 1;
	}

	if(strcmp(cmd, "/sban", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /sban [playerid/PartOfName] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
			    if(IsPlayerConnected(giveplayerid) && !IsPlayerNPC(giveplayerid))
			    {
			        if(giveplayerid != INVALID_PLAYER_ID)
			        {
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[64];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /sban [playerid/PartOfName] [reason]");
							return 1;
						}
						new year, month,day;
						getdate(year, month, day);
						format(string, sizeof(string), "AdmCmd: %s was banned by %s, reason: %s (%d-%d-%d)", giveplayer, sendername, (result),month,day,year);
						BanLog(string);
						PlayerInfo[giveplayerid][pAdmin] = PlayerInfo[giveplayerid][pLevel];
						PlayerInfo[giveplayerid][pLevel] = -999;
						Ban(giveplayerid);
						return 1;
					}
				}//not connected
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/ban", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	    	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /ban [playerid/PartOfName] [reason]");
				return 1;
			}
			giveplayerid = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= MOD)
			{
			    if(IsPlayerConnected(giveplayerid) && !IsPlayerNPC(giveplayerid))
			    {
			        if(giveplayerid != INVALID_PLAYER_ID)
			        {
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new length = strlen(cmdtext);
						while ((idx < length) && (cmdtext[idx] <= ' '))
						{
							idx++;
						}
						new offset = idx;
						new result[64];
						while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
						{
							result[idx - offset] = cmdtext[idx];
							idx++;
						}
						result[idx - offset] = EOS;
						if(!strlen(result))
						{
							SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /ban [playerid/PartOfName] [reason]");
							return 1;
						}
						new year, month,day;
						getdate(year, month, day);
						format(string, sizeof(string), "AdmCmd: %s was banned by %s, reason: %s (%d-%d-%d)", giveplayer, sendername, (result),month,day,year);
						BanLog(string);
						format(string, sizeof(string), "AdmCmd: %s was banned by %s, reason: %s", giveplayer, sendername, (result));
						SendClientMessageToAll(COLOR_LIGHTRED, string);
						PlayerInfo[giveplayerid][pAdmin] = PlayerInfo[giveplayerid][pLevel];
						PlayerInfo[giveplayerid][pLevel] = -999;
						Ban(giveplayerid);
						return 1;
					}
				}//not connected
			}
			else
			{
				format(string, sizeof(string), "   %d is not an active player.", giveplayerid);
				SendClientMessage(playerid, COLOR_GRAD1, string);
			}
		}
		return 1;
	}
//----------------------------------[Freeze]------------------------------------------------
	if(strcmp(cmd, "/freeze", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /freeze [playerid/PartOfName]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if(PlayerInfo[playa][pAdmin] >= GM)
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Admins can not be frozen");
				return 1;
			}
			if (PlayerInfo[playerid][pAdmin] >= GM)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
				        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						TogglePlayerControllable(playa, 0);
						format(string, sizeof(string), "AdmCmd: %s Freezes %s",sendername,  giveplayer);
						printf("%s",string);
						format(string, sizeof(string), "AdmCmd: %s was Frozen by %s",giveplayer ,sendername);
						ABroadCast(COLOR_LIGHTRED,string,1);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}

//----------------------------------[unfreeze]------------------------------------------------
	if(strcmp(cmd, "/unfreeze", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /unfreeze [playerid]");
				return 1;
			}
			new playa;
			playa = ReturnUser(tmp);
			if (PlayerInfo[playerid][pAdmin] >= GM)
			{
			    if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
			    {
			        if(playa != INVALID_PLAYER_ID)
			        {
			    	    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						TogglePlayerControllable(playa, 1);
						format(string, sizeof(string), "AdmCmd: %s UnFroze %s",sendername,  giveplayer);
						printf("%s",string);
						format(string, sizeof(string), "AdmCmd: %s was UnFrozen by %s",giveplayer ,sendername);
						ABroadCast(COLOR_LIGHTRED,string,1);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   you are not authorized to use that command!");
			}
		}
		return 1;
	}
//----------------------------------[GMX]-----------------------------------------------

	if(strcmp(cmd, "/gmx", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if (PlayerInfo[playerid][pAdmin] >= SA)
			{
				GameModeExit();
			}
			else
			{
				SendClientMessage(playerid, COLOR_GRAD1, "   You are not authorized to use that command !");
			}
		}
		return 1;
	}
	if (strcmp(cmd, "/admins", true) == 0)
	{
        if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			SendClientMessage(playerid, COLOR_GRAD1, "Admins Online:");
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && !IsPlayerNPC(i))
				{
				    if(PlayerInfo[i][pAdmin] >= MOD)
				    {
						GetPlayerName(i, sendername, sizeof(sendername));
						format(string, 256, "Admin: %s", sendername);
						SendClientMessage(playerid, COLOR_GRAD2, string);
					}
				}
			}
		}
		return 1;
	}
//----------------------------------[HELP]-----------------------------------------------
	if(strcmp(cmd, "/help", true) == 0)
	{

		return 1;
	}

//----------------------------------[HELP]-----------------------------------------------
	if(strcmp(cmd, "/cellphonehelp", true) == 0)
	{

		return 1;
	}
	if(strcmp(cmd, "/househelp", true) == 0)
	{
		return 1;
	}
	if(strcmp(cmd, "/renthelp", true) == 0)
	{
		return 1;
	}
	if(strcmp(cmd, "/businesshelp", true) == 0)
	{
		return 1;
	}
	if(strcmp(cmd, "/leaderhelp", true) == 0)
	{

		return 1;
	}

	if(strcmp(cmd,"/stopani",true)==0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        ClearAnimations(playerid);
	    }
	    return 1;
	}

	if(strcmp(cmd, "/givelicense", true) == 0)
	{
	
	    return 1;
	}
	if(strcmp(cmd, "/startlesson", true) == 0)
	{
	
	    return 1;
	}
	if(strcmp(cmd, "/stoplesson", true) == 0)
	{
	
	    return 1;
	}
	if(strcmp(cmd, "/families", true) == 0)
	{
	
	    return 1;
	}
	
	if(strcmp(cmd, "/allowcreation", true) == 0)
	{
	
	    return 1;
	}

	if(strcmp(cmd, "/ram", true) == 0)
	{
	 
		return 1;
	}
	if(strcmp(cmd, "/report", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
	        GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /report [text]");
				return 1;
			}
			format(string, sizeof(string), "Report from %s: %s", sendername, (result));
			ABroadCast(COLOR_YELLOW,string,1);
			SendClientMessage(playerid, COLOR_YELLOW, "Your Report Message was sent to the Admins.");
	    }
	    return 1;
	}

	if(strcmp(cmd, "/take", true) == 0)
	{
	
	    return 1;
	}
	if(strcmp(cmd, "/service", true) == 0)
	{
	  
		return 1;
	}
	if(strcmp(cmd, "/tie", true) == 0)
	{
	 
		return 1;
	}
	if(strcmp(cmd, "/untie", true) == 0)
	{
	
		return 1;
	}

	if(strcmp(cmd,"/fare",true)==0)
    {
    
	    return 1;
 	}
	if(strcmp(cmd,"/sellcar",true)==0)
	{
	
		return 1;
	}
	if(strcmp(cmd,"/materials",true)==0)
    {
    
		return 1;
	}
    if(strcmp(cmd,"/sellgun",true)==0)
    {
    
		return 1;
	}
	if(strcmp(cmd,"/get",true)==0)
    {
        if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			new x_job[256];
			x_job = strtok(cmdtext, idx);

			if(!strlen(x_job)) {
				SendClientMessage(playerid, COLOR_WHITE, "|__________________ Get __________________|");
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /get [name]");
		  		SendClientMessage(playerid, COLOR_GREY, "Available names: Drugs, Fuel");
				SendClientMessage(playerid, COLOR_GREEN, "|_________________________________________|");
				return 1;
			}

	
			else { return 1; }
		}//not connected
		return 1;
	}
	if(strcmp(cmd, "/join", true) == 0) {
	    if (PlayerInfo[playerid][pBanda] == 0) { //mensaje solo para gente sin team o banda
			if (PlayerInfo[playerid][pTeam] == 0)
			{
				if (PlayerToPoint(2.0, playerid, -2048.5483,-255.8789,35.3203))//BOMBEROS
				{
					//hacer una prueba coche ardiendo a apagar con extintor
					PlayerInfo[playerid][pTeam] = BOMBEROS;
					GameTextForPlayer(playerid, "Bienvenido a los bomberos!", 5000, 3);
					for (new i = 0; i < NUM_COCHES_BOMBEROS; i++)
						SetVehicleParamsForPlayer(CochesBomberos[i],playerid,0,0);
	        		return 1;
   				}
				else if (PlayerToPoint(2.0, playerid, 1561.0171,-1684.6732,1723.1050))//POLICIA
				{
					//hacer una prueba coche ardiendo a apagar con extintor
					PlayerInfo[playerid][pTeam] = POLI;
					GameTextForPlayer(playerid, "Bienvenido a la Policia!", 5000, 3);
					for (new i = 0; i < sizeof(CochesPolicia); i++)
						SetVehicleParamsForPlayer(CochesPolicia[i],playerid,0,0);
	        		return 1;
		    	}
			}
		    else
		    {
		    	SendClientMessage(playerid,COLOR_GREY,"Que haces, vuelve a tu trabajo!");
		    }
	    }
	    else
	    {
    		SendClientMessage(playerid,COLOR_GREY,"No puedes unirte, perteneces a una banda, sal de aqui!");
    	}
	    return 1;
	}
	if (strcmp("/armas", cmdtext, true, 10) == 0) {
		if(PlayerInfo[playerid][pTeam] == POLI && OnDuty[playerid] == 1 && PlayerToPoint(4,playerid,-1591.5914,716.2670,-5.2422 )) {
			ShowPlayerDialog(playerid, 2341, DIALOG_STYLE_LIST, "ARMERIA DE LA POLICIA", "ARMADURA\nDESERT EAGLE\nSHOTGUN\nSMG\nMP5\nSNIPER RIFLE", "ACEPTAR", "CANCELAR");
		} else {
		    ShowPlayerDialog(playerid, 1500, DIALOG_STYLE_MSGBOX, "NO ESTAS AUTORIZADO", "PONTE A HACER ALGO!","ACEPTAR","SALIR");
        }
		return 1;
	}

	if(strcmp(cmd, "/cuff", true) == 0)
	{
	 
		return 1;
	}
	if(strcmp(cmd, "/uncuff", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	    {
			if(PlayerInfo[playerid][pTeam] == 2)
			{
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)) {
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /uncuff [Playerid/PartOfName]");
					return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if(IsPlayerConnected(giveplayerid) && !IsPlayerNPC(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
					    if (ProxDetectorS(8.0, playerid, giveplayerid))
						{
						    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_GREY, "You cannot Uncuff yourself!"); return 1; }
							if(PlayerCuffed[giveplayerid])
							{
							    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
							    format(string, sizeof(string), "* You were Uncuffed by %s.", sendername);
								SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
								format(string, sizeof(string), "* You Uncuffed %s.", giveplayer);
								SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								GameTextForPlayer(giveplayerid, "~g~Uncuffed", 2500, 3);
								TogglePlayerControllable(giveplayerid, 1);
								PlayerCuffed[giveplayerid] = 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "   That player isn't Tied up !");
							    return 1;
							}
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "   That player is not near you !");
						    return 1;
						}
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GREY, "   That player is Offline !");
				    return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, "   You are not a Cop / FBI / National Guard !");
			}
		}//not connected
		return 1;
	}
    if(strcmp(cmd, "/find", true) == 0)
	{
	   
	    return 1;
	}

	if(strcmp(cmd,"/cancel",true)==0)
    {

		return 1;
	}
//ACCEPT COMMANDS (Cops)

	if(strcmp(cmd, "/refill", true) == 0)
	{
	 
		return 1;
	}
	if(strcmp(cmd, "/repair", true) == 0)
	{
	 
		return 1;
	}
	if(strcmp(cmd, "/family", true) == 0 || strcmp(cmd, "/f", true) == 0)
	{
	
		return 1;
	}
	if(strcmp(cmd, "/news", true) == 0)
	{
	
		return 1;
	}
	if(strcmp(cmd, "/live", true) == 0)
	{
	  
		return 1;
	}
	if(strcmp(cmd, "/healme", true) == 0)
	{
	  
		return 1;
	}
	if(strcmp(cmd, "/eject", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	   	{
	        new State;
	        if(IsPlayerInAnyVehicle(playerid))
	        {
         		State=GetPlayerState(playerid);
		        if(State!=PLAYER_STATE_DRIVER)
		        {
		        	SendClientMessage(playerid,COLOR_GREY,"  Solo puedes hacer esto si eres el conductor !");
		            return 1;
		        }
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_GRAD2, "USAGE: /eject [playerid/PartOfName]");
					return 1;
				}
				new playa;
				playa = ReturnUser(tmp);
				new test;
				test = GetPlayerVehicleID(playerid);
				if(IsPlayerConnected(playa) && !IsPlayerNPC(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(playa == playerid) { SendClientMessage(playerid, COLOR_GREY, "No puedes echarte a ti mismo!"); return 1; }
				        if(IsPlayerInVehicle(playa,test))
				        {
							new PName[MAX_PLAYER_NAME];
							GetPlayerName(playerid,PName,sizeof(PName));
							GetPlayerName(playa, giveplayer, sizeof(giveplayer));
							format(string, sizeof(string), "* Echaste a %s fuera del coche!", giveplayer);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* %s te echo del coche!", PName);
							SendClientMessage(playa, COLOR_LIGHTBLUE, string);
							RemovePlayerFromVehicle(playa);
						}
						else
						{
						    SendClientMessage(playerid, COLOR_GREY, "   no está en tu coche !");
						    return 1;
						}
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, " Invalid ID/Name!");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "   You need to be in a Vehicle to use this !");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/sex", true) == 0)
	{
	  
		return 1;
	}

	if(strcmp(cmd, "/quitjob", true) == 0)
	{
		return 1;
	}
	if(strcmp(cmd, "/bail", true) == 0)
	{
	    
		return 1;
	}

	if(strcmp(cmd, "/ticket", true) == 0) {
	    
	}

	//*********************************** COMANDOS MEDICOS
	if(strcmp(cmd,"/shock",true)==0)
	{
	  	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
  	 		if (PlayerInfo[playerid][pTeam] != MEDICO ) { SendClientMessage(playerid,COLOR_RED,"No eres medico."); return 1;}
	  	    if (!OnDuty[playerid]) { SendClientMessage(playerid,COLOR_RED,"Tienes que estar trabajando."); return 1;}
			new id = GetClosestPlayer(playerid);
			if (muriendo[id] == 0){
				SendClientMessage(playerid,COLOR_RED,"Este no se esta muriendo..");
			} else {
			    new suerte = random(2);
			    if (suerte){
			        new Float:vida;
					GetPlayerHealth(id,vida);
			        SetPlayerHealth(id,floatadd(vida,5.0));
		        } else {
			        new Float:vida;
					GetPlayerHealth(id,vida);
					if (floatround(vida) > 5)
				        SetPlayerHealth(id,floatsub(vida,5.0));
					else {
				 		SetPlayerHealth(id,0.0);
           				muriendo[id] = 0;
						for (new j = 0; j < MAX_PLAYERS; j++){
		         			if (IsPlayerConnected(j) && !IsPlayerNPC(j) && (PlayerInfo[j][pTeam] == MEDICO && PlayerInfo[j][pTeam] == POLI)){ //si es medico
	            		   		SetPlayerMarkerForPlayer(j,id,INVISIBLE);
		    	           		// aki habia ke ponerle la animacion del tunel
				            }

						}
					}
			    }
			}
		} 
		return 1;
	}

	if(strcmp(cmd,"/operar",true)==0){
		if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
  	 		if (PlayerInfo[playerid][pTeam] != MEDICO ) { SendClientMessage(playerid,COLOR_RED,"No eres medico."); return 1;}
	  	    if (!OnDuty[playerid]) { SendClientMessage(playerid,COLOR_RED,"Tienes que estar trabajando."); return 1;}
	  	    if (!IsPlayerInRangeOfPoint(playerid, 3.0, -2690.46,621.69,7.16))
	  	        { SendClientMessage(playerid,COLOR_RED,"Aqui no puedes usar este comando"); return 1;}
            new id = GetClosestPlayer(playerid);
			if (!muriendo[id]) {
				SendClientMessage(playerid,COLOR_RED,"Este no se está muriendo..");
			} else {
				muriendo[id] = 0;
				SendClientMessage(playerid,COLOR_GREEN,"El paciente ha sido operado con exito");
				SendClientMessage(id,COLOR_GREEN,"Ala, a seguir jugando y come mas...");
			}
		}
		return 1;
	}
	
	if(strcmp(cmd,"/vacuna",true)==0){
		if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
  	 		if (PlayerInfo[playerid][pTeam] != MEDICO ) { SendClientMessage(playerid,COLOR_RED,"No eres medico."); return 1;}
	  	    if (!OnDuty[playerid]) { SendClientMessage(playerid,COLOR_RED,"Tienes que estar trabajando."); return 1;}
	  	    if (!IsPlayerInRangeOfPoint(playerid, 3.0,-2649.64,641.40,4.18))
	  	        { SendClientMessage(playerid,COLOR_RED,"Aqui no puedes usar este comando"); return 1;}
            new id = GetClosestPlayer(playerid);
			if (!enfermo[id]) {
				SendClientMessage(playerid,COLOR_RED,"Este no tiene nada..");
			} else {
				enfermo[id] = 0;
				SendClientMessage(playerid,COLOR_GREEN,"El paciente ha sido curado con exito");
				SendClientMessage(id,COLOR_GREEN,"Te han curado, da gracias a los avances de la medicina!!");
			}
		}
		return 1;
	}
	
	//******************************** FIN COMANDOS MEDICO
	
	if(strcmp(cmd,"/where?",true)==0)
	{
	  if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	  {
        new PlayerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
       // if (PlayerInfo[playerid][pAdmin] > 0){
	    new Float:Xx,Float:Yy,Float:Zz;
	    GetPlayerPos(playerid, Xx,Yy,Zz);
	    PlayerPlaySound(playerid, 1062, Xx,Yy,Zz);
	    format(string, sizeof(string), "Tu posicion es: %.2f %.2f %.2f",Xx,Yy,Zz);
	    SendClientMessage(playerid, COLOR_GREY, string);
	    printf(" => Pos:  %f,%f,%f",Xx,Yy,Zz);
	    return 1;
//		}
		/*else {
          SendClientMessage(playerid, COLOR_GREY, "No eres admin");
		  return 1;
		}*/
      }
    }
    

   	if(strcmp(cmd,"/duty",true)==0)
	{

	 //   OnDuty[playerid] = 1;
	    return 1;
	}
   	if(strcmp(cmd,"/teleport",true)==0)
	{
	  if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	  {
  	    new PlayerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
        if (PlayerInfo[playerid][pAdmin] == 3)
		{
  	      new tmp1[256];
	      tmp1 = strtok(cmdtext, idx);
	 	  if(!strlen(tmp1)){
       	    SendClientMessage(playerid, COLOR_GREY, "	Uso: /teleport [x] [y] [z]");
		    return 1;
		  }
       	  new X = strval(tmp1);
       	  tmp1 = strtok(cmdtext, idx);
		  if(!strlen(tmp1)){
       	    SendClientMessage(playerid, COLOR_GREY, "	Uso: /teleport [x] [y] [z]");
		    return 1;
		  }
       	  new Y = strval(tmp1);
       	  tmp1 = strtok(cmdtext, idx);
		  if(!strlen(tmp1)){
       	    SendClientMessage(playerid, COLOR_GREY, "	Uso: /teleport [x] [y] [z]");
		    return 1;
		  }
       	  new Z = strval(tmp1);
          SetPlayerPos(playerid,X,Y,Z);
		}
     	return 1;
	  }
		else {
        SendClientMessage(playerid, COLOR_GREY, "No eres admin");
	    return 1;
	  }
    }
//--------------------------------------COMANDOS MENU---------------------------------------------------------
	if(strcmp(cmd, "/comer", true) == 0)// Comer Donut en el Auto Donut de la comisaria de San fierro
	{
	    if(IsPlayerConnected(playerid))
	    {
     		if(IsPlayerInRangeOfPoint(playerid, 5, -1540.7765,690.2141,6.9331) && IsPlayerInAnyVehicle(playerid))
	        {
				ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Bienvenido al Donut Auto ¿Que desea comer?", "Donut de Chocolate\nDonut de Caramelo con nata\nDonut con sirope de fresa\nNo quiero nada. Gracias", "Aceptar","Cancelar");
			}
			else
			{
         		SendClientMessage(playerid, COLOR_RED, "No estas en un Donut Auto");
	        }
		}
		return 1;
	}
	if(strcmp(cmd, "/Donut", true) == 0)// Comer Donut en el Auto Donut de la autoescuela
	{
	    if(IsPlayerConnected(playerid))
	    {
     		if(IsPlayerInRangeOfPoint(playerid, 2, -2080.8225,-86.9719,29.1935))
	        {
				ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Bienvenido al Donut Auto ¿Que desea comer?", "Donut de Chocolate\nDonut de Caramelo con nata\nDonut con sirope de fresa\nNo quiero nada. Gracias", "Aceptar","Cancelar");
			}
			else
			{
         		SendClientMessage(playerid, COLOR_RED, "No estas en un Donut Auto");
	        }
		}
		return 1;
	}
	if(strcmp(cmd, "/ayuda", true) == 0)// Menu de Ayuda
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(IsPlayerInRangeOfPoint(playerid, 3, -2028.60,-50.62,35.38))
	        {
	            TogglePlayerControllable(playerid, 0);
	            SetPlayerFacingAngle(playerid, 315);
	            SetPlayerCameraPos(playerid,-2027.92,-51.34,36.37);
				SetPlayerCameraLookAt(playerid,-2028.60,-50.62,36.38);
	            ShowPlayerDialog( playerid, 1, DIALOG_STYLE_LIST, "Ayuda para novatos.", "Opcion1\nOpcion2\nOpcion3\nOpcion4\nDespedirse", "Aceptar", "Cancelar" );
	            SetCameraBehindPlayer(playerid);
	            TogglePlayerControllable(playerid, 1);
	        }
	        else
	        {
         		SendClientMessage(playerid, COLOR_RED, "No estas lo suficientemente cerca");
	        }
		}
		return 1;
	}

	if(strcmp(cmd, "/camaras", true) == 0)// Menu de Ayuda
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pTeam] == POLI)
	        {
	        	if(IsPlayerInRangeOfPoint(playerid, 2, -1615.9277,686.4177,7.1875))
	        	{
	            	ShowPlayerDialog( playerid, 201, DIALOG_STYLE_LIST, "Camaras de Policia.", "Puerta trasera\nParking Superior 1\nParking Superior 2\nPuerta Principal\nRecepcion\nCeldas\nCerrar", "Aceptar", "Cancelar" );
	        	}
			}
	        else
	        {
         		ShowPlayerDialog(playerid, 1500, DIALOG_STYLE_MSGBOX, "NO ESTAS AUTORIZADO", "NO ERES POLICIA!","ACEPTAR","SALIR");
	        }
		}
		return 1;
	}
	return 1;
}
//---------------------------------------------FIN COMANDOS MENU -----------------------------------------------------

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && !IsPlayerNPC(i))
			{
				if(!BigEar[i])
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}

public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
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
	return 0;
}

public CustomPickups()
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
//	new string[128];
	NameTimer();
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			GetPlayerPos(i, oldposx, oldposy, oldposz);
//			new tmpcar = GetPlayerVehicleID(i);
			if (PlayerToPoint(2.0, i, -1527.96,149.21,3.55)) // Mision VTA Del Puerto
			{
				GameTextForPlayer(i, "~w~Usa /informacion~n~~r~Para ver los requisitos de la mision", 2000, 1);
			}
			if (PlayerToPoint(2.0, i, -2506.1765,769.4029,35.1719)) // Mision Armas
			{
				GameTextForPlayer(i, "~w~Usa /informacion~n~~r~Para ver los requisitos de la mision", 2000, 1);
			}
			else if (PlayerToPoint(2.0, i, -2107.4812,-221.7151,35.3203)) // Mision Mecanicos para Bandas
			{
			    if (PlayerInfo[i][pMisionBanda] == 0 &&  //si no está en ninguna misión
				 	PlayerInfo[i][pBanda] > 0 ){//&&         // y está en una banda
				//	Bandas[PlayerInfo[i][pBanda]][bNumCoches] == 0) {      // y esa banda no tiene coches
				    if (NPCocupado[idNPC[MECANICO]] == 0)
   						GameTextForPlayer(i, "~w~Usa /informacion~n~~r~Para ver los requisitos de la mision", 2000, 6);
					else if (PlayerInfo[i][pBanda] != PlayerInfo[mPlayerid[MISION_MECANICO][0]][pBanda])
						GameTextForPlayer(i, "~w~Intentalo mas tarde chico 2", 2000, 6);
				}
			}
			else if (PlayerToPoint(2.0, i, 322.4866,119.6555,1003.2194))//Comandos para el banko
			{
				GameTextForPlayer(i, "~w~Pulsa tus muertos~n~~r~Para mirar el menu del Banco", 2000, 1);
			}
			else if (PlayerToPoint(2.0, i, 1565.4065,-1672.1458,1723.1050))//Duty Policia
			{
				GameTextForPlayer(i, "~w~Pulsa N~n~~r~Para entrar en servicio", 2000, 1);
			}
		 	else if (PlayerToPoint(2.0, i,1561.0171,-1684.6732,1723.1050)) {// /join Policia
				GameTextForPlayer(i, "~w~Usa /join~n~Para unirte a la Policia", 2000, 1);
			}
			else if (PlayerToPoint(2.0, i,-1591.5914,716.2670,-5.2422)) {// /armas Armeria de la Policia
				GameTextForPlayer(i, "~w~Usa /armas", 2000, 1);
			}
			else if (PlayerToPoint(2.0, i, -2030.8715,-223.8672,14.5783))//Duty bomberos
			{
				GameTextForPlayer(i, "~w~Pulsa N~n~~r~Para entrar en servicio", 2000, 1);
			}
		 	else if (PlayerToPoint(2.0, i,-2048.5483,-255.8789,35.3203)) {// /join bomeros
				GameTextForPlayer(i, "~w~Usa /join~n~Para unirte a los bomberos", 2000, 1);
			}
			else if (PlayerToPoint(2.0, i, -1615.9277,686.4177,7.1875)) { //camaras vigilancia
				GameTextForPlayer(i, "~w~Usa /camaras~n~~r~Camaras de Vigilancia", 2000, 1);
            }
            //Radares Moviles
			else if( PlayerToPoint(50, i, -1997.5637,-57.5012,35.3203) && PlayerInfo[i][pTeam] != BOMBEROS && PlayerInfo[i][pTeam] != POLI && PlayerInfo[i][pTeam] != MEDICO && GetPlayerState(i)==2)
			{
				GameTextForPlayer(i, "Cuidado un radar", 1500, 1);
			}
			else if( PlayerToPoint(50, i, -2014.47,578.57,35.17) && PlayerInfo[i][pTeam] != BOMBEROS && PlayerInfo[i][pTeam] != POLI && PlayerInfo[i][pTeam] != MEDICO && GetPlayerState(i)==2)
			{
				GameTextForPlayer(i, "Cuidado un radar", 1500, 1);
			}
			else if( PlayerToPoint(50, i, -2249.76,307.85,35.32) && PlayerInfo[i][pTeam] != BOMBEROS && PlayerInfo[i][pTeam] != POLI && PlayerInfo[i][pTeam] != MEDICO && GetPlayerState(i)==2)
			{
				GameTextForPlayer(i, "Cuidado un radar", 1500, 1);
			}
			else if( PlayerToPoint(50, i, -2381.91,-77.90,33.32) && PlayerInfo[i][pTeam] != BOMBEROS && PlayerInfo[i][pTeam] != POLI && PlayerInfo[i][pTeam] != MEDICO && GetPlayerState(i)==2)
			{
				GameTextForPlayer(i, "Cuidado un radar", 1500, 1);
			}
			else if (PlayerToPoint(2.0, i, -1862.4753,961.7531,36.2719))//Trabajos Xoomer
			{
				//si ya ha cogido 10 trabajos..
				if (tiempoConverXoomer[i] == 0) {
					if (NPCocupado[MISION_XOOMER_FIN] == 0) {
						NPCocupado[MISION_XOOMER_FIN] = 1;
						timerConverXoomerID[i] = SetTimerEx("timerConverXoomer",1000,1,"d",i);
					} else {
					    GameTextForPlayer(i, "Intentalo mas tarde chico",4000, 6);
					}
				}
			}

		}
	}
	return 1;
}

public IdleKick()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    if(PlayerInfo[i][pAdmin] < MOD)
		    {
				GetPlayerPos(i, PlayerPos[i][0], PlayerPos[i][1], PlayerPos[i][2]);
				if(PlayerPos[i][0] == PlayerPos[i][3] && PlayerPos[i][1] == PlayerPos[i][4] && PlayerPos[i][2] == PlayerPos[i][5])
				{
					Kick(i);
				}
				PlayerPos[i][3] = PlayerPos[i][0];
				PlayerPos[i][4] = PlayerPos[i][1];
				PlayerPos[i][5] = PlayerPos[i][2];
			}
		}
	}
}

public OnPlayerText(playerid, text[])
{
//	new giver[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
//	new giveplayer[MAX_PLAYER_NAME];
	new string[256];
//	new giveplayerid;
	if(gPlayerLogged[playerid] == 0){
		return 0;
  	}
	//----------------------------[ eligiendo opciones ] ------------------------------------------
	if (eligiendoOpcion[playerid] > 0){
	    if(strcmp(text, "1", true) == 0) {
	        SendClientMessage(playerid,COLOR_ORANGE,"De los buenos!");
			PlayerTextDrawHide(playerid,EscenaText[playerid]);
		    GameTextForPlayer(playerid,"Ve a la empresa de limpieza", 5000, 6);
		    eligiendoOpcion[playerid] = 0;
			m2opcion[playerid] = 1;
			SetPlayerCheckpoint(playerid,m2posChkPnt[0],m2posChkPnt[1],m2posChkPnt[2],1.0);
		    KillTimer(timerConverXoomerID[playerid]);
		    KillTimer(timerOpcionID[playerid]);
	    } else if(strcmp(text, "2", true) == 0) {
   	        SendClientMessage(playerid,COLOR_ORANGE,"A ver cuanto duras fuera de la cárcel..");
			PlayerTextDrawHide(playerid,EscenaText[playerid]);
		    GameTextForPlayer(playerid,"Ve a la empresa de limpieza", 5000, 6);
		    eligiendoOpcion[playerid] = 0;
   			SetPlayerCheckpoint(playerid,m2posChkPnt[0],m2posChkPnt[1],m2posChkPnt[2],1.0);
   			m2opcion[playerid] = 2;
		    KillTimer(timerConverXoomerID[playerid]);
		    KillTimer(timerOpcionID[playerid]);
		}
		return 0;
	}
    
    if (megafono[playerid] == 1) {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pTeam] == BOMBEROS)
		    format(string, sizeof(string), "[Bombero %s:o< %s]", sendername, text);
		if (PlayerInfo[playerid][pTeam] == POLI)
		    format(string, sizeof(string), "[Poli %s:o< %s]", sendername, text);
		ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
        return 0;
    }

	if (realchat) {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s dice: %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return 0;
	}
	return 1;
}

public FixHour(hour)
{
	hour = timeshift+hour;
	if (hour < 0)
	{
		hour = hour+24;
	}
	else if (hour > 23)
	{
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}

//--------------------------------EL CABRA
//Un tio pasa por un punto almacenado en Alarmas. 30% de que le salga que le estan buscando y tenga ke huir
//Se le marca a la poli mientras este dentro del radio (800 metros)
//Al salir del radio se le desmarca a la policia menos a los que esten a menos de 40 metros del sospechoso

//huyendo[MAXPLAYERS][huye,d,pto]
// huye: un 1 cuando esta saliendo del radio, 31 hasta 1 cuando ha salido
// d: radio de huida
// pto: posicion del jugador a la hora de empezar a huir
// p: pillado en los 30 segundos despues de escapar
public hacerElCabra(playerid){
	if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid) && IsPlayerInAnyVehicle(playerid) && huyendo[playerid][huye] == 0 && PlayerInfo[playerid][pTeam] != POLI){
	    new suerte = 1 + random(99);
	    if (suerte >= 1) {
	        if (suerte <= 70) {
	        	SendClientMessage(playerid,COLOR_RED,"Vas demasiado rapido y el radar movil a saltado");
            }
			else if (suerte <= 85) {
	        	SendClientMessage(playerid,COLOR_RED,"Un policia recuerda tu cara y te tiene fichado");
            }
            else {
	        	SendClientMessage(playerid,COLOR_RED,"Un policia quiere ganarse un sueldo extra a tu costa");
            }
			GameTextForPlayer(playerid, "~w~Te han pillado ~n~~r~Corre!!!", 5000, 1);
  			new Float:ptX,Float:ptY,Float:ptZ;
  			GetPlayerPos(playerid,ptX,ptY,ptZ);
   			huyendo[playerid][huye] = 1;
			huyendo[playerid][d] = 800;
			huyendo[playerid][ptox] = ptX;
			huyendo[playerid][ptoy] = ptY;
			huyendo[playerid][ptoz] = ptZ;

	        for (new i = 0; i < MAX_PLAYERS; i++){
	            if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] == POLI && OnDuty[i] == 1){
             		SendClientMessage(i,COLOR_RED,"Atención a todas las unidades, se ha recibido un aviso de conduccion temeraria.");
               		SendClientMessage(i,COLOR_RED,"Todas las unidades dirijanse inmediatamente a detener al infractor");
               		SetPlayerMarkerForPlayer(i,playerid,COLOR_RED);
                }
	        }
	    }
	}
}


public fugitivo(){
	for (new k = 0; k < MAX_PLAYERS; k++){
		if (IsPlayerConnected(k) && !IsPlayerNPC(k)){
 			if (huyendo[k][huye] == 1){
				if (!PlayerToPoint(huyendo[k][d],k,huyendo[k][ptox],huyendo[k][ptoy],huyendo[k][ptoz])) {
		    	    SendClientMessage(k,COLOR_RED,"Esperemos que ningún poli te haya visto huyendo");
		    	    GameTextForPlayer(k, "~w~Saliste del radio!!!", 5000, 1);
	    	    	huyendo[k][huye] = 32; //tendra 30 segundos en los que si hay un poli cerca, este le seguira viendo
           			huyendo[k][p] = 0;
	    	    	for (new i = 0; i < MAX_PLAYERS; i++){
		    	        if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] == POLI){
	            	 		SendClientMessage(i,COLOR_RED,"Parece que el sospechoso ha salido del radio.");
	               			SetPlayerMarkerForPlayer(i,k,INVISIBLE);
						}
		            }
		        }
			}
			if (huyendo[k][huye] > 2){ //si esta dentro de esos 30 segundos
			    for (new i = 0; i < MAX_PLAYERS; i++){
		    		if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] == POLI && OnDuty[i] == 1){
						new Float:ptoX,Float:ptoY,Float:ptoZ;
						GetPlayerPos(k,ptoX,ptoY,ptoZ);
						if (IsPlayerInAnyVehicle(i)){
							new newcar = GetPlayerVehicleID(i);
						  	new model = GetVehicleModel(newcar);
						  	if (model == 497) { //si esta en el helicoptero de la policia
	  							if (PlayerToPoint(500.0,i,ptoX,ptoY,ptoZ)) {
	               					SetPlayerMarkerForPlayer(i,k,COLOR_RED);
		               				huyendo[k][p] = 1; //le han pillado asi que tendra que hacer otra vez lo de los 30 segundos
		            		        if (PlayerInfo[k][pWanted] < 3 && pillado[k] == 0){ //le sumanos un nivel de wanted si no le han pillado en los ultimos 5 minutos
										PlayerInfo[k][pWanted]++;
										pillado[k] = 300;
									}
			               		} else {
    	    	          	    	SetPlayerMarkerForPlayer(i,k,INVISIBLE);
	    		           		}
						  	}
							else if (PlayerToPoint(200.0,i,ptoX,ptoY,ptoZ)) { //cualkier otro vehiculo policia
	               				SetPlayerMarkerForPlayer(i,k,COLOR_RED);
	               				huyendo[k][p] = 1; //le han pillado asi que tendra que hacer otra vez lo de los 30 segundos
	               				if (PlayerInfo[k][pWanted] < 3 && pillado[k] == 0){ //le sumanos un nivel de wanted si no le han pillado en los ultimos 5 minutos
									PlayerInfo[k][pWanted]++;
									pillado[k] = 300;
								}
		               		} else {
    	              	    	SetPlayerMarkerForPlayer(i,k,INVISIBLE);
	    	           		}
						}
						else if (PlayerToPoint(100.0,i,ptoX,ptoY,ptoZ)) { //si el poli va andando
	               			SetPlayerMarkerForPlayer(i,k,COLOR_RED);
	               			huyendo[k][p] = 1; //le han pillado asi que tendra que hacer otra vez lo de los 30 segundos
      			    	    if (PlayerInfo[k][pWanted] < 3 && pillado[k] == 0){ //le sumanos un nivel de wanted si no le han pillado en los ultimos 5 minutos
								PlayerInfo[k][pWanted]++;
								pillado[k] = 300;
							}
	               		} else {
                  	    	SetPlayerMarkerForPlayer(i,k,INVISIBLE);
	               		}
					}
     			}
   				huyendo[k][huye]--;
			}
			if (huyendo[k][huye] == 2){ //cuando terminan los 30 segundos
			    if (huyendo[k][p] == 0) //si no le habian pillado
			    	huyendo[k][huye] = 0; //se salva
			    else { //si le habian pillado
			        huyendo[k][p] = 0;
			        huyendo[k][huye] = 32; //30 segundos mas
			        if (PlayerInfo[k][pWanted] < 3 && pillado[k] == 0){ //le sumanos un nivel de wanted si no le han pillado en los ultimos 5 minutos
						PlayerInfo[k][pWanted]++;
						pillado[k] = 300;
					}
				}
			}
			if (pillado[k] > 0){//si le habian pillado, tiene 5 minutos hasta que le den el siguiente wanted
			    pillado[k]--;
			}
			if (PlayerInfo[k][pWanted] == 3 && huyendo[k][huye] == 0){
			    for (new i = 0; i < MAX_PLAYERS; i++){
		    		if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] == POLI && OnDuty[i] == 1){
						new Float:ptoX,Float:ptoY,Float:ptoZ;
						GetPlayerPos(k,ptoX,ptoY,ptoZ);
						if (IsPlayerInAnyVehicle(i)){
							new newcar = GetPlayerVehicleID(i);
						  	new model = GetVehicleModel(newcar);
						  	if (model == 497) { //si esta en el helicoptero de la policia
	  							if (PlayerToPoint(500.0,i,ptoX,ptoY,ptoZ)) {
	               					SetPlayerMarkerForPlayer(i,k,COLOR_RED);
			               		} else {
    	    	          	    	SetPlayerMarkerForPlayer(i,k,INVISIBLE);
	    		           		}
						  	}
							else if (PlayerToPoint(200.0,i,ptoX,ptoY,ptoZ)) { //cualkier otro vehiculo policia
	               				SetPlayerMarkerForPlayer(i,k,COLOR_RED);
		               		} else {
    	              	    	SetPlayerMarkerForPlayer(i,k,INVISIBLE);
	    	           		}
						}
						else if (PlayerToPoint(100.0,i,ptoX,ptoY,ptoZ)) { //si el poli va andando
	               			SetPlayerMarkerForPlayer(i,k,COLOR_RED);
	               		} else {
                  	    	SetPlayerMarkerForPlayer(i,k,INVISIBLE);
	               		}
					}
     			}
			}
		}
	}
}

//--------------------FIN CABRA

/*----------------------   VIDA
Hace que si un jugador tiene poca vida se enrosque en el suelo y le salga una aviso a los medicos disponibles en el server.

muriendo[MAX_PLAYERS]: marca el tiempo que le queda al tio para seguir vivo
i : paciente
j : medico
*/
public actuVida(){
	for (new i = 0; i < MAX_PLAYERS; i++){
	    if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] != 2) {
			new destino = random(100);
			if (destino){
			    new desgraciado = random(MAX_PLAYERS);
			    if (IsPlayerConnected(desgraciado) && !IsPlayerNPC(desgraciado) && !enfermo[i] && !muriendo[i]){
			        new string[255];
			        new nombre[MAX_PLAYER_NAME];
			        GetPlayerName(i,nombre,sizeof(nombre));
					format(string,sizeof(string),"%s se retuerce de dolor...",nombre);
			        SendClientMessage(i,COLOR_RED,"Te notas horrible, que alguien llame una ambulancia!");
			        ProxDetector(15.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			        enfermo[i] = 125;
			    }
			}
	        if (enfermo[i] > 0) enfermo[i]--;
	        if (enfermo[i]) {
	            GameTextForPlayer(i,"Has muerto de un infarto!",5000,3);
				SetPlayerHealth(i,0);
				TogglePlayerControllable(i, 0);
	        }

	        if (muriendo[i] > 0) muriendo[i]--;
	        if (muriendo[i]) {
	            GameTextForPlayer(i,"Has muerto!",5000,3);
				SetPlayerHealth(i,0);
				TogglePlayerControllable(i, 0);
 		        for (new j = 0; j < MAX_PLAYERS; j++) {
		            if (IsPlayerConnected(j) && !IsPlayerNPC(j) && (PlayerInfo[j][pTeam] == 2 || PlayerInfo[j][pTeam] == 1)) { //si es medico
	             		SendClientMessage(j,COLOR_RED,"El paciente murio");
	               		SetPlayerMarkerForPlayer(j,i,INVISIBLE);
		            }
				}
	        }
        	new Float:vida;
        	GetPlayerHealth(i,vida);
        	if (floatround(vida) >= 20 && muriendo[i] > 0){ //le han curado
        	    TogglePlayerControllable(i, 1);
        	    ApplyAnimation(i,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);
        	    muriendo[i] = 75;
        	    for (new j = 0; j < MAX_PLAYERS; j++) {
	       	    	if (IsPlayerConnected(j) && !IsPlayerNPC(j) && (PlayerInfo[j][pTeam] == 2 || PlayerInfo[j][pTeam] == 1)) { //si es medico
		            	SendClientMessage(j,COLOR_RED,"Le reanimaron.");
	    	        	SetPlayerMarkerForPlayer(j,i,INVISIBLE);
		    	    }
				}
        	} else if (floatround(vida) <= 5 && !muriendo[i]) { //esta muriendose
               	GameTextForPlayer(i,"Estas podrido tio!",3000,3);
				ApplyAnimation(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
	 			muriendo[i] = 70;
		        for (new j = 0; j < MAX_PLAYERS; j++) {
		            if (IsPlayerConnected(j) && !IsPlayerNPC(j) && (PlayerInfo[j][pTeam] == 2 || PlayerInfo[j][pTeam] == 1)) { //si es medico o poli
        	     		SendClientMessage(j,COLOR_RED,"Atención a todas las unidades, hemos recibido una emergencia.");
            	 		SendClientMessage(j,COLOR_RED,"Se ha actualizado tu radar.");
           	 			SetPlayerMarkerForPlayer(j,i,COLOR_RED);
	   	           		// aki habia ke ponerle la animacion del tunel
					}
	            }
			}
	    }
	}
}
//-----------------------FIN VIDA


public timerConverXoomer(playerid) {
 	if (tiempoConverXoomer[playerid] == M2_TEXTO_INICIO) {
        PlayerTextDrawSetString(playerid,EscenaText[playerid],"Hola, tenemos un trabajo para ti.");
        PlayerTextDrawShow(playerid, EscenaText[playerid]);
 	} else if (tiempoConverXoomer[playerid] == M2_TEXTO_INICIO + 5) {
        PlayerTextDrawSetString(playerid,EscenaText[playerid],"Nos han llegado dos avisos de la empresa de limpieza urbana..");
        PlayerTextDrawShow(playerid, EscenaText[playerid]);
 	} else if (tiempoConverXoomer[playerid] == M2_TEXTO_INICIO + 11) {
        PlayerTextDrawSetString(playerid,EscenaText[playerid],"..y puedes elegir uno de los dos. Cual quieres?");
        PlayerTextDrawShow(playerid, EscenaText[playerid]);
 	} else if (tiempoConverXoomer[playerid] == M2_TEXTO_INICIO + 16) {
        PlayerTextDrawSetString(playerid,EscenaText[playerid],"Elije 1. Policia 2. Aztecas");
        PlayerTextDrawShow(playerid, EscenaText[playerid]);
		SendClientMessage(playerid,COLOR_ORANGE, "1: Departamento de policía");
 		SendClientMessage(playerid,COLOR_ORANGE, "2: Barrio de los aztecas");
 		eligiendoOpcion[playerid] = 11;
		KillTimer(timerConverXoomerID[playerid]);
 		timerOpcionID[playerid] = SetTimerEx("timerOpcion",1000,1,"d",playerid);
 	} else if (tiempoConverXoomer[playerid] == M2_TEXTO_SUBIR_COCHE) {
 	    PlayerTextDrawSetString(playerid,EscenaText[playerid],"Sube al coche");
        PlayerTextDrawShow(playerid, EscenaText[playerid]);
 	} else if (tiempoConverXoomer[playerid] == M2_TEXTO_SUBIR_COCHE+4) {
 		PlayerTextDrawHide(playerid,EscenaText[playerid]);
 		KillTimer(timerConverXoomerID[playerid]);
 	} else if (tiempoConverXoomer[playerid] == M2_MOSTRAR_CABEZA) {
	 	PlayerTextDrawHide(playerid,EscenaText[playerid]);
 	    TogglePlayerControllable(playerid, 0);
 	  	SetPlayerCameraPos(playerid,-1978.000,1336.000,8.000);
		SetPlayerCameraLookAt(playerid,-1977.000,1335.000,6.000);
 	} else if (tiempoConverXoomer[playerid] == M2_MOSTRAR_CABEZA+5) {
 	    TogglePlayerControllable(playerid, 1);
 	    SetCameraBehindPlayer(playerid);
  	    SendClientMessage(playerid,COLOR_GRAD1,"Mafioso: Ye chico, ven aqui.");
		contChkPnt[playerid]++;
 	    SetPlayerCheckpoint(playerid,-1968.4932,1374.4669,7.1875,1);
 		KillTimer(timerConverXoomerID[playerid]);
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO) {
		PlayerTextDrawHide(playerid,EscenaText[playerid]);
	    //TogglePlayerControllable(playerid, 0);
	    SendClientMessage(playerid,COLOR_GRAD1,"Mafioso: ¿Qué haces mirando en nuestra basura?");
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO + 3) {
	    new auxn[MAX_PLAYER_NAME];
	    new str[50];
	    GetPlayerName(playerid,auxn,sizeof(auxn));
	    format(str,sizeof(str),"%s: Estoy trabajando",auxn);
	    SendClientMessage(playerid,COLOR_GRAD1,str);
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO + 5) {
	    SendClientMessage(playerid,COLOR_GRAD1,"Mafioso: Vaya mierda de trabajo, ¿quieres trabajar para nosotros?");
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO + 8) {
	    new auxn[MAX_PLAYER_NAME];
	    new str[70];
	    GetPlayerName(playerid,auxn,sizeof(auxn));
	    format(str,sizeof(str),"%s: Claro que sí.. ¿Qué tengo que hacer?",auxn);
	    SendClientMessage(playerid,COLOR_GRAD1,str);
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO + 11) {
	    SendClientMessage(playerid,COLOR_GRAD1,"Mafioso: Le dije a Badboy que tirase los restos del último policía que descuartizamos a la basura..");
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO + 15) {
 	    SendClientMessage(playerid,COLOR_GRAD1,"Mafioso: ..y el muy tonto los tiró en este barrio, recójelo y mételos en esa casa.");
	} else if (tiempoConverXoomer[playerid] == M2_CONVERSACION_MAFIOSO + 18) {
	    new auxn[MAX_PLAYER_NAME];
	    new str[50];
	    GetPlayerName(playerid,auxn,sizeof(auxn));
	    format(str,sizeof(str),"%s: Ok",auxn);
	    SendClientMessage(playerid,COLOR_GRAD1,str);
	    //TogglePlayerControllable(playerid, 1);
	    GameTextForPlayer(playerid,"recoge los restos",3500,6);
		objetosFaltanM2 = M2_NUM_OBJETOS;
		contChkPnt[playerid]++;
	 	timerObjetosM2ID = SetTimerEx("timerObjetosM2",1000,1,"d",playerid);
	    SetPlayerCheckpoint(playerid,-1983.6531,1372.3242,7.1942, 1.0);
		KillTimer(timerConverXoomerID[playerid]);
	}
 	tiempoConverXoomer[playerid]++;
}

public crearObjetosM2() {
	for (new i = 0; i < M2_NUM_OBJETOS; i++)
		idObjetoM2[i] = CreateObject(tipoObjetoM2[i],objetoM2[i][0],objetoM2[i][1],objetoM2[i][2],0.0,0.0,0.0);
}

public timerOpcion(playerid) {
	if (eligiendoOpcion[playerid] == 0) {
		PlayerTextDrawHide(playerid,EscenaText[playerid]);
	    GameTextForPlayer(playerid,"Vuelve cuando lo tengas mas claro chico", 5000, 6);
	    tiempoConverXoomer[playerid] = 0;
	    NPCocupado[MISION_XOOMER_FIN] = 0;
	    SetPlayerPos(playerid,-1869.4950,942.1711,35.1719);
	    KillTimer(timerConverXoomerID[playerid]);
	    KillTimer(timerOpcionID[playerid]);
 	}
	if (eligiendoOpcion[playerid] > 0)
	    eligiendoOpcion[playerid]--;
}

public timerObjetosM2(playerid) {
	if (objetosFaltanM2 == 0) {
		tiempoConverXoomer[playerid] = 0;
		NPCocupado[MISION_XOOMER_FIN] = 0;
		DisablePlayerCheckpoint(playerid);
	    KillTimer(timerObjetosM2ID);
	}
	for (new i = 0; i < M2_NUM_OBJETOS; i++) {
	    if (PlayerToPoint( 2.0, playerid, objetoM2[i][0],  objetoM2[i][1],  objetoM2[i][2]) && IsValidObject(idObjetoM2[i]) && cargandoM2 == 0) {
	        DestroyObject(idObjetoM2[i]);
	        SetPlayerAttachedObject(playerid, SLOT_PIEZA_M2, 1264, 6); //bolsa basura
	        idObjetoM2[i] = -1;
			cargandoM2 = 1;
	    }
	}
}

//---------------- mecanicos taller
stock CarmodDialog(playerid)
{
	ShowPlayerDialog(playerid,1111,DIALOG_STYLE_LIST,"Seleccione su opción","Nitro(x2 Tanques)\nCar Color\nLlantas\nStereo\nHydraulics\nCar Componentes","Select","Cancel");
	return 1;
}
stock RegularCarDialog(playerid)
{
    new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
 	new string[128];
	if(vehmd == 401 || vehmd == 496 || vehmd == 518 || vehmd == 540 || vehmd == 546 || vehmd == 589)
	{string = "Spoiler\nCapó\nTecho\nVents\nSideskirt\nLuces\n{FF0000}atrás";}
	else if(vehmd == 549)
	{string = "Spoiler\nCapó\nVents\nSideskirt\nLuces\n{FF0000}Atrás";}
	else if(vehmd == 550)
	{string = "Spoiler\nHood\nRoof\nVents\nLuces\n{FF0000}Atrás";}
	else if(vehmd == 585 || vehmd == 603)
	{string = "Spoiler\nTecho\nVents\nSideskirt\nLuces\n{FF0000}Atrás";}
	else if(vehmd == 410 || vehmd == 436)
	{string = "Spoiler\nTecho\nSideskirt\nLuces\n{FF0000}Atrás";}
	else if(vehmd == 439 || vehmd == 458)
	{string = "Spoiler\nVents\nSideskirt\nLuces\n{FF0000}Atrás";}
	else if(vehmd == 551 || vehmd == 492 || vehmd == 529)
	{string = "Spoiler\nCapó\nTecho\nSideskirt\n{FF0000}Atrás";}
	else if(vehmd == 489 || vehmd == 505)
	{string = "Spoiler\nCapó\nTecho\nLuces\n{FF0000}Atrás";}
	else if(vehmd == 516)
	{string = "Spoiler\nCapó\nSideskirt\n{FF0000}Atrás";}
	else if(vehmd == 491 || vehmd == 517)
	{string = "Spoiler\nVents\nSideskirt\n{FF0000}Atrás";}
	else if(vehmd == 418 || vehmd == 527 || vehmd == 580)
	{string = "Spoiler\nTecho\nSideskirt\n{FF0000}Atrás";}
	else if(vehmd == 420 || vehmd == 587)
	{string = "Spoiler\nCapó\n{FF0000}Atrás";}
	else if(vehmd == 547)
	{string = "Spoiler\nVents\n{FF0000}Atrás";}
	else if(vehmd == 415)
	{string = "Spoiler\nSideskirt\n{FF0000}Atrás";}

    ShowPlayerDialog(playerid,1004,DIALOG_STYLE_LIST,"Selecciona tu opción",string,"Selección","Cancel");
    return 1;
}

stock Mod(playerid)//Alien
{
    ShowPlayerDialog(playerid,1511,DIALOG_STYLE_LIST,"Selecciona tu opción","Right Sideskirt\nLeft Sideskirt\nExhaust\nRoof\nSpoiler\nFront Bumper\nRear Bumper\n{FF0000}Back","Select","Cancle");
    return 1;
}
stock Mod1(playerid)//X-Flow
{
	ShowPlayerDialog(playerid,1512,DIALOG_STYLE_LIST,"Selecciona tu opción","Right Sideskirt\nLeft Sideskirt\nExhaust\nRoof\nSpoiler\nFront Bumper\nRear Bumper\n{FF0000}Back","Select","Cancle");
	return 1;
}
stock Mod2(playerid)//Chrome
{
 
    new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
    new string[128];
	if(vehmd == 576 || vehmd == 575)
	{string = "Right Sideskirt\nLeft Sideskirt\nExhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	else if(vehmd == 535)
	{string = "Front Bullbars\nRear Bullbars\nExhaust\nFront Bumper\nRight Sideskirt\nLeft Sideskirt\n{FF0000}Back";}
	else if(vehmd == 567 || vehmd == 536)
	{string = "Exhaust\nRight Sideskirt\nLeft Sideskirt\nRear Bumper\nFront Bumper\n{FF0000}Back";}
	else if(vehmd == 534)
	{string = "Grill\nBars\nLights\nExhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}

    ShowPlayerDialog(playerid,1513,DIALOG_STYLE_LIST,"Choose one",string,"Select","Cancle");
	return 1;
}
stock Mod3(playerid)//Slamin
{
    new vehmd = GetVehicleModel(GetPlayerVehicleID(playerid));
    new string[128];
    if(vehmd == 575 || vehmd == 576)
	{string = "Exhaust\nFront Bumper\nRear Bumper\n{FF0000}Back";}
	else if(vehmd == 535)
	{string = "Rear Bullbars\nFront Bullbars\nExhaust\nRight Sideskirt\nLeft Sidedkirt\n{FF0000}Back";}
	else if(vehmd == 567 || vehmd == 536 || vehmd == 534)
	{string = "Front Bumper\nRear Bumper\nExhaust\n{FF0000}Back";}
    ShowPlayerDialog(playerid,1514,DIALOG_STYLE_LIST,"Choose one",string,"Select","Cancle");
    return 1;
}
stock Lowrider(playerid)
{
    ShowPlayerDialog(playerid,1001,DIALOG_STYLE_LIST,"Escoja su opción","Paintjob\nCromo\nSlamin\n{FF0000}Back","Select","Cancel");
    return 1;
}

// ------------------------ Cosas de bomeros -------------------
public OnFireUpdate() {
	new aim, piss;
	for(new playerid; playerid < MAX_PLAYERS; playerid++) {
        aim = -1; piss = -1;
	    if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) { continue; }
		if(PlayerOnFire[playerid] && !CanPlayerBurn(playerid, 1)) {
			StopPlayerBurning(playerid);
		}
		if(Pissing_at_Flame(playerid) != -1 || Aiming_at_Flame(playerid) != -1) {
			piss = Pissing_at_Flame(playerid); aim = Aiming_at_Flame(playerid);

//			GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~LLamas a la vista!", 1500, 6);
			if(ExtTimer[playerid] == -1 && ((aim != -1 && Pressing(playerid) & KEY_FIRE) || piss != -1))
			{
			    new value, time, Float:x, Float:y, Float:z;
			    if(piss != -1)
			    {
					value = piss;
					time = EXTINGUISH_TIME_PEEING;
				}
				else if(aim != -1)
				{
					value = aim;
					if(GetPlayerWeapon(playerid) == 41)
					{
						CreateExplosion(Flame[value][Flame_pos][0], Flame[value][Flame_pos][1], Flame[value][Flame_pos][2], 2, 5);
						continue;
					}
					if(IsPlayerInAnyVehicle(playerid))
					{
					    time = EXTINGUISH_TIME_VEHICLE;
					}
					else
					{
						time = EXTINGUISH_TIME_ONFOOT;
					}
				}
				if(value < -1) { time = EXTINGUISH_TIME_PLAYER; }
				time *= 1000;
				if(value >= -1)
				{
					x = Flame[value][Flame_pos][0];
				    y = Flame[value][Flame_pos][1];
				    z = Flame[value][Flame_pos][2];
				    DestroyTheSmokeFromFlame(value);
					Flame[value][Smoke][0] = CreateObject(18727, x, y, z, 0.0, 0.0, 0.0);
					Flame[value][Smoke][1] = CreateObject(18727, x+1, y, z, 0.0, 0.0, 0.0);
					Flame[value][Smoke][2] = CreateObject(18727, x-1, y, z, 0.0, 0.0, 0.0);
					Flame[value][Smoke][3] = CreateObject(18727, x, y+1, z, 0.0, 0.0, 0.0);
					Flame[value][Smoke][4] = CreateObject(18727, x, y-1, z, 0.0, 0.0, 0.0);
					SetTimerEx("DestroyTheSmokeFromFlame", time, 0, "d", value);
				}
				ExtTimer[playerid] = SetTimerEx("FireTimer", time, 0, "dd", playerid, value);
			}
		}
		if(CanPlayerBurn(playerid) && IsAtFlame(playerid))
		{
			SetPlayerBurn(playerid);
		}
		new Float:x, Float:y, Float:z;
		for(new i; i < MAX_PLAYERS; i++)
	  	{
	  	    if(playerid != i && IsPlayerConnected(i) && !IsPlayerNPC(i))
		  	{
			  	if(CanPlayerBurn(i) && PlayerOnFire[playerid] && !PlayerOnFire[i])
	  	    	{
				  	GetPlayerPos(i, x, y, z);
					if(IsPlayerInRangeOfPoint(playerid, 1, x, y, z))
					{
					    SetPlayerBurn(i);
					}
				}
			}
		}
 	}
	return 1;
}


public AddFire(Float:x, Float:y, Float:z)
{
	new slot = GetFlameSlot();
	if(slot == -1) {return slot;}
	Flame[slot][Flame_Exists] = 1;
	Flame[slot][Flame_pos][0] = x;
	Flame[slot][Flame_pos][1] = y;
	Flame[slot][Flame_pos][2] = z - Z_DIFFERENCE;
	Flame[slot][Flame_id] = CreateObject(18689, Flame[slot][Flame_pos][0], Flame[slot][Flame_pos][1], Flame[slot][Flame_pos][2], 0.0, 0.0, 0.0);
	return slot;
}

public KillFire(id)
{
 	DestroyObject(Flame[id][Flame_id]);
	Flame[id][Flame_Exists] = 0;
	Flame[id][Flame_pos][0] = 0.0;
	Flame[id][Flame_pos][1] = 0.0;
	Flame[id][Flame_pos][2] = 0.0;
	DestroyTheSmokeFromFlame(id);
}

public AddSmoke(Float:x, Float:y, Float:z)
{
	return CreateObject(18727, x, y, z, 0.0, 0.0, 0.0);
}

public KillSmoke(id) {
 	DestroyObject(id);
}

// Destroys extinguishing-smoke
public DestroyTheSmokeFromFlame(id)
{
    for(new i; i < 5; i++) { DestroyObject(Flame[id][Smoke][i]); }
}

public FireTimer(playerid, id)
{
	if(id < -1 && (Aiming_at_Flame(playerid) == id || Pissing_at_Flame(playerid) == id)) { StopPlayerBurning(id+MAX_PLAYERS); }
	else if(Flame[id][Flame_Exists] && ((Pressing(playerid) & KEY_FIRE && Aiming_at_Flame(playerid) == id) || (Pissing_at_Flame(playerid) == id)))
	{
		new sendername[MAX_PLAYER_NAME+26];
		GetPlayerName(playerid, sendername, sizeof(sendername));

	    if(Pissing_at_Flame(playerid) == id)
		{
			SendClientMessage(playerid, FireMessageColor, "* You pissed out a fire! *");
		}
		else if(Aiming_at_Flame(playerid) == id)
		{
			SendClientMessage(playerid, FireMessageColor, "* You extinguished a fire! *");
		}

	    KillFire(id);
		GivePlayerMoney(playerid, 1);
		for (new i = 0; i < NUM_FUEGOS_TEJADO; i++) {
	    	if (fuegoTejadoID[i] == id) {
				fuegoTejadoID[i] = AddFire(CoordFuegoTejado[i][0],CoordFuegoTejado[i][1],CoordFuegoTejado[i][2]);
			}
		}
	}
	KillTimer(ExtTimer[playerid]);
	ExtTimer[playerid] = -1;
}

public SetPlayerBurn(playerid)
{
    SetPlayerAttachedObject(playerid, FIRE_OBJECT_SLOT, 18690, 2, -1, 0, -1.9, 0, 0);
	PlayerOnFire[playerid] = 1;
	GetPlayerHealth(playerid, PlayerOnFireHP[playerid]);
	KillTimer(PlayerOnFireTimer[playerid]); KillTimer(PlayerOnFireTimer2[playerid]);
	PlayerOnFireTimer[playerid] = SetTimerEx("BurningTimer", 91, 1, "d", playerid);
	PlayerOnFireTimer2[playerid] = SetTimerEx("StopPlayerBurning", 7000, 0, "d", playerid);
	return 1;
}

public BurningTimer(playerid)
{
	if(PlayerOnFire[playerid])
	{
	    new Float:hp;
	    GetPlayerHealth(playerid, hp);
	    if(hp < PlayerOnFireHP[playerid])
	    {
	        PlayerOnFireHP[playerid] = hp;
		}
		CallRemoteFunction("SetPlayerHealth", "dd", playerid, PlayerOnFireHP[playerid]-1.0);
	    PlayerOnFireHP[playerid] -= 1.0;
	}
	else { KillTimer(PlayerOnFireTimer[playerid]); KillTimer(PlayerOnFireTimer2[playerid]); }
}

public StopPlayerBurning(playerid)
{
	KillTimer(PlayerOnFireTimer[playerid]);
	PlayerOnFire[playerid] = 0;
	RemovePlayerAttachedObject(playerid, FIRE_OBJECT_SLOT);
}

//===================== Other Functions ====================

stock GetFireID(Float:x, Float:y, Float:z, &Float:dist)
{
	new id = -1;
	dist = 99999.99;
	for(new i; i < MAX_FLAMES; i++)
	{
	    if(GetDistanceBetweenPoints(x,y,z,Flame[i][Flame_pos][0],Flame[i][Flame_pos][1],Flame[i][Flame_pos][2]) < dist)
	    {
	        dist = GetDistanceBetweenPoints(x,y,z,Flame[i][Flame_pos][0],Flame[i][Flame_pos][1],Flame[i][Flame_pos][2]);
	        id = i;
		}
	}
	return id;
}

stock CanPlayerBurn(playerid, val = 0)
{
	if(!IsPlayerInWater(playerid) && (!val && !PlayerOnFire[playerid]) || (val && PlayerOnFire[playerid])) { return 1; }
	return 0;
}

 //Uncomment or copy to your script.
/*
forward CanBurn(playerid);
public CanBurn(playerid)
{
//	if(...)
//	{
	return 1;
//	}
//	return -1; // IMPORTANT!
}*/


stock IsPlayerInWater(playerid)
{
	new Float:X, Float:Y, Float:Z, an = GetPlayerAnimationIndex(playerid);
	GetPlayerPos(playerid, X, Y, Z);
	if((1544 >= an >= 1538 || an == 1062 || an == 1250) && (Z <= 0 || (Z <= 41.0 && IsPlayerInArea(playerid, -1387, -473, 2025, 2824))) ||
	(1544 >= an >= 1538 || an == 1062 || an == 1250) && (Z <= 2 || (Z <= 39.0 && IsPlayerInArea(playerid, -1387, -473, 2025, 2824))))
	{
	    return 1;
 	}
 	return 0;
}

stock IsPlayerInArea(playerid, Float:MinX, Float:MaxX, Float:MinY, Float:MaxY)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	#pragma unused z
    if(x >= MinX && x <= MaxX && y >= MinY && y <= MaxY) { return 1; }
    return 0;
}

stock GetFlameSlot()
{
	for(new i = 0; i < MAX_FLAMES; i++)
	{
		if(!Flame[i][Flame_Exists]) { return i; }
	}
	return -1;
}

//===================== "Callbacks" ====================

stock IsAtFlame(playerid)
{
	for(new i; i < MAX_FLAMES; i++)
	{

	    if(Flame[i][Flame_Exists])
		{
		    if(!IsPlayerInAnyVehicle(playerid) && (IsPlayerInRangeOfPoint(playerid, FLAME_ZONE, Flame[i][Flame_pos][0], Flame[i][Flame_pos][1], Flame[i][Flame_pos][2]+Z_DIFFERENCE) ||
												   IsPlayerInRangeOfPoint(playerid, FLAME_ZONE, Flame[i][Flame_pos][0], Flame[i][Flame_pos][1], Flame[i][Flame_pos][2]+Z_DIFFERENCE-1)))
		    {
				return 1;
			}
		}
	}
	return 0;
}

new AaF_cache[MAX_PLAYERS] = { -1, ... };
new AaF_cacheTime[MAX_PLAYERS];

stock Aiming_at_Flame(playerid)
{
	if(gettime() - AaF_cacheTime[playerid] < 1)
  	{
  	    return AaF_cache[playerid];
 	}
 	AaF_cacheTime[playerid] = gettime();

	new id = -1;
	new Float:dis = 99999.99;
	new Float:dis2;
	new Float:px, Float:py, Float:pz;
	new Float:x, Float:y, Float:z, Float:a;
	GetXYInFrontOfPlayer(playerid, x, y, z, a, 1);
	z -= Z_DIFFERENCE;

	new Float:cx,Float:cy,Float:cz,Float:fx,Float:fy,Float:fz;
	GetPlayerCameraPos(playerid, cx, cy, cz);
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);

	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && PlayerOnFire[i] && (IsInWaterCar(playerid) || HasExtinguisher(playerid) || GetPlayerWeapon(playerid) == 41 || Peeing(playerid)) && PlayerOnFire[i])
	    {
	        GetPlayerPos(i, px, py, pz);
	        if(!Peeing(playerid))
		 	{
	        	dis2 = DistanceCameraTargetToLocation(cx, cy, cz, px, py, pz, fx, fy, fz);
 			}
 			else
 			{
 			    if(IsPlayerInRangeOfPoint(playerid, ONFOOT_RADIUS, px, py, pz))
				{
	        		dis2 = 0.0;
				}
 			}
	        if(dis2 < dis)
	        {
				dis = dis2;
	    		id = i;
	    		if(Peeing(playerid))
	    		{
	    		    return id;
				}
			}
		}
	}
	if(id != -1) { return id-MAX_PLAYERS; }
	for(new i; i < MAX_FLAMES; i++)
	{
		if(Flame[i][Flame_Exists])
		{
		    if(IsInWaterCar(playerid) || HasExtinguisher(playerid) || GetPlayerWeapon(playerid) == 41 || Peeing(playerid))
		    {
		        if(!Peeing(playerid))
				{
					dis2 = DistanceCameraTargetToLocation(cx, cy, cz, Flame[i][Flame_pos][0], Flame[i][Flame_pos][1], Flame[i][Flame_pos][2]+Z_DIFFERENCE, fx, fy, fz);
				}
				else
				{
				    dis2 = GetDistanceBetweenPoints(x,y,z,Flame[i][Flame_pos][0],Flame[i][Flame_pos][1],Flame[i][Flame_pos][2]);
				}
				if((IsPlayerInAnyVehicle(playerid) && dis2 < CAR_RADIUS && dis2 < dis) || (!IsPlayerInAnyVehicle(playerid) && ((dis2 < ONFOOT_RADIUS && dis2 < dis) || (Peeing(playerid) && dis2 < PISSING_WAY && dis2 < dis))))
				{
				    dis = dis2;
				    id = i;
				}
			}
		}
	}
	if(id != -1)
	{
		if
		(
			(
				IsPlayerInAnyVehicle(playerid) && !IsPlayerInRangeOfPoint(playerid, 50, Flame[id][Flame_pos][0], Flame[id][Flame_pos][1], Flame[id][Flame_pos][2])
			)
			||
			(
				!IsPlayerInAnyVehicle(playerid)  && !IsPlayerInRangeOfPoint(playerid, 5, Flame[id][Flame_pos][0], Flame[id][Flame_pos][1], Flame[id][Flame_pos][2])
			)
		)
		{ id = -1; }
	}
	AaF_cache[playerid] = id;
	return id;
}

stock Pissing_at_Flame(playerid)
{
	if(Peeing(playerid))
	{
	    new string[22];
	    format(string, sizeof(string), "%d", Aiming_at_Flame(playerid));
	    SendClientMessage(playerid, 0xFFFFFFFF, string);
	    return strval(string);
	}
	return -1;
}

stock IsInWaterCar(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 407 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 601) { return 1; }
	return 0;
}

stock HasExtinguisher(playerid)
{
    if(GetPlayerWeapon(playerid) == 42 && !IsPlayerInAnyVehicle(playerid)) { return 1; }
	return 0;
}

stock Peeing(playerid)
{
	return GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_PISSING;
}

stock Pressing(playerid)
{
	new keys, updown, leftright;
	GetPlayerKeys(playerid, keys, updown, leftright);
	return keys;
}

//===================== Important Shit ====================

forward MMF_ExtFire(version[15]);
public MMF_ExtFire(version[15])
{
	if(strcmp(VERSION, version, true) && strlen(version))
	{
	    return 2;
	}
	return 1;
}

public crearExplosion() {
	new semilla = random(NUM_EXPLOSIONES);
	CreateExplosion(CoordExplosiones[semilla][0],CoordExplosiones[semilla][1],CoordExplosiones[semilla][2], 2, 200);
}

public crearExplosionEdificio() {
	for (new i = 0; i < NUM_EXPLOSIONES_EDIFICIO; i++) {
		CreateExplosion(CoordExplosionesEdificio[i][0],CoordExplosionesEdificio[i][1],CoordExplosionesEdificio[i][2], 2, 200);
		AddFire(CoordExplosionesEdificio[i][0]+2.0,CoordExplosionesEdificio[i][1]+2.0,CoordExplosionesEdificio[i][2]);
		AddFire(CoordExplosionesEdificio[i][0]+2.0,CoordExplosionesEdificio[i][1]-2.0,CoordExplosionesEdificio[i][2]);
	}
}

public crearExplosionNoControlada() {
	for (new i = 0; i < NUM_EXPLOSIONES_NO_CONTROL; i++) {
		CreateExplosion(CoordExplosionesNoControl[i][0],CoordExplosionesNoControl[i][1],CoordExplosionesNoControl[i][2], 2, 200);
		AddFire(CoordExplosionesNoControl[i][0]+2.0,CoordExplosionesNoControl[i][1]+2.0,CoordExplosionesNoControl[i][2]);
		AddFire(CoordExplosionesNoControl[i][0]+2.0,CoordExplosionesNoControl[i][1]-2.0,CoordExplosionesNoControl[i][2]);
	}
	for (new i = 0; i < MAX_PLAYERS; i++) {
	    if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerToPoint(30.0, i, 2088.0, 1307.40002, -39.7)){
			GameTextForPlayer(i, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Has muerto por la explosion", 2500, 6);
			SetPlayerHealth(i,0.0);
	    }
	}
}

public crearExplosionEnfrente() {
	for (new i = 0; i < NUM_EXPLOSIONES_ENFRENTE; i++) {
		CreateExplosion(CoordExplosionesEnfrente[i][0],CoordExplosionesEnfrente[i][1],CoordExplosionesEnfrente[i][2], 2, 200);
		AddFire(CoordExplosionesEnfrente[i][0]+2.0,CoordExplosionesEnfrente[i][1]+2.0,CoordExplosionesEnfrente[i][2]);
		AddFire(CoordExplosionesEnfrente[i][0]+2.0,CoordExplosionesEnfrente[i][1]-2.0,CoordExplosionesEnfrente[i][2]);
	}
}

public crearFuegoTejado() {
	for (new i = 0; i < NUM_FUEGOS_TEJADO; i++){
	    fuegoTejadoID[i] = AddFire(CoordFuegoTejado[i][0],CoordFuegoTejado[i][1],CoordFuegoTejado[i][2]);
	}
}

public crearFuegosEstaticos() {
	for (new i = 0; i < FUEGOS_ESTATICOS; i++)
	    fuegoEstaticoID[i] = CreateObject(18691, fuegoEstatico[i][0], fuegoEstatico[i][1], fuegoEstatico[i][2], 0, 0, 0);
}

public eliminarFuegosEstaticos() {
  	for (new i = 0; i < FUEGOS_ESTATICOS; i++)
  	    DestroyObject(fuegoEstaticoID[i]);
}

public crearFuegosDeCasa() {
	for (new i = 0; i < FUEGOS_DE_CASA; i++) {
	    fuegosDeCasaID[i] = AddFire(CoordFuegosDeCasa[i][0],CoordFuegosDeCasa[i][1],CoordFuegosDeCasa[i][2]);
	}
}

public eliminarFuegosDeCasa() {
	for (new i = 0; i < FUEGOS_DE_CASA; i++) {
	    KillFire(fuegosDeCasaID[i]);
	}
}

public timerGasCiudad() {
	CreateExplosion(CoordExplosionGasCiudad[tiempoGasCiudad][0],CoordExplosionGasCiudad[tiempoGasCiudad][1],CoordExplosionGasCiudad[tiempoGasCiudad][2],2, 200);
	tiempoGasCiudad++;
 	if (tiempoGasCiudad >= NUM_EXPLOSIONES_GAS_CIUDAD) {
 	    crearExplosionEnfrente();
        tiempoGasCiudad = 0;
		CreateObject(18723,-2243.09, 701.93, 48.99,0.0,0.0,0.0,200.0); //humo edificio en frente
        KillTimer(timerGasCiudadID);
	}
}

public exploRapida() {
	crearExplosion();
}

public timerEventoBombero(){
	if (tiempoEventoBombero == 0) {
		exploRapidaID = SetTimer("exploRapida",2000,1);
		crearFuegoTejado();
		crearFuegosEstaticos();
		KillTimer(TimerMediaHoraID);
	}
	if (tiempoEventoBombero == 50) {
	    for (new i = 0; i < MAX_PLAYERS; i++) {
	        if (IsPlayerConnected(i) && !IsPlayerNPC(i) && PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1) {
				GameTextForPlayer(i, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Alarma alarma!", 2500, 6);
                SetPlayerMapIcon(i,0, CoordExplosiones[0][0],CoordExplosiones[0][1],CoordExplosiones[0][2],20,MAPICON_GLOBAL);
         	}
	    }
    } else if (tiempoEventoBombero == 200 || tiempoEventoBombero == 317 || tiempoEventoBombero == 434 ||
				tiempoEventoBombero == 551 || tiempoEventoBombero == 667) {
		randCoordBombero = random(MAX_COORDENADAS_BOMBEROS);
	    for(new i=0 ; i < MAX_PLAYERS; i++) {
	        if(PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1) {
	        	crearFuegosDeCasa();
		        GameTextForPlayer(i, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Hay una persona dentro, Salvala!", 3000, 6);
                SetPlayerCheckpoint(i, coordBomberosEntrada[randCoordBombero][0],coordBomberosEntrada[randCoordBombero][1],coordBomberosEntrada[randCoordBombero][2], 1);
	        }
	    }

    } else if (tiempoEventoBombero == 107 || tiempoEventoBombero == 244 || tiempoEventoBombero == 341 ||
				tiempoEventoBombero == 457 || tiempoEventoBombero == 574 || tiempoEventoBombero == 690 ) {
		for(new i=0 ; i < MAX_PLAYERS; i++)
	        if(PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1){
				GameTextForPlayer(i, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~El bajo va a explotar! salgan de ahi ya!", 3000, 6);
			 	SetPlayerCheckpoint(i, 2092.9502,1291.2554,-42.6625, 1.5);
            }
	} else if (tiempoEventoBombero == 114 || tiempoEventoBombero == 250 || tiempoEventoBombero == 347 ||
				tiempoEventoBombero == 463 || tiempoEventoBombero == 580 || tiempoEventoBombero == 696 ) {
    	crearExplosionNoControlada();
		CreateObject(18723,-2280.06,707.14,49.5,0.0,0.0,0.0,200.0); //humo edificio en frente
    	for(new i=0 ; i < MAX_PLAYERS; i++) {
            if(PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1) {
                DisablePlayerCheckpoint(i);
            }
        }
        eliminarFuegosDeCasa();
	//	KillTimer(timerBomberos);
	} else if (tiempoEventoBombero == 180 || tiempoEventoBombero == 600) {
		for(new i=0 ; i < MAX_PLAYERS; i++)
	        if(PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1)
	        	GameTextForPlayer(i, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~El fuego se ha propagado, Cuidado!", 3000, 6);

    } else if (tiempoEventoBombero == 184 || tiempoEventoBombero == 604) {
		CreateObject(18723,-2278.82, 686.72, 49.5,0.0,0.0,0.0,200.0); //humo edificio de al lado
    	crearExplosionEdificio();
	//	KillTimer(timerBomberos);
	} else if (tiempoEventoBombero == 230 || tiempoEventoBombero == 500) {
		for(new i=0 ; i < MAX_PLAYERS; i++)
	        if(PlayerInfo[i][pTeam] == BOMBEROS && OnDuty[i] == 1)
	        	GameTextForPlayer(i, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Va a explotar la tuberia de gas! salgan de ahi ya!", 3000, 6);
				
    } else if (tiempoEventoBombero == 235 || tiempoEventoBombero == 505) {
   		timerGasCiudadID = SetTimer("timerGasCiudad",10,1);
	} else if (tiempoEventoBombero == 701) {
	    KillTimer(exploRapidaID);
		KillTimer(timerEventoBomberoID);
		TimerMediaHoraID = SetTimer("TimerMediaHora", 2000, 1); //ATENCION, AHORA ES UN TIMER DE 1 HORA
	 	tiempoEventoBombero = -20;
	 	eliminarFuegosEstaticos();
		for (new i = 0; i < MAX_FLAMES; i++)
            KillFire(i);
	}
	tiempoEventoBombero++;
}


public TimerMediaHora() {
	if (contadorTimerMediaHora == 1800) {
	    KillTimer(TimerMediaHoraID);
		contadorTimerMediaHora = 0;
    	timerEventoBomberoID = SetTimer("timerEventoBombero",1000,1);
	}
	contadorTimerMediaHora++;
}

public esCocheBomberos(id) {
	for (new i = 0; i < NUM_COCHES_BOMBEROS; i++) {
	    if (id == CochesBomberos[i])
	        return true;
	}
	return false;
}

public esCochePolicia(id) {
	for (new i = 0; i < NUM_COCHES_POLICIA; i++) {
	    if (id == CochesPolicia[i])
	        return true;
	}
	return false;
}

public esMoto(_vehid) {
	new model = GetVehicleModel(_vehid);
	if (model == 448 || model == 461 || model == 462 || model == 463 || model == 468 || model == 521 ||
	    model == 523 || model == 581 ) {
	    return true;
	}
	return false;
}


public puedePonerBarrera(playerid) {
	if (numBarreras[playerid] == MAX_BARRERA-1)
		return false;
	return true;
}

public crearBarrera(playerid) {
	if (puedePonerBarrera(playerid)) {
		new Float:x, Float:y, Float:z, Float:a;
		GetXYInFrontOfPlayer(playerid, x, y, z, a, 1.0);
		if (PlayerInfo[playerid][pTeam] == POLI)
	 		BarreraID[playerid][numBarreras[playerid]] = CreateObject(1459, x, y, z-0.5 ,0, 0, a);
  		else if(PlayerInfo[playerid][pTeam] == BOMBEROS)
	 		BarreraID[playerid][numBarreras[playerid]] = CreateObject(1238, x, y, z-0.65 ,0, 0, a);
 		numBarreras[playerid]++;
	} else {
	    SendClientMessage(playerid,COLOR_RED, "No puedes poner más barreras, elimina primero");
	}
}

public eliminarBarrera(playerid) {
	if ( numBarreras[playerid] > 0) {
		numBarreras[playerid]--;
	    DestroyObject(BarreraID[playerid][numBarreras[playerid]]);
	} else {
	    SendClientMessage(playerid,COLOR_RED, "Ya las quitaste todas!");
	}
}

//----------------- Fin bomberos

//------------------- Avisos
public existeAviso(id) {
	for (new i = 0; i < MAX_PLAYERS; i++) {
	    if (avisos[i][taID] == id && avisos[i][taValido] > 1) {
	        return i;
		}
	}
	return -1;
}

public cerrarAviso(creador) {
    avisos[creador][taValido] = 0;
}

public infoAviso(playerid, avisoid) {
	new existe = existeAviso(avisoid);
	if (existe != -1) {
	    new msg[255];
	    new nombre[MAX_PLAYER_NAME];
	    GetPlayerName(existe,nombre,sizeof(nombre));
	    format(msg,sizeof(msg), "Aviso (%d) por %s(%d)", avisoid, nombre, existe);
		SendClientMessage(playerid, COLOR_ORANGE, msg);
		if (PlayerInfo[existe][pTeam] == POLI)
			format(msg,sizeof(msg), "Departamento policías");
		else if (PlayerInfo[existe][pTeam] == MEDICO)
			format(msg,sizeof(msg), "Departamento urgencias");
		else if (PlayerInfo[existe][pTeam] == BOMBEROS)
			format(msg,sizeof(msg), "Departamento bomberos");
		SendClientMessage(playerid, COLOR_ORANGE, msg);
		format(msg,sizeof(msg), "Informe: %s", avisos[existe][taMensaje]);
		SendClientMessage(playerid, COLOR_ORANGE, msg);
	} else {
	    SendClientMessage(playerid, COLOR_RED, "No hay información sobre ese aviso");
	}
}


public mostrarAvisos(playerid) {
	SendClientMessage(playerid,COLOR_GRAD1, "Avisos de la última hora");
	new msg[200];
	new nombre[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++) {
		if (avisos[i][taValido] > 1) {
		    GetPlayerName(i,nombre,sizeof(nombre));
		    format(msg,sizeof(msg),"ID:%d Hora:%d:%d Creador:%s(%d)",avisos[i][taID], avisos[i][taHour],avisos[i][taMin],nombre,i);
		    if (i % 2 == 0)
			    SendClientMessage(playerid,COLOR_GRAD2, msg);
			else
			    SendClientMessage(playerid,COLOR_GRAD3, msg);
		}
 	}
}

public caducarAviso(playerid) {
	if (avisos[playerid][taValido] == 1) {
		KillTimer(caducarAvisoID[playerid]);
	}
    avisos[playerid][taValido]--;
}

public crearAviso(creador, msg[]) {
	if (avisos[creador][taValido] > 1) {
		SendClientMessage(creador, COLOR_RED, "ya has creado un aviso, cierralo primero");
		return -1;
	}
	new cont = 0;
	while (cont < 10) {
		new ale = random(999) + 1000;
		if (existeAviso(ale) == -1) {
		    avisos[creador][taValido] = 3600;
		    avisos[creador][taID] = ale;
		    gettime(avisos[creador][taHour],avisos[creador][taMin],avisos[creador][taSeg]);
		    format(avisos[creador][taMensaje],MAX_TAM_MENSAJE_AVISO, msg);
		    caducarAvisoID[creador] = SetTimerEx("caducarAviso",1000,1,"d",creador);
		    return ale;
		}
		cont++;
	}
	if (cont == 30) {
		SendClientMessage(creador, COLOR_RED, "No ha sido posible, inténtalo más tarde");
		return 0;
	}
	return -1;
}

// -------------------- Fin avisos


public Float:hyp(Float:x1,Float:y1,Float:x2,Float:y2){
   new Float:A = floatabs(x1-x2);
   A = floatpower(A,2);
   new Float:B = floatabs(y1-y2);
   B = floatpower(B,2);
   new Float:C = floatadd(A,B);
   new Float:D = floatsqroot(C);
   return D;
}

public GivePlayerRank(team,rank,senderid,giveid) {

	return 1;
}
public GetPlayerRank(playerid,nombre[255]){

	return 1;
}

public TimerClear(playerid) {
	ClearAnimations(playerid,1);
}

public TimerFall(playerid) {
    ApplyAnimation(playerid,"KNIFE","knife_hit_3",4.1,0,1,1,0,0,1);
}

public TazerControl(playerid) {
    if (GetPlayerWeapon(playerid) > 0 )
        SetPlayerArmedWeapon(playerid,0);
}

public PlaySoundRadius(playerid, soundid, Float:radius) {
	new Float:x, Float:y, Float:z, Float:xx, Float:yy, Float:zz;
	GetPlayerPos(playerid,x,y,z);
	for (new i = 0; i < MAX_PLAYERS; i++) {
	    if (IsPlayerConnected(i) && !IsPlayerNPC(i)) {
	        GetPlayerPos(i,xx,yy,zz);
		    if (GetDistanceBetweenPoints(x,y,z,xx,yy,zz) <= radius)
		     	//PlayAudioStreamForPlayer(playerid, "http://k004.kiwi6.com/hotlink/9s19772cbe/taser_sound.mp3", x, y, z, radius, 1);
		        PlayerPlaySound(i,soundid,x,y,z);
		}
	}
}


#define PRESSED(%0) \
        (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
     if (newkeys & KEY_FIRE) {
		if(HaveTaser[playerid] == 1 ) {

 			ApplyAnimation(playerid,"KNIFE","knife_3",4.1,0,1,1,0,0,1);
      		SetTimerEx("TimerClear",2000,false,"d",playerid);
      		PlaySoundRadius(playerid,4400,8.0);
		    new victimid = GetClosestPlayer(playerid);
			if(IsPlayerConnected(victimid))
	     	{
	        	if(GetDistanceBetweenPlayers(playerid,victimid) < 2)
	            {
	            	new Float:health;
	                GetPlayerHealth(victimid, health);
	                SetPlayerHealth(victimid, health - 5.0);
	                SetTimerEx("TimerFall",300,false,"d",victimid);
	                return 1;
	             }
	         }
         } 
     }
     if(PRESSED(KEY_NO)) {
//     	SendClientMessage(playerid, COLOR_GREEN, "pulsaste la n");
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pTeam] == POLI)
	        {
				ShowPlayerDialog(playerid, DIALOGO_ACCIONES_POLI, DIALOG_STYLE_LIST, "ACCIONES DE POLICIAS", "COMENZAR TRABAJO\nTAZER\nMULTAR\nENCERRAR\nPONER BARRERA\nQUITAR BARRERA\nPONER/QUITAR PINCHOS\nUSAR MEGÁFONO\nPONER CEPO\nREQUISAR\nCACHEAR\nCREAR AVISO\nINFORMACIÓN AVISO\nLISTADO AVISOS ABIERTOS\nACEPTAR AVISO", "ACEPTAR", "SALIR");
			}
			else if(PlayerInfo[playerid][pTeam] == BOMBEROS)
	        {
			    ShowPlayerDialog(playerid, DIALOGO_ACCIONES_BOMBERO, DIALOG_STYLE_LIST, "ACCIONES DE BOMBEROS", "COMENZAR TRABAJO\nPONER BARRERA\nSACAR BARRERA\nPOLICIA\nAMBULANCIA\nUSAR MEGÁFONO\nCREAR AVISO\nINFORMACIÓN AVISO", "ACEPTAR", "SALIR");
			}
			else if(PlayerInfo[playerid][pTeam] == MECANICO)
	        {
			    ShowPlayerDialog(playerid, MECANICOS, DIALOG_STYLE_LIST, "TALLER","COMENZAR TRABAJoR\nReparaciones\nTuneado\nRemolcar\nFactura ", "Aceptar", "Salir");
			}
		}
        return 1;

     }
     return 1;
}

public OnPlayerShootPlayer(shooter,target,Float:damage)
{
    new Float:H;
    GetPlayerHealth(target, H);
    if(GetPlayerWeapon(shooter) == 27 || GetPlayerWeapon(shooter) == 23)
        SetPlayerHealth(target, H);
    return 1;
}


//-------------------------------------------- MENUS --------------------

public OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	new idcar = GetPlayerVehicleID(playerid);
//---------------------------------------------- [login] -----------------------------------------------------------------
	if(dialogid == REGISTRO) {
	    if (!response) {
			Kick(playerid);
	        return 1;
	    }
	    
		new tmppass[255];
		strmid(tmppass, inputtext, 0, strlen(inputtext), 255);
		OnPlayerRegister(playerid,tmppass);
		new aux[255];
		format(aux, sizeof(aux), "\n{7FFFD4}Nick: {1E90FF}%s Registrado\n\n{FFFFFF} Contraseña\n", nLogin);
        ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "Sistema de Login", aux, "Login", "Salir");
		return true;
  	} else if(dialogid == LOGIN){
  		if (!response) {
			Kick(playerid);
	        return 1;
	    }
  	
    	new str[255];
  		if(!strlen(inputtext)) {
	        GetPlayerName(playerid, nLogin, sizeof(nLogin));
			format(str, sizeof(str),
				"\n{7FFFD4}Nick: {1E90FF}%s Registrado\n\n{FFFFFF} Contraseña\n", nLogin);
   		    ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "Sistema de Login", str, "Login", "Salir");
			SendClientMessage(playerid,0x1E90FFAA,"FIELD BLANK - Introduzca su contraseña!");
			return true;
		}

		OnPlayerLogin(playerid,inputtext);
		return true;

	}
  	else if (dialogid == DIALOGO_ID) { //despues de preguntar id
  	    if (!response) return 1;
  	    new id;
  	    new nombre[MAX_PLAYER_NAME];

		if (pidiendoInfo[playerid] == 1) {
			if (isNumeric(inputtext)) {
			    infoAviso(playerid,strval(inputtext));
			}
			pidiendoInfo[playerid] = 0;
			return 1;
		}
       	if (isNumeric(inputtext)) {
	    	id = strval(inputtext);
		    if (IsPlayerConnected(id) && !IsPlayerNPC(id))
		    	GetPlayerName(id,nombre,sizeof(nombre));
			else {
				ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "Jugador no encontrado", "Inténtalo de nuevo", "ACEPTAR", "SALIR");
				return 1;
			}
		} else {
			id = ReturnUser(inputtext);
			if (id == INVALID_PLAYER_ID || id == -1) {
				ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "Jugador no encontrado", "Inténtalo de nuevo", "ACEPTAR", "SALIR");
				return 1;
			}
			GetPlayerName(id,nombre,sizeof(nombre));
		}
        if (multando[playerid][tmPaso] == MULTA_ID) {

	        new str[255];
    	    format(str,sizeof(str), "Multando a %s(%d) ",nombre,id);
    	    
   			multando[playerid][tmPaso] = MULTA_DINERO;
			multando[playerid][tmID] = id;
    	    
			ShowPlayerDialog(playerid, DIALOGO_DINERO, DIALOG_STYLE_INPUT, str, "Introduce cantidad", "ACEPTAR", "SALIR");

		} else if (requisando[playerid] == 1) {
		    if (GetDistanceBetweenPlayers(playerid,id) > 5.0) {
		        SendClientMessage(playerid,COLOR_RED, "Está demasiado lejos como para que puedas hacer esto");
		        requisando[playerid] = 0;
		        return 1;
		    }
		    new agente[MAX_PLAYER_NAME];
			GetPlayerName(playerid,agente,sizeof(agente));
			
			new msg[200];
			format(msg,sizeof(msg),"%s(%d) requisó todas las armas a %s(%d)",agente,playerid,nombre,id);
			ProxDetector(8.0, playerid, msg, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Armas requisadas!", 2500, 6);
			GameTextForPlayer(id, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Sin armas!", 2500, 6);
			ResetPlayerWeapons(id);
			requisando[playerid] = 0;
		} else if (cacheando[playerid] == 1) {

		    new weapon, ammo;
		    new msg[80];
		    format(msg,sizeof(msg),"Armas que lleva %s(%d)",nombre,id);
		    SendClientMessage(playerid,COLOR_ORANGE, msg);
		    for (new i = 0; i < 13; i++) {
				GetPlayerWeaponData(id,i,weapon,ammo);
				GetWeaponName(weapon,msg,sizeof(msg));
				if (strlen(msg) > 0)
				    SendClientMessage(playerid,COLOR_ORANGE,msg);
		    }
			cacheando[playerid] = 0;
		} else if (traspasando[playerid] > 0 && IndiceDropItem[playerid] != -1) {
			if (GetDistanceBetweenPlayers(playerid,id) > 3.0) {
		        SendClientMessage(playerid,COLOR_RED, "Está demasiado lejos como para que puedas hacer esto");
		    } else {
		        new str[150];
		        new nombre1[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,nombre1,sizeof(nombre1));
				if (insertarItem(id, PlayerInfo[playerid][pInventario][IndiceDropItem[playerid]])) {
					format(str, sizeof(str), "%s le da un objeto a %s",nombre1, nombre);
					borrarItem(playerid,IndiceDropItem[playerid]);
				} else {
					format(str, sizeof(str), "%s no pudo darle el objeto a %s porque tiene el inventario lleno",nombre1, nombre);
				}
				ProxDetector(7.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			IndiceDropItem[playerid] = -1;
	        traspasando[playerid] = 0;

		}
		return 1;
	}
	else if (dialogid == DIALOGO_DINERO) {
		if (!response) return 1;
		if (multando[playerid][tmPaso] == MULTA_DINERO) {
			if (!isNumeric(inputtext)) {
				ShowPlayerDialog(playerid, DIALOGO_DINERO, DIALOG_STYLE_INPUT, "Error", "Introduce cantidad", "ACEPTAR", "SALIR");
				return 1;
			}
			new cantidad = strval(inputtext);
			if (cantidad < 1 || cantidad > 1000) {
				ShowPlayerDialog(playerid, DIALOGO_DINERO, DIALOG_STYLE_INPUT, "Error", "Máximo 1000$", "ACEPTAR", "SALIR");
				return 1;
			}
			multando[playerid][tmDinero] = cantidad;
			multando[playerid][tmPaso] = MULTA_RAZON;
			new str[255];
	        new nombre[MAX_PLAYER_NAME];
	        GetPlayerName(multando[playerid][tmID],nombre,sizeof(nombre));
         	format(str,sizeof(str), "Multando a %s(%d) ",nombre,multando[playerid][tmID]);
    		ShowPlayerDialog(playerid, DIALOGO_RAZON, DIALOG_STYLE_INPUT, str, "Introduce la razón", "ACEPTAR", "SALIR");
    		return 1;
		} else if(cobrando[playerid] > 1){
    		if (!isNumeric(inputtext)) {
				ShowPlayerDialog(playerid, DIALOGO_DINERO, DIALOG_STYLE_INPUT, "Error", "Introduce cantidad", "ACEPTAR", "SALIR");
				return 1;
			}
			new cantidad = strval(inputtext);
            if (cantidad < 1 || cantidad > 100) {
                ShowPlayerDialog(playerid, DIALOGO_DINERO, DIALOG_STYLE_INPUT, "Error", "Máximo 100$", "ACEPTAR", "SALIR");
                return 1;
            }
            cobrando[cobrando[playerid]] = cantidad;
        	new str[255];
			new nombre[MAX_PLAYER_NAME];
        	GetPlayerName(playerid,nombre,sizeof(nombre));
         	format(str,sizeof(str), "%s quiere cobrar %d$ ",nombre,cantidad);
            ShowPlayerDialog(cobrando[playerid], DIALOGO_CONFIRMAR, DIALOG_STYLE_MSGBOX, "FACTURA", str, "PAGAR", "NEGARSE");
            cobrando[playerid] = 0;
		}
	}
	else if (dialogid == DIALOGO_RAZON) {
 		if (!response) return 1;
		if (multando[playerid][tmPaso] == MULTA_RAZON) {
			new nombre[MAX_PLAYER_NAME];
			GetPlayerName(multando[playerid][tmID],nombre,sizeof(nombre));
		
		    format(multando[playerid][tmRazon],MAX_RAZON,"%s",inputtext);
			if (strlen(multando[playerid][tmRazon]) == 0) {
			    ShowPlayerDialog(playerid, DIALOGO_RAZON, DIALOG_STYLE_INPUT, "Fallo", "Introduce la razón", "ACEPTAR", "SALIR");
			    return 1;
			}
			
			new msg[150];
			format(msg,sizeof(msg),"{FFFFFF}Infractor: {7FFFD4}%s(%d)\n{FFFFFF}Cantidad: {7FFFD4}%d$\n{FFFFFF}Razón: {7FFFD4}%s\n",nombre,multando[playerid][tmID],multando[playerid][tmDinero],multando[playerid][tmRazon]);

			multando[playerid][tmPaso] = MULTA_CONFIRMAR;
			ShowPlayerDialog(playerid, DIALOGO_CONFIRMAR, DIALOG_STYLE_MSGBOX, "Multa", msg, "CONFIRMAR", "SALIR");
			return 1;
		} else if (avisando[playerid] == 1) {
		    if (strlen(inputtext) == 0) return 1;
		    new idAviso = crearAviso(playerid,inputtext);
		    if (idAviso != -1) {
				new nombre[MAX_PLAYER_NAME];
				GetPlayerName(playerid,nombre,sizeof(nombre));
				new msg[255];
				format(msg,sizeof(msg), "Creado aviso %d", idAviso);
				SendClientMessage(playerid,COLOR_GREEN,msg);
				format(msg,sizeof(msg)," ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Entrada de Aviso id: %d!",idAviso);
				GameTextForTeam(POLI, msg, 4000, 6, 1);
				GameTextForTeam(MEDICO, msg, 4000, 6, 1);
				GameTextForTeam(BOMBEROS, msg, 4000, 6, 1);
			}
			avisando[playerid] = 0;
		}
	}
	else if (dialogid == DIALOGO_CONFIRMAR) {
  	    new id = multando[playerid][tmID];
  	    new nombre[MAX_PLAYER_NAME];
  	    new msg[200];
		if (multando[playerid][tmPaso] == MULTA_CONFIRMAR) {
			if (!response) return 1;
			GetPlayerName(playerid,nombre,sizeof(nombre)); //nombre del agente
			
			new multado[MAX_PLAYER_NAME];
			GetPlayerName(id, multado, sizeof(multado));
			
			format(msg,sizeof(msg),"%s le pone una multa a %s por %s",nombre, multado,multando[playerid][tmRazon]);
			ProxDetector(8.0, playerid, msg, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			
			multando[multando[playerid][tmID]][tmID] = playerid;
			multando[multando[playerid][tmID]][tmPaso] = MULTA_PAGANDO;
			multando[multando[playerid][tmID]][tmDinero] = multando[playerid][tmDinero];

			format(msg,sizeof(msg),"{FFFFFF}Agente: {7FFFD4}%s(%d)\n{FFFFFF}Cantidad: {7FFFD4}%d$\n{FFFFFF}Razón: {7FFFD4}%s",nombre,playerid,multando[playerid][tmDinero],multando[playerid][tmRazon]);

            ShowPlayerDialog(multando[playerid][tmID], DIALOGO_CONFIRMAR, DIALOG_STYLE_MSGBOX, "Multa", msg, "PAGAR", "NEGARSE");
		} else if (multando[playerid][tmPaso] == MULTA_PAGANDO) {
		    GetPlayerName(playerid, nombre, sizeof(nombre));
		    if (!response) {
			    ProxDetector(8.0, playerid, "Pero se negó a pagarla", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    format(msg, sizeof(msg), "%s(%d) NO pagó la multa", nombre,playerid);
			    SendClientMessage(multando[playerid][tmID], COLOR_RED, msg);
		    } else {
			    ProxDetector(8.0, playerid, "Y la pagó", COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    format(msg, sizeof(msg), "%s(%d) pagó la multa", nombre,playerid);
			    SendClientMessage(multando[playerid][tmID], COLOR_GREEN, msg);
			    GivePlayerMoney(playerid, -multando[playerid][tmDinero]);
			}
			multando[playerid][tmPaso] = 0;
			multando[multando[playerid][tmID]][tmPaso] = 0;
			return 1;
		}else if(cobrando[playerid]>0)
		{
			GetPlayerName(playerid, nombre, sizeof(nombre));
			if (!response) {
			    
			    format(msg, sizeof(msg), "%s(%d) NO pagó la factura", nombre,playerid);
			    ProxDetector(8.0, playerid, msg, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    SendClientMessage(cobrando[playerid], COLOR_RED, msg);
		    } else {
				format(msg, sizeof(msg), "%s(%d) pagó la factura", nombre,playerid);
			    ProxDetector(8.0, playerid, msg, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			    SendClientMessage(multando[playerid][tmID], COLOR_GREEN, msg);
			    GivePlayerMoney(playerid, -cobrando[playerid]);
			}
		
		}
		cobrando[playerid]=0;
		return 1;
  	}
  	else if (dialogid == DIALOGO_TIEMPO) {
  	    if (!response) return 1;
  	    if (!isNumeric(inputtext)) {
	  	    ShowPlayerDialog(playerid, DIALOGO_TIEMPO, DIALOG_STYLE_INPUT, "Error", "Minutos que debe permanecer encerrado", "ACEPTAR", "SALIR");
	  	    return 1;
  	    }
		new tiempo = strval(inputtext);
		if (tiempo < 5 || tiempo > 30) {
	  	    ShowPlayerDialog(playerid, DIALOGO_TIEMPO, DIALOG_STYLE_INPUT, "Error", "Entre 5 y 30 por favor", "ACEPTAR", "SALIR");
	  	    return 1;
		}
		if (arrestando[playerid] == 1) {
			new cercano = GetClosestPlayer(playerid);
			if (!IsPlayerConnected(cercano) || IsPlayerNPC(cercano) || GetDistanceBetweenPlayers(cercano,playerid) > 3.0 || PlayerInfo[cercano][pJailTime] > 0) {
			    ShowPlayerDialog(playerid, DIALOGO_ERROR, DIALOG_STYLE_MSGBOX, "Error", "No hay nadie cerca", "ACEPTAR", "SALIR");
			    return 1;
			}
			new ale = random(NUM_CARCELES);
			SetPlayerPos(cercano,CoordCarcel[ale][0],CoordCarcel[ale][1],CoordCarcel[ale][2]);
			PlayerInfo[cercano][pJailTime] = tiempo * 60;

			new maloso[MAX_PLAYER_NAME];
			new agente[MAX_PLAYER_NAME];
			new msg[255];
			GetPlayerName(playerid,agente,sizeof(agente));
			GetPlayerName(cercano,maloso,sizeof(maloso));
			format(msg,sizeof(msg),"%s encerró a %s", agente, maloso);
			ProxDetector(15.0, playerid, msg, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Encerrado", 2500, 6);
			GameTextForPlayer(cercano, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~Encerrado", 2500, 6);
			format(msg, sizeof(msg), "Encerrado por %d minutos.", tiempo);
			SendClientMessage(cercano,COLOR_YELLOW, msg);
			timerEncerradoID[playerid] = SetTimerEx("timerEncerrado",1000,1,"d",cercano);
			arrestando[playerid] = 0;
		    return 1;
		}
		return 1;
  	}

//------------------------------------------------------ Menu Policias --------------------------------------------------------
  	else if(dialogid == DIALOGO_ACCIONES_POLI)// MENU POLICIA
  	{
  		if(listitem == 0)//duty
		{
			if(OnDuty[playerid]==0 && IsPlayerInRangeOfPoint(playerid, 3, 1565.4065,-1672.1458,1723.1050))
			{
				new skinsPOLI[] = {265,266,267,280,281,282,283,284};
		        OnDuty[playerid] = 1;
		        SetPlayerHealth(playerid, 100);

		        SetPlayerSkin(playerid, skinsPOLI[random(8)]);
				GameTextForPlayer(playerid, "EL DEBER TE LLAMA!", 3500, 6);
			}
			else if(OnDuty[playerid]==1 && IsPlayerInRangeOfPoint(playerid, 3, 1565.4065,-1672.1458,1723.1050))
			{
		        OnDuty[playerid] = 0;
		        SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO, DIALOG_STYLE_MSGBOX, " " , "No estas en los vestuarios de la comisaria.", "ACEPTAR", "SALIR");
			}
		}

		else if(listitem == 1)//TAZER
		{
		    if(OnDuty[playerid] == 0)
		    {
			    ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO, DIALOG_STYLE_MSGBOX, " ", "No estas de servicio!.", "ACEPTAR", "SALIR");
	    	}
	    	else
	    	{
				if (HaveTaser[playerid] == 0) {
	        		SetPlayerAttachedObject(playerid, 0, 18642, 6, 0.06, 0.01, 0.08, 180.0, 0.0, 0.0);
	        		HaveTaser[playerid] = 1;
	        		TazerControlID[playerid] = SetTimerEx("TazerControl",50,1,"d",playerid);
				} else {
					RemovePlayerAttachedObject(playerid,0);
				   	HaveTaser[playerid] = 0;
				   	KillTimer(TazerControlID[playerid]);
				}
			}
		}
		
		else if(listitem == 2)//MULTAR
		{
		    if(OnDuty[playerid] == 0) {
			    ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO, DIALOG_STYLE_MSGBOX, " ", "No estas de servicio!.", "ACEPTAR", "SALIR");
	    	} else {
	    	    multando[playerid][tmPaso] = MULTA_ID;
				ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "ID", "ID o parte del nombre del infractor", "ACEPTAR", "SALIR");
			}
		}
		
		else if(listitem == 3) { //ARRESTAR
		    if (PlayerToPoint(10.0,playerid, 1557.39, -1660.04, 1718.90)) {
			    if(OnDuty[playerid] == 0) {
				    ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO, DIALOG_STYLE_MSGBOX, " ", "No estas de servicio!.", "ACEPTAR", "SALIR");
	    		} else {
	    		    arrestando[playerid] = 1;
					ShowPlayerDialog(playerid, DIALOGO_TIEMPO, DIALOG_STYLE_INPUT, "Tiempo", "Minutos que debe permanecer encerrado", "ACEPTAR", "SALIR");
				}
			} else ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO, DIALOG_STYLE_MSGBOX, "Imposible", "Estás muy lejos de las celdas.", "ACEPTAR", "SALIR");
		}
 		else if(listitem == 4) { //poner barrera
        	if (OnDuty[playerid] == 1) {
                crearBarrera(playerid);
        	}
        	else{
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}

		} else if(listitem == 5){//Quitar barrera
		   	if (OnDuty[playerid] == 1) {
                eliminarBarrera(playerid);
        	}
        	else{
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
    	} else if(listitem == 6){//Poner/Quitar pinchos
    	    if (OnDuty[playerid] == 1) {
	            if (pincho[playerid] == 0) {
	    		    new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
			        GetPlayerPos(playerid, plocx, plocy, plocz);
	        		GetPlayerFacingAngle(playerid,ploca);
			        pincho[playerid] = CreateStrip(plocx,plocy,plocz,ploca);
	    		} else {
	    		    DeleteStrip(pincho[playerid]);
	    		    pincho[playerid] = 0;
	    		}
        	} else {
    			ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
		} else if(listitem == 7){ //Usar Megafono
        	if (OnDuty[playerid] == 0) {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
		    else if (megafono[playerid] == 0) {
		        SendClientMessage(playerid,COLOR_GREEN, "Megáfono activado");
		        megafono[playerid] = 1;
			} else {
			    SendClientMessage(playerid,COLOR_GREEN, "Megáfono desactivado");
			    megafono[playerid] = 0;
			}
		} else if(listitem == 8){ //PONER CEPO
        	if (OnDuty[playerid] == 1) {

			}
		} else if(listitem == 9){ //REQUISAR
        	if (OnDuty[playerid] == 0) {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
			} else {
				requisando[playerid] = 1;
				ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "ID", "ID o parte del nombre del infractor", "ACEPTAR", "SALIR");
			}
		} else if(listitem == 10){ //CACHEAR
        	if (OnDuty[playerid] == 0) {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		} else {
				cacheando[playerid] = 1;
				ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "ID", "ID o parte del nombre del infractor", "ACEPTAR", "SALIR");
			}
		} else if(listitem == 11){ //AVISAR
        	if (OnDuty[playerid] == 0) {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		} else {
				avisando[playerid] = 1;
   			 	ShowPlayerDialog(playerid, DIALOGO_RAZON, DIALOG_STYLE_INPUT, "Aviso", "Introduce motivo de aviso", "ACEPTAR", "SALIR");
			}
		} else if (listitem == 12) { //INFORMACION AVISO
			if (OnDuty[playerid] == 0) {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		} else {
				pidiendoInfo[playerid] = 1;
   			 	ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "ID", "Introduce número aviso", "ACEPTAR", "SALIR");
			}
		} else if (listitem == 13) { //LISTADO AVISOS ABIERTOS
			if (OnDuty[playerid] == 0) {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		} else {
				mostrarAvisos(playerid);
			}
		} else if(listitem == 14){ //Aceptar aviso
        	if (OnDuty[playerid] == 1) {

			}
		}
	}
    else if(dialogid == DIALOGO_CAMARAS_POLI)//Menu de la policia (camaras de vigilancia) /CAMARAS  (COMANDO)
	{
	    if(listitem == 0)
	    {
	        TogglePlayerControllable(playerid, 0);
            SetPlayerCameraPos(playerid,-1662.4323,687.6676,28.4683);
			SetPlayerCameraLookAt(playerid,-1689.0756,682.2585,21.8063);
			ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Camaras de Vigilancia:", "¿Has visto suficiente?.", "Aceptar", "Cerrar");
		}
		if(listitem == 1)
	    {
			TogglePlayerControllable(playerid, 0);
            SetPlayerCameraPos(playerid,-1604.9850,679.0843,16.1875);
			SetPlayerCameraLookAt(playerid,-1627.4283,659.1926,7.1875);
			ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Camaras de Vigilancia:", "¿Has visto suficiente?.", "Aceptar", "Cerrar");
		}
		if(listitem == 2)
	    {
			TogglePlayerControllable(playerid, 0);
            SetPlayerCameraPos(playerid,-1604.9850,679.0843,16.1875);
			SetPlayerCameraLookAt(playerid,-1584.5695,658.2625,7.1875);
			ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Camaras de Vigilancia:", "¿Has visto suficiente?.", "Aceptar", "Cerrar");

		}
		if(listitem == 3)
	    {
			TogglePlayerControllable(playerid, 0);
            SetPlayerCameraPos(playerid,-1571.3192,686.9904,10.1797);
			SetPlayerCameraLookAt(playerid,-1564.4459,659.4697,7.0391);
			ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Camaras de Vigilancia:", "¿Has visto suficiente?.", "Aceptar", "Cerrar");
		
		}
		if(listitem == 4)
	    {
			TogglePlayerControllable(playerid, 0);
            SetPlayerCameraPos(playerid,1561.3925,-1678.4655,1726.1050);
			SetPlayerCameraLookAt(playerid,1553.9943,-1684.3240,1723.1050);
			ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Camaras de Vigilancia:", "¿Has visto suficiente?.", "Aceptar", "Cerrar");
		}
		if(listitem == 5)
	    {
			TogglePlayerControllable(playerid, 0);
            SetPlayerCameraPos(playerid,1558.7582,-1652.3834,1721.9019);
			SetPlayerCameraLookAt(playerid,1556.2253,-1657.5729,1718.9019);
			ShowPlayerDialog(playerid, 202, DIALOG_STYLE_MSGBOX, "Camaras de Vigilancia:", "¿Has visto suficiente?.", "Aceptar", "Cerrar");
		}
    }
    else if(dialogid == DIALOGO_SALIR_CAMARAS_POLI)//Menu de la policia (camaras de vigilancia) /CAMARAS  (COMANDO)
	{
    		SetCameraBehindPlayer(playerid);
            TogglePlayerControllable(playerid, 1);
	}
	else if(dialogid == DIALOGO_ACCIONES_BOMBERO)//MENU DE LOS BOMBEROS
	{
	    if(listitem == 0)
	    {
    		if (OnDuty[playerid] == 0 && PlayerInfo[playerid][pTeam] == BOMBEROS && PlayerToPoint(2.0, playerid, -2030.8715,-223.8672,14.5783)){
		        new skinsFIRE[] = {277,278,279};

		        OnDuty[playerid] = 1;
        		SetPlayerHealth(playerid, 100);
		        SetPlayerColor(playerid, COLOR_RED);
        		GivePlayerWeapon(playerid, 42, 99999);
		        SetPlayerSkin(playerid, skinsFIRE[random(3)]);

		        GameTextForPlayer(playerid, "EL DEBER TE LLAMA!", 3500, 3);
		        return 1;
			} else {
	            ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Ve a los vestuarios.", "ACEPTAR", "SALIR");
			}
		} else if(listitem == 1) { //poner barrera
        	if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == BOMBEROS) {
                crearBarrera(playerid);
            	return 1;
        	}
        	else{
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
		} else if(listitem == 2){//Quitar barrera
		   	if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == BOMBEROS) {
                eliminarBarrera(playerid);
            	return 1;
        	}
        	else{
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
		} else if(listitem == 3){ //llamar policia
			if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == BOMBEROS) {
			    new string[255];
			    new nombre[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,nombre,sizeof(nombre));
			    format(string,sizeof(string), "%s avisa a los policias sobre la emergencia",nombre);
				ProxDetector(15.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				GameTextForTeam(POLI, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~10-45 Se a producido un 10-70 en el Barrio Chino!", 2500, 6, 1);
			} else {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
    		
		} else if(listitem == 4){ //llamar Ambulancia
			if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == BOMBEROS) {
			    new string[255];
			    new nombre[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,nombre,sizeof(nombre));
			    format(string,sizeof(string), "%s avisa a los medicos sobre la emergencia",nombre);
				ProxDetector(15.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
				GameTextForTeam(MEDICO, " ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~n~ ~r~~h~10-45 Se a producido un 10-70 en el Barrio Chino!", 2500, 6, 1);
			} else {
        		ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Primero debes estar OnDuty.", "ACEPTAR", "SALIR");
    		}
		} else if(listitem == 5){ //Usar Megafono
		    if (megafono[playerid] == 0) {
		        SendClientMessage(playerid,COLOR_GREEN, "Megáfono activado");
		        megafono[playerid] = 1;
			} else {
			    SendClientMessage(playerid,COLOR_GREEN, "Megáfono desactivado");
			    megafono[playerid] = 0;
			}
			return 1;
		} else if(listitem == 6){ //salir
			SendClientMessage(playerid, COLOR_GREEN, "Ya no eres bombero!");
			PlayerInfo[playerid][pTeam] = 0;
		}
	}
	
//---------------MENU MECANICOS-------------
	if(dialogid == MECANICOS)
	{
 		if(response)
		{
			if(listitem == 0)
			{
    			if(OnDuty[playerid]==0 && IsPlayerInRangeOfPoint(playerid, 3, -1871.3744,909.0146,35.1719))
				{
					new skinsMECA[] = {50,108};
		        	OnDuty[playerid] = 1;
		        	SetPlayerHealth(playerid, 100);
			        SetPlayerSkin(playerid, skinsMECA[random(2)]);
					GameTextForPlayer(playerid, "EL TALLER TE LLAMA!", 3500, 6);
				}
				else if(OnDuty[playerid]==1 && IsPlayerInRangeOfPoint(playerid, 3, -1871.3744,909.0146,35.1719))
				{
		        	OnDuty[playerid] = 0;
		        	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
				}
				else {
	            	ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "Ve a los vestuarios.", "ACEPTAR", "SALIR");
				}
				return 1;
			}
			else if(listitem == 1) //
			{
			    if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == MECANICO)
	   			{
	   				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	   			    {
						ShowPlayerDialog(playerid, MECANICO1, DIALOG_STYLE_LIST, "REPARAR","Reparar Motor\nReparar Carroceria", "Seleccionar", "Salir");
					} else
				 		SendClientMessage(playerid, COLOR_GRAD2, "Tienes que ser conductor!");
				} else {
	            	ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "PONTE A TRABAJAR.", "ACEPTAR", "SALIR");
				}
			}
			else if(listitem == 2) //
			{
				if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == MECANICO)
	   			{
	   			    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	   			    {
						ShowPlayerDialog(playerid,1111,DIALOG_STYLE_LIST,"Seleccione su opción","Nitro(x2 Tanques)\nCar Color\nLlantas\nStereo\nHydraulics\nCar Componentes","Select","Cancel");
					} else
						SendClientMessage(playerid, COLOR_GRAD2, "Tienes que ser conductor!");
				} else {
	            	ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "PONTE A TRABAJAR.", "ACEPTAR", "SALIR");
				}
	        }
      		else if(listitem == 3) {
				if (OnDuty[playerid] == 1 && PlayerInfo[playerid][pTeam] == MECANICO) {
					if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
						idcar= GetPlayerVehicleID(playerid);
	   					if(GetVehicleModel(idcar) == 525) {
							new Float:pXx,Float:pYx,Float:pZx;
							GetPlayerPos(playerid,pXx,pYx,pZx);
							new Float:vX,Float:vY,Float:vZ;
							new Found=0;
							new vid=0;
							while((vid < MAX_VEHICLES)&&(!Found)) {
				   				vid++;
		   						GetVehiclePos(vid,vX,vY,vZ);
		   						if ((floatabs(pXx-vX)<7.0)&&(floatabs(pYx-vY)<7.0)&&(floatabs(pZx-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid))) {
			  						Found=1;
				    				if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) {
   				        				DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
       				 				} else {
    									AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
									}
	 							}
    						}
							if(!Found) {
	   							SendClientMessage(playerid,COLOR_GRAD2,"No hay ningún vehículo cerca!");
							}
						} else
							SendClientMessage(playerid, COLOR_GRAD2, "No puedes remolcar con este vehículo!");
					} else
						SendClientMessage(playerid, COLOR_GRAD2, "Tienes que ser conductor!");
				} else {
	            	ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO,DIALOG_STYLE_MSGBOX, " ", "PONTE A TRABAJAR.", "ACEPTAR", "SALIR");
				}
	  		}
		 	else if(listitem ==4) {
				if(OnDuty[playerid] == 0) {
			    	ShowPlayerDialog(playerid, DIALOGO_NO_AUTORIZADO, DIALOG_STYLE_MSGBOX, " ", "No estas Trabajando!.", "ACEPTAR", "SALIR");
	    		} else {
                 	new mascercano=GetClosestPlayer(playerid);
	    	    	cobrando[playerid]= mascercano;
					ShowPlayerDialog(playerid, DIALOGO_DINERO, DIALOG_STYLE_INPUT, "DINERO", "Factura a cliente", "ACEPTAR", "SALIR");
				}
			}
		}
	} else if(dialogid == 1111 && response) {
		switch(listitem)
		{
			case 0: AddVehicleComponent(idcar,1010),CarmodDialog(playerid), PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			case 1: ShowPlayerDialog(playerid,1112,DIALOG_STYLE_LIST,"Cambiar Color primario:","Blanco\nNegro\nNaranja\nAzul Claro\nAzul Oscuro\nMorado\nRojo\nRojo Oscuro\nGris","Select","Cancelar");
			case 2: ShowPlayerDialog(playerid,1113,DIALOG_STYLE_LIST,"Cambiar Llantas:","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\nAhab\nVirtual\nAcces\n{FF0000}Back","Select","Cancle");
			case 3: AddVehicleComponent(idcar, 1086), PlayerPlaySound(playerid,1133,0.0,0.0,0.0), CarmodDialog(playerid);
			case 4: AddVehicleComponent(idcar, 1087), PlayerPlaySound(playerid,1133,0.0,0.0,0.0), CarmodDialog(playerid);
			case 5: {
				new idcar2;
				idcar2=GetVehicleModel(GetPlayerVehicleID(playerid));
			    
				if(idcar2 == 562 || idcar2 == 565 || idcar2 == 559 || idcar2 == 561 || idcar2 == 560 || idcar2 == 558)
				{
					ShowPlayerDialog(playerid,1114,DIALOG_STYLE_LIST,"Elija su opción","Paintjob\nAlien\nX-Flow\n{FF0000}Back","Select","Cancel");
				}
				else if(idcar2 == 576 || idcar2 == 575 || idcar2 == 535)
				{
					Lowrider(playerid);
    			}
				else if(idcar2 == 567 || idcar2 == 536)
				{
                    ShowPlayerDialog(playerid,1002,DIALOG_STYLE_LIST,"Elija su opción","Paintjob\nChrome\nSlamin\nHardtop Roof\nSofttop Roof\n{FF0000}Back","Select","Cancel");
				}
				else if(idcar2 == 534)
				{
                    ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"Elija su opción","Paintjob\nChrome\nSlamin\nFlame Sideskirt \nArches Sideskirt Roof\n{FF0000}Back","Select","Cancel");
				}
				else if(idcar2==496 || idcar2==505 || idcar2==516 || idcar2==517 || idcar2==518 || idcar2==527 || idcar2==529 || idcar2==540 || idcar2==546 || idcar2 == 547 || idcar2 == 549 || idcar2 == 550 || idcar2 == 551 || idcar2 == 580 || idcar2 == 585 || idcar2 == 587 || idcar2 == 589 || idcar2 == 600 || idcar2 == 603 || idcar2 == 401 || idcar2 == 410 || idcar2 == 415 || idcar2 == 418 || idcar2 == 420 || idcar2 == 436 || idcar2 == 439 || idcar2 == 458 || idcar2 == 489 || idcar2 == 491 || idcar2 == 492)
				{
					RegularCarDialog(playerid);
				}
				else
				{
					SendClientMessage(playerid,COLOR_GREY,"Este vehículo no puede ser tuneado.");
				}
			}
		}
	}
	if(dialogid == 1112 && response)
	{
		new color1, color2;
		GetVehicleColor(idcar,color1,color2);
	    new Carray[] = {1,0,6,2,79,149,151,3,34};
	    ChangeVehicleColor(idcar,Carray[listitem],color2);
	    return ShowPlayerDialog(playerid,1116,DIALOG_STYLE_LIST,"Color secundario:","Blanco\nNegro\nNaranja\nAzul Claro\nAzul Oscuro\nMorado\nRojo\nRojo Oscuro\nGris","Instalar","Cancle");
	}
	if(dialogid == 1116 && response)
	{
	    new color1, color2;
		GetVehicleColor(idcar,color1,color2);
	    new Carray[] = {1,0,6,2,79,149,151,3,34};
        ChangeVehicleColor(idcar,color1,Carray[listitem]);
        return CarmodDialog(playerid);
	}
	if(dialogid == 1113 && response)
	{
	    if(listitem == 16) return CarmodDialog(playerid);
		new Warray[] = {1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};
		AddVehicleComponent(idcar,Warray[listitem]);
		return CarmodDialog(playerid);
	}
	if(dialogid == 1114 && response)
	{
	    switch(listitem)
	    {
			case 0: ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Cambiar paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Aceptar","Cancel");
			case 1: Mod(playerid);
			case 2: Mod1(playerid);
			case 3: CarmodDialog(playerid);
		}
	}
	if(dialogid == 1001 && response)
	{
		switch(listitem)
		{
			case 0: ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Cambiar paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Aceptar","Cancel");
			case 1: Mod2(playerid);
			case 2: Mod3(playerid);
			case 3: CarmodDialog(playerid);
		}
	}
	if(dialogid  == 1002)
	{
		switch(listitem)
		{
			case 0: ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Cambiar paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Aceptar","Cancel");
			case 1: Mod2(playerid);
			case 2: Mod3(playerid);
			case 3:
			{
				new idcar2= GetVehicleModel(idcar);
				if(idcar2 == 567)//Savanna
				{
					AddVehicleComponent(idcar, 1130);
				}
				if(idcar2 == 536)//Blade
                {
                    AddVehicleComponent(idcar, 1128);
				}
			}
			case 4:
			{
				new idcar2= GetVehicleModel(idcar);
				if(idcar2 == 567)//Savanna
				{
    				 AddVehicleComponent(idcar, 1131);
				}
				if(idcar2 == 536)//Blade
                {
                    AddVehicleComponent(idcar, 1103);
				}
			}
			case 5: CarmodDialog(playerid);
		}
	}
	if(dialogid  == 1003)//Remington
	{
		switch(listitem)
		{
		    case 0:ShowPlayerDialog(playerid,1115,DIALOG_STYLE_LIST,"Cambiar paintjob:","Paintjob 1\nPaintjob 2\nPaintjob 3","Aceptar","Cancel");
		    case 1: Mod2(playerid);
			case 2: Mod3(playerid);
			case 3: AddVehicleComponent(idcar, 1122),AddVehicleComponent(idcar, 1101),ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"Opciones","Paintjob\nChrome\nSlamin\nFlame Sideskirt \nArches Sideskirt Roof\n{FF0000}Back","Aceptar","Cancel");
			case 4: AddVehicleComponent(idcar, 1106),AddVehicleComponent(idcar, 1124),ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"Opciones","Paintjob\nChrome\nSlamin\nFlame Sideskirt \nArches Sideskirt Roof\n{FF0000}Back","Aceptar","Cancel");
			case 5: CarmodDialog(playerid);
		}
	}
	if(dialogid == 1004 && response)//regular cars
	{
	    switch(listitem)
	    {
			case 0:
			{
				ShowPlayerDialog(playerid,1010,DIALOG_STYLE_LIST,"Spoiler","Pro\nWin\nDrag\nAlpha\nChamp\nRace\nWorx\nFury\n{FF0000}Back","Aceptar","Cancelar");
			}
			case 1:
			{
				new idcar2= GetVehicleModel(idcar);
			    if(idcar2 == 585 || idcar2 == 603 || idcar2 == 439 || idcar2 == 458 || idcar2 == 418 || idcar2 == 527 || idcar2 == 580)
			    {
					AddVehicleComponent(idcar, 1006);
					return RegularCarDialog(playerid);
				}
				else if(idcar2 == 439 || idcar2 == 458 || idcar2 == 491 || idcar2 == 517 ||idcar2 == 547)
			    {ShowPlayerDialog(playerid,1040,DIALOG_STYLE_LIST,"Vents","Oval\nSquare\n{FF0000}Back","Select","Cancel");}
                else if(idcar == 415)
                {
					AddVehicleComponent(idcar, 1007);
					AddVehicleComponent(idcar, 1071);
					return RegularCarDialog(playerid);
				}
                else ShowPlayerDialog(playerid,1020,DIALOG_STYLE_LIST,"Hood","Champ\nFury\nRace\nWorx\n{FF0000}Back","Select","Cancel");
			}
			case 2:
			{
				new idcar2= GetVehicleModel(idcar);
			    if(idcar2 == 549 || idcar2 == 585 || idcar2 == 603)
				{ShowPlayerDialog(playerid,1040,DIALOG_STYLE_LIST,"Vents","Oval\nSquare\n{FF0000}Back","Select","Cancel");}
				else if(idcar2 == 410 || idcar2 == 436 || idcar2 == 439 || idcar2 == 458 || idcar2 == 516 || idcar2 == 491 || idcar2 == 517 || idcar2 == 418 || idcar2 == 527 || idcar2 == 580)
				{
                    AddVehicleComponent(idcar, 1007);
					AddVehicleComponent(idcar, 1071);
					return RegularCarDialog(playerid);
				}
				else if(idcar2 == 415 || idcar2 == 547 || idcar2 == 420 || idcar2 == 587)
				{CarmodDialog(playerid);}
				else
				{
					AddVehicleComponent(idcar, 1006);
					return RegularCarDialog(playerid);
				}

			}
			case 3:
			{
			    new idcar2= GetVehicleModel(idcar);
			    if(idcar2 == 549 || idcar2 == 585 || idcar2 == 603 || idcar2 == 551 || idcar2 == 492 || idcar2 == 529)
			    {
					AddVehicleComponent(idcar, 1007);
					AddVehicleComponent(idcar, 1071);
					return RegularCarDialog(playerid);
				}
				else if(idcar2 == 410 || idcar2 == 436 || idcar2 == 439 || idcar2 == 458 || idcar2 == 489 || idcar2 == 505)
				{ShowPlayerDialog(playerid,1060,DIALOG_STYLE_LIST,"Luces","Round Fog\nSquare Fog\n{FF0000}Back","Select","Cancel");}
				else if(idcar2 == 418 || idcar2 == 527 || idcar2 == 580 || idcar2 == 491 || idcar2 == 517 || idcar2 == 516)
				{CarmodDialog(playerid);}
				else{ShowPlayerDialog(playerid,1040,DIALOG_STYLE_LIST,"Vents","Oval\nSquare\n{FF0000}Back","Select","Cancel");}
			}
			case 4:
			{
			    new idcar2= GetVehicleModel(idcar);
			    if(idcar2 == 549 || idcar2 == 550 || idcar2 == 585 || idcar2 == 603)
			    {ShowPlayerDialog(playerid,1060,DIALOG_STYLE_LIST,"Lights","Round Fog\nSquare Fog\n{FF0000}Back","Select","Cancel");}
			    else if(idcar2 == 489 || idcar2 == 505 || idcar2 == 551 || idcar2 == 492 || idcar2 == 529 || idcar2 == 439 || idcar2 == 458 || idcar2 == 410 || idcar2 == 436)
			    {CarmodDialog(playerid);}
			    else
			    {
					AddVehicleComponent(idcar, 1007);
					AddVehicleComponent(idcar, 1071);
					return RegularCarDialog(playerid);
				}
			}
			case 5:
			{
			    new idcar2= GetVehicleModel(idcar);
				if(idcar2 == 585 || idcar2 == 603 || idcar2 == 550 || idcar2 == 549)
				{CarmodDialog(playerid);}
				else{ShowPlayerDialog(playerid,1060,DIALOG_STYLE_LIST,"Lights","Round Fog\nSquare Fog\n{FF0000}Back","Select","Cancel");}
			}
			case 6: CarmodDialog(playerid);
		}
	}
	if(dialogid == 1010 && response)
	{
		if(listitem == 8) return RegularCarDialog(playerid);
		new Xarray[] = {1000,1001,1002,1003,1014,1015,1016,1023};
		AddVehicleComponent(idcar, Xarray[listitem]);
		return RegularCarDialog(playerid);
	}
	if(dialogid == 1020 && response)
	{
		if(listitem == 4) return RegularCarDialog(playerid);
		new Xarray[] = {1004,1005,1011,1012};
		AddVehicleComponent(idcar, Xarray[listitem]);
		return RegularCarDialog(playerid);
	}
	if(dialogid == 1040 && response)
	{
	    switch(listitem)
	    {
			case 0:
			{
				AddVehicleComponent(idcar, 1142);
				AddVehicleComponent(idcar, 1143);
				return RegularCarDialog(playerid);
			}
			case 1:
			{
				AddVehicleComponent(idcar, 1144);
				AddVehicleComponent(idcar, 1145);
				return RegularCarDialog(playerid);
			}
			case 2: RegularCarDialog(playerid);
		}
	}
	if(dialogid == 1060 && response)
	{
		if(listitem == 2) return RegularCarDialog(playerid);
		new Xarray[] = {1013,1024};
		AddVehicleComponent(idcar, Xarray[listitem]);
		return RegularCarDialog(playerid);
	}
	if(dialogid == 1115 && response)
	{
	    if(listitem == 3) return CarmodDialog(playerid);
		new Parray[] = {0,1,2};
		ChangeVehiclePaintjob(idcar, Parray[listitem]);
		return CarmodDialog(playerid);
	}
	if(dialogid == 1511 && response)
	{
		new idcar2= GetVehicleModel(idcar);
	    if(listitem == 7) return ShowPlayerDialog(playerid,1114,DIALOG_STYLE_LIST,"Choose one","Paintjob\nAlien\nX-Flow\n{FF0000}Back","Select","Cancel");
		if(idcar2 == 558)//Uranus
		{
			new Varray[] = {1090,1094,1092,1088,1164,1166,1168};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(idcar2 == 559)//Jester
		{
            new Varray[] = {1069,1071,1065,1067,1162,1160,1159};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(idcar2 == 560)//Sultan
		{
            new Varray[] = {1026,1027,1028,1032,1138,1169,1141};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(idcar2 == 561)//Stratum
		{
            new Varray[] = {1056,1062,1064,1055,1058,1155,1154};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(idcar2 == 562)//Elegy
		{
            new Varray[] = {1036,1040,1034,1038,1147,1171,1149};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod(playerid);
		}
		if(idcar2 == 565)//Flash
		{
            new Varray[] = {1047,1051,1046,1054,1049,1153,1150};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod(playerid);
		}
	}
	if(dialogid == 1512 && response)
	{
		new idcar2= GetVehicleModel(idcar);
	    if(listitem == 7) return ShowPlayerDialog(playerid,1114,DIALOG_STYLE_LIST,"Choose one","Paintjob\nAlien\nX-Flow\n{FF0000}Back","Select","Cancel");
	    if(idcar2 == 558)//Uranus
	    {
            new Varray[] = {1093,1095,1089,1091,1163,1165,1167};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(idcar2 == 559)//Jester
	    {
            new Varray[] = {1070,1072,1066,1068,1158,1173,1161};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(idcar2 == 560)//Sultan
	    {
            new Varray[] = {1031,1030,1029,1033,1139,1170,1140};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(idcar2 == 561)//Stratum
	    {
            new Varray[] = {1057,1063,1059,1061,1060,1157,1156};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(idcar2 == 562)//Elegy
	    {
            new Varray[] = {1039,1041,1037,1035,1146,1172,1148};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod1(playerid);
		}
	    if(idcar2 == 565)//Flash
	    {
            new Varray[] = {1048,1052,1045,1053,1050,1152,1151};
	 		AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod1(playerid);
		}
	}
	if(dialogid == 1513 && response)
	{
		new idcar2= GetVehicleModel(idcar);
		if(idcar2 == 576)
        {
			if(listitem == 5) return Lowrider(playerid);
      		new Varray[] = {1134,1137,1136,1191,1192};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod2(playerid);
		}
		if(idcar2 == 575)
		{
			if(listitem == 5) return Lowrider(playerid);
  			new Varray[] = {1042,1099,1044,1174,1176};
			AddVehicleComponent(idcar,Varray[listitem]);
	 		return Mod2(playerid);
		}
		if(idcar2 == 535)
		{
  			if(listitem == 6) return Lowrider(playerid);
  			new Varray[] = {1115,1109,1113,1117,1118,1120};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod2(playerid);
		}
		if(idcar2 == 567)
		{

		    if(listitem == 5) return Lowrider(playerid);
			new Varray[] = {1129,1133,1102,1187,1189};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod2(playerid);
		}
		if(idcar2 == 536)
		{
		    if(listitem == 5) return Lowrider(playerid);
			new Varray[] = {1104,1108,1107,1184,1182};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod2(playerid);
		}
		if(idcar2 == 534)
		{
		    if(listitem == 6) return Lowrider(playerid);
			new Varray[] = {1100,1123,1125,1126,1179,1180};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod2(playerid);
		}
	}
	if(dialogid == 1514 && response)
	{
		new idcar2= GetVehicleModel(idcar);
		if(idcar2 == 576)
		{
		    if(listitem == 3) return Lowrider(playerid);
  			new Varray[] = {1135,1190,1193};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod3(playerid);
		}
		if(idcar2 == 575)
		{
		    if(listitem == 3) return Lowrider(playerid);
  			new Varray[] = {1177,1175,1043};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod3(playerid);
		}
		if(idcar2 == 535)
		{
		    if(listitem == 5) return Lowrider(playerid);
  			new Varray[] = {1110,1116,1114,1119,1121};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod3(playerid);
		}
  		if(idcar2 == 567)
		{
		    if(listitem == 3) return Lowrider(playerid);
			new Varray[] = {1188,1186,1132};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod3(playerid);
		}
		if(idcar2 == 536)
		{
		    if(listitem == 3) return Lowrider(playerid);
			new Varray[] = {1181,1183,1105};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod3(playerid);
		}
		if(idcar2 == 534)
		{
		    if(listitem == 3) return Lowrider(playerid);
			new Varray[] = {1185,1178,1127};
			AddVehicleComponent(idcar,Varray[listitem]);
			return Mod3(playerid);
		}
	}
	if(dialogid == MECANICO1) //REPARAR
	{
		if(response)
		{
			if(listitem == 0)
			{
			    idcar= GetPlayerVehicleID(playerid);
    		 	new Float:cx, Float:cy, Float:cz;
         		GetVehiclePos(idcar, cx, cy, cz);
         		PlayerPlaySound(playerid, 1133, cx, cy, cz);
				SetVehicleHealth(idcar, 1000.0);
				PlayerPlaySound(playerid, 1133, cx, cy, cz);
			}
			if(listitem == 1)
			{
				idcar= GetPlayerVehicleID(playerid);
		 		new Float:cx, Float:cy, Float:cz;
    	  		GetVehiclePos(idcar, cx, cy, cz);
      			PlayerPlaySound(playerid, 1133, cx, cy, cz);
      			PlayerPlaySound(playerid, 1133, cx, cy, cz);
				RepairVehicle(GetPlayerVehicleID(playerid));
			}
		}
   	}
   	else if (dialogid == DIALOGO_USAR_DROP) {
		if (response && IndiceDropItem[playerid] != -1) {
	   	    if(listitem == 0) { // USAR OBJETO DEL INVENTARIO
   	            SendClientMessage(playerid, COLOR_GREEN, "Usaste el objeto");
   				borrarItem(playerid, IndiceDropItem[playerid]);
				IndiceDropItem[playerid] = -1;
   		    } else if (listitem == 1) { //TIRAR OBJETO DEL INVENTARIO
   	    		new Float:x, Float:y, Float:z, Float:ang;
				GetPlayerPos(playerid, x, y, z);
				GetPlayerFacingAngle(playerid,ang);
				GetXYInFrontOfPlayer(playerid, x, y, z, ang, 2.0);
				RegistrarDrop(playerid, PlayerInfo[playerid][pInventario][IndiceDropItem[playerid]], x, y, z);
				borrarItem(playerid, IndiceDropItem[playerid]);
				IndiceDropItem[playerid] = -1;
			} else if (listitem == 2) {      //DAR OBJECTO
				traspasando[playerid] = 1;
				ShowPlayerDialog(playerid, DIALOGO_ID, DIALOG_STYLE_INPUT, "¿A quién le doy esto?", "ID o parte del nombre", "ACEPTAR", "SALIR");
			}
		}
		CrearVariablesItem(playerid);
		CreateSelectionMenuInventario(playerid, PESTANA_INVENTARIO, numItems[playerid]);

	} else if(dialogid == 2341) {       //MENU DE LOS POLICIAS
    	if(response) {
			if(listitem == 0) {
		    	SetPlayerArmour(playerid, 100); //Armour
			    GameTextForPlayer(playerid, "~r~Lo tienes!", 500, 0);
			} else if(listitem == 1){
		    	GivePlayerWeapon(playerid, 24, 40); //Desert Eagle
		    	GameTextForPlayer(playerid, "~r~Ok lo tengo!", 500, 0);
			} else if(listitem == 2) {
 				GivePlayerWeapon(playerid, 25, 200); //Shotgun
	     		GameTextForPlayer(playerid, "~r~Ok lo tengo!!", 500, 0);
			} else if(listitem == 3) {
				GivePlayerWeapon(playerid, 28, 500); //Micro SMG
				GameTextForPlayer(playerid, "~r~Ok lo tengo!!", 500, 0);
			} else if(listitem == 4) {
				GivePlayerWeapon(playerid, 29, 500); //MP5
				GameTextForPlayer(playerid, "~r~Ok lo tengo!!", 500, 0);
			} else if(listitem == 5) {
				GivePlayerWeapon(playerid, 34, 20); //Sniper Rifle
				GameTextForPlayer(playerid, "~r~Ok lo tengo!!", 500, 0);
			}
		}
		return 1;

	}
	return 0;
}

//-------------------------- llaves de coches
public giveKeys(playerid, _key) {
	for (new i = 0; i < MAX_PLAYER_CAR_KEYS; i++)
		if (PlayerInfo[playerid][pCarKeys][i] == 0) {
			PlayerInfo[playerid][pCarKeys][i] = _key;
			return 1;
		}
	SendClientMessage(playerid, COLOR_RED, "No puedes tener más llaves de coches");
	return 0;
}

// ------------------------ drop e items
public OnObjectMoved(objectid) {
	for (new i = 0; i < numDrops; i++)
	    if (objectid == drops[i][dropid]) {
			new Float:x, Float:y, Float:z;
			GetObjectPos(objectid, x, y, z);
			if (drops[i][dropdir] == SUBIENDO) {
				MoveObject(objectid,x, y, z+0.2, 0.3, 0.0, 0.0, 0.0);
				drops[i][dropdir] = BAJANDO;
			} else {
				MoveObject(objectid,x, y, z-0.2, 0.3, 0.0, 0.0, 0.0);
				drops[i][dropdir] = SUBIENDO;
			}
		}
}

public AnimarDrop(objectid) {
	new Float:x, Float:y, Float:z;
    GetObjectPos(objectid, x, y, z);
    MoveObject(objectid,x, y, z-0.2, 0.1, 0.0, 0.0, 0.0);
}


public borrarItem(playerid, indice) {
 	numItems[playerid]--;
	for (new i = indice; i < numItems[playerid]; i++)
	    PlayerInfo[playerid][pInventario][i] = PlayerInfo[playerid][pInventario][i+1];
    avisoInventarioLleno[playerid] = true;
    PlayerInfo[playerid][pInventario][numItems[playerid]] = 0;
	SendClientMessage(playerid, COLOR_RED, "Borrado objeto de tu inventario");
}

public insertarItem(playerid, modelid) {
	if (numItems[playerid] == MAX_INVENTARIO) return 0;
	PlayerInfo[playerid][pInventario][numItems[playerid]] = modelid;
	numItems[playerid]++;
	SendClientMessage(playerid, COLOR_GREEN, "Objeto añadido a tu inventario");
	return 1;
}

public RegistrarDrop(playerid, modelid, Float:x, Float:y, Float:z) {
	if (numDrops < MAX_DROPS) {
	    drops[numDrops][dropmodel] = modelid;
	    drops[numDrops][droppos][0] = x;
 	    drops[numDrops][droppos][1] = y;
   	    drops[numDrops][droppos][2] = z;
	 	drops[numDrops][dropid] = CreateObject(modelid, x, y, z +0.2, 0.0, 0.0, 0.0, 20.0);
	 	drops[numDrops][dropvida] = TIEMPO_DROP;
	 	drops[numDrops][dropdir] = SUBIENDO;
	 	AnimarDrop(drops[numDrops][dropid]);
	 	numDrops++;
	} else
	    SendClientMessage(playerid, COLOR_RED, "no puedo procesar este drop ahora, avisa a un admin sobre el error o inténtalo más tarde");
}

public BorrarDrop(_dropid) {
	DestroyObject(drops[_dropid][dropid]);
	for (new i = _dropid; i < numDrops-1; i++) {
		drops[i][dropid] = drops[i+1][dropid];
	    drops[i][dropmodel] = drops[i+1][dropmodel];
	    drops[i][droppos][0] = drops[i+1][droppos][0];
 	    drops[i][droppos][1] = drops[i+1][droppos][0];
   	    drops[i][droppos][2] = drops[i+1][droppos][0];
   	    drops[i][dropvida] = drops[i+1][dropvida];
   	    drops[i][dropdir] = drops[i+1][dropdir];
	}
	numDrops--;
	if (numDrops < 0) {
	    printf("\n\n ATENCIÓN ATENCIÓN, TENGO NUMERO DE DROPS NEGATIVO, ALGO FALLA \n\n");
	}
}

public CrearVariablesItem(playerid) {
	for (new i = 0; i < numItems[playerid]; i++) {
	    new varname[10];
	    format(varname, sizeof(varname), "inv%d", i);
	    
		SetPVarInt(playerid,varname, PlayerInfo[playerid][pInventario][i]);
	}
}

public TimerTiempoVidaDrop() {
	for (new i = 0; i < numDrops; i++) {
	    if (drops[i][dropvida] > 0) {
	        drops[i][dropvida]--;
	        if (drops[i][dropvida] == 0) {
				BorrarDrop(i);                  //se carga los drops acabado su tiempo de vida
	        }
	    }
	}
}

public TimerRecogidaItemInventario() {

	for (new playerid = 0; playerid < MAX_PLAYERS; playerid++) {
	    if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)) {
		    for (new _dropid = 0; _dropid < numDrops; _dropid++){
		        if (PlayerToPoint(1.5, playerid,drops[_dropid][droppos][0], drops[_dropid][droppos][1], drops[_dropid][droppos][2])) {
//		            printf("Esta en el drop %d", _dropid);
		            if (insertarItem(playerid,drops[_dropid][dropmodel])) {
			            drops[_dropid][dropvida] = 1;
			            SendClientMessage(playerid, COLOR_GREEN, "Has cogido el drop!");
					} else {
					    if (avisoInventarioLleno[playerid]) {
						    SendClientMessage(playerid, COLOR_YELLOW, "Tienes el inventario lleno!");
						    avisoInventarioLleno[playerid] = false;
						}
					}
				}
		    }
	    }

 	}
}

public dropItemInventario(playerid, _idInventario){
	DestroySelectionMenu(playerid);
	if (PlayerInfo[playerid][pInventario][_idInventario] == 0){
		CrearVariablesItem(playerid);
		CreateSelectionMenuInventario(playerid, PESTANA_INVENTARIO, numItems[playerid]);
		return 1;
	}
	IndiceDropItem[playerid] = _idInventario;
	ShowPlayerDialog(playerid, DIALOGO_USAR_DROP, DIALOG_STYLE_LIST, "¿Qué quieres hacer con el objeto?", "USAR\nTIRAR\nDAR", "ACEPTAR", "CANCELAR");

	return 1;
}


//-------------------------- funciones MEGAMENU

public OnPlayerSkillSelection(playerid, response, skillid, pestana)
{
	if(pestana == PESTANA_SKILL)
	{
	    if(response)
	    {
		    switch(skillid)
			{
	        	case 0: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste una skill 1");
	        	case 1: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste una skill 2");
	        	case 2: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 3 skill");
	        	case 3: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 4 skill");
	        	case 4: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 5 skill");
	        	case 5: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 6 skill");
	        	case 6: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 7 skill");
	        	case 7: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 8 skill");
	        	case 8: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 9 skill");
	        	case 9: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 10 skill");
	        	case 10: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 11 skill");
	        	case 11: SendClientMessage(playerid, 0x33AA33AA, "Clickeaste 12 skill");
			}
	    }
	    else {
 			SendClientMessage(playerid, 0xFF0000FF, "Cancelaste");
 			SetPVarInt(playerid, "menu_on", 0);
		}
    	return 1;
	}
	return 1;
}

public OnPlayerCarMenuSelection(playerid, carKeyIndex)
{
    DestroySelectionMenu(playerid);
    new index;
    if (PlayerInfo[playerid][pCarKeys][carKeyIndex] == 0) {
       CreateSelectionMenuCoches(playerid, PESTANA_COCHES, carKeyIndex, -1);
    }
    else if (searchKey(PlayerInfo[playerid][pCarKeys][carKeyIndex], index)) {
		CreateSelectionMenuCoches(playerid, PESTANA_COCHES, carKeyIndex, index);
    }
    return 1;
}

public OnPlayerCambiaPestana(playerid, pestana) {
   	new titulo[50];
   	new sendername[MAX_PLAYER_NAME];

	DestroySelectionMenu(playerid);

    SetPVarInt(playerid, "menu_on", pestana);
    if (pestana == PESTANA_SKILL) {
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(titulo,sizeof(titulo),"%s - Nivel %d",sendername,PlayerInfo[playerid][pLevel]);
		new skills[NUM_SKILLS];
		for (new i = 0; i < NUM_SKILLS; i++)
		    skills[i] = PlayerInfo[playerid][pSkill][i];
	    CreateSelectionMenuSkill(playerid,titulo, pestana, skills);
	} else if (pestana == PESTANA_BANDA && PlayerInfo[playerid][pBanda] > 0) {
		format(titulo,sizeof(titulo),"%s - Nivel %d",Bandas[PlayerInfo[playerid][pBanda]][bNombre],Bandas[PlayerInfo[playerid][pBanda]][bNivel]);
	    CreateSelectionMenuBanda(playerid,titulo, pestana);
	} else if (pestana == PESTANA_BANDA && PlayerInfo[playerid][pBanda] == 0) {
	    pestana = PESTANA_SIN_BANDA;
		format(titulo,sizeof(titulo),"No estas en ninguna banda");
	    CreateSelectionMenuBanda(playerid,titulo, pestana);
	} else if (pestana == PESTANA_COCHES) {
	    new index;
	    if (searchKey(PlayerInfo[playerid][pCarKeys][0], index)) {
    	    CreateSelectionMenuCoches(playerid, pestana, 0, index);
		} else {
			CreateSelectionMenuCoches(playerid, pestana, 0, -1);
		}
	} else if (pestana == PESTANA_INVENTARIO) {
		CrearVariablesItem(playerid);
		CreateSelectionMenuInventario(playerid, pestana, numItems[playerid]);
	}
    return 1;
}

public MenuTiendaHandler(playerid, skinid, precio){
	new str[200];
	format(str,sizeof(str), "Has seleccionado la skin %d que vale %d", skinid, precio);
	SendClientMessage(playerid, COLOR_GREEN,str);
}

public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	new strError[1024];
	format(strError, sizeof( strError ), "Error: %i | %s \nQuery: %s", errorid, error, query);

	/*
	switch(errorid)
	{
		case CR_SERVER_GONE_ERROR:
		{
			printf("Lost connection to server, trying reconnect...");
			mysql_reconnect(connectionHandle);
		}
		case ER_SYNTAX_ERROR:
		{
			printf("Something is wrong in your syntax, query: %s",query);
		}
	}*/
	return 1;
}

