local _G = _G;
local PLL = _G.PLL;

function PLL:ColorizeText(text, color)
	local c = self.Rainbow["Blue"].hex
	if(self.Rainbow[color] ~= nil) then
		c = self.Rainbow[color].hex
	end
    return ("|cFF%s%s|r"):format(c, text);
end

local rainbowArray = nil;
function PLL:RainbowizeText(text)
	local chars = { text:match( (text:gsub(".", "(.)")) ) };
	local res = "";
	local colors = {};
	local i = 0;
	if(not rainbowArray) then
		rainbowArray = {}
		for _, c in pairs(self.Rainbow) do
			rainbowArray[i] = c.hex;
			i=i+1;
		end
	end
	i=0;
	for _, c in pairs(chars) do
		res = ("%s|cFF%s%s|r"):format(res, rainbowArray[i % #rainbowArray], c);
		i=i+1;
	end
    return res;
end

PLL.Rainbow = {
		    ["Red"] = { r = 1.00, g = 0.40, b = 0.39, hex = "FF6663" },
		 ["Orange"] = { r = 1.00, g = 0.70, b = 0.27, hex = "FEB144" },
		 ["Yellow"] = { r = 0.99, g = 0.99, b = 0.59, hex = "FDFD97" },
		  ["Green"] = { r = 0.62, g = 0.88, b = 0.62, hex = "9EE09E" },
		   ["Blue"] = { r = 0.62, g = 0.76, b = 0.81, hex = "9EC1CF" },
		 ["Indigo"] = { r = 0.47, g = 0.00, b = 0.70, hex = "7600B1" },
		 ["Violet"] = { r = 0.80, g = 0.60, b = 0.79, hex = "CC99C9" }
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