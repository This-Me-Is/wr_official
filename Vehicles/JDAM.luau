--!strict
local partitions = require("./partitions")

local JDAM = {}

print("Hello World!")

local JDAMProjectileBlueprint = {
  partitionGuid = Guid("575E8F27-30DC-4A9C-81FC-A8C3634B8A30"),
  instanceGuid = Guid("2EE31CD7-5494-4169-8715-27721D3EEAA9")
}

function JDAM:OnVehicleBlueprintLoad(p_ProjectileBlueprint: ProjectileBlueprint)
    print("* Found JDAM2 Blueprint!!!") 
    local s_MissileEntityData = p_ProjectileBlueprint.object :: MissileEntityData
    local s_VeniceExplosionEntityData = s_MissileEntityData.explosion
    s_MissileEntityData.initialSpeed = 5000
    s_VeniceExplosionEntityData.blastRadius = 500
    s_VeniceExplosionEntityData.blastImpulse = 500
    s_VeniceExplosionEntityData.shockwaveRadius = 500
    s_VeniceExplosionEntityData.blastDamage = 200000
end

partitions.onInstanceLoad(
    JDAMProjectileBlueprint.partitionGuid,
    JDAMProjectileBlueprint.instanceGuid,
    JDAM,
    JDAM.OnVehicleBlueprintLoad
)

return nil