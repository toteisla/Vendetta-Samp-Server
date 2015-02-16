#include <a_samp>
#include "../include/gl_common.inc"

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

#define CALAVERA 1313
//*******Estructura de Trabajos**********
#define SIN_TRABAJO 0
#define NUM_TRABAJOS 10
#define MAX_PLAYERS_TRABAJOS 5

#define FALLIDO 0
#define EXITO 1

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward startJob(tID, playerid);
forward finishJob(tID, playerid,razon);
forward checkSlots(tID);

forward setJobCheckpoint(playerid, Float:x, Float:y, Float: z, Float:size);
forward onPlayerEnterJobCheckpoint();

forward cogerObjeto(playerid, slot, modelo_id);
forward cargandoObjeto(playerid);
forward dejarObjeto(playerid);
forward dejandoObjeto(playerid, slot);

new onPlayerEnterJobCheckpointT;
new cargando[MAX_PLAYERS];
new TimerCargando[MAX_PLAYERS];

new Trabajo[MAX_PLAYERS];
//*******Fin Estructura******************

//--------------Trabajo 1: Repartir Pizzas
#define NUM_TRABAJO_PIZZAS 1
#define CAJA_PIZZA 1582

new t1PizzaPickup;
new t1ChksRestantes[MAX_PLAYERS];

enum tMoto{
	ID,
	cargada,
	Float:tx,
	Float:ty,
	Float:tz,
	idPlayer
}
new MotoInfo[4][tMoto];

new Float:t1ChkPnts[4][3] = {
	{-2319.8342,-145.3344,35.5547},//Coger Mision
	{-2319.7227,-154.9143,35.5547},//Coger Pizza
	{-2429.7759,-114.7320,35.3125},//Entegar 1
	{-2429.9016,-182.6492,35.3203} //Entegar 2
};

//--------------Trabajo 2: Repartir Dinero
#define NUM_TRABAJO_DINERO 2
#define SACO_DINERO 1550
#define PAQUETE_DINERO 1212

//new t2DineroPickup;
new t2ChksRestantes[MAX_PLAYERS];

enum tCamion{
	ID,
	cargado,
	Float:tx,
	Float:ty,
	Float:tz,
	idPlayer
}
new TruckInfo[4][tCamion];

new Float:t2ChkPnts[6][3] = {
	{-1968.4020,592.0119,34.8914},//Coger Mision
	{-1696.4171,949.1847,24.8906},//Entrada Tienda
	{1983.5715,1651.1350,-20.7922},//Coger Dinero
	{2008.3002,1655.0859,-19.7922},//Salida Tienda
	{-1600.2876,900.2864,9.2266}, //Entrada banco
	{300.1981,120.1157,999.1031}//Dejar Dinero
};
//--------------Fin Trabajo 2

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Vendetta's Job System by Tote_Vendetta ");
	print("--------------------------------------\n");
	
	//******************************NO TOCAR***************************************
 	onPlayerEnterJobCheckpointT = SetTimer("onPlayerEnterJobCheckpoint",500,1);
	for(new i=0 ; i<NUM_TRABAJOS; i++){Trabajo[i] = 0;}
	//*****************************************************************************
	//------------------Trabajo 1
	MotoInfo[0][ID] = AddStaticVehicle(448,-2343.88,-137.67,35.32,173.37,0,0);//Moto Pizza 1
    MotoInfo[1][ID] = AddStaticVehicle(448,-2338.88,-137.67,35.32,173.37,0,0);//Moto Pizza 2
    MotoInfo[2][ID] = AddStaticVehicle(448,-2333.88,-137.67,35.32,173.37,0,0);//Moto Pizza 3
    MotoInfo[3][ID] = AddStaticVehicle(448,-2328.88,-137.67,35.32,173.37,0,0);//Moto Pizza 4
	AddStaticPickup(CALAVERA, 1, t1ChkPnts[0][0], t1ChkPnts[0][1], t1ChkPnts[0][2], 0);//PickUp Trabajo
	
	//------------------Trabajo 2
	TruckInfo[0][ID] = AddStaticVehicle(428,-1944.2157,585.1483,34.8345,0.6682,0,0);//Moto Pizza 1
    TruckInfo[1][ID] = AddStaticVehicle(428,-1953.1492,585.6088,34.8232,0.1115,0,0);//Moto Pizza 2
    TruckInfo[2][ID] = AddStaticVehicle(428,-1959.4076,585.0554,34.8285,0.5942,0,0);//Moto Pizza 3
    TruckInfo[3][ID] = AddStaticVehicle(428,-1929.3522,585.0063,34.8367,359.7085,0,0);//Moto Pizza 4
    AddStaticPickup(CALAVERA, 1, t2ChkPnts[0][0], t2ChkPnts[0][1], t2ChkPnts[0][2], 0);//PickUp Trabajo
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(onPlayerEnterJobCheckpointT);
	return 1;
}

