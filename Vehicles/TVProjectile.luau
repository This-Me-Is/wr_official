--!strict
local partitions = require("./partitions")

local TVProjectile = {}

print("Hello World!")

local TVProjectileBlueprint = {
	partitionGuid = Guid("1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3"),
	instanceGuid = Guid("0DD3BA2E-4434-371C-8383-0E11272D7F1C")
}

function TVProjectile:OnVehicleBlueprintLoad(p_VehicleBlueprint: VehicleBlueprint)
    print("***** Found TV Projectile Blueprint!!!")
    local s_VehicleEntityData = p_VehicleBlueprint.object :: VehicleEntityData
	local s_PhysicsEntityData = s_VehicleEntityData.physicsData :: PhysicsEntityData
	local s_InertiaModifier = s_PhysicsEntityData.inertiaModifier
	local s_Transform = s_VehicleEntityData.transform
	local s_Right = s_Transform.right
	local s_Up = s_Transform.up
	local s_Forward = s_Transform.forward
	local s_Trans = s_Transform.trans
	s_Right.x = 5.0
	s_Up.y = 5.0
	s_Forward.z = 5.0
	s_InertiaModifier.x = 0
	s_InertiaModifier.y = 0
	s_InertiaModifier.z = 0
	s_PhysicsEntityData.mass = 0.0
	s_PhysicsEntityData.friction = 0.0
	s_PhysicsEntityData.angularVelocityDamping = 0.0
	s_PhysicsEntityData.linearVelocityDamping = 0.0
end

partitions.onInstanceLoad(
    TVProjectileBlueprint.partitionGuid,
    TVProjectileBlueprint.instanceGuid,
    TVProjectile,
    TVProjectile.OnVehicleBlueprintLoad
)

return nil