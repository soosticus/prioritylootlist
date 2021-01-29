local _G = _G;
local PLL = _G.PLL;

function PLL:ColorizeText(text, color)
	local c = self.AllColors["Blue"].hex
	if(self.AllColors[color] ~= nil) then
		c = self.AllColors[color].hex
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
	      ["Yellow"] = { r = 1.00, g = 1.00, b = 0.60, hex = "FDFD97" },
	       ["Green"] = { r = 0.62, g = 0.88, b = 0.62, hex = "9EE09E" },
	        ["Blue"] = { r = 0.62, g = 0.76, b = 0.82, hex = "9EC1CF" },
	      ["Indigo"] = { r = 0.47, g = 0.00, b = 0.70, hex = "7600B1" },
	      ["Violet"] = { r = 0.80, g = 0.60, b = 0.79, hex = "CC99C9" },
}

PLL.ClassColors = {
	["Death Knight"] = { r = 0.77, g = 0.13, b = 0.24, hex = "C41F3B" },
	["Demon Hunter"] = { r = 0.64, g = 0.19, b = 0.79, hex = "A330C9" },
	       ["Druid"] = { r = 1.00, g = 0.50, b = 0.04, hex = "FF7D0A" },
	      ["Hunter"] = { r = 0.68, g = 0.84, b = 0.46, hex = "ABD473" },
	        ["Mage"] = { r = 0.42, g = 0.80, b = 0.95, hex = "69CCF0" },
	        ["Monk"] = { r = 0.00, g = 1.00, b = 0.59, hex = "00FF96" },
	     ["Paladin"] = { r = 0.97, g = 0.55, b = 0.73, hex = "F58CBA" },
	      ["Priest"] = { r = 1.00, g = 1.00, b = 1.00, hex = "FFFFFF" },
	       ["Rogue"] = { r = 1.00, g = 0.97, b = 0.42, hex = "FFF569" },
	      ["Shaman"] = { r = 0.00, g = 0.44, b = 0.88, hex = "0070DE" },
	     ["Warlock"] = { r = 0.59, g = 0.51, b = 0.79, hex = "9482C9" },
	     ["Warrior"] = { r = 0.79, g = 0.62, b = 0.44, hex = "C79C6E" },
}

PLL.Colors = {

}

function PLL:InitColors()
	self.AllColors = {}
	for k,v in pairs(self.ClassColors) do self.AllColors[k] = v end
	for k,v in pairs(self.Rainbow) do self.AllColors[k] = v end
	for k,v in pairs(self.Colors) do self.AllColors[k] = v end
end