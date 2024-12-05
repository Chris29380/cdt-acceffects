local effectActive = false            -- Blur screen effect active
local blackOutActive = false          -- Blackout effect active
local currAccidentLevel = 0           -- Level of accident player has effect active of
local wasInCar = false
local oldBodyDamage = 0.0
local oldSpeed = 0.0
local currentDamage = 0.0
local currentSpeed = 0.0
local vehicle
local disableControls = false

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

RegisterNetEvent("crashEffect")
AddEventHandler("crashEffect", function(countDown, accidentLevel)

    if not effectActive or (accidentLevel > currAccidentLevel) then
        currAccidentLevel = accidentLevel
        disableControls = true
        effectActive = true
        blackOutActive = true
		DoScreenFadeOut(100)
		Wait(Options.BlackoutTime)
        DoScreenFadeIn(250)
        blackOutActive = false

        -- Starts screen effect
        StartScreenEffect('PeyoteEndOut', 0, true)
        StartScreenEffect('Dont_tazeme_bro', 0, true)
        StartScreenEffect('MP_race_crash', 0, true)
    
        while countDown > 0 do

            -- Adds screen moving effect while remaining countdown is 3 times the accident level,
            -- In order to stop screen shaking BEFORE the 'blur' effect finishes
            if countDown > (3.5*accidentLevel)   then 
                ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE", (accidentLevel * Options.ScreenShakeMultiplier))
            end 
            Wait(750)
            
            countDown = countDown - 1

            if countDown < Options.TimeLeftToEnableControls and disableControls then
                disableControls = false
            end
            -- Stops screen effect before countdown finishes
            if countDown <= 1 then
                StopScreenEffect('PeyoteEndOut')
                StopScreenEffect('Dont_tazeme_bro')
                StopScreenEffect('MP_race_crash')
            end
        end
        currAccidentLevel = 0
        effectActive = false
    end
end)




Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
        
            -- If the damage changed, see if it went over the threshold and blackout if necesary
            vehicle = GetVehiclePedIsIn(PlayerPedId(-1), false)
            if DoesEntityExist(vehicle) and (wasInCar or IsCar(vehicle)) then
                wasInCar = true
                oldSpeed = currentSpeed
                oldBodyDamage = currentDamage
                currentDamage = GetVehicleBodyHealth(vehicle)
                currentSpeed = GetEntitySpeed(vehicle) * 2.23

                if currentDamage ~= oldBodyDamage then
                    if not effect and currentDamage < oldBodyDamage then
                        if (oldBodyDamage - currentDamage) >= Options.BlackoutDamageRequiredLevel5 or
                        (oldSpeed - currentSpeed)  >= Options.BlackoutSpeedRequiredLevel5
                        then
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Options.EffectTimeLevel5, 5) 
                        elseif (oldBodyDamage - currentDamage) >= Options.BlackoutDamageRequiredLevel4 or (oldSpeed - currentSpeed)  >= Options.BlackoutSpeedRequiredLevel4
                        then
                            TriggerEvent("crashEffect", Options.EffectTimeLevel4, 4)
                            oldBodyDamage = currentDamage
                        elseif (oldBodyDamage - currentDamage) >= Options.BlackoutDamageRequiredLevel3 or (oldSpeed - currentSpeed)  >= Options.BlackoutSpeedRequiredLevel3
                        then   
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Options.EffectTimeLevel3, 3)
                        elseif (oldBodyDamage - currentDamage) >= Options.BlackoutDamageRequiredLevel2 or (oldSpeed - currentSpeed)  >= Options.BlackoutSpeedRequiredLevel2
                        then
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Options.EffectTimeLevel2, 2)
                        elseif (oldBodyDamage - currentDamage) >= Options.BlackoutDamageRequiredLevel1 or (oldSpeed - currentSpeed)  >= Options.BlackoutSpeedRequiredLevel1
                        then
                            oldBodyDamage = currentDamage
                            TriggerEvent("crashEffect", Options.EffectTimeLevel1, 1)
                        end
                    end
                end
            elseif wasInCar then
                wasInCar = false
                beltOn = false
                currentDamage = 0
                oldBodyDamage = 0
                currentSpeed = 0
                oldSpeed = 0
            end
            
        if disableControls and Options.DisableControlsOnBlackout then
            -- Controls to disable while player is on blackout
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,75,true) -- disable exit vehicle
		end
	end
end)