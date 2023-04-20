if(isServer) then {
	missionNamespace setVariable ["D37AT_weaponsArr", ['M_Titan_MIL_AP','M_Titan_MIL_AT'], true];
};

[player] call D37AT_fnc_addEventHandler;