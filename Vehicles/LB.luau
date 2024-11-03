--!strict
local partitions = require("./partitions")

local LB = {}

print("Hello World!")

local LBBlueprint = {
  partitionGuid = Guid("FD8AB747-FF4D-11DD-A7B1-F7C6DEEC9D32"),
  instanceGuid = Guid("FD8AB748-FF4D-11DD-A7B1-F7C6DEEC9D32")
}

function LB:OnVehicleBlueprintLoad(p_VehicleBlueprint: VehicleBlueprint)
    print("***** Found LB Blueprint!!!")
	local s_VehicleEntityData = p_VehicleBlueprint.object :: VehicleEntityData
	s_VehicleEntityData.upsideDownDamage = 0.0
	s_VehicleEntityData.waterDamage = 35.0
	s_VehicleEntityData.regenerationDelay = 5.0
	s_VehicleEntityData.regenerationRate = 15.0

	local s_PhysicsEntityData = s_VehicleEntityData.physicsData :: PhysicsEntityData
	s_PhysicsEntityData.angularVelocityDamping = 0.0

    local s_PitchPropellerEngineConfigData = ((((s_VehicleEntityData.components :: DataContainer)[1] :: ChassisComponentData).components :: DataContainer)[21] :: EngineComponentData).config :: PropellerEngineConfigData
    print("***** Found PitchPropellerEngineConfigData!!!")
    s_PitchPropellerEngineConfigData.pitchStrength = 100.0
    s_PitchPropellerEngineConfigData.pitchLimit = 3.0

	local s_RotorParameters = s_PitchPropellerEngineConfigData.rotorConfig :: RotorParameters
    s_RotorParameters.collectiveThrottleInputScale = 5.0
	s_RotorParameters.collectiveBrakeInputScale = 3.5
	s_RotorParameters.cyclicInputScalePitch = 2.0
	s_RotorParameters.cyclicInputScaleRoll = 0.5

    local s_PitchBoost = s_PitchPropellerEngineConfigData.boost :: Boost
    s_PitchPropellerEngineConfigData.rpmMax = 0.0

    local s_YawPropellerEngineConfigData = ((((s_VehicleEntityData.components :: DataContainer)[1] :: ChassisComponentData).components :: DataContainer)[20] :: EngineComponentData).config :: PropellerEngineConfigData
    print("***** Found YawPropellerEngineConfigData!!!")

    local s_YawBoost = s_YawPropellerEngineConfigData.boost :: Boost
	s_YawPropellerEngineConfigData.collectiveThrottleInputScale = 5.0
    s_YawPropellerEngineConfigData.collectiveBrakeInputScale = 3.5
    s_YawPropellerEngineConfigData.enginePowerMultiplier = 2.0
    s_YawPropellerEngineConfigData.internalDeaccelerationFactor = 1.0
    s_YawPropellerEngineConfigData.internalAccelerationFactor = 1.0
    s_YawPropellerEngineConfigData.rpmMax = 30000.0
	s_YawPropellerEngineConfigData.rpmCut = 29999.0

end

partitions.onInstanceLoad(
    LBBlueprint.partitionGuid,
    LBBlueprint.instanceGuid,
    LB,
    LB.OnVehicleBlueprintLoad
)

return nil