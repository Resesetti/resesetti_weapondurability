--DOCS
-- https://docs.fivem.net/natives/?_0xC3287EE3050FB74C
-- Minimum degrade per shoot to ped/player
-- SHooting only decreasing when player shooting in ped/entity.
-- DON'T TOUCH group item in array, use docs in link above
local durabilityUsage = {
    [416676503] = {minDegrade = 0.4, maxDegrade = 5.0, group= 'GROUP_PISTOL'}, --Pistols
    [3566412244]= {minDegrade = 0.3, maxDegrade = 5.0, group= 'GROUP_MELEE'}, --Melee 
    [690389602] = {minDegrade = 0.1, maxDegrade = 5.0, group = "GROUP_STUNGUN"}, --Stunguns
    [970310034] = {minDegrade = 0.2, maxDegrade = 5.0, group = 'GROUP_RIFLE'}, --Riffles
    [860033945] = {minDegrade = 0.3, maxDegrade = 5.0, group = 'GROUP_SHOTGUN'}, --Shotguns
    [3082541095] = {minDegrade = 0.5, maxDegrade = 5.0,group = 'GROUP_SNIPER'}, --Snipers
    [1159398588] = {minDegrade = 0.4, maxDegrade = 5.0, group = "GROUP_MG"}, --MG
    [3337201093] = {minDegrade = 0.4, maxDegrade = 5.0, group = "GROUP_SMG"} -- SMG
}
local function randomDurability(degrade)
    math.randomseed(os.time())
    local minusDurability = math.random(durabilityUsage[degrade].minDegrade, durabilityUsage[degrade].maxDegrade)
    return minusDurability
end

RegisterNetEvent('resesetti:removeDurability', function(attacker,weaponName,degrade)
    if not weaponName or not type(degrade)  == 'number' then return end
    local slot = exports.ox_inventory:GetSlotIdWithItem(attacker, weaponName)
    local playerWeapon = exports.ox_inventory:Search(attacker, 1, weaponName)
    if playerWeapon then
        for k,v in pairs(playerWeapon) do
            playerWeapon = v
            break
        end
        local currDurrability = playerWeapon.metadata.durability
        local minusDurability = randomDurability(degrade)
        currDurrability = currDurrability-minusDurability
        if currDurrability < 0 then currDurrability = 0 return end
        exports.ox_inventory:SetDurability(attacker, slot, currDurrability)
    end    
end)
