local _G = _G
local PLL = _G.PLL;

PLL.DebugEnabled = false;
PLL.drumsSoundId = nil;
function PLL:StopChickenDrums()
    if(PLL.drumsSoundId ~= nil) then
        StopSound(PLL.drumsSoundId);
        PLL.drumsSoundId = nil;
    end
end

function PLL:PlayChickenDrums()
    self:Debug("Playing drums!");
    self:StopChickenDrums();
    PLL.drumsSoundId = select(2, PlaySoundFile("Interface\\AddOns\\PriorityLootList\\Sounds\\cd.mp3", "Dialog"));
end

function PLL:OnEnable()
    self:RegisterComm(self:GetCommPrefix());
    self:InitOptions();
    self:InitConsole();
    self:SetCommHandler(self.CommTypes.PLAY_DRUMS.name, function(self, event, data, dist, sender, version)
        self:Debug("Got Drums Message from %s", sender);
        if( not self.db.global.enableDrums) then
            self:Debug("Got Drums Message from %s, but drums disabled.", sender);
            return;
        end
        self:Debug("%s ~= %s", sender, UnitName("player"));
        if(sender ~= UnitName("player")) then
            self:Notify(string.format( "%s is rocking out with them chicken drums!", sender));
        end
        self:PlayChickenDrums();
    end, self);
end

local function GetSystemFrame()
    for i = 1, _G.NUM_CHAT_WINDOWS do
        local shown = select(7, GetChatWindowInfo(i));
        if shown then
            local frame = _G["ChatFrame" .. i];
            for _, type in ipairs(frame.messageTypeList) do
                if type == "SYSTEM" then
                    return frame;
                end
            end
        end
    end

    return _G.DEFAULT_CHAT_FRAME;
end

function PLL:Notify(str, ...)
    local msg = ("%s: %s"):format(self:ColorizeText(PLL.name), tostring(str):format(...));
    GetSystemFrame():AddMessage(msg, 1, 1, 1);
end

function PLL:Debug(str, ...)
    if(self.DebugEnabled) then
        local msg = ("%s: %s"):format(self:ColorizeText(PLL.name, "Red"), tostring(str):format(...));
        GetSystemFrame():AddMessage(msg, 1, 1, 1);
    end
end