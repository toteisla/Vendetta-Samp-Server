#include <a_npc>

#define RECORDING "vendetta_drogacoche" //Este es el nombre del archivo que grabaron in game
#define RECORDING_TYPE 1 //1 = en vehiculo 2= caminando
new gStoppedForTraffic = 0;
new gPlaybackActive = 0;

public ScanTimer();

#define AHEAD_OF_CAR_DISTANCE    11.0
#define SCAN_RADIUS     		 3.0

main(){}
public OnRecordingPlaybackEnd()
{
	StartRecordingPlayback(RECORDING_TYPE, RECORDING);
	StartPlayback();
}

#if RECORDING_TYPE == 1
  public OnNPCEnterVehicle(vehicleid, seatid)
  {
  
   StartRecordingPlayback(RECORDING_TYPE, RECORDING);
  
  }
  public OnNPCExitVehicle() StopRecordingPlayback();
#else
  public OnNPCSpawn() StartRecordingPlayback(RECORDING_TYPE, RECORDING);
#endif


stock GetXYInfrontOfMe(Float:distance, &Float:x, &Float:y)
{
    new Float:z, Float:angle;
    GetMyPos(x,y,z);
    GetMyFacingAngle(angle);
    x += (distance * floatsin(-angle, degrees));
    y += (distance * floatcos(-angle, degrees));
}

//------------------------------------------

public OnNPCModeInit()
{
	SetTimer("ScanTimer",200,1);
}

//------------------------------------------

LookForAReasonToPause()
{
  	new Float:X,Float:Y,Float:Z;
	new x=0;

	GetMyPos(X,Y,Z);
	GetXYInfrontOfMe(AHEAD_OF_CAR_DISTANCE,X,Y);
	while(x!=MAX_PLAYERS) {
    	if(IsPlayerConnected(x) && IsPlayerStreamedIn(x)) {
			if( GetPlayerState(x) == PLAYER_STATE_DRIVER ||
		    	GetPlayerState(x) == PLAYER_STATE_ONFOOT )
			{
				if(IsPlayerInRangeOfPoint(x,SCAN_RADIUS,X,Y,Z)) {
					return 1;
				}
			}
		}
		x++;
	}
 
	//new msg[256];
	//new Float:angle;
	//GetMyFacingAngle(angle);
	//format(msg,256,"My yaw/heading = %f",angle);
	//SendChat(msg);

	return 0;
}


//------------------------------------------

public ScanTimer()
{
	//new ticker = GetTickCount() - g_LastTick;
    //printf("npctest: timer (%d)ms", ticker);
    //g_LastTick = GetTickCount();

    new ReasonToPause = LookForAReasonToPause();

	if(ReasonToPause && !gStoppedForTraffic)
	{
	    //SendChat("I'm pausing");
		PauseRecordingPlayback();
		gStoppedForTraffic = 1;
	}
	else if(!ReasonToPause && gStoppedForTraffic)
	{
	    //SendChat("I'm resuming");
	    ResumeRecordingPlayback();
	    gStoppedForTraffic = 0;
	}
}


//------------------------------------------

StartPlayback()
{
	StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"vendetta_drogacoche");
	gStoppedForTraffic = 0;
	gPlaybackActive = 1;
}


//------------------------------------------



//------------------------------------------


//------------------------------------------



