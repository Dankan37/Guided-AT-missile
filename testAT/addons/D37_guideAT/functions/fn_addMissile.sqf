params ["_ammoName", "_action"];

if(isNil "_action") then {
	_action = "add";
};
private _action = toLower _action;

private _arr = missionNamespace getVariable ["D37AT_weaponsArr", []];
switch (_action) do {
	case "add": {
		_arr pushBackUnique _ammoName;
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