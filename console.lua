local _G = _G;
local PLL = _G.PLL;
local AceConfig = _G.LibStub("AceConfig-3.0");

local addonText = "Priority Loot List";
function PLL:InitConsole()
    local options = {
        drums = {
            name = "drums",
            desc = "Plays a fun instrumental for all to enjoy!",
            type = "execute",
            func = function() self:PlayChickenDrums(); end
        }
    };

    AceConfig:RegisterOptionsTable(self:ColorizeText(addonText), {
        type = "group",
        args = options,
    }, { "pll" });
end