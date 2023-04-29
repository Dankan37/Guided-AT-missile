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
            //class postInit {postInit = 1;};
            class addMissile {};
            class camCreate {};
            class dialogEventHandlers {};
            class initMissile {};
            class cleanEffectsCam {};
		};
	};
};

class cfgAmmo {
    class M_Titan_AT;
    class M_Titan_MIL_AT:M_Titan_AT {
        indirectHit = 35;
        indirectHitRange = 4;
        manualControl = 0;
        timeToLive =  180;
        flightProfiles[] = {"TopDown"};
        submunitionAmmo = "ammo_Penetrator_Titan_AT_improved";
        submunitionInitSpeed = 1250;
        D37AT_speedArray[] = {75, 43, 7, 60, 1};

        class EventHandlers {
            class D37_AT {
                fired = "[_this #0, _this # 6] call D37AT_fnc_initMissile;";
            };
        };
    };

    class M_Titan_MIL_AP: M_Titan_AT {
        indirectHit = 50;
        indirectHitRange = 12;
        manualControl = 0;
        timeToLive = 180;
        flightProfiles[] = {"TopDown"};
        D37AT_speedArray[] = {77, 45, 7, 60, 1};
        missileManualControlCone = 0;
        model = "\A3\Weapons_F_beta\Launchers\titan\titan_missile_ap_fly";
        submunitionAmmo = "";

        class EventHandlers {
            class D37_AT {
                fired = "[_this #0, _this # 6] call D37AT_fnc_initMissile;";
            };
        };
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

        class EventHandlers {
            class D37_AT {
                fired = "[_this #0, _this # 6] call D37AT_fnc_initMissile;";
            };
        };
    };

    class ammo_Penetrator_Titan_AT_long;
    class ammo_Penetrator_Titan_AT_improved: ammo_Penetrator_Titan_AT_long {
        simulationStep = 0.002;
        timeToLive = 0.25;
    };

    //hardpoints[] = {"RHS_HP_HELLFIRE_RACK","RHS_HP_FFAR_USMC"};
    class M_Scalpel_AT;
    class M_Scalpel_MIL_AT: M_Scalpel_AT {
        indirectHit = 40;
        indirectHitRange = 9;
        manualControl = 1;
        maxControlRange = 300;
        missileManualControlCone = 180;
        timeToLive = 180;
        thrustTime = 0.6;
        D37AT_speedArray[] = {180, 120, 9, 77, 1.2};
        submunitionAmmo = "ammo_Penetrator_Titan_AT_improved";
        submunitionInitSpeed = 1250;

        class EventHandlers {
            class D37_AT {
                fired = "[_this #0, _this # 6] call D37AT_fnc_initMissile;";
            };
        };
    };
};

class cfgMagazines {
    class Titan_AT;
    class Titan_MIL_AT: Titan_AT {
        displayname = "Titan AT (Seeker)";
        ammo = "M_Titan_MIL_AT";
        mass = 100;
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

    //hardpoints[] = {"RHS_HP_HELLFIRE_RACK","RHS_HP_LONGBOW_RACK","RHS_HP_MELB"};
    class PylonRack_4Rnd_LG_scalpel;
    class PylonRack_4Rnd_MIL_scalpel: PylonRack_4Rnd_LG_scalpel {
        displayName = "Scalpel 4x (SEEKER)";
        ammo = "M_Scalpel_MIL_AT";
        hardpoints[] += {"RHS_HP_HELLFIRE_RACK","RHS_HP_LONGBOW_RACK", "RHS_HP_APU6_9m127_KA52", "RHS_HP_9m120_Mi28","RHS_HP_MELB"};
    };

    class PylonRack_3Rnd_LG_scalpel;
    class PylonRack_3Rnd_MIL_scalpel: PylonRack_3Rnd_LG_scalpel {
        displayName = "Scalpel 3x (SEEKER)";
        ammo = "M_Scalpel_MIL_AT";
        hardpoints[] += {"RHS_HP_HELLFIRE_RACK","RHS_HP_LONGBOW_RACK", "RHS_HP_APU6_9m127_KA52", "RHS_HP_9m120_Mi28","RHS_HP_MELB"};
    };

    class PylonRack_1Rnd_LG_scalpel; 
    class PylonRack_1Rnd_MIL_scalpel: PylonRack_1Rnd_LG_scalpel {
        displayName = "Scalpel (SEEKER)";
        ammo = "M_Scalpel_MIL_AT";
    };

    class PylonMissile_1Rnd_LG_scalpel;
    class PylonMissile_1Rnd_MIL_scalpel: PylonMissile_1Rnd_LG_scalpel {
        displayName = "Scalpel (SEEKER)";
        ammo = "M_Scalpel_MIL_AT";
        hardpoints[] += {"RHS_HP_HELLFIRE_PLANE","RHS_HP_LONGBOW_PLANE","RHS_HP_MELB"};
    };
};

class cfgWeapons {
    class launch_Titan_base;
    class launch_Titan_short_base: launch_Titan_base {
        magazines[] += {"Titan_MIL_AP","Titan_MIL_AT","TITAN_MIL_KE"};
    };

    //hardpoints[] = {"RHS_HP_APU6_9m127_KA52"};
    class RocketPods;
    class missiles_SCALPEL: RocketPods {
        magazines[] += {"PylonRack_4Rnd_MIL_scalpel","PylonRack_1Rnd_MIL_scalpel", "PylonRack_3Rnd_MIL_scalpel", "PylonMissile_1Rnd_MIL_scalpel"};
        hardpoints[] += {"RHS_HP_HELLFIRE_RACK","RHS_HP_LONGBOW_RACK", "RHS_HP_APU6_9m127_KA52", "RHS_HP_9m120_Mi28","RHS_HP_MELB"};
        class EventHandlers {
            class D37_AT {
                //fired = "systemchat ('Fired VEH' + str(_this));";
            }
        }
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