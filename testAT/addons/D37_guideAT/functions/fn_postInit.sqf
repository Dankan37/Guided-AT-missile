[player] call D37AT_fnc_addEventHandler;

//every 10 seconds it adds the event handler for fired to all players
if(isServer) then {
	missionNamespace setVariable ["D37AT_weaponsArr", ['M_Titan_MIL_AP','M_Titan_MIL_AT','M_Titan_MIL_KE'], true];

/*
	Postinit is allegedly called on each player, so I guess I don't need this...
	D37AT_frameIndex = 0;
	private _id = ["D37_addEHGlobal", "onEachFrame", {
		if(D37AT_frameIndex == 600) then {
			D37AT_frameIndex = 0;
			{
				[[_x], D37AT_fnc_addEventHandler] remoteExec ["spawn", owner _x];
			}forEach allPlayers;
		};
		D37AT_frameIndex = D37AT_frameIndex + 1;
	}] call BIS_fnc_addStackedEventHandler;
*/
};

