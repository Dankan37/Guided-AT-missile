#include "..\includes.hpp"

params ["_dialog", "_projectile"];

private _txElev = _dialog displayCtrl tx_elev;
private _txFlir = _dialog displayCtrl tx_camera;
private _txAzim = _dialog displayCtrl tx_azimuth;
private _txDate = _dialog displayCtrl tx_time;
private _txLock = _dialog displayCtrl tx_lock;
private _txTime = _dialog displayCtrl tx_eta;

_txElev ctrlSetFontHeight 0.07;
_txFlir ctrlSetFontHeight 0.07;
_txAzim ctrlSetFontHeight 0.07;
_txDate ctrlSetFontHeight 0.05;
_txLock ctrlSetFontHeight 0.05;

//Date
date params ["_year", "_month", "_day", "_hours", "_minutes"];
_timeMessage = str _day + "/" + str _month + str _year + " - " + str _hours + ":" + str _minutes;
_txDate ctrlSetText _timeMessage;

private _timeNow = time;
private _t = 0;
while {alive _projectile and dialog} do {
	private _thermal 	= uiNamespace getVariable ["_thermalState", true];
	private _lock 		= uiNamespace getVariable ["_autoLockState", true];
	private _zoom 		= uiNamespace getVariable ["_zoomStatus", false];
	private _locked 	= uiNamespace getVariable ["_itemLock", false];

	//There has to be a better way
	_thermalMessage = "CCD";
	if(!_thermal) then {
		_thermalMessage = "WHOT";
	};
	_zoomMessage = "";
	if(_zoom) then {
		_zoomMessage = "Z1";
	};
	_lockMessage = "Lock: OFF";
	if(_locked) then {
		_lockMessage = "Lock: ON";
	};
	if(!_lock) then {
		_lockMessage = "OVRD";
	};

	_t = round(time - _timeNow);
	_txTime ctrlSetText str _t;
	_txLock ctrlSetText _lockMessage;
	_txAzim ctrlSetText str round (direction _projectile);
	_txElev ctrlSetText _zoomMessage;
	_txFlir ctrlSetText _thermalMessage;

	sleep 0.25;
};