public OnPlayerDeath(playerid){
    if(Trabajo[playerid] != SIN_TRABAJO)
		finishJob(Trabajo[playerid], playerid, FALLIDO);
}

public OnPlayerDisconnect(playerid){
	if(Trabajo[playerid] != SIN_TRABAJO)
		finishJob(Trabajo[playerid], playerid, FALLIDO);
}

public startJob(tID, playerid){
	Trabajo[playerid] = tID;
	if(tID == NUM_TRABAJO_PIZZAS){
		//sendJobGameText(tID, playerid, "Coge esas pizzas y cargalas en una de las motos", 6);
  		t1ChksRestantes[playerid] = 6;
		t1PizzaPickup = CreateObject(CAJA_PIZZA, t1ChkPnts[1][0], t1ChkPnts[1][1], t1ChkPnts[1][2], 0,0,0,0);//PickUp Trabajo
		setJobCheckpoint(playerid,t1ChkPnts[1][0],t1ChkPnts[1][1],t1ChkPnts[1][2],3.0);
		
	}else if(tID == NUM_TRABAJO_DINERO){
	    t2ChksRestantes[playerid] = 6;
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Coge uno de los furgones blindados");
	}
}

public finishJob(tID, playerid, razon){
	DisablePlayerCheckpoint(playerid);
	if(tID == NUM_TRABAJO_PIZZAS){
	    for(new i=0 ; i<4; i++){//limpia lo relacionado con la moto
	        if(MotoInfo[i][idPlayer] == playerid){
                MotoInfo[i][idPlayer] = -1;
                MotoInfo[i][cargada] = 0;
                SetVehicleParamsForPlayer(MotoInfo[i][ID], playerid, 0, 0);
                SetVehicleToRespawn(MotoInfo[i][ID]);
	        }
	    }
	}
	else if(tID == NUM_TRABAJO_DINERO){
	    for(new i=0 ; i<4; i++){//limpia lo relacionado con los camiones
	        if(TruckInfo[i][idPlayer] == playerid){
                TruckInfo[i][idPlayer] = -1;
                SetVehicleToRespawn(TruckInfo[i][ID]);
	        }
	    }
	}
	
	Trabajo[playerid] = SIN_TRABAJO;
	if(razon == EXITO){
		//DAR RECOMPENSA
		SendClientMessage(playerid, COLOR_GREEN, "Gracias por su trabajo. Aqui tiene su recompensa");
	}
	else if(razon == FALLIDO){
	    SendClientMessage(playerid, COLOR_RED, "Fracasaste en tu trabajo. Vuelve a intentarlo cuando quieras");
	}
}

