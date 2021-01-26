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
            func = function() 
                if(self.db.global.enableDrums) then
                    self:SendComm(self.CommTypes.PLAY_DRUMS, "", "RAID");
                else
                    self:Notify(string.format("Chicken Drums are disabled.  Re-enable in %s options. (/pll options)", PLL.name));
                end
            end
        },
        killdrums = {
            name = "killdrums",
            desc = "Ends the local instrumental.",
            type = "execute",
            func = function() self:StopChickenDrums(); end
        },
        options = {
            name = "options",
            desc = "Opens the configuration interface",
            type = "execute",
            func = function() self:OpenOptionsInterface(); end
        },
        toggledebug = {
            name = "toggledebug",
            desc = "Toggles debug logging",
            type = "execute",
            hidden = true,
            cmdHidden = nil;
            func = function() self.DebugEnabled = not self.DebugEnabled; end
        },
    };

    local function setupAlias(existing, alias)
        options[alias] = {};
        for k, v in pairs(options[existing]) do options[alias][k] = v; end
        options[alias].hidden = true;
        options[alias].cmdHidden = nil;
    end
    setupAlias("options", "opt");

    AceConfig:RegisterOptionsTable(self:RainbowizeText(PLL.name), {
        type = "group",
        args = options,
    }, { "pll" });
end