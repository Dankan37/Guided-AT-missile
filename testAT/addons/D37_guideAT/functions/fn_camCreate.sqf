params ["_projectile", "_offset"];

private _tcamera = "camera" camCreate getPosASL _projectile;
showCinemaBorder false;
cameraEffectEnableHUD true;
_tcamera cameraEffect ["External", "BACK"];
_tcamera camSetTarget _projectile;
_tcamera camSetRelPos [0,0,0];
_tcamera camCommit 0;
_tcamera attachTo [_projectile, [0, _offset, 0]];
_tcamera camSetFov 0.55;
_tcamera camCommit 0;

_tcamera;