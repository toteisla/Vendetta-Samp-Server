#include <a_samp>

#define COLOR_DARKGOLD 0x808000AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA

new PizzaJob[256];

public OnFilterScriptInit()
{

    AddStaticVehicle(448,-2331.7651,-136.7180,35.3203,173.3735,0,0); // Pizza 1
    AddStaticVehicle(448,-2335.0002,-137.1075,35.3203,179.3269,0,0); // Pizza 1
    AddStaticVehicle(448,-2338.0447,-136.3402,35.3203,173.6868,0,0); // Pizza 2
    AddStaticVehicle(448,-2340.8489,-136.3293,35.3203,177.4468,0,0); // Pizza 3

}
public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/pizza", cmdtext, true, 10) == 0)
    {
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
        {
            PizzaJob[playerid] = 1;
            new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "* %s is now a Pizzaboy.", name );
            SendClientMessageToAll(COLOR_YELLOW, string);
            SetPlayerCheckpoint(playerid,-2428.9141,-155.1205,35.3125,10);//lugar coger pizza
            SendClientMessage(playerid,COLOR_YELLOW,"* Follow the red markers and you'll recieve money!");
            return 1;
        }
        SendClientMessage(playerid, COLOR_RED,"You have to be on a pizza bike to start the job!");
    }
    return 0;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
     if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
     {
         SendClientMessage(playerid, COLOR_RED, "* You can start the pizza courier by using /pizza");
     }
     return 0;
}
public OnPlayerEnterCheckpoint(playerid)
{
     if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
     {
        if(PizzaJob[playerid] == 1){
            PizzaJob[playerid] = 2;
            SetPlayerCheckpoint(playerid,-2428.6428,-145.9356,35.3125,2);
            SendClientMessage(playerid,COLOR_YELLOW,"* Please go to the next mark, and you'll be payed!");
            return 1;
         }
        if(PizzaJob[playerid] == 2){
            PizzaJob[playerid] = 3;
            SetPlayerCheckpoint(playerid,-2428.5674,-109.3475,35.3203,2);
            return 1;
         }
        if(PizzaJob[playerid] == 3){
            PizzaJob[playerid] = 4;
            SetPlayerCheckpoint(playerid,-2428.3516,-93.7403,35.3203,2);
            return 1;
         }
        if(PizzaJob[playerid] == 4){
            PizzaJob[playerid] = 5;
            SetPlayerCheckpoint(playerid,-2428.7354,-52.3524,35.3125,2);
            return 1;
         }
        /*if(PizzaJob[playerid] == 5){
            PizzaJob[playerid] = 6;
            SetPlayerCheckpoint(playerid,2441.1526,-2017.4093,13.1231,10);
            return 1;
         }
        if(PizzaJob[playerid] == 6){
            PizzaJob[playerid] = 7;
            SetPlayerCheckpoint(playerid,2486.2058,-2017.6384,13.1309,10);
            return 1;
         }
        if(PizzaJob[playerid] == 7){
            PizzaJob[playerid] = 8;
            SetPlayerCheckpoint(playerid,2520.9238,-2016.4714,13.1395,10);
            return 1;
         }
        if(PizzaJob[playerid] == 8){
            PizzaJob[playerid] = 9;
            SetPlayerCheckpoint(playerid,2464.7258,-2000.3944,13.1430,10);
            return 1;
         }
        if(PizzaJob[playerid] == 9){
            PizzaJob[playerid] = 10;
            SetPlayerCheckpoint(playerid,2240.8374,-1886.9504,13.1486,10);
            return 1;
         }
        if(PizzaJob[playerid] == 10){
            PizzaJob[playerid] = 11;
            SetPlayerCheckpoint(playerid,2095.5488,-1815.7517,12.9792,10);
            return 1;
         }*/
        if(PizzaJob[playerid] == 5){
            PizzaJob[playerid] = 0;
            DisablePlayerCheckpoint(playerid);
            SendClientMessage(playerid,COLOR_YELLOW,"* You have recieved $400 for delivering the pizzas.");
            GivePlayerMoney(playerid,400);
         }
     }
     return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(PizzaJob[playerid] > 0)
    {
        PizzaJob[playerid] = 0;
        SendClientMessage(playerid, COLOR_RED, "* You have left your job, you won't be payed.");
        DisablePlayerCheckpoint(playerid);
    }
}
