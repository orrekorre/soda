local mod = _SODA_BOY

local catears = Isaac.GetItemIdByName("Fake Cat Ears")


function mod:CatEarUse(item)
    Isaac.ExecuteCommand("giveitem c665")
    return {
        Discharge = true,
        Remove = false,
        Showanim = true,
    }
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.CatEarUse, catears)

if  mod:CatEarUse(item) then
    function
         mod:NewRoomfunction()
        Isaac.ExecuteCommand("remove c665")
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.NewRoomfunction)