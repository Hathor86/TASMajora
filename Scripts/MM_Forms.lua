AdditionalWindows = {};

local bombersCode = "";
local skulltullaCode = "";
local lotteryCodes = {};

local editBoxes = {};

local editMode = true;

-- EditableValue class
local EditableValue = 
{
	formHandle = 0;
	labelHandle = 0;
	textBoxHandle = 0;
};
--EditableValue cTor
function EditableValue:new (form, x, y, text, value)
	o = {};
	setmetatable(o, self);
	self.__index = self;
	
	o.formHandle = form;
	o.labelHandle = forms.label(o.formHandle, string.format("%s: %s", text, value), x, y, 125, 20, false);
	o.textBoxHandle = forms.textbox(o.formHandle, value, 75, 20, _, x + 125, y);
	return o;
end



--Load values
local function Load()

	bombersCode = "";
	for i = 0, 4 do
		bombersCode = string.format("%s%s", bombersCode, memory.readbyte(MM.Watch.Inventory.Quests.BombersCode1stByte + i));
	end
	
	skulltullaCode = "";
	for i = 0, 5 do
		skulltullaCode = string.format("%s%s", skulltullaCode, memory.readbyte(MM.Watch.Inventory.Quests.SkutullaCode1stByte + i));
	end

	local k = 0;
	for i = 0, 2 do
		lotteryCodes[i] = "";
		for j = 0, 2 do
			lotteryCodes[i] = string.format("%s%s", lotteryCodes[i], memory.readbyte(MM.Watch.Inventory.Quests.LotteryCode1stByte + k));
			k = k + 1;
		end
		k = k + 1;
	end
end

--Replace values
local function SetValues()
	for key, handle in pairs(editBoxes) do
		
		if key == "bombers" then
			local newcode = forms.gettext(handle.textBoxHandle);
			for i = 0, 4 do
				memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.BombersCode1stByte + i, tonumber(string.sub(newcode,i + 1,i + 1)));
			end
		end
		
		if key == "skulltula" then
			local newcode = forms.gettext(handle.textBoxHandle);
			for i = 0, 5 do
				memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.SkutullaCode1stByte + i, tonumber(string.sub(newcode,i + 1,i + 1)));
			end
		end
		
		if key == "lottery" then
			if currentDayValue == 1 or currentDayValue == 2 or currentDayValue == 3 then
				local newcode = forms.gettext(handle.textBoxHandle);
				local currentDayValue = memory.readbyte(MM.Watch.Status.CurrentDay);
				for i = 0, 2 do
					memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.LotteryCode1stByte + (currentDayValue - 1) * 3 + i, tonumber(string.sub(newcode,i + 1,i + 1)));
				end
			end
		end
		
	end
	Load();
end

local function switchMode()
	editMode = not editMode;
	
	for key, handle in pairs(editBoxes) do
		forms.setproperty(handle.textBoxHandle, "Enabled", editMode);
	end
end

local function Test()
	local f = assert(io.open("test.pgm", "w"));
	 --320x227
	 --local header = {0x42 ,0x4d ,0xb6 ,0x23 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x3e ,0x00 ,0x00 ,0x00 ,0x28 ,0x00 ,0x00 ,0x00 ,0x40 ,0x01 ,0x00 ,0x00 ,0xe3 ,0x00 ,0x00 ,0x00 ,0x01 ,0x00 ,0x01 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x78 ,0x23 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00};
	 --f:write(string.char(unpack(header)));
	f:write("P2\n");
	f:write("# CREATOR: GIMP PNM Filter Version 1.1\n");
	f:write("320 227\n");
	f:write("255\n");
	local j = 0;
	for i = 0, 11201 do --Picture is 11200 length
		--f:write(string.char(memory.readbyte(0x1F0750 + i)));
		--f:write(memory.readbyte(0x1F0750 + i).."\n");
		if j == 0 then
			memory.writebyte(0x1F0750 + i,0x00);
		end
		if j == 1 then
			memory.writebyte(0x1F0750 + i,0x3F);
		end
		if j == 2 then
			memory.writebyte(0x1F0750 + i,0x3F);
		end
		if j == 3 then
			memory.writebyte(0x1F0750 + i,0x3F);
		end
		--[[if j == 4 then
			memory.writebyte(0x1F0750 + i,0x00);
			j = 0;
		end]]
		if j == 2 then
			j = 0;
		else
			j = j + 1;
		end
		--memory.writebyte(0x1F0750 + i,0x3F);
	end
	f:close();
end

AdditionalWindows.InitAdvancedConrols = function()

	local form = forms.newform(200, 200, "Controls");

	local handle = forms.label(form, "Song Player", 0, 0, 75, 15, false);
	handle = forms.dropdown(form, {"SOT" ,"SODT", "SOH", "SOE", "SOS", "SOST", "SOA", "GLI", "GL", "NWBN", "EOE", "OOA"}, 0, 15, 50,15);
	forms.button(form, "Click Me!", Test, 50, 15, 75, 25);
end

AdditionalWindows.InitWatches = function()
	local form = forms.newform(400, 400, "Watches");
	
	editBoxes["bombers"] = EditableValue:new(form, 0, 0, "Bombers Code", bombersCode);
	editBoxes["skulltula"] = EditableValue:new(form, 0, 20, "Skulltula Code", skulltullaCode);
	editBoxes["lottery"] = EditableValue:new(form, 0, 40, "Lottery Code", lotteryCodes[0]);	
	
	forms.button(form, "Set !", SetValues, 0 ,300);
	
	--switchMode();
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
	
	if editBoxes["bombers"].labelHandle ~= nil then
		forms.setproperty(editBoxes["bombers"].labelHandle, "Text", string.format("Bombers Code: %s", bombersCode));
	end
	
	if editBoxes["skulltula"].labelHandle ~= nil then
		forms.setproperty(editBoxes["skulltula"].labelHandle, "Text", string.format("Skulltula Code : %s", skulltullaCode));
	end
	
	local currentDayValue = memory.readbyte(MM.Watch.Status.CurrentDay);
	if editBoxes["lottery"].labelHandle ~= nil then
		if currentDayValue == 1 or currentDayValue == 2 or currentDayValue == 3 then
			forms.setproperty(editBoxes["lottery"].labelHandle, "Text", string.format("Lottery code: %s", lotteryCodes[currentDayValue - 1]));
		end
	end
end

forms.destroyall();
Load();
AdditionalWindows.InitWatches();
AdditionalWindows.InitAdvancedConrols();
--Load();

--AdditionalWindows.InitWatches();
--[[
while true do
	codes();
	--emu.yield();
	--emu.frameadvance();
end]]