#include <a_samp>
public OnFilterScriptInit()
{
	print("(SA-MP 0.3d)");
	/*for(new i=0;i<MAX_PLAYERS;i++)
	{
		RemoveBuildingForPlayer(i, 8229, 0.0, 0.0, 0.0, 6000.0);
  		RemoveBuildingForPlayer(i, 11014, 0.0, 0.0, 0.0, 6000.0);
  		RemoveBuildingForPlayer(i, 11372, 0, 0, 0, 6000.0);
		RemoveBuildingForPlayer(i, 10973, 0, 0, 0, 6000.0);
		RemoveBuildingForPlayer(i, 10974, 0, 0, 0, 6000.0);
    }
	return 1;*/
}

public OnPlayerConnect(playerid)
{
//---------------------------REMOVE GANGASTYLEDROGA
    RemoveBuildingForPlayer(playerid, 731, -2325.3125, 2350.0078, 3.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 9348, -2314.1484, 2408.3047, 5.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 9429, -2314.1484, 2408.3047, 5.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 715, -2346.4766, 2343.7969, 11.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 715, -2281.1094, 2380.2266, 12.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 647, -2334.0547, 2411.1563, 7.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 647, -2331.0859, 2414.9922, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 715, -2300.9219, 2394.6172, 12.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 715, -2311.7656, 2410.2422, 12.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 762, -2313.7031, 2422.2969, 9.3984, 0.25);
//------------------------------------------------------------
	RemoveBuildingForPlayer(playerid, 11091, -2133.5547, -132.7031, 36.1328, 0.25); //Muro de los mecanicos
	RemoveBuildingForPlayer(playerid, 11156, -2056.5469, -91.4219, 34.4922, 0.25);//Suelo de la puerta de la autoescuela el que estaba bugueado
//--------------------------Donde esta el basurero ahora.
	RemoveBuildingForPlayer(playerid, 9965, -1535.4219, 1168.6641, 18.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 9951, -1535.4219, 1168.6641, 18.2031, 0.25);
	//---------------------AUTOECUELA
	RemoveBuildingForPlayer(playerid, 11371, -2028.1328, -111.2734, 36.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 11372, -2076.4375, -107.9297, 36.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 11099, -2056.9922, -184.5469, 34.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 1497, -2029.0156, -120.0625, 34.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 11015, -2028.1328, -111.2734, 36.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 11014, -2076.4375, -107.9297, 36.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1532, -2025.8281, -102.4688, 34.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 11156, -2056.5469, -91.4219, 34.4922, 0.25); //El bugueado
//-----------------------EDIFICO DE BOMBEROS
	RemoveBuildingForPlayer(playerid, 11245, -2023.7109, 83.9688, 37.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 11272, -2037.5391, 79.9297, 34.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 11008, -2037.5391, 79.9297, 34.1094, 0.25);

	//------------EDIFICIO EN FORMA DE PIRAMIDE DE SAN FIERRO
	RemoveBuildingForPlayer(playerid, 10777, -1724.1953, 547.0859, 32.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 11375, -1724.1953, 547.0859, 32.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 9900, -1753.7109, 884.3906, 159.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 9933, -1753.6250, 884.4531, 179.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 9936, -1753.7109, 884.3906, 159.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 10040, -1765.7422, 799.9453, 53.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 10165, -1753.7813, 884.3906, 35.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 10235, -1753.7813, 884.3906, 35.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 10260, -1753.7422, 884.3984, 25.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1776.7188, 867.6563, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 717, -1785.3906, 867.6953, 24.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1776.7188, 879.6875, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 717, -1785.3906, 884.4297, 24.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1776.7188, 891.2500, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1776.7188, 901.4453, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 717, -1785.3906, 899.5078, 24.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1730.2422, 867.6563, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1730.2422, 879.6875, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1730.2422, 891.2500, 23.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 717, -1722.9531, 867.6953, 24.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 717, -1722.9531, 884.4297, 24.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 717, -1722.9531, 899.5078, 24.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 673, -1730.2422, 901.4453, 23.4063, 0.25);

	//------------LA BANDA
	RemoveBuildingForPlayer(playerid, 10158, -1954.2422, 1358.3672, 18.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 9950, -1954.2422, 1358.3672, 18.2031, 0.25);


//    RemoveBuildingForPlayer(playerid, 10973, 0, 0, 0, 6000.0);
//	RemoveBuildingForPlayer(playerid, 10974, 0, 0, 0, 6000.0);
	return 1;
}
