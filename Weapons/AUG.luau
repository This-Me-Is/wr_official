local partitions = require("./partitions")

local AUG = {}

print("AUG Module Loading...")

local AUGSoldierWeaponBlueprint = {
	partitionGuid = Guid("3B13249B-36AD-4600-98B1-7D7585A8F64D"),
	instanceGuid = Guid("768D3BC0-04CF-408B-9E13-AF1BBCEAAAF4")
}

function AUG:OnSoldierWeaponBlueprintLoad(p_SoldierWeaponBlueprint: SoldierWeaponBlueprint)
    local s_SoldierWeaponData = p_SoldierWeaponBlueprint.object
  	local s_WeaponFiring = s_SoldierWeaponData.weaponFiring
	s_WeaponFiring.altDeployTime = 0.0
	s_WeaponFiring.deployTime = 0.0

  	local s_PrimaryFire = s_WeaponFiring.primaryFire
	local s_FireLogic = s_PrimaryFire.fireLogic
	s_FireLogic.clientFireRateMultiplier = 2.0
	s_FireLogic.rateOfFireForBurst = 1200.0
	s_FireLogic.reloadTimeBulletsLeft = 1.2
	s_FireLogic.rateOfFire = 1200.0
	s_FireLogic.reloadTime = 1.5
	s_FireLogic.reloadThreshold = 0.0
	local s_Ammo = s_PrimaryFire.ammo
	s_Ammo.magazineCapacity = 101
	s_Ammo.numberOfMagazines = 5
	s_Ammo.traceFrequency = 1
	s_Ammo.autoReplenishDelay = 2.0
	print("----> AUG Module Loaded")
end

partitions.onInstanceLoad(
    AUGSoldierWeaponBlueprint.partitionGuid,
    AUGSoldierWeaponBlueprint.instanceGuid,
    AUG,
    AUG.OnSoldierWeaponBlueprintLoad
)

return nil