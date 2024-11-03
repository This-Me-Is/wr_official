local partitions = require("./partitions")
local AUG = {}
print("Hello World!")
local AUGSoldierWeaponBlueprint = {
	partitionGuid = Guid("3B13249B-36AD-4600-98B1-7D7585A8F64D"),
	instanceGuid = Guid("768D3BC0-04CF-408B-9E13-AF1BBCEAAAF4")
}
function AUG:OnSoldierWeaponBlueprintLoad(p_SoldierWeaponBlueprint: SoldierWeaponBlueprint)
    print("***** Found AUG Blueprint!!!")
    local s_SoldierWeaponData = p_SoldierWeaponBlueprint.object :: SoldierWeaponData
  	local s_WeaponFiringData = s_SoldierWeaponData.weaponFiring :: WeaponFiringData
  	local s_FiringFunctionData = s_WeaponFiringData.primaryFire :: FiringFunctionData
	local s_FireLogicData = s_FiringFunctionData.fireLogic :: FireLogicData
	s_FireLogicData.rateOfFireForBurst = 1200.0
	s_FireLogicData.rateOfFire = 1000.0
	s_FireLogicData.reloadTime = 2.1
	s_FireLogicData.reloadThreshold = 0.0
	local s_Shot = s_FiringFunctionData.shot
end
partitions.onInstanceLoad(
    AUGSoldierWeaponBlueprint.partitionGuid,
    AUGSoldierWeaponBlueprint.instanceGuid,
    AUG,
    AUG.OnSoldierWeaponBlueprintLoad
)

return nil