public onPlayerEnterJobCheckpoint(){
    for (new playerindex = 0; playerindex < MAX_PLAYERS; playerindex++) {//recorre los jugadores de dicho trabajo
		new playerid = playerindex; //La id del jugador encontrado se guarda en playerid
    	if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){ //comprobacion de toda la vida
    	    if(Trabajo[playerid] == NUM_TRABAJO_PIZZAS){// Si es el trabajo de las pizzas tira palante
    	        if(PlayerToPoint(3,playerid,t1ChkPnts[1][0],t1ChkPnts[1][1],t1ChkPnts[1][2]) && t1ChksRestantes[playerid] == 6){//Pickup Pizza
    	            if(cargando[playerid] != 1){
    	            	DestroyObject(t1PizzaPickup);
    	            	cogerObjeto(playerid,0,CAJA_PIZZA);
    	            	DisablePlayerCheckpoint(playerid);
    	            	SendClientMessage(playerid,COLOR_LIGHTBLUE, "Mete la pizza en una de las motos. Usa el comando /meterpizza cerca de una de las motos");
    	            	t1ChksRestantes[playerid]--;
					}
    	        }
    	        else if(t1ChksRestantes[playerid] == 4){
    	            for(new i=0 ; i<4 ; i++){
	    	            if(MotoInfo[i][cargada] == 1){
	    	                if(MotoInfo[i][idPlayer] == playerid){
								setJobCheckpoint(playerid, MotoInfo[i][tx], MotoInfo[i][ty], MotoInfo[i][tz], 3);
								t1ChksRestantes[playerid]--;
		    	            }
	    	            }
	    	        }
    	        }
    	        else if(t1ChksRestantes[playerid] == 3){
    	            for(new i=0 ; i<4 ; i++){
    	                if(MotoInfo[i][cargada] == 1){
	    	                if(MotoInfo[i][idPlayer] == playerid){
		    	                if(PlayerToPoint(3,playerid,MotoInfo[i][tx], MotoInfo[i][ty], MotoInfo[i][tz])){
		    	                    setJobCheckpoint(playerid,t1ChkPnts[2][0],t1ChkPnts[2][1],t1ChkPnts[2][2],3);
	    	                		t1ChksRestantes[playerid]--;
		    	                }
							}
						}
    	            }
    	        }
    	        else if(PlayerToPoint(3,playerid,t1ChkPnts[2][0],t1ChkPnts[2][1],t1ChkPnts[2][2]) && t1ChksRestantes[playerid] == 2){
    	            if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && cargando[playerid] == 1){
    	                dejarObjeto(playerid);
    	                setJobCheckpoint(playerid,t1ChkPnts[3][0],t1ChkPnts[3][1],t1ChkPnts[3][2],3);
    	            	t1ChksRestantes[playerid]--;
    	            }
    	        }
    	        else if(PlayerToPoint(3,playerid,t1ChkPnts[3][0],t1ChkPnts[3][1],t1ChkPnts[3][2]) && t1ChksRestantes[playerid] == 1){
    	            if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && cargando[playerid] == 1){
    	                dejarObjeto(playerid);
    	                setJobCheckpoint(playerid,t1ChkPnts[0][0],t1ChkPnts[0][1],t1ChkPnts[0][2],3);
    	            	t1ChksRestantes[playerid]--;
    	            }
    	        }
    	        else if(PlayerToPoint(3,playerid,t1ChkPnts[0][0],t1ChkPnts[0][1],t1ChkPnts[0][2]) && t1ChksRestantes[playerid] == 0){
   					if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
   					    finishJob(NUM_TRABAJO_PIZZAS, playerid, EXITO);
   					}
    	        }
    	    }
    	    else if(Trabajo[playerid] == NUM_TRABAJO_DINERO){
    	        if(t2ChksRestantes[playerid] == 6){
    	            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
    	                for(new i=0 ; i<4 ; i++){
    	                    if(GetPlayerVehicleID(playerid) == TruckInfo[i][ID]){
    	                        TruckInfo[i][idPlayer] = playerid;
								SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ve al negocio a recoger el dinero");
                             	setJobCheckpoint(playerid, t2ChkPnts[1][0],t2ChkPnts[1][1],t2ChkPnts[1][2], 3);
                             	t2ChksRestantes[playerid]--;
    	                    }
    	                }
    	            }
    	        }
    	        else if(PlayerToPoint(3,playerid,t2ChkPnts[1][0],t2ChkPnts[1][1],t2ChkPnts[1][2]) && t2ChksRestantes[playerid] == 5){
    	            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Entra en la tienda y coge el dinero");
    	            setJobCheckpoint(playerid, t2ChkPnts[2][0],t2ChkPnts[2][1],t2ChkPnts[2][2], 3);
    	            t2ChksRestantes[playerid]--;
    	        }
    	        else if(PlayerToPoint(3,playerid,t2ChkPnts[2][0],t2ChkPnts[2][1],t2ChkPnts[2][2]) && t2ChksRestantes[playerid] == 4){
    	            if(cargando[playerid] == 0){
    	                
    	                cogerObjeto(playerid, 0, PAQUETE_DINERO);
	    	            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Sal de la tienda y mete el dinero en el camion");
	    	            setJobCheckpoint(playerid, t2ChkPnts[3][0],t2ChkPnts[3][1],t2ChkPnts[3][2], 3);
	    	            t2ChksRestantes[playerid]--;
    	            }
    	        }
    	        else if(PlayerToPoint(3,playerid,t2ChkPnts[3][0],t2ChkPnts[3][1],t2ChkPnts[3][2]) && t2ChksRestantes[playerid] == 3){
    	            for(new i=0 ; i<4 ; i++){
					 	if(TruckInfo[i][idPlayer] == playerid){
					 	    GetVehiclePos(TruckInfo[i][ID], TruckInfo[i][tx], TruckInfo[i][ty], TruckInfo[i][tz]);
    	            		setJobCheckpoint(playerid, TruckInfo[i][tx], TruckInfo[i][ty], TruckInfo[i][tz], 3);
    	            		t2ChksRestantes[playerid]--;
						}
	 				}
    	        }
    	        else if(t2ChksRestantes[playerid] == 2){
    	            for(new i=0 ; i<4 ; i++){
    	                if(TruckInfo[i][idPlayer] == playerid){
    	                    if(PlayerToPoint(3, playerid, TruckInfo[i][tx], TruckInfo[i][ty], TruckInfo[i][tz])){
    	                        if(cargando[playerid] == 1){
									dejarObjeto(playerid);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, "Monta en el camion y dirigete al banco");
									setJobCheckpoint(playerid, t2ChkPnts[4][0],t2ChkPnts[4][1],t2ChkPnts[4][2], 3);
									t2ChksRestantes[playerid]--;
								}
    	                    }
    	                }
    	            }
    	        }
    	        else if(t2ChksRestantes[playerid] == 1){
    	            if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
    	                SetPlayerAttachedObject(playerid, 1, SACO_DINERO, 1, 0.053070, -0.083673, -0.004646, 86.6, 354.2, 180.0, 1.0, 1.0, 1.0);//Saco de dinero
    	                
    	                if(PlayerToPoint(3, playerid, t2ChkPnts[4][0],t2ChkPnts[4][1],t2ChkPnts[4][2])){
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Monta en el camion y dirigete al banco");
							setJobCheckpoint(playerid, t2ChkPnts[5][0],t2ChkPnts[5][1],t2ChkPnts[5][2], 3);
							t2ChksRestantes[playerid]--;
		    	        }
					}
					else{
						RemovePlayerAttachedObject(playerid, 1);
					}
				}
				else if(PlayerToPoint(3, playerid, t2ChkPnts[5][0],t2ChkPnts[5][1],t2ChkPnts[5][2]) && t2ChksRestantes[playerid] == 0){
				    finishJob(NUM_TRABAJO_DINERO, playerid, EXITO);
				}
    	    }
    	}
	}
}

