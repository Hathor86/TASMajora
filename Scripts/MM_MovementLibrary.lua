MovementsHelper = {};
MovementsHelper.Songs = {};

local buttons = {};

MovementsHelper.Songs["SOT"] = {"C Right", "A", "C Down", "C Right", "A", "C Down"}; --Song Of time
MovementsHelper.Songs["SODT"] = {"C Right", "C Right", "A", "A", "C Down", "C Down"}; -- Song of Double Time
MovementsHelper.Songs["ISOT"] = {"C Down", "A", "C Right", "C Down", "A", "C Right"}; -- Inverted Song Of Time
MovementsHelper.Songs["SOH"] = {"C Left", "C Right", "C Down", "C Left", "C Right", "C Down"}; -- Song Of Healing
MovementsHelper.Songs["SOE"] = {"C Up", "C Left", "C Right", "C Up", "C Left", "C Right"}; -- Song Of Epona
MovementsHelper.Songs["SOS"] = {"C Down", "C Left", "C Up", "C Down", "C Left", "C Up"}; -- Song Of Soaring
MovementsHelper.Songs["SOST"] = {"A", "C Down", "C Up", "A", "C Down", "C Up"}; -- Song Of Storm
MovementsHelper.Songs["SOA"] = {"C Up", "C Left", "C Up", "C Left", "A", "C Right", "A"}; -- Sonata Of Awakening
MovementsHelper.Songs["GLI"] = {"A", "C Right", "C Left", "A", "C Right", "C Left"}; -- Goron Lullaby Intro
MovementsHelper.Songs["GL"] = {"A", "C Right", "C Left", "A", "C Right", "C Left", "C Right", "A"}; -- Goron Lullaby
MovementsHelper.Songs["NWBN"] = {"C Left", "C Up", "C Left", "C Right", "C Down", "C Left", "C Right"}; -- New Wave Bossa Nova
MovementsHelper.Songs["EOE"] = {"C Right", "C Left", "C Right", "C Down", "C Right", "C Up", "C Left"}; -- Elegy Of Emptyness
MovementsHelper.Songs["OOA"] = {"C Right", "C Down", "A", "C Down", "C Right", "C Up"}; -- Oath Of Order
MovementsHelper.Songs["Evan"] = {"A", "C Down", "C Right", "A", "C Down", "C Right", "C Left", "C Down", "C Right", "C Right", "C Down", "A", "A", "C Down", "C Right", "A", "C Left", "C Left", "C Right", "C Down", "C Down", "C Right", "C Left", "C Down"}; -- Evan's song in Zora hall

--For Z64 engine 1 frame => 3 "real" frames"
MovementsHelper.Z64FrameAdvance = function()
	joypad.set(buttons, 1);
	emu.frameadvance();	
	joypad.set(buttons, 1);
	emu.frameadvance();
	joypad.set(buttons, 1);
	emu.frameadvance();
end

--Simply play specified song
MovementsHelper.PlaySong = function(songName)
	buttons = {};
	if(songName == "SODT" or songName == "Evan") then
		for idx, button in ipairs(MovementsHelper.Songs[songName]) do
			buttons[button] = true;
			joypad.set(buttons, 1);
			MovementsHelper.Z64FrameAdvance();
			MovementsHelper.Z64FrameAdvance();
			buttons[button] = false;
			MovementsHelper.Z64FrameAdvance();
		end
	--[[elseif (songName == "Evan") then
		for idx, button in ipairs(MovementsHelper.Songs[songName]) do
			if(idx == 9 
			or idx == 12
			or idx == 16
			or idx == 18) then
				buttons[button] = true;
				joypad.set(buttons, 1);
				MovementsHelper.Z64FrameAdvance();
				MovementsHelper.Z64FrameAdvance();
				buttons[button] = false;
				MovementsHelper.Z64FrameAdvance();
			else
				buttons[button] = true;
				joypad.set(buttons, 1);
				MovementsHelper.Z64FrameAdvance();
				MovementsHelper.Z64FrameAdvance();
				buttons[button] = false;
			end
		end]]
	else
		for idx, button in ipairs(MovementsHelper.Songs[songName]) do
			buttons[button] = true;
			joypad.set(buttons, 1);
			MovementsHelper.Z64FrameAdvance();
			MovementsHelper.Z64FrameAdvance();
			buttons[button] = false;
		end
	end
end

--Helps to perfom the Reverse Camera Angle
MovementsHelper.ReverseCameraAngle = function(saveStateSlot)
	buttons = {};
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

MovementsHelper.QuickSpin = function()
end