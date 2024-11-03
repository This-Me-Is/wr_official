local function config(partitionGuid,instanceGuid)

	local partitions = require("./partitions")

	local TOW = {}

	print("TOW Module Loading...")

	function TOW:OnWeaponFiringDataAssetLoad(p_WeaponFiringDataAsset: WeaponFiringDataAsset)
	    print("----> TOW Module Loaded")
	    local s_Data = p_WeaponFiringDataAsset.data
		s_Data.altDeployTime = 0.0
		s_Data.deployTime = 0.0
	    local s_PrimaryFire = s_Data.primaryFire
	    local s_Shot = s_PrimaryFire.shot
	    s_Shot.numberOfBulletsPerShell = 1
	    s_Shot.numberOfBulletsPerShot = 1
	    local s_ProjectileData = s_Shot.projectileData
	    s_ProjectileData.initialSpeed = 500.0
		s_ProjectileData.maxSpeed = 500.0
	    s_ProjectileData.timeToLive = 0.0
		local s_FireLogic = s_PrimaryFire.fireLogic
		s_FireLogic.clientFireRateMultiplier = 2.0
		s_FireLogic.rateOfFireForBurst = 600.0
		s_FireLogic.rateOfFire = 600.0
		s_FireLogic.reloadTime = 1.5
	    local s_Ammo = s_PrimaryFire.ammo
		s_Ammo.autoReplenishDelay = 8.0;
	    s_Ammo.magazineCapacity = 8
	    s_Ammo.numberOfMagazines = 4
		s_Ammo.traceFrequency = 1
	end

	partitions.onInstanceLoad(
	    Guid(partitionGuid),
	    Guid(instanceGuid),
	    TOW,
	    TOW.OnWeaponFiringDataAssetLoad
	)
	return nil
end

return {
	config = config
}