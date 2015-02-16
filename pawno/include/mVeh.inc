
/*
		Owning de coches Vendetta's Revenge server
*/

#include <a_samp>
#include "../include/gl_common.inc"
#include <float>
#include <file>

#define MAX_CARS_PROP 	500
#define RESPAWN_TIME	60*5

#define MAX_PLAYER_CAR_KEYS	3

forward giveKeys(playerid, _key);
forward timerAlarmaCoche(_vehid);

new VehicleNames[212][30] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
    "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
    "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
    "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
    "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
    "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
    "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
    "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
    "Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
    "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
    "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
    "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
    "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
    "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
    "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
    "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
    "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
    "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
    "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
    "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
    "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
    "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
    "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
    "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
    "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
    "Tiller", "Utility Trailer"
};


enum cInfo {
	vehid,
	vehkey, 
	vehmodel,
	Float:vehPos[4], //x,y,z,angle
	vehc[2],         //color1, color2
	vehcopy,
	vehdoors, 			//1 locked 0 open
	cSpoiler,    // Aleron
	cHood,      // Capó
	cRoof,      // Techo
	cSideskirt, // Faldones
	cNitro,     // N20
	cLamps,     // Luces Delanteras
	cExhaust,   // Tubo Escape
	cWheel,     // Llantas
	cHydraulics,    // Hidráulica
	cPaintjob,    // Stereo
	cFrontBumper,    // Par. Delantero
	cRearBumper,    // Par. Trasero
	cVents,     // Respiraderos
};
new car[MAX_CARS_PROP][cInfo];
new numCars;

new tiempoAlarmaCoche[MAX_CARS_PROP*2];
new timerAlarmaCocheID[MAX_CARS_PROP*2];

