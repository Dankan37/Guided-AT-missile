_unit = param [0, objNull];
if(isNull _unit) exitWith {};

_unit addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if(_ammo in (missionNamespace getVariable "D37AT_weaponsArr")) then {
        _id = _unit addAction ["Missile FOV", {
			params ["_target", "_caller", "_actionId", "_arguments"];
			_unit = _arguments # 0;
			_projectile = _arguments # 1;

			[_projectile] spawn D37AT_fnc_handleMissile;
		}, [_unit, _projectile], 10, true, false, "(alive _target)","", 1, false];

		[_projectile, _id, _unit] spawn {
			_projectile = _this #0;
			_actionId = _this # 1;
			_unit 	= _this # 2;

			waitUntil {!alive _projectile};
			_unit removeAction _actionId;
		};
    };
}];