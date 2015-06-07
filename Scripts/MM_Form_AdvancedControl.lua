AdditionalWindows.AdvancedConrols = {};

local handles = {};
local flags = {};
flags["song"] = 0;
flags["revertcam"] = 0;

local function GotoExit()
	memory.write_s16_be(MM.Watch.Misc.ExitSetter, MM.Dictionnary.ExitsByName[forms.getproperty(handles["exitDropDown"], "Text")]);
	memory.writebyte(MM.Watch.Misc.WarpSetter, 1);
end

local function SetFlag(flag)
	flags[flag] = 1;
end

AdditionalWindows.AdvancedConrols.Init = function()
	local form = forms.newform(200, 200, "Controls");

	forms.label(form, "Song Player", 0, 0, 75, 15, false);
	handles["song"] = forms.dropdown(form, {"Evan", "SOT" ,"SODT", "SOH", "SOE", "SOS", "SOST", "SOA", "GLI", "GL", "NWBN", "EOE", "OOA"}, 0, 15, 50, 15);
	forms.button(form, "Play", function() SetFlag("song") end, 55, 15, 35, 22);
	
	forms.label(form, "Exit Setter", 0, 45, 75, 15, false);
	handles["exitDropDown"] = forms.dropdown(form, MM.Dictionnary.Exits, 0, 60, 125, 15);
	handles["goToExitButton"] = forms.button(form, "Go", GotoExit, 130, 60, 35, 22);
	
	forms.button(form, "Revert Camera Angle", function() SetFlag("revertcam") end, 0, 85, 125, 22);
	handles["savestate"] = forms.dropdown(form, {"1","2","3","4","5","6","7","8","9"}, 130,85, 35, 15);
end

AdditionalWindows.AdvancedConrols.Refresh = function()
	--Avoid to write unwanted stuff into memory when tasing
	if (movie.isloaded()) then
		forms.setproperty(handles["goToExitButton"], "Enabled", false);
	else
		forms.setproperty(handles["goToExitButton"], "Enabled", true);
	end
	
	if (flags["song"] == 1) then
		flags["song"] = 0;
		MovementsHelper.PlaySong(forms.getproperty(handles["song"], "Text"));
	end
	
	if (flags["revertcam"] == 1) then
		flags["revertcam"] = 0;
		MovementsHelper.ReverseCameraAngle(tonumber(forms.getproperty(handles["savestate"], "Text")));
	end
end