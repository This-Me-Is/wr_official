local function heli(partitionGuid,instanceGuid,pitch,roll,yaw,type)

	local partitions = require("./partitions")

	local HELI = {
		Viper = {9,10},
		Venom = {7,5},
		Havoc = {9,10},
		KA60 = {12,13},
		Z11 = {12,11},
		Z10 = {8,9},
		Z9 = {14,15},
		LB = {21,20},
	}

	local Heli = {}

	print("Heli Module Loading...")

	function Heli:OnVehicleBlueprintLoad(p_VehicleBlueprint: VehicleBlueprint)
	    print("----> Heli Module Loaded")
		local s_VehicleEntityData = p_VehicleBlueprint.object
		s_VehicleEntityData.highAltitudeLockHeight = 10000.0
		s_VehicleEntityData.upsideDownDamage = 0.0
		s_VehicleEntityData.waterDamage = 35.0
		s_VehicleEntityData.regenerationDelay = 5.0
		s_VehicleEntityData.regenerationRate = 20.0

		local s_PhysicsData = s_VehicleEntityData.physicsData
		s_PhysicsData.angularVelocityDamping = 0.0

		local s_ChassisComponents = s_VehicleEntityData.components[1].components

	    local s_PitchPropellerEngineConfigData = s_ChassisComponents[HELI[type][1]].config
	    print("***** Found PitchPropellerEngineConfigData!!!")
	    s_PitchPropellerEngineConfigData.pitchStrength = 20.0 * pitch
	    s_PitchPropellerEngineConfigData.pitchLimit = 0.5 * pitch
	    s_PitchPropellerEngineConfigData.rpmMax = 6000.0 * pitch
	    s_PitchPropellerEngineConfigData.rpmCut = 5999.0 * pitch

		local s_RotorConfig = s_PitchPropellerEngineConfigData.rotorConfig
	    s_RotorConfig.collectiveThrottleInputScale = 1.0 * pitch
		s_RotorConfig.collectiveBrakeInputScale = 0.7 * pitch
		s_RotorConfig.cyclicInputScalePitch = 1.5 * pitch
		s_RotorConfig.cyclicInputScaleRoll = 0.2 * roll

	    local s_YawPropellerEngineConfigData = s_ChassisComponents[HELI[type][2]].config
	    print("***** Found YawPropellerEngineConfigData!!!")

		s_YawPropellerEngineConfigData.collectiveThrottleInputScale = 1.0 * yaw
	    s_YawPropellerEngineConfigData.collectiveBrakeInputScale = 1.0 * yaw
	    s_YawPropellerEngineConfigData.enginePowerMultiplier = 1.0 * yaw
	    s_YawPropellerEngineConfigData.internalDeaccelerationFactor = 0.5 * yaw
	    s_YawPropellerEngineConfigData.internalAccelerationFactor = 0.5 * yaw
	    s_YawPropellerEngineConfigData.rpmMax = 10000.0 * yaw
		s_YawPropellerEngineConfigData.rpmCut = 9999.0 * yaw
	end
	partitions.onInstanceLoad(
	    Guid(partitionGuid),
	    Guid(instanceGuid),
	    Heli,
	    Heli.OnVehicleBlueprintLoad
	)
	return nil
end

local function scout(partitionGuid,instanceGuid,type) -- Scout
	return heli(partitionGuid,instanceGuid,2,3.5,1.5,type)
end

local function Z11(partitionGuid,instanceGuid)
	return scout(partitionGuid,instanceGuid,"Z11")
end

local function LB(partitionGuid,instanceGuid)
	return scout(partitionGuid,instanceGuid,"LB")
end

local function attack(partitionGuid,instanceGuid,type) -- Attack
	return heli(partitionGuid,instanceGuid,2,2.5,1.2,type)
end

local function Z10(partitionGuid,instanceGuid)
	return attack(partitionGuid,instanceGuid,"Z10")
end

local function Havoc(partitionGuid,instanceGuid)
	return attack(partitionGuid,instanceGuid,"Havoc")
end

local function Viper(partitionGuid,instanceGuid)
	return attack(partitionGuid,instanceGuid,"Viper")
end

local function transport(partitionGuid,instanceGuid,type) -- Transport
	return heli(partitionGuid,instanceGuid,2,2,1.2,type)
end

local function Z9(partitionGuid,instanceGuid)
	return transport(partitionGuid,instanceGuid,"Z9")
end

local function KA60(partitionGuid,instanceGuid)
	return transport(partitionGuid,instanceGuid,"KA60")
end

local function Venom(partitionGuid,instanceGuid)
	return transport(partitionGuid,instanceGuid,"Venom")
end

return {
	LB = LB,
	Z9 = Z9,
	Z10 = Z10,
	Z11 = Z11,
	KA60 = KA60,
	Havoc = Havoc,
	Venom = Venom,
	Viper = Viper
}