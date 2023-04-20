#include "..\includes.hpp"
params["_projectile"];

private _camera = "camera" camCreate getPosASL _projectile;
_camera cameraEffect ["External", "BACK"];
showCinemaBorder false;
cameraEffectEnableHUD true;
_camera camSetTarget _projectile;
_camera camSetRelPos [0,0,0];
_camera camCommit 0;
_camera attachTo [_projectile, [0, 1, 0]];
_camera camSetFov 0.55;
_camera camCommit 0;

//Create dialog
_diag = createDialog ["D37_seeker", false];

//Detect clicks
uiNamespace setVariable ["mouseClick", false];
private _ehId = findDisplay 3737 displayAddEventHandler ["MouseButtonDown","uiNamespace setVariable ['mouseClick', true];"];

//Change FOV / thermals / autolock
uiNamespace setVariable ["isSlewing", false];
uiNamespace setVariable ["_mainCamera", _camera];
uiNamespace setVariable ["_thermalState", true];
uiNamespace setVariable ["_autoLockState", true];
uiNamespace setVariable ["_zoomStatus", false];
uiNamespace setVariable ["_itemLock", false];
private _cmdEH = _diag displayAddEventHandler ["KeyDown",  { 
	params ["_display", "_key"];

	switch (_key) do {
		//thermals
		case 49: {
			private _camera = uiNamespace getVariable ["_mainCamera", objNull];
			if(isNull _camera) exitWith {}; 

			private _state = uiNamespace getVariable ["_thermalState", true];
			_state setCamUseTI 0;
			uiNamespace setVariable ["_thermalState", !_state];
		};
		//autolock
		case 20: {
			private _camera = uiNamespace getVariable ["_mainCamera", objNull];
			if(isNull _camera) exitWith {}; 

			private _state = uiNamespace getVariable ["_autoLockState", true];
			uiNamespace setVariable ["_autoLockState", !_state];

			private _targetCursor = _display displayCtrl target_cursor;
			uiNamespace setVariable ["_itemLock", false];
			_targetCursor ctrlShow false;
		};
		//zoom
		case 19: {
			private _camera = uiNamespace getVariable ["_mainCamera", objNull];
			if(isNull _camera) exitWith {}; 

			private _state = uiNamespace getVariable ["_zoomStatus", false];
			uiNamespace setVariable ["_zoomStatus", !_state];

			private _crosshair = _display displayCtrl seeker_head;
			private _targetCursor = _display displayCtrl target_cursor;

			if(_state) then {
				_camera camSetFov 0.55;
				_crosshair ctrlSetPosition [0.5 - txtSize / 2, 0.5 - txtSize / 2, txtSize, txtSize];
				_crosshair ctrlCommit 0;

				_targetCursor ctrlSetPosition [0.5 - txtSize / 16, 0.5 - txtSize / 16, txtSize/16, txtSize/16];
				_targetCursor ctrlCommit 0;
			} else {
				private _t = txtSize * 1.5;
				_camera camSetFov 0.15;
				_crosshair ctrlSetPosition [0.5 -_t / 2, 0.5 - _t / 2, _t, _t];
				_crosshair ctrlCommit 0;

				_targetCursor ctrlSetPosition [0.5 - _t / 16, 0.5 - _t / 16, _t/16, _t/16];
				_targetCursor ctrlCommit 0;
			};
			_camera camCommit 0;
			[_display] call D37AT_fnc_handleMouse;
		};
		case 1: {
			closeDialog 1;
		};
	};
}];

//Missile stuff
//Main variables
private _target = objNull;
private _posProj = [];
private _posWorld = [];
private _v = [];
private _timeManouver = 0;
private _timeCheck = time;
private _targetEnabled = true;
private _crossTarget = [];
private _crtlSize = [];
private _wordToScreenPos = [];

//Effects
[] call D37AT_fnc_handleEffects;

//Speed
[_projectile, 133, 55, 9, 48] spawn D37AT_fnc_handleSpeed;

//Updates all the text values for the seeker
[_diag, _projectile] spawn D37AT_fnc_handleText;

//Target cursor box and crosshair
private _crosshair = _diag displayCtrl seeker_head;
private _targetCursor = _diag displayCtrl target_cursor;
_targetCursor ctrlShow false;

