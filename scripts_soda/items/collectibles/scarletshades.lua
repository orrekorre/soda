local mod = _SODA_BOY

---@param first boolean
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, function (_, _, _, first, _, _, player)
    if not first then return end

    if player:GetHealthType() == HealthType.SOUL then
        player:AddBlackHearts(2)
    else
        player:AddMaxHearts(2)
        player:AddHearts(4)
    end
end, mod.Item.SCARLET_SHADES)

---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function (_, player)
    if not player:HasCollectible(mod.Item.SCARLET_SHADES) then
        mod:GetData(player, "ScarletShades").Prev = nil
        return
    end

    local data = mod:GetData(player, "ScarletShades")
    local healthType = player:GetHealthType()
    local numHearts

    if healthType == HealthType.LOST then
        numHearts = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    elseif healthType == HealthType.SOUL then
        numHearts = math.max(0, player:GetSoulHearts() - 6)
    else
        numHearts = math.max(0, player:GetHearts() - 4)
    end

    if data.Prev ~= numHearts then
        ---@diagnostic disable-next-line: param-type-mismatch
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_SPEED, true)
        print("vla")
    end

    data.Prev = numHearts
end)

---@param player EntityPlayer
---@param flag CacheFlag
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function (_, player, flag)
    if not player:HasCollectible(mod.Item.SCARLET_SHADES) then return end

    local damage = flag == CacheFlag.CACHE_DAMAGE
    local speed = flag == CacheFlag.CACHE_SPEED

    if not (damage or speed) then return end

    local healthType = player:GetHealthType()
    local numHearts

    if healthType == HealthType.LOST then
        numHearts = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) * 10
    elseif healthType == HealthType.SOUL then
        numHearts = math.max(0, player:GetSoulHearts() - 6)
    else
        numHearts = math.max(0, player:GetHearts() - 4)
    end

    local num = player:GetCollectibleNum(mod.Item.SCARLET_SHADES)

    if damage then
        player.Damage = player.Damage + numHearts * 0.25 * num
    elseif speed then
        player.MoveSpeed = player.MoveSpeed + numHearts * 0.025 * num
    end
end)