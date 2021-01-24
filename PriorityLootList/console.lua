local _G = _G;
local PLL = _G.PLL;
local AceConfig = _G.LibStub("AceConfig-3.0");

local pairs = pairs;
local type = type;
function PLL:InitConsole()
    local options = {
        drums = {
            name = "drums",
            desc = "Plays a fun instrumental for all to enjoy!",
            type = "execute",
            func = function() self:PlayChickenDrums(); end
        },
        killdrums = {
            name = "killdrums",
            desc = "Ends the local instrumental.",
            type = "execute",
            func = function() self:StopChickenDrums(); end
        },
        options = {
            name = "Options",
            desc = "Opens the configuration interface",
            type = "execute",
            func = function() self:OpenOptionsInterface(); end
        },
    };

    local function setupAlias(existing, alias)
        options[alias] = {};
        for k, v in pairs(options[existing]) do options[alias][k] = v; end
        options[alias].hidden = true;
        options[alias].cmdHidden = nil;
    end
    setupAlias("options", "opt");

    AceConfig:RegisterOptionsTable(self:ColorizeText(PLL.name), {
        type = "group",
        args = options,
    }, { "pll" });
end