#include "..\includes.hpp"
params ["_display"];

if(uiNamespace getVariable ["isSlewing", false]) exitWith {};

getMousePosition params ["_x", "_y"];
_x = 0 max (1 min _x);

private _control = _display displayCtrl seeker_head;
private _startPos = ctrlPosition _control;

private _pos = [_x - _startPos#2 /2, _y - _startPos#3 /2];
_control ctrlSetPosition _pos;
_control ctrlCommit 0;