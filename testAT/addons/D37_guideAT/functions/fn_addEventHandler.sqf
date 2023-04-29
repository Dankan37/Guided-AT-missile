//Unused

_unit = param [0, objNull];
if(isNull _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
private _hasInit = _unit getVariable ["D37AT_hasInit", false];
if(_hasInit) exitWith {};

_unit addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if(_ammo in (missionNamespace getVariable "D37AT_weaponsArr")) then {
		[_unit, _projectile] call D37AT_fnc_initMissile;
    };
}];

_unit setVariable ["D37AT_hasInit", true];
true;