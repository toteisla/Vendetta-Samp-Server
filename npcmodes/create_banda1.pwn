#define RECORDING "create_banda1" //This is the filename of your recording without the extension.
#define RECORDING_TYPE 2 //1 for in vehicle and 2 for on foot.

#include <a_npc>
#include <a_samp>

main(){}

public OnRecordingPlaybackEnd() {
	StartRecordingPlayback(RECORDING_TYPE, RECORDING);
}

public OnNPCSpawn(){
	StartRecordingPlayback(RECORDING_TYPE, RECORDING);

}
