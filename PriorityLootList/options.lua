local _G = _G;
local PLL = _G.PLL;
local AceConfig = _G.LibStub("AceConfig-3.0");
local AceConfigDialog = _G.LibStub("AceConfigDialog-3.0");
local AceDB = _G.LibStub("AceDB-3.0");

function PLL:InitOptions()
    self.db = AceDB:New("PLL_DB", {
        global = {
            playRemoteDrums = true,
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
                desc = {
                    order = 2,
                    type = "description",
                    name = ("Brought to you by %s of <%s>, %s!"):format(
                        self:ColorizeText("Xanido"), self:ColorizeText("Always Be Pulling"), self:ColorizeText("US-Atiesh (Alliance)")),
                },
                desc2 = {
                    order = 3,
                    type = "description",
                    name = ("%s: leave a comment on CurseForge/WoWInterface/GitHub, or reach out to %s on reddit."):format(
                        self:ColorizeText("Feedback/support"), self:ColorizeText("ross456")),
                },
                settings = {
                    name = " ",
                    type = "group",
                    inline = true,
                    order = 4,
                    args = {
                        playRemoteDrums = {
                            name = "Play Other's Drums",
                            order = 1,
                            desc = "Play the fun instrumental when sent from other players",
                            type = "toggle",
                            get = function(info) return self.db.global.playRemoteDrums; end,
                            set = function(info, v) self.db.global.playRemoteDrums = v; end,
                        },
                    },
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