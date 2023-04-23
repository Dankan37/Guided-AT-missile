#include "BIS_AddonInfo.hpp"
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
            class camCreate {};
            class dialogEventHandlers {};
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
        submunitionInitSpeed = 1250;
        D37AT_speedArray[] = {95, 56, 9, 55, 1};
    };

    class M_Titan_MIL_AP: M_Titan_AT {
        indirectHit = 45;
        indirectHitRange = 12;
        manualControl = 0;
        timeToLive = 180;
        flightProfiles[] = {"TopDown"};
        D37AT_speedArray[] = {95, 60, 9, 55, 1};
        missileManualControlCone = 0;
        model = "\A3\Weapons_F_beta\Launchers\titan\titan_missile_ap_fly";
        submunitionAmmo = "";
    };

    class M_Titan_MIL_KE: M_Titan_AT {
        explosive = 0;
        indirectHit = 5;
        indirectHitRange = 0.5;
        manualControl = 0;
        caliber = 4;
        hit = 30;
        //deflecting = 15;
        timeToLive = 180;
        flightProfiles[] = {"TopDown"};
        D37AT_speedArray[] = {95, 88, 9, 77, 1};
        submunitionAmmo = "";
    };

    class ammo_Penetrator_Titan_AT_long;
    class ammo_Penetrator_Titan_AT_improved: ammo_Penetrator_Titan_AT_long {
        simulationStep = 0.002;
        timeToLive = 0.25;
    };

    /*
    class M_Scalpel_AT;
    class M_Scalpel_MIL_AT: M_Scalpel_AT {
        manualControl = 0;
        maxControlRange = 100;
        timeToLive = 120;

        class EventHandlers {
            class D37_AT {
                fired = "systemchat ('Fired' + str(_this));";
                init = "systemchat ('init' + str(_this));";
            }
        }
    };
    */
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
        ammo = "M_Titan_MIL_AP";
        mass = 70;
        author = "Dankan37";
    };
    class TITAN_MIL_KE: Titan_MIL_AP {
        displayname = "Titan KE (Seeker)";
        descriptionShort = "Type: Kinetic <br />Rounds: 1<br />Used in: Titan MPRL Compact";
        displayNameShort = "KE";
        ammo = "M_Titan_MIL_KE";
        mass = 25;
        author = "Dankan37";
    };

    /*
    class PylonRack_4Rnd_LG_scalpel;
    class PylonRack_4Rnd_MIL_scalpel: PylonRack_4Rnd_LG_scalpel {
        displayName = "Scalpel (SEEKER)";
        ammo = "M_Scalpel_MIL_AT";
    };

    class PylonRack_1Rnd_LG_scalpel;
    class PylonRack_1Rnd_MIL_scalpel: PylonRack_1Rnd_LG_scalpel {
        displayName = "Scalpel (SEEKER)";
        ammo = "M_Scalpel_MIL_AT";
    };
    */
};

class cfgWeapons {
    class launch_Titan_base;
    class launch_Titan_short_base: launch_Titan_base {
        magazines[] += {"Titan_MIL_AP","Titan_MIL_AT","TITAN_MIL_KE"};
    };
};

class CfgWrapperUI {
	class Cursors
	{
		class Move;
		class BlankCursor: Move
		{
			texture="D37_guideAT\pictures\blank_ca.paa";
		};
	};
};