--!strict
local partitions = require("./partitions")

local F35 = {}

print("Hello World!")

local F35Blueprint = {
  partitionGuid = Guid("EB06DA1E-4B21-11E0-AC22-92ED36F00269"),
  instanceGuid = Guid("3F18FCA6-A7D4-D3B5-28E5-44A5CAFFE6BE")
}

function F35:OnVehicleBlueprintLoad(p_VehicleBlueprint: VehicleBlueprint)
    print("***** Found F35 Blueprint!!!")
    local s_JetEngineConfigData = (((((p_VehicleBlueprint.object :: VehicleEntityData).components :: DataContainer)[1] :: ChassisComponentData).components :: DataContainer)[10] :: EngineComponentData).config :: JetEngineConfigData
    print("***** Set JetEngineConfigData!!!")
    local s_Boost = s_JetEngineConfigData.boost :: Boost
    s_Boost.forwardStrength = 30.0
    s_Boost.reverseStrength = 50.0
    s_Boost.accelerationScale = 5.0
    s_JetEngineConfigData.maxVelocity = 1000.0
    s_JetEngineConfigData.rpmMax = 1000.0

end

partitions.onInstanceLoad(
    F35Blueprint.partitionGuid,
    F35Blueprint.instanceGuid,
    F35,
    F35.OnVehicleBlueprintLoad
)

return nil