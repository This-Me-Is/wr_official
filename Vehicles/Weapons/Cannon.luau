local function cannon(partitionGuid,instanceGuid,rounds,mags,fireRate,speed)

	local partitions = require("./partitions")

	local Cannon = {}

	print("Cannon Module Loading...")

	function Cannon:OnWeaponFiringDataAssetLoad(p_WeaponFiringDataAsset: WeaponFiringDataAsset)
	    print("----> Cannon Module Loaded")
	    local s_Data = p_WeaponFiringDataAsset.data
		s_Data.altDeployTime = 0.0
		s_Data.deployTime = 0.0
	    local s_PrimaryFire = s_Data.primaryFire
	    local s_Shot = s_PrimaryFire.shot
	    s_Shot.numberOfBulletsPerShell = 1
	    s_Shot.numberOfBulletsPerShot = 1
	    local s_ProjectileData = s_Shot.projectileData
	    s_ProjectileData.initialSpeed = speed
	    s_ProjectileData.timeToLive = 0.0
		local s_FireLogic = s_PrimaryFire.fireLogic
		--s_FireLogic.rateOfFireForBursts = fireRate
		s_FireLogic.rateOfFire = fireRate
		s_FireLogic.reloadTime = 1.5
		local s_Recoil = s_FireLogic.recoil
		s_Recoil.maxRecoilAngleX = 0.0
		s_Recoil.minRecoilAngleX = 0.0
		s_Recoil.maxRecoilAngleY = 0.0
		s_Recoil.minRecoilAngleY = 0.0
		s_Recoil.maxRecoilAngleZ = 0.0
		s_Recoil.minRecoilAngleZ = 0.0
	    local s_Ammo = s_PrimaryFire.ammo
		s_Ammo.autoReplenishDelay = 8.0;
	    s_Ammo.magazineCapacity = rounds
	    s_Ammo.numberOfMagazines = mags
		s_Ammo.traceFrequency = 1

	end

	partitions.onInstanceLoad(
	    Guid(partitionGuid),
	    Guid(instanceGuid),
	    Cannon,
	    Cannon.OnWeaponFiringDataAssetLoad
	)

	return nil

end

local function limited20(partitionGuid,instanceGuid)
	return cannon(partitionGuid,instanceGuid,200,3,2000,1500)

end

local function limited25(partitionGuid,instanceGuid)
	return cannon(partitionGuid,instanceGuid,150,3,1500,1000)

end

local function limited30(partitionGuid,instanceGuid)
	return cannon(partitionGuid,instanceGuid,100,2,1000,750)

end

return {
	limited20 = limited20,
	limited25 = limited25,
	limited30 = limited30,
}