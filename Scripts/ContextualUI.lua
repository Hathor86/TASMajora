ContextualUI = {};

local currentRoom = 0;
local currentValue;

local maxValue = -1;

--Specific UI for Odolwa
local function Odolwa()
	currentValue = memory.readbyte(MM.Watch.Misc.OdolwaHealth);
	maxValue = 20;
	
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (currentValue == 255) then
		currentValue = 0;
	end
	
	gui.text(0, 110, string.format("Boss Health: %i/%i", currentValue, maxValue));
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (currentValue / maxValue) * 200, 13, _, "Green");
end

--Specific UI for Goth
local function Goth()
	currentValue = memory.readbyte(MM.Watch.Misc.GothHealth);
	maxValue = 20;
	
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (currentValue == 255) then
		currentValue = 0;
	end
	
	gui.text(0, 110, string.format("Boss Health: %i/%i", currentValue, maxValue));
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (currentValue / maxValue) * 200, 13, _, "Green");
end

--Specific UI for Gyorg
local function Gyorg()
	currentValue = memory.readbyte(MM.Watch.Misc.GyorgHealth);
	maxValue = 20;
	
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (currentValue == 255) then
		currentValue = 0;
	end
	
	gui.text(0, 110, string.format("Boss Health: %i/%i", currentValue, maxValue));
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (currentValue / maxValue) * 200, 13, _, "Green");
end

--Specific UI for Twinmold
local function Twinmold()
	currentValue = memory.readbyte(MM.Watch.Misc.BlueTwinmoldHealth);
	local currentValue2 = memory.readbyte(MM.Watch.Misc.RedTwinmoldHealth);
	maxValue = 20;
	
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (currentValue == 255) then
		currentValue = 0;
	end
	if (currentValue2 == 255) then
		currentValue2 = 0;
	end
	
	gui.text(0, 110, string.format("Boss Health: %i/%i - %i/%i", currentValue, maxValue, currentValue2, maxValue));
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(0, 140, 202, 15, "White");
	gui.drawRectangle(1, 126, (currentValue / maxValue) * 200, 13, _, "Blue");
	gui.drawRectangle(1, 141, (currentValue2 / maxValue) * 200, 13, _, "Red");
end

--Specific UI for Honey & Darling
local function Honey()
	if (memory.readbyte(MM.Watch.Status.CurrentDay) == 3) then
		currentValue = memory.readbyte(MM.Watch.Misc.HoneyAndDarlingCurrentScoreD3);
		maxValue = memory.readbyte(MM.Watch.Misc.HoneyAndDarlingPerfectScoreD3);
	else
		currentValue = memory.readbyte(MM.Watch.Misc.HoneyAndDarlingCurrentScore);
		maxValue = memory.readbyte(MM.Watch.Misc.HoneyAndDarlingPerfectScore);
	end
	
	
	
	gui.text(0, 110, string.format("Score: %i/%i", currentValue, maxValue));
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (currentValue / maxValue) * 200, 13);
end

local function HotSpringWaterTimer()
	local timer = memory.read_u16_be(MM.Watch.Misc.HSW1Timer);
	if (timer ~= 0) then
		gui.text(0, 110, string.format("Hot Spring Water 1: %.2f", timer * MM.Helper.Constant.OneGameSecond / 60));
	end
end

--Refresh the ui
ContextualUI.Refresh = function()
	currentRoom = memory.read_u16_be(MM.Watch.Status.CurrentMap);
	if(currentRoom == MM.Dictionnary.ExitsByName["Odolwa"]) then
		Odolwa();
	elseif (currentRoom == MM.Dictionnary.ExitsByName["Goth"]) then
		Goth();
	elseif (currentRoom == MM.Dictionnary.ExitsByName["Gyorg"]) then
		Gyorg();
	elseif (currentRoom == MM.Dictionnary.ExitsByName["Twinmold"]) then
		Twinmold();
	elseif (currentRoom == MM.Dictionnary.ExitsByName["Honey & Darling"]) then
		Honey();
	else
		maxValue = -1;
	end
	HotSpringWaterTimer();
end