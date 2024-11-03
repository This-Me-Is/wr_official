local partitions = require("./partitions")
local TV = {}
print("Hello World!")
local TVBlueprint = {
	partitionGuid = Guid("B0ABD608-1E4E-4F82-9742-BED2CEC60940"),
	instanceGuid = Guid("5AB2A0BF-556D-409D-B10F-F8C66FED4B07")
}
function TV:OnWeaponFiringDataAssetLoad(p_WeaponFiringDataAsset: WeaponFiringDataAsset)
    print("***** Found TV Blueprint!!!")
    local s_WeaponFiringData = p_WeaponFiringDataAsset.data :: WeaponFiringData
    local s_FiringFunctionData = s_WeaponFiringData.primaryFire
    local s_Ammo = s_FiringFunctionData.ammo
    local s_Shot = s_FiringFunctionData.shot
    s_WeaponFiringData.deployTime = 0
	s_FiringFunctionData.fireLogic.reloadTime = 2
	s_Ammo.autoReplenishDelay = 8
    s_Ammo.magazineCapacity = 4
    s_Ammo.numberOfMagazines = 4
end
partitions.onInstanceLoad(
    TVBlueprint.partitionGuid,
    TVBlueprint.instanceGuid,
    TV,
    TV.OnWeaponFiringDataAssetLoad
)

return nil