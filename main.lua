ESX = nil

local cruiser

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(350) 
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped, false)
		local sleep = true
		Citizen.Wait(100)
		if veh then
			sleep = false
			local speed = GetEntitySpeed(veh)*3.6 -- Value in KM/H
			local gear = GetVehicleCurrentGear(veh)
			SendNUIMessage({
				isInCoche = veh;
				speed = speed;
				vidatexto = ESX.Math.Round(GetVehicleEngineHealth(veh) / 10),
				fueltexto = ESX.Math.Round(GetVehicleFuelLevel(veh)),
			})
		else
			SendNUIMessage({
				isInCoche = veh;
			})
		end
		if sleep then Citizen.Wait(1200) end
	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(450)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehicleClass = GetVehicleClass(vehicle)

		-- Vehicle Cruiser
		if IsPedInAnyVehicle(player, false) and GetIsVehicleEngineRunning(vehicle) and IsControlJustPressed(1, 243) and GetPedInVehicleSeat(vehicle, player) then
			
			local vehicleSpeedSource = GetEntitySpeed(vehicle)

			if vehicleCruiser == 'on' then
				vehicleCruiser = 'off'
				SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
				
			else
				vehicleCruiser = 'on'
				SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
			end
        end

	end
end)
