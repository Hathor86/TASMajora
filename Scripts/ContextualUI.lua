ContextualUI = {};

local currentRoom = 0;
local mobCurrentHealth;

local mobMaxHealth = -1;

--Specific UI for Odolwa
local function Odolwa()

	mobCurrentHealth = memory.readbyte(MM.Watch.Misc.OdolwaHealth);
	if(mobMaxHealth == -1) then
		mobMaxHealth = mobCurrentHealth;
	end
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (mobCurrentHealth == 255) then
		mobCurrentHealth = 0;
	end
	
	gui.text(0, 110, "Boss Health: "..mobCurrentHealth);
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (mobCurrentHealth / mobMaxHealth) * 200, 13, _, "Green");

end

--Specific UI for Goth
local function Goth()

	mobCurrentHealth = memory.readbyte(MM.Watch.Misc.GothHealth);
	if(mobMaxHealth == -1) then
		mobMaxHealth = mobCurrentHealth;
	end
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (mobCurrentHealth == 255) then
		mobCurrentHealth = 0;
	end
	
	gui.text(0, 110, "Boss Health: "..mobCurrentHealth);
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (mobCurrentHealth / mobMaxHealth) * 200, 13, _, "Green");

end

--Specific UI for Gyorg
local function Gyorg()

	mobCurrentHealth = memory.readbyte(MM.Watch.Misc.GyorgHealth);
	if(mobMaxHealth == -1) then
		mobMaxHealth = mobCurrentHealth;
	end
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (mobCurrentHealth == 255) then
		mobCurrentHealth = 0;
	end
	
	gui.text(0, 110, "Boss Health: "..mobCurrentHealth);
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(1, 126, (mobCurrentHealth / mobMaxHealth) * 200, 13, _, "Green");

end

--Specific UI for Twinmold
local function Twinmold()

	mobCurrentHealth = memory.readbyte(MM.Watch.Misc.BlueTwinmoldHealth);
	local mobCurrentHealth2 = memory.readbyte(MM.Watch.Misc.RedTwinmoldHealth);
	if(mobMaxHealth == -1) then
		mobMaxHealth = mobCurrentHealth;
	end
	-- For strange reason, helath is set to max value (255 - 0xFF) when die
	if (mobCurrentHealth == 255) then
		mobCurrentHealth = 0;
	end
	if (mobCurrentHealth2 == 255) then
		mobCurrentHealth2 = 0;
	end
	
	gui.text(0, 110, "Boss Health: "..mobCurrentHealth.."/"..mobCurrentHealth2);
	gui.drawRectangle(0, 125, 202, 15, "White");
	gui.drawRectangle(0, 140, 202, 15, "White");
	gui.drawRectangle(1, 126, (mobCurrentHealth / mobMaxHealth) * 200, 13, _, "Blue");
	gui.drawRectangle(1, 141, (mobCurrentHealth2 / mobMaxHealth) * 200, 13, _, "Red");

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
	else
		mobMaxHealth = -1;
	end

end