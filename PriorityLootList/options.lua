local _G = _G;
local PLL = _G.PLL;
local AceConfig = _G.LibStub("AceConfig-3.0");
local AceConfigDialog = _G.LibStub("AceConfigDialog-3.0");
local AceDB = _G.LibStub("AceDB-3.0");

function PLL:InitOptions()
    self.db = AceDB:New("PLL_DB", {
        global = {
            enableDrums = true,
        },
    });
    local guiOptions = {
        general = {
            name = "",
            type = "group",
            inline = true,
            order = 1,
            args = {
                header = {
                    order = 1,
                    type = "header",
                    name = "General",
                },
                settings = {
                    name = " ",
                    type = "group",
                    inline = true,
                    order = 2,
                    args = {
                        enableDrums = {
                            name = "Enable Drums",
                            order = 1,
                            desc = "Enable the fun instrumental (/pll drums)",
                            type = "toggle",
                            get = function(info) return self.db.global.enableDrums; end,
                            set = function(info, v) self.db.global.enableDrums = v; end,
                        },
                    },
                },
                desc1 = {
                    order = 4,
                    type = "description",
                    name = ("%s: https://github.com/soosticus/PriorityLootList"):format(
                        self:ColorizeText("GitHub Support")),
                },
                desc2 = {
                    order = 5,
                    type = "description",
                    name = ("%s: https://discord.gg/hqSNgup7cR"):format(
                        self:ColorizeText("Discord")),
                },
            },
        },
    };
    AceConfig:RegisterOptionsTable(PLL.name, {
        name = self:ColorizeText(PLL.name) .. " Options",
        type = "group",
        args = guiOptions,
    });
    self.OptionsFrame = AceConfigDialog:AddToBlizOptions(PLL.name);
end

function PLL:OpenOptionsInterface()
    _G.InterfaceOptionsFrame_Show();
    _G.InterfaceOptionsFrame_OpenToCategory(self.OptionsFrame);
end