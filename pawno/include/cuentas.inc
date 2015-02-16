ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

c_estaLogueado(playerid){
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	new File: UserFile = fopen("logged.txt", io_read);
	if (UserFile){
	    new key[256], Data[256];
	    while ( fread( UserFile , Data , sizeof( Data ) ) ){
			key = ini_GetKey( Data );
			if( strcmp( key , name , true ) == 0 ) {
				fclose(UserFile);
				return 1;
			}
		}
		fclose(UserFile);
	}
	return 0;
}

c_Team(playerid){
	new name[MAX_PLAYER_NAME],str[256],val[256];
 	GetPlayerName(playerid, name, sizeof(name));
	format(str, sizeof(str), "%s.ini", name);
	new File: UserFile = fopen(str, io_read);
	if (UserFile){
	    new key[256], Data[256];
	    while ( fread( UserFile , Data , sizeof( Data ) ) ){
			key = ini_GetKey( Data );
			if( strcmp( key , "Team" , true ) == 0 ) {
				val = ini_GetValue( Data );
				fclose(UserFile);
				return strval( val );
			}
		}
		fclose(UserFile);
	}
	return -1;
}

c_Rank(playerid){
	new name[MAX_PLAYER_NAME],str[256],val[256];
 	GetPlayerName(playerid, name, sizeof(name));
	format(str, sizeof(str), "%s.ini", name);
	new File: UserFile = fopen(str, io_read);
	if (UserFile){
	    new key[256], Data[256];
	    while ( fread( UserFile , Data , sizeof( Data ) ) ){
			key = ini_GetKey( Data );
			if( strcmp( key , "Rank" , true ) == 0 ) {
				val = ini_GetValue( Data );
				fclose(UserFile);
				return strval( val );
			}
		}
		fclose(UserFile);
	}
	return -1;
}


split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

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

GetClosestPlayer(p1)
{
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

Float:GetDistanceBetweenPlayerVeh(p1,p2){
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) && !IsPlayerNPC(p1))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetVehiclePos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}


GetClosestVeh(playerid){
	new Float:dis,Float:dis2,car;
    car = -1;
    dis = 99999.99;
    for (new i = 0; i < MAX_VEHICLES; i++ ) {
       	dis2 = GetDistanceBetweenPlayerVeh(playerid,i);
        if(floatcmp(dis,dis2) > 0 && floatround(dis2) < 5 && floatround(dis2) > 0.0)
		{
        	dis = dis2;
            car = i;
  		}
    }
    return car;
}


