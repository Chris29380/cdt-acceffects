-------------------------------------------------------------------
--- CDT Dev Fivem -------------------------------------------------
--- If you have any questions, you can join my discord :
--- https://dicord.gg/ae2jAmtQsm
-------------------------------------------------------------------

Options = {}

-- Amount of Time to Blackout, in milliseconds
-- 2000 = 2 seconds
Options.BlackoutTime = 1000

--[[ Options.Effect = {
    Time = {8 ,13 ,19 ,25 ,33},
    Damage = {15, 25, 45, 65, 100}
    Speed = {20, 45, 65,95, 130}
} ]]

Options.EffectTimeLevel1 = 8
Options.EffectTimeLevel2 = 13
Options.EffectTimeLevel3 = 19
Options.EffectTimeLevel4 = 25
Options.EffectTimeLevel5 = 33

-- Enable blacking out due to vehicle damage
-- If a vehicle suffers an impact greater than the specified value, the player blacks out
Options.BlackoutDamageRequiredLevel1 = 15
Options.BlackoutDamageRequiredLevel2 = 25
Options.BlackoutDamageRequiredLevel3 = 45
Options.BlackoutDamageRequiredLevel4 = 65
Options.BlackoutDamageRequiredLevel5 = 300

-- Enable blacking out due to speed deceleration
-- If a vehicle slows down rapidly over this threshold, the player blacks out
Options.BlackoutSpeedRequiredLevel1 = 20 -- Speed in MPH
Options.BlackoutSpeedRequiredLevel2 = 45
Options.BlackoutSpeedRequiredLevel3 = 65
Options.BlackoutSpeedRequiredLevel4 = 95
Options.BlackoutSpeedRequiredLevel5 = 130

-- Enable the disabling of controls if the player is blacked out
Options.DisableControlsOnBlackout = true
Options.TimeLeftToEnableControls = 10

-- Multiplier of screen shaking strength
Options.ScreenShakeMultiplier = 0.1