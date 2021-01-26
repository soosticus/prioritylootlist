local _G = _G;
local PLL = _G.PLL;

function PLL:ColorizeText(text, color)
	c = self.Colors["Blue"].hex
	if(self.Colors[color] ~= nil) then
		c = self.Colors[color].hex
	end
    return ("|cFF%s%s|r"):format(c, text);
end

PLL.Colors = {
	    ["Blue"] = { r = 0.26, g = 0.53, b = 0.96, hex = "4287F5" },
	  ["Purple"] = { r = 0.56, g = 0.25, b = 0.96, hex = "9042f5" },
	     ["Red"] = { r = 0.69, g = 0.13, b = 0.13, hex = "B22222" }
}

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