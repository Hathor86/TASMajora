AdditionalWindows = {};

AdditionalWindows.currentDay = 0x1EF68B;

local skutullaCode1stByte = 0x1F0665;
local bombersCode1stByte = 0x1F066B;
local lotteryCode1stByte = 0x1F065F;

local bombersCode = "";
local skulltullaCode = "";
local lotteryCodes = {};

local handles = {};
local editTextBox = {};

local editMode = true;

--Load values
local function Load()

	bombersCode = "";
	for i = 0, 4 do
		bombersCode = string.format("%s%s", bombersCode, memory.readbyte(bombersCode1stByte + i));
	end
	
	skulltullaCode = "";
	for i = 0, 5 do
		skulltullaCode = string.format("%s%s", skulltullaCode, memory.readbyte(skutullaCode1stByte + i));
	end

	local k = 0;
	for i = 0, 2 do
		lotteryCodes[i] = "";
		for j = 0, 2 do
			lotteryCodes[i] = string.format("%s%s", lotteryCodes[i], memory.readbyte(lotteryCode1stByte + k));
			k = k + 1;
		end
		k = k + 1;
	end
end

local function SetValues()
	for key, handle in pairs(editTextBox) do
		
		if key == "bombers" then
			local newcode = forms.gettext(handle);
			for i = 1, #newcode do
				memory.writebyte(bombersCode1stByte + i - 1, tonumber(newcode:sub(i,i)));
			end
		end
		
	end
	Load();
end

local function switchMode()
	editMode = not editMode;
	
	for key, handle in pairs(editTextBox) do
		forms.setproperty(handle, "Enabled", editMode);
	end
end

AdditionalWindows.InitAdvancedConrols = function()

	local form = forms.newform(200, 200, "Controls");

	local handle = forms.label(form, "Song Player", 0, 0, 75, 15, false);
	handle = forms.dropdown(form, {"SOT" ,"SODT", "SOH", "SOE", "SOS", "SOST", "SOA", "GLI", "GL", "NWBN", "EOE", "OOA"}, 0, 15, 50,15);
	--console.log(forms.getproperty(handle,"Position"));
	forms.button(form, "Click Me!", _, 50, 15, 75, 25);
end

AdditionalWindows.InitWatches = function()
	local form = forms.newform(400, 400, "Watches");
	handles["bombers"] = forms.label(form, string.format("Bombers Code: %s", bombersCode), 0, 0, 125, 20, false);
	handles["skulltula"] = forms.label(form, string.format("Skulltula Code : %s", skulltullaCode), 0, 20, 125, 20, false);
	handles["lottery"] = forms.label(form, string.format("Lottery Code : %s", lotteryCodes[0]), 0, 40, 125, 20, false);
	
	editTextBox["bombers"] = forms.textbox(form, bombersCode, 75, 20, _, 125, 0);
	editTextBox["skulltula"] = forms.textbox(form, skulltullaCode, 75, 20, _, 125, 20);
	editTextBox["lottery"] = forms.textbox(form, lotteryCodes[0], 75, 20, _, 125, 40);
	
	forms.button(form, "Test2", SetValues, 0 ,300);
	
	switchMode();
end

--Update the lottery code
local function codes()
	--local color = "white";
	--local tab = "";
	--local jumpCount = 0;
	
	--gui.text(0, firstLine, );	
	--[[for i = 0, 5 do		
		tab = "";
		if skulltullaCode[i] == 0 then
			color = "red";
		elseif skulltullaCode[i] == 1 then
			color = "blue";
		elseif skulltullaCode[i] == 2 then
			color = "yellow"
		else
			color = "green";
		end

		if i > 0 then
			if math.abs(skulltullaCode[i - 1] - skulltullaCode[i]) > 1
			or (skulltullaCode[i] == 1 and skulltullaCode[i - 1] > 1)
			or (skulltullaCode[i] == 2 and skulltullaCode[i - 1] < 2) then
				tab = "-";
				jumpCount = jumpCount + 1;
			end
		else
			tab = "";
		end
		if i == 0 then
			
		end
		--gui.text(currentWidth / 2.5 + i * 20, firstLine + spacing, string.format("%s%i", tab, skulltullaCode[i]), _, color);
	end
	--gui.text(0, firstLine + spacing, string.format("Skulltula Code (%s jumps):", jumpCount));]]
	
	if handles["bombers"] ~= nil then
		forms.setproperty(handles["bombers"], "Text", string.format("Bombers Code: %s", bombersCode));
	end
	
	if handles["skulltula"] ~= nil then
		forms.setproperty(handles["skulltula"], "Text", string.format("Skulltula Code : %s", skulltullaCode));
	end
	
	local currentDayValue = memory.readbyte(AdditionalWindows.currentDay);
	if handles["lottery"] ~= nil then
		if currentDayValue == 1 or currentDayValue == 2 or currentDayValue == 3 then
			forms.setproperty(handles["lottery"], "Text", string.format("Lottery code: %s", lotteryCodes[currentDayValue - 1]));
		end
	end
end

forms.destroyall();
Load();
while true do
	codes();
	emu.yield();
	emu.frameadvance();
end