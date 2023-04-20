#include "BIS_AddonInfo.hpp"
//#include "defines.hpp"
#include "controls.hpp"

class cfgPatches 
{
    class D37_AT
    {
        units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F", "A3_Weapons_F_beta"};
        author = "Dankan37";
    };
};

class cfgFunctions {
	class D37AT {
		file = "D37_guideAT\functions";
		class scripts {
            class handleSpeed {};
            class findTarget {};
            class handleGuidance {};
            class handleMissile {};
            class manouverTime {};
            class handleEffects {};
            class handleMouse {};
            class centerCursor {};
            class handleText {};
            class addEventHandler {};
            class postInit {postInit = 1;};
            class addMissile {};
		};
	};
};

class cfgAmmo {
    class M_Titan_AT;
    class M_Titan_MIL_AT:M_Titan_AT {
        indirectHit = 35;
        indirectHitRange = 5;
        manualControl = 0;
        timeToLive =  180;

        flightProfiles[] = {"TopDown"};
        submunitionAmmo = "ammo_Penetrator_Titan_AT_improved";
        submunitionInitSpeed = 1200;
    };

    class M_Titan_AP;
    class M_Titan_MIL_AP: M_Titan_AP {
        indirectHit = 45;
        indirectHitRange = 12;
        manualControl = 0;
        timeToLive = 180;

        flightProfiles[] = {"TopDown"};
    };

    class ammo_Penetrator_Titan_AT_long;
    class ammo_Penetrator_Titan_AT_improved: ammo_Penetrator_Titan_AT_long {
        simulationStep = 0.01;
        timeToLive = 1;
    };
};

class cfgMagazines {
    class Titan_AT;
    class Titan_MIL_AT: Titan_AT {
        displayname = "Titan AT (Seeker)";
        ammo = "M_Titan_MIL_AT";
        mass = 110;
        author = "Dankan37";
    };
    class Titan_AP;
    class Titan_MIL_AP: Titan_AP {
        displayname = "Titan AP (Seeker)";
        ammo = "M_Titan_MIL_AT";
        mass = 70;
        author = "Dankan37";
    };
};

class cfgWeapons {
    class launch_Titan_base;
    class launch_Titan_short_base: launch_Titan_base {
        magazines[] += {"Titan_MIL_AP","Titan_MIL_AT"};
    };
};

class CfgWrapperUI
{
	class Cursors
	{
		class Move;
		class BlankCursor: Move
		{
			texture="D37_guideAT\pictures\blank_ca.paa";
		};
	};
};