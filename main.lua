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
    "items.collectibles.fakecatears",
    "items.collectibles.fizzingsoul",
    "items.collectibles.scarletshades",
}) do
    include("scripts_soda." .. v)
end