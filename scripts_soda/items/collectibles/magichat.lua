local mod = _SODA_BOY

local TROLL_BOMB_DISTANCE = 60

local SALVAGABLE_PICKUPS = TSIL.Utils.Tables.ConstructDictionaryFromTable({
    PickupVariant.PICKUP_COLLECTIBLE,
    PickupVariant.PICKUP_SHOPITEM,
})

local OUTCOMES = {
    ---@param player EntityPlayer
    function (player)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D6, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
    end,

    ---@param player EntityPlayer
    function (player)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_DIPLOPIA, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
    end,

    ---@param player EntityPlayer
    ---@param rng RNG
    function (player, rng)
        for _, v in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
            if SALVAGABLE_PICKUPS[v.Variant] then
                player:SalvageCollectible(v.SubType, v.Position, rng, mod:GetCurrentItemPool())
                v:Remove()
                rng:Next()
            end
        end
    end,

    ---@param player EntityPlayer
    function (player)
        local room = mod.Game:GetRoom()

        for i = 1, 3 do
            TSIL.Utils.Functions.RunInFramesTemporary(function ()
                TSIL.EntitySpecific.SpawnBomb(
                    BombVariant.BOMB_SUPERTROLL,
                    0,
                    room:FindFreePickupSpawnPosition(player.Position, TROLL_BOMB_DISTANCE, true)
                )
            end, (i - 1) * 3)
        end
    end,
}

---@param rng RNG
---@param player EntityPlayer
---@param flags UseFlag
mod:AddCallback(ModCallbacks.MC_USE_ITEM, function (_, _, rng, player, flags)
    OUTCOMES[rng:RandomInt(1, 4)](player, rng)

    if flags & UseFlag.USE_NOANIM == 0 then
        return true
    end
end, mod.Item.MAGIC_HAT)