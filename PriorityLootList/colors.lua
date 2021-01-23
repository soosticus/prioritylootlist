local _G = _G;
local PLL = _G.PLL;

PLL.Color = "|cFF327DA8";
function PLL:ColorizeText(text)
    return ("%s%s|r"):format(PLL.Color, text);
end

PLL.ClassColors = {
	  ["Druid"] = { r = 1.00, g = 0.49, b = 0.04, hex = "FF7D0A" },
	[ "Hunter"] = { r = 0.67, g = 0.83, b = 0.45, hex = "ABD473" },
	   ["Mage"] = { r = 0.25, g = 0.78, b = 0.92, hex = "40C7EB" },
	 ["Priest"] = { r = 1.00, g = 1.00, b = 1.00, hex = "FFFFFF" },
	  ["Rogue"] = { r = 1.00, g = 0.96, b = 0.41, hex = "FFF569" },
	 ["Shaman"] = { r = 0.00, g = 0.44, b = 0.87, hex = "F58CBA" },
	["Paladin"] = { r = 0.96, g = 0.55, b = 0.73, hex = "F58CBA" },
	["Warlock"] = { r = 0.53, g = 0.53, b = 0.93, hex = "8787ED" },
	["Warrior"] = { r = 0.78, g = 0.61, b = 0.43, hex = "C79C6E" }
}

-- local tc_classes = {}

-- core.faction = UnitFactionGroup("player")
-- if core.faction == "Horde" then
-- 	tc_classes = { "Druid", "Hunter", "Mage", "Priest", "Rogue", "Shaman", "Warlock", "Warrior" }
-- elseif core.faction == "Alliance" then
-- 	tc_classes = { "Druid", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Warlock", "Warrior" }
-- end

-- core.classes = {}
-- for i = 1, #tc_classes do
-- 	local cname = tc_classes[i]
-- 	local lname = string.upper(cname)
-- 	core.CColors[lname] = ClassColors[cname]
-- 	table.insert(core.classes, lname)
-- end