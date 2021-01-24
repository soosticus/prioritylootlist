local _G = _G
local PLL = _G.PLL;


PLL.customSoundId = nil
function PLL:StopSound()
    if(PLL.customSoundId ~= nil) then
        StopSound(PLL.customSoundId)
        PLL.customSoundId = nil
    end
end

function PLL:PlayChickenDrums()
    self:StopSound()
    PLL.customSoundId = select(2, PlaySoundFile("Interface\\AddOns\\PriorityLootList\\Sounds\\cd.mp3", "Dialog"))
end

function PLL:OnEnable()
    self:RegisterComm(self:GetCommPrefix());
    self:InitConsole();
    self:SetCommHandler(self.CommTypes.PLAY_DRUMS.name, function(self, event, data, dist, sender, version)
        self:PlayChickenDrums();
    end, self);
end
