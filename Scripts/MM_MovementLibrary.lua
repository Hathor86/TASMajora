MovementsHelper = {};
MovementsHelper.cOcarina = "";

MovementsHelper.ocarinaDelay = 15;

MovementsHelper.Songs = {};
MovementsHelper.Songs["SOT"] = {"Right", "A", "Down", "Right", "A", "Down"}; --Song Of time
MovementsHelper.Songs["SODT"] = {"Right", "Right", "A", "A", "Down", "Down"}; -- Song of Double Time
MovementsHelper.Songs["SOH"] = {"Left", "Right", "Down", "Left", "Right", "Down"}; -- Song Of Healing
MovementsHelper.Songs["SOE"] = {"Up", "Left", "Right", "Up", "Left", "Right"}; -- Song Of Epona
MovementsHelper.Songs["SOS"] = {"Down", "Left", "Up", "Down", "Left", "Up"}; -- Song Of Soaring
MovementsHelper.Songs["SOST"] = {"A", "Down", "Up", "A", "Down", "Up"}; -- Song Of Storm
MovementsHelper.Songs["SOA"] = {"Up", "Left", "Up", "Left", "A", "Right", "A"}; -- Sonata Of Awakening
MovementsHelper.Songs["GLI"] = {"A", "Right", "Left", "A", "Right", "Left"}; -- Goron Lullaby Intro
MovementsHelper.Songs["GL"] = {"A", "Right", "Left", "A", "Right", "Left", "Right", "A"}; -- Goron Lullaby
MovementsHelper.Songs["NWBN"] = {"Left", "Up", "Left", "Right", "Down", "Left", "Right"}; -- New Wave Bossa Nova
MovementsHelper.Songs["EOE"] = {"Right", "Left", "Right", "Down", "Right", "Up", "Left"}; -- Elegy Of Emptyness
MovementsHelper.Songs["OOA"] = {"Right", "Down", "A", "Down", "Right", "Up"}; -- Oath Of Order

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
	joypad.set(buttons, 1);
	emu.frameadvance();	
	joypad.set(buttons, 1);
	emu.frameadvance();
	joypad.set(buttons, 1);
	emu.frameadvance();
end

MovementsHelper.PlaySong = function(songName)

	-- if(MovementsHelper.cOcarina == "") then
		-- return nil;
	-- else
		-- setButton(MovementsHelper.cOcarina);
		-- joypad.set(buttons, 1);
		-- for i = 0, MovementsHelper.ocarinaDelay do
			-- MovementsHelper.Z64FrameAdvance();
			--removeButton(MovementsHelper.cOcarina);
		-- end
	
		for idx, button in ipairs(MovementsHelper.Songs[songName]) do
			setButton(button);
			joypad.set(buttons, 1);
			MovementsHelper.Z64FrameAdvance();
			MovementsHelper.Z64FrameAdvance();
		end
	--end
end

MovementsHelper.ReverseCameraAngle = function(saveStateSlot)
	
	savestate.loadslot(saveStateSlot);
	
	buttons["Z"] = true;
	
	joypad.set(buttons, 1);
	MovementsHelper.Z64FrameAdvance();	
	joypad.set(buttons, 1);
	MovementsHelper.Z64FrameAdvance();	
	joypad.set(buttons, 1);
	MovementsHelper.Z64FrameAdvance();
	
	buttons["Z"] = false;
	joypad.set(buttons, 1);
	MovementsHelper.Z64FrameAdvance();
	MovementsHelper.Z64FrameAdvance();
	MovementsHelper.Z64FrameAdvance();
	
	gui.drawText(250, 250, "Set stick", _, 25);
	emu.yield();
	MovementsHelper.Z64FrameAdvance();
	buttons["Z"] = true;
	joypad.set(buttons, 1);
	MovementsHelper.Z64FrameAdvance();
	gui.drawText(250, 250, "Hold Z", _, 25);
	
end