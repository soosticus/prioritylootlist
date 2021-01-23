local _G = _G;
local PLL = _G.PLL;

local handlers = {};

function PLL:SetCommHandler(name, func)
    handlers[name] = func
end

function PLL:Fire(name, ...)
    local func = handlers[name]
    if func then 
        func(self, name, ...);
    end
end

function PLL:GetCommPrefix()
    return "PLLv0";
end

PLL.CommTypes = {
    PLAY_DRUMS = { name = "PLAY_DRUMS", id = 1, priority = "ALERT", fireLocally = true },
};

function PLL:PackMessage(ctype, data)
    payload = table.concat('|', { ctype, data } )
    return data, self:GetCommPrefix()
end

local function split(inputstr, sep)
    local sep = sep or '%s'
    local t = {}
    for field, s in string.gmatch(inputstr, "([^" .. sep .. "]*)(" .. sep .. "?)") do
        table.insert(t, field)
        if s == "" then
            return t
        end
    end
end

function PLL:UnPackMessage(payload)
    local success = true;
    local ctype, data = unpack(split(payload, "|"))
    return success, ctype, data;
end

local logInCallback = true;
function PLL:SendComm(ctype, data, dist, target)
    local priority = ctype.priority;
    local payload, prefix = self:PackCommMessage(ctype, data);
    dist, target = self:GetBroadcastChannel();
    local commCallback = function(self, sent, total)
        self:CommCallback(sent, total, logInCallback);
    end
    self:SendCommMessage(prefix, data, dist, target, priority, commCallback, self);
    if ctype.fireLocally then
        self:LogDebug("Firing comm [%s] locally.", typ.name);
        self:Fire(ctype.name, data, dist, UnitName("player"), self:GetVersion());
    end
end

function PLL:OnCommReceived(prefix, payload, dist, sender)
    local success, ctype, version, data = self:Deserialize(payload);
    if self.CommTypes[ctype] and self.CommTypes[ctype].fireLocally and sender == UnitName("player") then
        return;
    end

    self:Fire(ctype, data, dist, sender, version);
end