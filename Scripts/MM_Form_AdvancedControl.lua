AdditionalWindows.InitAdvancedConrols = function()
	local form = forms.newform(200, 200, "Controls");

	local handle = forms.label(form, "Song Player", 0, 0, 75, 15, false);
	handle = forms.dropdown(form, {"SOT" ,"SODT", "SOH", "SOE", "SOS", "SOST", "SOA", "GLI", "GL", "NWBN", "EOE", "OOA"}, 0, 15, 50,15);
	forms.button(form, "Click Me!", _, 50, 15, 75, 25);
end