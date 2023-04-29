
private _ppGrain  = ppEffectCreate ["FilmGrain", 1500]; 
_ppGrain ppEffectAdjust [0.5,1.25, 3.2, 0.65, 1, false]; 
   
private _ppcolor = ppEffectCreate ["colorCorrections", 1501]; 
_ppcolor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]]; 

private _ppcolor2 = ppEffectCreate ["colorCorrections", 1502]; 
_ppcolor2 ppEffectAdjust [1,1,0,[0,0,0.23,0.15],[0.26,0.26,0.3,0.25],[0.299, 0.587, 0.114, 0]]; 

private _effects = [_ppGrain, _ppcolor, _ppcolor2];
{
	_x ppEffectCommit 0;
	_x ppEffectEnable true;
}forEach _effects;

uiNamespace setVariable ["D37_effectsArr",  _effects];