//Main loop
while {alive _projectile and dialog} do {
	if(time - _timeCheck > 0.2) then {
		_targetEnabled = uiNamespace getVariable ["_autoLockState", true];
		
		//Target cursor
		if(ctrlShown _targetCursor) then {
			_crtlSize = (ctrlPosition _targetCursor) # 3;
			_crossTarget = [];
			if(isNull _target) then {
				_wordToScreenPos = worldToScreen ASLTOAGL _posWorld;
				if(count _wordToScreenPos > 0) then {
					_crossTarget = _wordToScreenPos vectorDiff [_crtlSize/2, _crtlSize/2];
				};
			} else {
				_wordToScreenPos = worldToScreen ASLTOAGL getPosASL _target;
				if(count _wordToScreenPos > 0) then {
					_crossTarget = _wordToScreenPos vectorDiff [_crtlSize/2, _crtlSize/2];
				};
			};
			//Check if the cursor is outside the screen, in that case disable it
			if(count _crossTarget > 0) then {
				_crossTarget vectorAdd [random [-0.1, 0, 0.1], random [-0.15, 0, 0.15]];
				_crossTarget deleteAt 2;
				_targetCursor ctrlSetPosition _crossTarget;
				_targetCursor ctrlCommit 0;
			} else {
				_targetCursor ctrlShow false;
			};
			
			uiNamespace setVariable ["_itemLock", ctrlShown _targetCursor];
		};

		_timeCheck = time;
	};

	//Has clicked
	if(uiNamespace getVariable ["mouseClick", false]) then {
		uiNamespace setVariable ['mouseClick', false];
		_target = objNull;
		_projectile setMissileTarget objNull;

		//_posProj = getPosASL _projectile;	
		_posProj = AGLTOASL positionCameraToWorld [0,0,0];	
		_posWorld = AGLTOASL screenToWorld getMousePosition;
		_v = _posWorld vectorDiff _posProj; 

		if(_targetEnabled) then {
			_target = [_projectile, _v] call D37AT_fnc_findTarget;
			//More accurate
			if(!isNull _target) then {
				_v = (getPosASL _target) vectorDiff _posProj; 
			};
		};

		//Manouver time based on speed
		_angleFac = (1 - abs((vectorDir _projectile) vectorCos _v)); //high deviation means longer manouvers
		_timeManouver = [_projectile, 0.5 + _angleFac, 1] call D37AT_fnc_manouverTime;
	
		//Crosshair
		[_diag, _crosshair, _timeManouver, nil, true]  spawn D37AT_fnc_centerCursor;

		//Moves the missile
		[_projectile, _v, _timeManouver] spawn D37AT_fnc_handleGuidance;

		//Finally show the cursor
		_targetCursor ctrlShow _targetEnabled;
	} else {
		//If the missile has a target it will keep tracking it
		if(!isNull _target and _targetEnabled) then {
			_projectile setMissileTarget _target;
			_posProj = AGLTOASL positionCameraToWorld [0,0,0];	
			_v = (getPosASL _target vectorAdd [0,0,1]) vectorDiff _posProj; 

			//Makes cursor point the target
			_timeManouver = 0.3;
			_crtlSize = (ctrlPosition _crosshair) # 3;
			_wordToScreenPos = (worldToScreen ASLTOAGL getposASl _target);
			if(count _wordToScreenPos > 0) then {
				_crossTarget = _wordToScreenPos vectorDiff [_crtlSize/2, _crtlSize/2];
				_crossTarget vectorAdd [random [-0.2, 0, 0.2], random [-0.15, 0, 0.15]];
				[_diag, _crosshair, _timeManouver, _crossTarget]  spawn D37AT_fnc_centerCursor;
				[_projectile, _v, _timeManouver] spawn D37AT_fnc_handleGuidance;
				sleep _timeManouver;
			};
		};
	};

	sleep 0.03;
};

closeDialog 1;
false setCamUseTI 0;
_camera cameraEffect ["terminate","back"];
camDestroy _camera;

private _effects = (uiNamespace getVariable ["D37_effectsArr", []]);
if(count _effects > 0) then {
	{
		ppEffectDestroy _x;
	}forEach _effects;
};


		//_id = [str _projectile, "onEachFrame", { drawLine3D [_this # 0, _this # 1, [1,1,1,1]]}, [aslToAGL positionCameraToWorld [0,0,0], (aslToAGL _posProj) vectorAdd _v]] call BIS_fnc_addStackedEventHandler;
		