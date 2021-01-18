local _, core = ...;

local AddonPrefix = "PRIORITYLOOTLIST"

local function listmembers(rank_index)
    local num_members = GetNumGuildMembers()
    for index = 1, num_members, 1 do
        local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName,
            achievementPoints, achievementRank, isMobile, isSoREligible, standingID = GetGuildRosterInfo(index);
        if not rank_index or rankIndex == tonumber(rank_index) then
            local color = core.ClassColors[class]
            print(string.format("|cff%s%s|r is rank %s", color.hex, name, rank))
        end
    end
end

local function listranks()
    local num_ranks = GuildControlGetNumRanks()
    print("Listing " .. num_ranks .. " guild ranks")
    for index = 1, num_ranks, 1 do
        local rank = GuildControlGetRankName(index);
        local color = core.ClassColors[class]
        print(string.format("%02d: %s", index - 1, rank))
    end
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

local function process_cmd(funcs, ...)
    local arg = {...}
    local func_name = tostring(arg[1])
    local func_args = {unpack(arg, 2, table.getn(arg))}
    local func_args_str = "nil"
    if func_args and table.getn(func_args) then
        func_args_str = table.concat(func_args, ';')
    end
    local func = funcs[func_name]
    if func then
        func(unpack(func_args))
    else
    end
end

local function list(...)
    process_cmd({
        ["ranks"] = listranks,
        ["members"] = listmembers
    }, ...)
end

local customSoundId = nil

local function stopsound()
    if(customSoundId ~= nil) then
        StopSound(customSoundId)
        customSoundId = nil
    end
end

local function chickendrums()
    C_ChatInfo.SendAddonMessage(AddonPrefix, "cd", "RAID");
    C_ChatInfo.SendAddonMessage(AddonPrefix, "cd", "WHISPER", UnitName("player"))
end

function Addon_OnEvent(self, event, ...)
    if event == "CHAT_MSG_ADDON" then
        local args = {...}
        if args[1] == AddonPrefix then
            -- print(event, ...)
            if args[2] == "cd" then
                stopsound()
                customSoundId = select(2, PlaySoundFile("Interface\\AddOns\\PriorityLootList\\Sounds\\cd.mp3"))
            end
        end
	elseif event == "PLAYER_LOGIN" then
		local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix(AddonPrefix)
	elseif event == "PLAYER_ENTERING_WORLD" then
	end
end

SLASH_PLL1 = "/pll"
SlashCmdList["PLL"] = function(cmd)
    process_cmd({
        ["list"] = list,
        ["cd"] = chickendrums,
        ["stopsound"] = stopsound
    }, unpack(split(cmd)))
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", Addon_OnEvent)
f:RegisterEvent("CHAT_MSG_ADDON");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("PLAYER_ENTERING_WORLD");