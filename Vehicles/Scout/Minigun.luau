local partitions = require("./partitions")

local Minigun = {}

print("Hello World!")

local MinigunWeaponFiringDataAsset = {
  partitionGuid = Guid("BEF55B28-16D1-4824-3DE6-9BD42C5164F1"),
  instanceGuid = Guid("92A51D62-09A6-2519-34E1-F129707E49D1")
}

function Minigun:OnWeaponFiringDataAssetLoad(p_WeaponFiringDataAsset: WeaponFiringDataAsset)
    print("***** Scout 25mm Blueprint!!!")
    local s_WeaponFiringData = p_WeaponFiringDataAsset.data :: WeaponFiringData
    local s_FiringFunctionData = s_WeaponFiringData.primaryFire :: FiringFunctionData
	local s_FireLogicData = s_FiringFunctionData.fireLogic :: FireLogicData
	s_FireLogicData.reloadTime = 2.0
	local s_RecoilData = s_FireLogicData.recoil :: RecoilData
	s_RecoilData.maxRecoilAngleX = 0.0
	s_RecoilData.minRecoilAngleX = 0.0
	s_RecoilData.maxRecoilAngleY = 0.0
	s_RecoilData.minRecoilAngleY = 0.0
	s_RecoilData.maxRecoilAngleZ = 0.0
	s_RecoilData.minRecoilAngleZ = 0.0
    local s_Ammo = s_FiringFunctionData.ammo
    local s_Shot = s_FiringFunctionData.shot
    s_Ammo.magazineCapacity = 300
    s_Ammo.numberOfMagazines = 4
	s_Ammo.traceFrequency = 1
end

partitions.onInstanceLoad(
    MinigunWeaponFiringDataAsset.partitionGuid,
    MinigunWeaponFiringDataAsset.instanceGuid,
    Minigun,
    Minigun.OnWeaponFiringDataAssetLoad
)

return nil