public cogerObjeto(playerid, slot, modelo_id){
	cargando[playerid] = 1;
    KillTimer(TimerCargando[playerid]);
    TimerCargando[playerid] = SetTimerEx("cargandoObjeto",1000,1,"d",playerid);
    ApplyAnimation(playerid,"CARRY","liftup",1,0,0,0,0,0);
	return SetPlayerAttachedObject(playerid, slot, modelo_id, 5, -0.045800, 0.005297, 0.213481, 276.266876, 0.722662, 119.390830, 0.825105, 0.976897, 0.840149 );
}

public cargandoObjeto(playerid) {
    ApplyAnimation(playerid,"CARRY","crry_prtial",10,7,5,1,1,1);
    return 1;
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

public checkSlots(tID){
	new cont = 0;
	for(new i=0 ; i<MAX_PLAYERS ; i++){
	    if(Trabajo[i] == tID){
			cont++;
	    }
	}
	if(cont < MAX_PLAYERS_TRABAJOS)
		return 1;
	else
	    return 0;
}

public setJobCheckpoint(playerid, Float:x, Float:y, Float: z, Float:size){
	SetPlayerCheckpoint(playerid,x,y,z,size);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/cogertrabajo", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
	        if(PlayerToPoint(5, playerid, t1ChkPnts[0][0],t1ChkPnts[0][1],t1ChkPnts[0][2])){
			    if(checkSlots(NUM_TRABAJO_PIZZAS)){
			        startJob(NUM_TRABAJO_PIZZAS, playerid);
			    }else{
			        SendClientMessage(playerid, COLOR_RED, "Vuelve mas tarde.");
			    }
			}
	        else if(PlayerToPoint(5, playerid, t2ChkPnts[0][0],t2ChkPnts[0][1],t2ChkPnts[0][2])){
			    if(checkSlots(NUM_TRABAJO_DINERO)){
			        Trabajo[playerid] = NUM_TRABAJO_DINERO;
			        startJob(NUM_TRABAJO_DINERO, playerid);
			    }else{
			        SendClientMessage(playerid, COLOR_RED, "Vuelve mas tarde.");
			    }
			}
		}
		return 1;
	}
	if (strcmp("/meterpizza", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
	        if(t1ChksRestantes[playerid] == 5){
		        new Float:x, Float:y, Float:z;
		        for(new i=0 ; i<4 ; i++){
		            GetVehiclePos(MotoInfo[i][ID], x, y, z);
			        if(PlayerToPoint(3, playerid, x, y, z)){
			            dejarObjeto(playerid);
					    MotoInfo[i][cargada] = 1;
					    MotoInfo[i][idPlayer] = playerid;
					    MotoInfo[i][tx] = x;
					    MotoInfo[i][ty] = y;
					    MotoInfo[i][tz] = z;
					    SetVehicleParamsForPlayer(MotoInfo[i][ID], playerid, 1, 0);
					    t1ChksRestantes[playerid]--;
					}
			 	}
			}
	    }
		return 1;
	}
	if (strcmp("/cogerpizza", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
	        if(t1ChksRestantes[playerid] == 2 || t1ChksRestantes[playerid] == 1){
		        new Float:x, Float:y, Float:z;
		        for(new i=0 ; i<4 ; i++){
		            GetVehiclePos(MotoInfo[i][ID], x, y, z);
		            if(MotoInfo[i][idPlayer] == playerid){
		                if(PlayerToPoint(3, playerid, x, y, z)){
							cogerObjeto(playerid,0,CAJA_PIZZA);
						}
		            }
			 	}
			}
	    }
		return 1;
	}
	if (strcmp("/pizza", cmdtext, true, 10) == 0)
	{
	    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)){
	    	SetPlayerPos(playerid, t1ChkPnts[0][0],t1ChkPnts[0][1],t1ChkPnts[0][2]);
	    }
		return 1;
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
