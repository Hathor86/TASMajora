AdditionalWindows.AdvancedConrols = {};

local handles = {};
local flags = 
{
	
};

local function GotoExit()

	memory.write_s16_be(MM.Watch.Misc.ExitSetter, MM.Dictionnary.ExitsByName[forms.getproperty(handles.exitDropDown, "Text")]);
	memory.writebyte(MM.Watch.Misc.WarpSetter, 1);

end

AdditionalWindows.AdvancedConrols.Init = function()
	local form = forms.newform(200, 200, "Controls");

	forms.label(form, "Song Player", 0, 0, 75, 15, false);
	local handle = forms.dropdown(form, {"SOT" ,"SODT", "SOH", "SOE", "SOS", "SOST", "SOA", "GLI", "GL", "NWBN", "EOE", "OOA"}, 0, 15, 50, 15);
	
	forms.label(form, "Exit Setter", 0, 45, 75, 15, false);
	handles["exitDropDown"] = forms.dropdown(form, MM.Dictionnary.Exits, 0, 60, 75, 15);
	handles["goToExitButton"] = forms.button(form, "Go", GotoExit, 80, 60, 35, 20);
end

AdditionalWindows.AdvancedConrols.Refresh = function()

	--Avoid to write unwanted stuff into memory when tasing
	if (movie.isloaded()) then
		forms.setproperty(handles["goToExitButton"], "Enabled", false);
	else
		forms.setproperty(handles["goToExitButton"], "Enabled", true);
	end

end