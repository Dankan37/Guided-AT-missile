params ["_ammoName", "_action"];

if(isNil "_action") then {
	_action = "add";
};
private _action = toLower _action;

private _arr = missionNamespace getVariable ["D37AT_weaponsArr", ['M_Titan_MIL_AP','M_Titan_MIL_AT']];
switch (_action) do {
	case "add": {
		_arr pushBack _ammoName;
	};
	case "remove": {
		private _index = _arr find _ammoName;
		if(_index != -1) then {
			_arr deleteAt _index;
		};
	};
};

missionNamespace setVariable ["D37AT_weaponsArr", _arr, true];
true;