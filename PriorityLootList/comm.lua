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
    PLAY_DRUMS = { name="PLAY_DRUMS", id = 1, priority = "BULK", fireLocally = true },
};

function PLL:PackCommMessage(ctype, data)
    local payload = table.concat({ ctype.name, data }, '|')
    return payload, self:GetCommPrefix()
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

local commTypeNameMap = nil;
function PLL:UnPackCommMessage(payload)
    local success = true;
    if(not commTypeNameMap) then
        commTypeNameMap = {}
        for k,v in pairs(self.CommTypes) do
            if k then                 
                self:Debug("commTypeNameMap ++ %s", k);
                commTypeNameMap[k] = v;
            end
        end
    end
    local spl = split(payload, "|");
    self:Debug("UnPackCommMessage Payload: %s", payload);
    self:Debug("UnPackCommMessage Split: %s", table.concat(spl, ' '));
    local ctypename, data = unpack(spl)
    return success, commTypeNameMap[ctypename], self.version, data;
end

local logInCallback = true;
function PLL:SendComm(ctype, data, dist, target)
    local priority = ctype.priority;
    local payload, prefix = self:PackCommMessage(ctype, data);
    self:Debug("SendCommMessage(%s, %s, %s, %s, %s)", prefix, payload, dist, UnitName("player"), priority);
    self:SendCommMessage(prefix, payload, dist, UnitName("player"), priority);
    if ctype.fireLocally then
        self:Debug("Firing %s locally", ctype.name);
        self:Fire(ctype.name, data, dist, UnitName("player"), self.version);
    end
end

function PLL:OnCommReceived(prefix, payload, dist, sender)
    self:Debug("OnCommReceived(%s, %s, %s, %s)", prefix, payload, dist, sender);
    local success, ctype, version, data = self:UnPackCommMessage(payload);
    self:Debug("Unpacked: %d, %s, %s, %s", success, ctype.name, version, data);
    if self.CommTypes[ctype] and self.CommTypes[ctype].fireLocally and sender == UnitName("player") then
        return;
    end

    self:Fire(ctype, data, dist, sender, version);
end