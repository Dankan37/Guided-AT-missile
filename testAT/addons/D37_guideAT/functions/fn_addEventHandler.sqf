_unit = param [0, objNull];
if(isNull _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
private _hasInit = _unit getVariable ["D37AT_hasInit", false];
if(_hasInit) exitWith {};

_unit addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if(_ammo in (missionNamespace getVariable "D37AT_weaponsArr")) then {
		//Speed, override speed only for missiles with presets
		_speedArr = getArray (configOf _projectile >> "D37AT_speedArray");
		if(!isNil "_speedArr") then {
			if(count _speedArr > 0) then {
				[_projectile, _speedArr] spawn D37AT_fnc_handleSpeed;
			};
		};
		
		//Adds the main control action
		_projectile setVariable ["D37_launchTime", time];
        _id = _unit addAction ["Missile FOV", {
			params ["_target", "_caller", "_actionId", "_arguments"];
			_unit = _arguments # 0;
			_projectile = _arguments # 1;

			[_projectile] spawn D37AT_fnc_handleMissile;
		}, [_unit, _projectile], 10, true, false, "(alive _target)","", 1, false];

		//Clean the action if the proj dies
		[_projectile, _id, _unit] spawn {
			_projectile = _this #0;
			_actionId = _this # 1;
			_unit 	= _this # 2;

			waitUntil {!alive _projectile};
			_unit removeAction _actionId;
		};
    };
}];

_unit setVariable ["D37AT_hasInit", true];
true;