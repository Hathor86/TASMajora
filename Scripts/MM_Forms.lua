AdditionalWindows = {};

local bombersCode = "";
local skulltullaCode = "";
local lotteryCodes = {};

local refreshList = {};

local editBoxes = {};

local editMode = true;

--EditableValue class
local EditableValue = 
{
	formHandle = 0;
	labelHandle = 0;
	textBoxHandle = 0;
};
function EditableValue:new (form, x, y, text, value, width) --Constructor
	o = {};
	setmetatable(o, self);
	self.__index = self;
	
	if (width == nil) then
		width = 125;
	end
	o.formHandle = form;
	o.labelHandle = forms.label(o.formHandle, string.format("%s: %s", text, value), x, y, width, 20, false);
	o.textBoxHandle = forms.textbox(o.formHandle, value, 75, 20, _, x + width, y);
	
	return o;
end

-- EditableItem Class
local EditableItem = 
{
	formHandle = 0;
	slotID = 0;
	itemLabelHandle = 0;
	dropDownHandle = 0;
	Height = 50;
};
function EditableItem:new(form, x, y, slotID) --Constructor
	o = {};
	setmetatable(o, self);
	self.__index = self;
	
	o.formHandle = form;
	o.slotID = slotID;
	forms.label(o.formHandle, string.format("Slot %i", o.slotID), x, y, 40, 13, false);
	o.itemLabelHandle = forms.label(o.formHandle, "Current:", x, y + 13, 125, 13, false);
	o.dropDownHandle = forms.dropdown(form, MM.Dictionnary.Items, x, y + 26);
	
	return o;
end
function EditableItem:refresh() --Refresh method. We read the values in memory and update the label
	if self.slotID < 24 then
		forms.setproperty(self.itemLabelHandle, "Text", string.format("Current: %s", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.ItemsBySlotID[self.slotID])]));
	elseif self.slotID <= 47 then
		forms.setproperty(self.itemLabelHandle, "Text", string.format("Current: %s", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.MasksBySlotId[self.slotID - 24])]));
	end
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

--Write edited values into memory
local function SetValues()
	if (not movie.isloaded()) then
		for key, handle in pairs(editBoxes) do
			
			if (key == "bombers") then
				local newcode = forms.gettext(handle.textBoxHandle);
				for i = 0, 4 do
					memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.BombersCode1stByte + i, tonumber(string.sub(newcode,i + 1,i + 1)));
				end
			end
			
			if (key == "skulltula") then
				local newcode = forms.gettext(handle.textBoxHandle);
				for i = 0, 5 do
					memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.SkutullaCode1stByte + i, tonumber(string.sub(newcode,i + 1,i + 1)));
				end
			end
			
			if (key == "lottery") then
				if (currentDayValue == 1 or currentDayValue == 2 or currentDayValue == 3) then
					local newcode = forms.gettext(handle.textBoxHandle);
					local currentDayValue = memory.readbyte(MM.Watch.Status.CurrentDay);
					for i = 0, 2 do
						memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.LotteryCode1stByte + (currentDayValue - 1) * 3 + i, tonumber(string.sub(newcode,i + 1,i + 1)));
					end
				end
			end
		end
	end
end

local function switchMode()
	if (movie.isloaded()) then
		editMode = false;
	else
		editMode = not editMode;
	end
	
	for key, handle in pairs(editBoxes) do
		forms.setproperty(handle.textBoxHandle, "Enabled", editMode);
	end
	
	for _, item in pairs(refreshList) do 
		forms.setproperty(item.dropDownHandle, "Enabled", editMode);
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
	local form = forms.newform(800, 800, "Watches");
	
	editBoxes["bombers"] = EditableValue:new(form, 0, 0, "Bombers Code", bombersCode);
	editBoxes["skulltula"] = EditableValue:new(form, 0, 20, "Skulltula Code", skulltullaCode);
	editBoxes["lottery"] = EditableValue:new(form, 0, 40, "Lottery Code", lotteryCodes[0]);
	
	forms.label(form, "Inventory", 0, 80, 60, 20, false);
	local tmp;
	local k = 0;
	for i = 0, 3 do
		for j = 0, 5 do
			tmp = EditableItem:new(form, j * 125, i * EditableItem.Height + 100, k);
			forms.setproperty(tmp.dropDownHandle, "Text", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.ItemsBySlotID[tmp.slotID])]);
			tmp:refresh();
			table.insert(refreshList, tmp);
			k = k + 1;
		end
	end
	
	forms.label(form, "Masks", 0, 320, 60, 20, false);
	k = 24;
	for i = 0, 3 do
		for j = 0, 5 do
			tmp = EditableItem:new(form, j * 125, i * EditableItem.Height + 340, k);
			forms.setproperty(tmp.dropDownHandle, "Text", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.MasksBySlotId[tmp.slotID - 24])]);
			tmp:refresh();
			table.insert(refreshList, tmp);
			k = k + 1;
		end
	end
	
	forms.button(form, "Set !", SetValues, 0 ,650);
	
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
	
	if (editBoxes["bombers"].labelHandle ~= nil) then
		forms.setproperty(editBoxes["bombers"].labelHandle, "Text", string.format("Bombers Code: %s", bombersCode));
	end
	if (editBoxes["skulltula"].labelHandle ~= nil) then
		forms.setproperty(editBoxes["skulltula"].labelHandle, "Text", string.format("Skulltula Code : %s", skulltullaCode));
	end
	
	local currentDayValue = memory.readbyte(MM.Watch.Status.CurrentDay);
	if (editBoxes["lottery"].labelHandle ~= nil) then
		if (currentDayValue == 1 or currentDayValue == 2 or currentDayValue == 3) then
			forms.setproperty(editBoxes["lottery"].labelHandle, "Text", string.format("Lottery code: %s", lotteryCodes[currentDayValue - 1]));
		end
	end
end

AdditionalWindows.Refresh = function()
	Load();
	for _, item in pairs(refreshList) do 
		item:refresh();
	end
	codes();
end

Load();