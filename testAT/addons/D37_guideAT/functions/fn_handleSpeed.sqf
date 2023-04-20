params ["_projectile", "_maxSpeed", "_minSpeed", "_maxTime", "_graceTime"];

_graceTime = _graceTime + _maxTime;
private _deltaSpeed = _maxSpeed - _minSpeed;
private _time = time;
private _n = 0;
private _t = (time - _time);
while {alive _projectile} do {
	_t = (time - _time);
	//Boost
	if(_t < 1) then {
		_projectile setVelocityModelSpace [0,_maxSpeed,0];
	};
	//Starts slowing down
	if(_t > 1 and _t < _maxTime) then {
		_n = _deltaSpeed * (((_maxTime - _t) / _maxTime) max 0) + _minSpeed;
		_projectile setVelocityModelSpace [0,_n,0];
	};
	//Hold min speed 
	if(_t > _maxTime and _t < _graceTime) then {
		_projectile setVelocityModelSpace [0,_minSpeed,0];
	};
	if(_t > _graceTime) exitWith {};
	
	sleep 0.04;
};
