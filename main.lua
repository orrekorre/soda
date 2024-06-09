_SODA_BOY = RegisterMod("Soda Boy", 1)

-- Misc declarations
_SODA_BOY.Game = Game()
_SODA_BOY.SFX = SFXManager()

-- Libraries
local loiPath = "scripts_soda.lib.libraryofisaac"
require(loiPath .. ".TSIL").Init(loiPath)

-- Files
for _, v in ipairs({
    -- Declarations
    "declarations.enums",
    "declarations.functions",
    -- Collectibles
    "items.collectibles.magichat",
}) do
    include("scripts_soda." .. v)
end

local catears = Isaac.GetItemIdByName("Fake Cat Ears") -- is it okay if i include this in main or should i make a file in scripts?? also i still need to fix the bug that gets rid of guppys eye even when you dont have the active

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
