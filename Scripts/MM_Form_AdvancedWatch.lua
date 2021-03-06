AdditionalWindows = {};
AdditionalWindows.Watches = {};

local currentDay = "";
local bombersCode = "";
local skulltullaCode = "";
local lotteryCodes = {};
local health = "";
local maxHealth = "";
local soarCursor = "";
local swordSwing = "";
local owls = {};
local questsStatus = {};
local temple = {};
local skullHouse = {};

local buttons = {};

local refreshList = {};
local editBoxes = {};
local readOnly = {};
local refreshListCount = 0;
local currentRefresh = 1;

local editMode = true;
local valueSetter = 0;

--ReadOnlyVlaue class
local ReadOnlyValue =
{
	formHandle = 0;
	labelHandle = 0;
	text = "";
};
--Constructor
function ReadOnlyValue:new(form, x, y, text, value, width)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	
	if (width == nil) then
		width = 145;
	end
	o.formHandle = form;
	o.text = text;
	o.labelHandle = forms.label(o.formHandle, string.format("%s: %s", text, value), x, y, width, 20, false);
	
	return o;
end
--Refresh method
function ReadOnlyValue:refresh(value)
	forms.setproperty(self.labelHandle, "Text", string.format("%s: %s", self.text, value));
end

--EditableValue class
local EditableValue = 
{
	formHandle = 0;
	labelHandle = 0;
	textBoxHandle = 0;
	text = 0;
};
--Constructor
function EditableValue:new (form, x, y, text, value, width)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	
	if (width == nil) then
		width = 125;
	end
	o.formHandle = form;
	o.text = text;
	o.labelHandle = forms.label(o.formHandle, string.format("%s: %s", text, value), x, y, width, 20, false);
	o.textBoxHandle = forms.textbox(o.formHandle, value, 50, 20, _, x + width, y);
	
	return o;
end
function EditableValue:refresh(value)
	forms.setproperty(self.labelHandle, "Text", string.format("%s: %s", self.text, value));
end

-- EditableItem Class
local EditableItem = 
{
	formHandle = 0;
	slotID = 0;
	itemLabelHandle = 0;
	dropDownHandle = 0;
	Height = 50;
	ammoLabel = 0;
	ammoEditHandle = 0;
	ammoWatchAddress = 0;
};
--Constructor
function EditableItem:new(form, x, y, slotID)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	
	o.formHandle = form;
	o.slotID = slotID;
	forms.label(o.formHandle, string.format("Slot %i", o.slotID), x, y, 40, 13, false);
	o.itemLabelHandle = forms.label(o.formHandle, "Current:", x, y + 13, 125, 13, false);
	o.dropDownHandle = forms.dropdown(form, MM.Dictionnary.Items, x, y + 26);
	
	if(o.slotID == memory.readbyte(MM.Watch.Inventory.Items.HeroBow)
	or o.slotID == memory.readbyte(MM.Watch.Inventory.Items.Bomb)
	or o.slotID == memory.readbyte(MM.Watch.Inventory.Items.Bombchu)
	or o.slotID == memory.readbyte(MM.Watch.Inventory.Items.DekuStick)
	or o.slotID == memory.readbyte(MM.Watch.Inventory.Items.DekuNut)
	or o.slotID == memory.readbyte(MM.Watch.Inventory.Items.MagicBean)
	or o.slotID == memory.readbyte(MM.Watch.Inventory.Items.PowderKeg)
	) then
		if (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.HeroBow)) then
			o.ammoWatchAddress = MM.Watch.Ammo.Arrows;
		elseif (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.Bomb)) then
			o.ammoWatchAddress = MM.Watch.Ammo.Bombs;
		elseif (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.Bombchu)) then
			o.ammoWatchAddress = MM.Watch.Ammo.Bombchus;
		elseif (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.DekuStick)) then
			o.ammoWatchAddress = MM.Watch.Ammo.DekuSticks;
		elseif (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.DekuNut)) then
			o.ammoWatchAddress = MM.Watch.Ammo.DekuNuts;
		elseif (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.MagicBean)) then
			o.ammoWatchAddress = MM.Watch.Ammo.MagicBeans;
		elseif (o.slotID == memory.readbyte(MM.Watch.Inventory.Items.PowderKeg)) then
			ammoWatchAddress = MM.Watch.Ammo.PowderKegs;
		end
		o.ammoLabel = forms.label(o.formHandle, "", x + 40, y, 55, 13, false);
		forms.setproperty(o.ammoLabel, "Text", string.format("Ammo: %s", memory.readbyte(o.ammoWatchAddress)));
		o.ammoEditHandle = forms.textbox(o.formHandle, memory.readbyte(o.ammoWatchAddress), 20, 20, _, x + 95, y - 1);
	end
	
	return o;