public timerAlarmaCoche(_vehid) {
	new engine, lights, alarm, doors, bonnet, boot, objective;
	if (tiempoAlarmaCoche[_vehid] == 0) {
		GetVehicleParamsEx(_vehid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(_vehid, engine, lights, 0, doors, bonnet, boot, objective);
		KillTimer(timerAlarmaCocheID[_vehid]);
	} else {
		tiempoAlarmaCoche[_vehid]--;
	}
}

stock GetVehicleName(vehicleid)	{
	new String[30];
    format(String,sizeof(String),"%s",VehicleNames[GetVehicleModel(vehicleid) - 400]);
    return String;
}

/*
giveKeysCopy(playerid, _key) {
	new copy = _key * 10;
	new index;
	if (!car[index][vehcopy] && searchKey(_key, index)) {
		car[index][vehcopy] = 1;
		if (giveKeys(playerid,copy) == -1)
			return -1;
		return 0;
	} 
	return -1;
}*/

isKeyCopy(_key) {
	if (_key > 9999)
		return true;
	return false;
}


searchCar(_vehid) {
	for (new i = 0; i < numCars; i++) {
		if (car[i][vehid] == _vehid)
			return i;
	}
	return -1;
}

searchKey(_key, &_index) {
	new centro;
	new inf = 0;
	new sup = numCars-1;
	while (inf <= sup) {
		centro = (sup - inf) / 2 + inf;
		if (car[centro][vehkey] == _key) {
			_index = centro;
			return true;
		}
		else if (car[centro][vehkey] > _key) {
			sup = centro-1;
			_index = centro;
		} else {
			inf = centro+1;
			_index = centro+1;
		}
	}
	return false;
}

/*
isKeyCar(_key, _veh, &index) {
	if (searchKey(_key, index)) {
		if (car[index][vehid] == _veh)
			return true;
	}
	return false;
}
*/
/*
toggleDoors(_key, _veh) {
	new index;
	if (isKeyCar(_key,_veh,index) {
		if (car[index][vehdoors] == 0)
			car[index][vehdoors] = 1;
		else
			car[index][vehdoors] = 0;
		return 0;
	}
	return -1;
}

DoorsLocked(_key, _veh) {
	new index;
	if (isKeyCar(_key,_veh,index) {
		return car[index][vehdoors];
	}
	return -1;
}*/

createKey(&_index) {
	new rand;
	new intentos = 10;
	for (new i = 0; i < intentos; i++) {
		rand = random(8999) + 1000;
		if (!searchKey(rand, _index))
			return rand;
	}
	for (new i = rand; i < MAX_CARS_PROP; i++) {
		if (!searchKey(i, _index))
			return i;
	}
	return -1;
}

InsertCar(_key, index,modelid,id,Float:x,Float:y,Float:z,Float:angle,color1,color2) {
	if (numCars == MAX_CARS_PROP)
		return -1;
	for (new i = numCars; i > index; i--) {
		car[i][vehid] = car[i-1][vehid];
		car[i][vehkey] = car[i-1][vehkey];
		car[i][vehmodel] = car[i-1][vehmodel];
		car[i][vehPos][0] = car[i-1][vehPos][0];
		car[i][vehPos][1] = car[i-1][vehPos][1];
		car[i][vehPos][2] = car[i-1][vehPos][2];
		car[i][vehPos][3] = car[i-1][vehPos][3];
		car[i][vehc][0] = car[i-1][vehc][0];
		car[i][vehc][1] = car[i-1][vehc][1];
	}
	car[index][vehid] = id;
	car[index][vehkey] = _key;
	car[index][vehmodel] = modelid;
	car[index][vehPos][0] = x;
	car[index][vehPos][1] = y;
	car[index][vehPos][2] = z;
	car[index][vehPos][3] = angle;
	car[index][vehc][0] = color1;
	car[index][vehc][1] = color2;
	numCars++;
	return 0;
}

/*
BuyCar(_vehid, color1, color2) {
	new index;
	new _key = createKey(index);
	if (_key != -1) {
		new Float:x, Float:y, Float:z, Float:angle;
		new modelid = GetVehicleModel(_vehid);
		GetVehiclePos(_vehid,x,y,z);
		GetVehicleZAngle(_vehid,angle);
		if (InsertCar(_key,index,modelid, _vehid,x,y,z,angle,color1,color2) == -1) {
			DestroyVehicle(id);
			printf("NO SE PUEDEN CREAR MÁS COCHES DE PROPIEDAD, REVISAR ESTO URGENTEMENTE");
		}
		return id;
	}
	return -1;
}*/

CreatePropCar(modelid, Float:x, Float:y, Float:z, Float:angle,color1, color2) {
	new index;
	new _key = createKey(index);
	if (_key != -1) {
		new id = CreateVehicle(modelid,x,y,z,angle,color1,color2,RESPAWN_TIME);
		printf("LLave:%d Index:%d id(%d) en (%.2f,%.2f,%.2f)",_key, index, id,x,y,z);
		if (InsertCar(_key,index,modelid,id,x,y,z,angle,color1,color2) == -1) {
			DestroyVehicle(id);
			printf("NO SE PUEDEN CREAR MÁS COCHES DE PROPIEDAD, REVISAR ESTO URGENTEMENTE");
		}
		return _key;
	}
	return -1;
}

DestroyPropCarByKey(_key) {
	new index;
	if (searchKey(_key, index)){
		DestroyVehicle(car[index][vehid]);
		
		for (new i = index; i < numCars; i++) {
			car[i][vehkey] = car[i+1][vehkey];
			car[i][vehid] = car[i+1][vehid];
			car[i][vehmodel] = car[i+1][vehmodel];
			car[i][vehPos][0] = car[i+1][vehPos][0];
			car[i][vehPos][1] = car[i+1][vehPos][1];
			car[i][vehPos][2] = car[i+1][vehPos][2];
			car[i][vehPos][3] = car[i+1][vehPos][3];
			car[i][vehc][0] = car[i+1][vehc][0];
			car[i][vehc][1] = car[i+1][vehc][1];	
			printf("Pasando %d a %d", i+1, i);
		}
		numCars--;
		return true;
	}
	return false;
}
/*
DestroyPropCarByVehicleID(_id) {
	new index = searchCar(_id);
	if (index != -1){
		DestroyVehicle(car[index][vehid]);
		
		for (new i = index; i < numCars; i++) {
			car[i][vehkey] = car[i+1][vehkey];
			car[i][vehid] = car[i+1][vehid];
			car[i][vehmode] = car[i+1][vehmodel];
			car[i][vehPos][0] = car[i+1][vehPos][0];
			car[i][vehPos][1] = car[i+1][vehPos][1];
			car[i][vehPos][2] = car[i+1][vehPos][2];
			car[i][vehPos][3] = car[i+1][vehPos][3];
			car[i][vehc][0] = car[i+1][vehc][0];
			car[i][vehc][1] = car[i+1][vehc][1];		
		}
		numCars--;
		return true;
	}
	return false;
}
*/

loadVeh( ){
	printf("Cargando coches en propiedad ");
    printf("-------------------------");
	new idx = 0;
	new File: hFile;
    hFile = fopen("cars.txt", io_read);
	if (hFile) {
        new strLine[21][20];                 //ojo aqui si añadimos o quitamos
        new line[150];
        while ( fread( hFile , line , sizeof( line ) ) ) {
            split(line, strLine, '|');
			car[idx][vehkey] = strval(strLine[0]);
			car[idx][vehmodel] = strval(strLine[1]);
			car[idx][vehPos][0] = floatstr(strLine[2]);
			car[idx][vehPos][1] = floatstr(strLine[3]);
			car[idx][vehPos][2] = floatstr(strLine[4]);
			car[idx][vehPos][3] = floatstr(strLine[5]);
			car[idx][vehc][0] = strval(strLine[6]);
			car[idx][vehc][1] = strval(strLine[7]);
	
			car[idx][cSpoiler] = strval(strLine[8]);
			car[idx][cHood] = strval(strLine[9]);
			car[idx][cRoof] = strval(strLine[10]);
			car[idx][cSideskirt] = strval(strLine[11]);
			car[idx][cNitro] = strval(strLine[12]);
			car[idx][cLamps] = strval(strLine[13]);
			car[idx][cExhaust] = strval(strLine[14]);
			car[idx][cWheel] = strval(strLine[15]);
			car[idx][cHydraulics] = strval(strLine[16]);
			car[idx][cPaintjob] = strval(strLine[17]);
			car[idx][cFrontBumper] = strval(strLine[18]);
			car[idx][cRearBumper] = strval(strLine[19]);
			car[idx][cVents] = strval(strLine[20]);
			
			car[idx][vehid] = CreateVehicle(car[idx][vehmodel],
										car[idx][vehPos][0],
										car[idx][vehPos][1],
										car[idx][vehPos][2],
										car[idx][vehPos][3],
										car[idx][vehc][0],
										car[idx][vehc][0],
										RESPAWN_TIME);
			
			printf("Creado %d con llave %d",car[idx][vehid],car[idx][vehkey]);
			
			/*new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(car[idx][vehid], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(car[idx][vehid], engine, lights, alarm, 1, bonnet, boot, objective);*/
			car[idx][vehdoors] = 1; //cerrar las puertas por defecto
			PonerTunning(car[idx][vehid]);
			idx++;
		}
		numCars = idx;
	}
	printf("\n***** COCHES EN PROPIEDAD CARGADOS ******\n\n");
}

saveVeh() {
	new idx = 0;
	new File: hFile;
	new strLine[150];
	while (idx < numCars)
	{
		format(strLine, sizeof(strLine), "%d|%d|%f|%f|%f|%f|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d\n", 
			car[idx][vehkey],
			car[idx][vehmodel],
			car[idx][vehPos][0],
			car[idx][vehPos][1],
			car[idx][vehPos][2],
			car[idx][vehPos][3],
			car[idx][vehc][0],
			car[idx][vehc][1],
			car[idx][cSpoiler],
			car[idx][cHood],
			car[idx][cRoof],
			car[idx][cSideskirt],
			car[idx][cNitro],
			car[idx][cLamps],
			car[idx][cExhaust],
			car[idx][cWheel],
			car[idx][cHydraulics],
			car[idx][cPaintjob],
			car[idx][cFrontBumper],
			car[idx][cRearBumper],
			car[idx][cVents]);
		if(idx == 0) {
			hFile = fopen("cars.txt", io_write);
		}
		else {
			hFile = fopen("cars.txt", io_append);
		}
		fwrite(hFile, strLine);
		fclose(hFile);
		idx++;
    }
	return 1;
}


PonerTunning(idx) {

   ChangeVehicleColor(idx, car[idx][vehc][0], car[idx][vehc][1]);
   if(car[idx][cWheel] > 0)          AddVehicleComponent(idx, car[idx][cWheel]);
   if(car[idx][cHydraulics] > 0)    AddVehicleComponent(idx, car[idx][cHydraulics]);
   if(car[idx][cNitro] > 0)           AddVehicleComponent(idx, car[idx][cNitro]);
   if(car[idx][cSideskirt] > 0)
   {
        AddVehicleComponent(idx, car[idx][cSideskirt]);
        new skirt = car[idx][cSideskirt];
        // X-FLOW
        if(skirt == 1030) AddVehicleComponent(idx, 1031);
        else if(skirt == 1039) AddVehicleComponent(idx, 1041);
        else if(skirt == 1048) AddVehicleComponent(idx, 1052);
        else if(skirt == 1070) AddVehicleComponent(idx, 1072);
        else if(skirt == 1057) AddVehicleComponent(idx, 1063);
        else if(skirt == 1093) AddVehicleComponent(idx, 1095);
        // ALIEN
        if(skirt == 1026) AddVehicleComponent(idx, 1027);
        else if(skirt == 1036) AddVehicleComponent(idx, 1040);
        else if(skirt == 1047) AddVehicleComponent(idx, 1051);
        else if(skirt == 1069) AddVehicleComponent(idx, 1071);
        else if(skirt == 1056) AddVehicleComponent(idx, 1062);
        else if(skirt == 1094) AddVehicleComponent(idx, 1090);
   }
   if(car[idx][cRoof] > 0)           AddVehicleComponent(idx, car[idx][cRoof]);
   if(car[idx][cSpoiler] > 0)        AddVehicleComponent(idx, car[idx][cSpoiler]);
   if(car[idx][cRearBumper] > 0)    AddVehicleComponent(idx, car[idx][cRearBumper]);
   if(car[idx][cFrontBumper] > 0)    AddVehicleComponent(idx, car[idx][cFrontBumper]);
   if(car[idx][cExhaust] > 0)       AddVehicleComponent(idx, car[idx][cExhaust]);
   if(car[idx][cPaintjob] > 0)       ChangeVehiclePaintjob(idx, car[idx][cPaintjob]-1);
}
