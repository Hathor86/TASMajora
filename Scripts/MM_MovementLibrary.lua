MovementsHelper = {};
MovementsHelper.cOcarina = "";

MovementsHelper.Songs = {};
MovementsHelper.Songs["SOT"] = {"Right", "A", "Down", "Right", "A", "Down"};
MovementsHelper.Songs["SODT"] = {"Right", "Right", "A", "A", "Down", "Down"};
MovementsHelper.Songs["SOH"] = {"Left", "Right", "Down", "Left", "Right", "Down"};
MovementsHelper.Songs["SOE"] = {"Up", "Left", "Right", "Up", "Left", "Right"};
MovementsHelper.Songs["SOS"] = {"Down", "Left", "Up", "Down", "Left", "Up"};
MovementsHelper.Songs["SOST"] = {"A", "Down", "Up", "A", "Down", "Up"};
MovementsHelper.Songs["SOA"] = {"Up", "Left", "Up", "Left", "A", "Right", "A"};
MovementsHelper.Songs["GLI"] = {"A", "Right", "Left", "A", "Right", "Left"};
MovementsHelper.Songs["GL"] = {"A", "Right", "Left", "A", "Right", "Left", "Right", "A"};
MovementsHelper.Songs["NWBN"] = {"Left", "Up", "Left", "Right", "Down", "Left", "Right"};
MovementsHelper.Songs["EOE"] = {"Right", "Left", "Right", "Down", "Right", "Up", "Left"};
MovementsHelper.Songs["OOA"] = {"Right", "Down", "A", "Down", "Right", "Up"};

local buttons = {};

local function setButton(button)
	buttons = {};
	if (button == "Up") then
		buttons["C Up"] = true;
	elseif (button == "Down") then
		buttons["C Down"] = true;
	elseif (button == "Left") then
		buttons["C Left"] = true;
	elseif (button == "Right") then
		buttons["C Right"] = true;
	elseif (button == "A") then
		buttons["A"] = true;
	else
		console.log(string.format("Unknow button: %s ", button));
	end
end

local function removeButton(button)
	if (button == "Up") then
		buttons["C Up"] = false;
	elseif (button == "Down") then
		buttons["C Down"] = false;
	elseif (button == "Left") then
		buttons["C Left"] = false;
	elseif (button == "Right") then
		buttons["C Right"] = false;
	elseif (button == "A") then
		buttons["A"] = false;
	else
		console.log(string.format("Unknow button: %s", button));
	end
end

MovementsHelper.Z64FrameAdvance = function()
	emu.frameadvance();
	joypad.set(buttons, 1);
	emu.frameadvance();
	joypad.set(buttons, 1);
	emu.frameadvance();
	joypad.set(buttons, 1);
end

MovementsHelper.PlaySong = function(songName)

	if(MovementsHelper.cOcarina == "") then
		return nil;
	else
		setButton(MovementsHelper.cOcarina);
		joypad.set(buttons, 1);
		for i = 0, 16 do --15 seems to be the lesser limit  for link
			MovementsHelper.Z64FrameAdvance();
			removeButton(MovementsHelper.cOcarina);
		end
		
		for idx, button in ipairs(MovementsHelper.Songs[songName]) do
			setButton(button);
			joypad.set(buttons, 1);
			MovementsHelper.Z64FrameAdvance();
			MovementsHelper.Z64FrameAdvance();
		end
	end
end