end
--Refresh method. We read the values in memory and update the label
function EditableItem:refresh()
	if self.slotID < 24 then
		forms.setproperty(self.itemLabelHandle, "Text", string.format("Current: %s", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.ItemsBySlotID[self.slotID])]));
	elseif self.slotID <= 47 then
		forms.setproperty(self.itemLabelHandle, "Text", string.format("Current: %s", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.MasksBySlotId[self.slotID - 24])]));
	end
	if self.ammoLabel ~= 0 then
		forms.setproperty(self.ammoLabel, "Text", string.format("Ammo: %s", memory.readbyte(self.ammoWatchAddress)));
	end
end

--EditableCheckbox class
local EditableCheckbox = 
{
	formHandle = 0;
	checkboxHandle = 0;
};
--Constructor
function EditableCheckbox:new(form, x, y, text)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	
	o.formHandle = form;
	o.checkboxHandle = forms.checkbox(form, text, x, y);
	return o;
end
--Refresh method
function EditableCheckbox:refresh()
	forms.setproperty(self.checkboxHandle, "Checked", owls[forms.getproperty(self.checkboxHandle, "Text")] ~= nil or questsStatus[forms.getproperty(self.checkboxHandle, "Text")] ~= nil);
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
	
	currentDay = memory.readbyte(MM.Watch.Status.CurrentDay);
	health = memory.read_s16_be(MM.Watch.Link.Health);
	maxHealth = memory.read_s16_be(MM.Watch.Inventory.Quests.HeartContainer);
	soarCursor = memory.readbyte(MM.Watch.Status.SoarCursor);
	swordSwing = memory.read_s8(MM.Watch.Status.SwordSwing);
	owls = MM.Helper.GetOwlsHit();
	questsStatus = MM.Helper.GetQuestStatus();
	
	temple["wood"] = {};
	temple["wood"].keys = memory.readbyte(MM.Watch.Inventory.Quests.WoodfallKeys);
	temple["wood"].fairies = memory.readbyte(MM.Watch.Inventory.Quests.WoodfallFairies);
	
	temple["snow"] = {};
	temple["snow"].keys = memory.readbyte(MM.Watch.Inventory.Quests.SnowheadKeys);
	temple["snow"].fairies = memory.readbyte(MM.Watch.Inventory.Quests.SnowheadFairies);
	
	temple["bay"] = {};
	temple["bay"].keys = memory.readbyte(MM.Watch.Inventory.Quests.GreatBayKeys);
	temple["bay"].fairies = memory.readbyte(MM.Watch.Inventory.Quests.GreatBayFairies);
	
	temple["stone"] = {};
	temple["stone"].keys = memory.readbyte(MM.Watch.Inventory.Quests.StoneTowerKeys);
	temple["stone"].fairies = memory.readbyte(MM.Watch.Inventory.Quests.StoneTowerFairies);
	
	skullHouse["swamp"] = memory.readbyte(MM.Watch.Inventory.Quests.SwampSkulltulaToken);
	skullHouse["ocean"] = memory.readbyte(MM.Watch.Inventory.Quests.OceansideSkulltulaToken);
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
				if (currentDay == 1 or currentDay == 2 or currentDay == 3) then
					local newcode = forms.gettext(handle.textBoxHandle);
					for i = 0, 2 do
						memory.writebyte(MM.Watch.Inventory.Quests.LotteryCode1stByte.LotteryCode1stByte + (currentDay - 1) * 3 + i, tonumber(string.sub(newcode,i + 1,i + 1)));
					end
				end
			end
		
		end
	end
end

