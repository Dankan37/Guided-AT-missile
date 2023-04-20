params["_projectile", "_v"];

//Easy snap to targets near where you clicked
//_objs = lineIntersectsObjs [positionCameraToWorld [0,0,0], _posProj vectorAdd (_vDirTgt vectorMultiply 200), _projectile, objNull, true, 2 + 16 + 32];
private _currentTarget = objNull;
private _cameraPosASL = AGLTOASL positionCameraToWorld [0,0,0];
private _intersections = lineIntersectsSurfaces [_cameraPosASL, _cameraPosASL vectorAdd (_v vectorMultiply 200), _projectile, objNull, true, 1];
if(count _intersections > 0) then {
	_currentTarget = (_intersections # 0 # 2);
	//No object
	if(isNull _currentTarget) then {
		_currentTarget = nearestObject [(_intersections # 0 # 0), "LandVehicle"];	
		//No aimbot pls
		if(_currentTarget distance2d (_intersections # 0 # 0) > 8) then {
			_currentTarget = objNull;
		};
	};
	if(_currentTarget isKindOf "Building" or _currentTarget isKindOf "Tree") then {
		_currentTarget = objNull;
	};
};

_currentTarget;