--Switch between edit and view mode
local function SwitchMode()
	if (movie.isloaded()) then
		editMode = false;
	else
		editMode = true;
	end
	
	forms.setproperty(valueSetter, "Enabled", editMode);
	
	for key, handle in pairs(editBoxes) do
		forms.setproperty(handle.textBoxHandle, "Enabled", editMode);
	end
	
	for _, item in pairs(refreshList) do
		if(item.dropDownHandle ~= nil) then
			forms.setproperty(item.dropDownHandle, "Enabled", editMode);
			forms.setproperty(item.ammoEditHandle, "Enabled", editMode);
		end
		if(item.checkboxHandle ~= nil) then
			forms.setproperty(item.checkboxHandle, "Enabled", editMode);
		end
	end
end

--Initialize the window
AdditionalWindows.Watches.Init = function()
	local form = forms.newform(800, 830, "Watches");
	
	editBoxes["bombers"] = EditableValue:new(form, 0, 0, "Bombers Code", bombersCode);
	editBoxes["skulltula"] = EditableValue:new(form, 0, 20, "Skulltula Code", skulltullaCode);
	editBoxes["lottery"] = EditableValue:new(form, 0, 40, "Lottery Code", lotteryCodes[0]);
	
	editBoxes["health"] = EditableValue:new(form, 200, 0, "Current health", health, 100);
	editBoxes["maxHealth"] = EditableValue:new(form, 200, 20, "Heart container", maxHealth / 16, 100);
	
	readOnly["soar"] = ReadOnlyValue:new(form, 400, 0, "Soar to", 0);
	
	readOnly["ISG"] = ReadOnlyValue:new(form, 400, 20, "ISG", 0);
	
	readOnly["stick"] = ReadOnlyValue:new(form, 625, 0, "Stick Angle", 0);
	readOnly["Left Sidehop"] = ReadOnlyValue:new(form, 625, 20, "Left Sidehop", 0);
	readOnly["Right Sidehop"] = ReadOnlyValue:new(form, 625, 40, "Right Sidehop", 0);
	readOnly["UTurn"] = ReadOnlyValue:new(form, 625, 60, "Uturn", 0);
	
	forms.label(form, "Inventory", 0, 80, 60, 20, false);
	local tmp;
	local k = 0;
	for i = 0, 3 do
		for j = 0, 5 do
			tmp = EditableItem:new(form, j * 125, i * EditableItem.Height + 100, k);
			forms.setproperty(tmp.dropDownHandle, "Text", MM.Dictionnary.Items[memory.readbyte(MM.Watch.Inventory.ItemsBySlotID[tmp.slotID])]);
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
			table.insert(refreshList, tmp);
			k = k + 1;
		end
	end
	
	forms.label(form, "Owls", 0, 550, 60, 20, false);
	local y = 570;
	for owl,flag in pairs(MM.Dictionnary.Owls) do
		tmp = EditableCheckbox:new(form, 0, y, owl);
		table.insert(refreshList, tmp);
		y = y + 20;
	end
	
	forms.label(form, "Quest Status", 120, 550, 60, 20, false);
	y = 570;
	local x = 120;
	local i = 0;
	for item,flag in pairs(MM.Dictionnary.QuestsStatus) do
		tmp = EditableCheckbox:new(form, x, y, item);
		table.insert(refreshList, tmp);
		y = y + 20;
		i = i + 1;
		if(i == 11) then
			x = x + 120;
			y = 570;
			i = 0;
		end
	end
	
	x = 480;
	y = 570;
	editBoxes["woodK"] = EditableValue:new(form, x, y, "Woodfall keys", temple["wood"].keys, 105);
	x = x + 160;
	editBoxes["woodF"] = EditableValue:new(form, x, y, "Fairies", temple["wood"].fairies, 55);
	y = y + 20;
	
	x = 480;
	editBoxes["snowK"] = EditableValue:new(form, x, y, "Snowhead keys", temple["snow"].keys, 105);
	x = x + 160;
	editBoxes["snowF"] = EditableValue:new(form, x, y, "Fairies", temple["snow"].fairies, 55);
	y = y + 20;
	
	x = 480;
	editBoxes["bayK"] = EditableValue:new(form, x, y, "Great Bay keys", temple["bay"].keys, 105);
	x = x + 160;
	editBoxes["bayF"] = EditableValue:new(form, x, y, "Fairies", temple["bay"].fairies, 55);
	y = y + 20;
	
	x = 480;
	editBoxes["stoneK"] = EditableValue:new(form, x, y, "Stone Tower keys", temple["stone"].keys, 105);
	x = x + 160;
	editBoxes["stoneF"] = EditableValue:new(form, x, y, "Fairies", temple["stone"].fairies, 55);
	y = y + 40;
	
	x = 480;
	editBoxes["swampSkull"] = EditableValue:new(form, x, y, "Swamp Skull Tokens", skullHouse["swamp"], 120);
	y = y + 20;
	editBoxes["oceanSkull"] = EditableValue:new(form, x, y, "Ocean Skull Tokens", skullHouse["ocean"], 120);
	
	
	for _, item in pairs(refreshList) do 
		refreshListCount = refreshListCount + 1;
	end
	
	
	valueSetter = forms.button(form, "Set !", SetValues, 700 ,750);
end

local function Update()
	Load();
	buttons = joypad.get(1);
	
	editBoxes["bombers"]:refresh(bombersCode);
	editBoxes["skulltula"]:refresh(skulltullaCode);
	
	if (currentDay == 1 or currentDay == 2 or currentDay == 3) then
		editBoxes["lottery"]:refresh(lotteryCodes[currentDay - 1]);
	end
	
	editBoxes["health"]:refresh(health);
	editBoxes["maxHealth"]:refresh(maxHealth);
	editBoxes["woodK"]:refresh(temple["wood"].keys);
	editBoxes["woodF"]:refresh(temple["wood"].fairies);
	editBoxes["snowK"]:refresh(temple["snow"].keys);
	editBoxes["snowF"]:refresh(temple["snow"].fairies);
	editBoxes["bayK"]:refresh(temple["bay"].keys);
	editBoxes["bayF"]:refresh(temple["bay"].fairies);
	editBoxes["stoneK"]:refresh(temple["stone"].keys);
	editBoxes["stoneF"]:refresh(temple["stone"].fairies);
	editBoxes["swampSkull"]:refresh(skullHouse["swamp"]);
	editBoxes["oceanSkull"]:refresh(skullHouse["ocean"]);
	
	if(soarCursor < 11) then
		readOnly["soar"]:refresh(MM.Dictionnary.IndexWarp[soarCursor + 1]);
	else
		readOnly["soar"]:refresh(MM.Dictionnary.IndexWarp[1]);
	end
	
	readOnly["ISG"]:refresh(swordSwing);
	
	local currentAngle = math.atan2(buttons["Y Axis"], buttons["X Axis"]);
	readOnly["stick"]:refresh(string.format("%.2f", math.deg(currentAngle)));
	readOnly["Left Sidehop"]:refresh(string.format("X:%.0f - Y:%.0f", MM.Helper.ToCartesian(currentAngle + math.pi / 2)));
	readOnly["Right Sidehop"]:refresh(string.format("X:%.0f - Y:%.0f", MM.Helper.ToCartesian(currentAngle - math.pi / 2)));
	readOnly["UTurn"]:refresh(string.format("X:%.0f - Y:%.0f", MM.Helper.ToCartesian(currentAngle + math.pi)));
end

--Refresh values
--TAS mode means that everything is re-read each times
local function TasRefresh()
	Update();
	for _, item in pairs(refreshList) do
		item:refresh();
	end
end

--Refresh values
--Alternate refresh mode. Only one value each time the loop is called; other values 1 time over 10.
local function LightweigthRefresh()
	for idx, item in pairs(refreshList) do
		if(idx == currentRefresh) then
			if(currentRefresh == refreshListCount) then
				currentRefresh = 1;
			else
				currentRefresh = currentRefresh + 1;
			end
			item:refresh();
			break;
		end
	end
	if(currentRefresh % 10 == 0) then
		Load();
		Update();
	end
end

AdditionalWindows.Watches.Refresh = function()
	if((movie.isloaded() and editMode)
		or (not movie.isloaded() and not editMode)
	) then
		SwitchMode();
	end
	
	TasRefresh();
	--LightweigthRefresh();
end
Load();