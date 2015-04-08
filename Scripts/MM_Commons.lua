--[[
This file holds all common stuff espacially ram adresses
]]
MM = {};

MM.Watch = 
{
	--Everything with the pause menu
	Inventory = 
	{
		-- Items (bows etc...)
		Items = 
		{
			Ocarina = 0x1EF6E0
			,HeroBow = 0
			,FireArrow = 0
			,IceArrow = 0
			,LightArrow = 0
			,QuestItem1 = 0
			,Bomb = 0
			,Bombchu = 0
			,DekuStick = 0
			,DekuNut = 0
			,MagicBean = 0
			,QuestItem2 = 0
			,PowderKeg = 0
			,PictoBox = 0
			,LensOfTruth = 0
			,Hookshot = 0
			,GreatFairySword = 0
			,QuestItem3 = 0
			,Bottle1 = 0
			,Bottle2 = 0
			,Bottle3 = 0
			,Bottle4 = 0
			,Bottle5 = 0
			,Bottle6 = 0
		}
		,ItemsBySlotID = 
		{}
		,Masks = 
		{
			Postman = 0x1EF6F8
			,AllNight = 0
			,Blast = 0
			,Stone = 0
			,GreatFairy = 0
			,Deku = 0
			,Keaton = 0
			,Bremen = 0
			,Bunny = 0
			,DonGero = 0
			,Scents = 0
			,Goron = 0
			,Romani = 0
			,CircusLeader = 0
			,Kafei = 0
			,Couple = 0
			,Truth = 0
			,Zora = 0
			,Kamaro = 0
			,Gibdo = 0
			,Garo = 0
			,Captain = 0
			,Giant = 0
			,FierceDeity = 0
		}
		,MasksBySlotId = {}
		-- HP, Songs, Remains,....
		,Quests = 
		{
			SkutullaCode1stByte = 0x1F0665
			,BombersCode1stByte = 0x1F066B
			,LotteryCode1stByte = 0x1F065F
			,Picture1stByte = 0x1F0750
		}
	}
	--Everything about Link
	,Link = 
	{
		X = 0x3FFDD4
		,Y = 0x3FFDD8
		,Z = 0x3FFDDC
		,Rotation = 0x3FFE6E --Wrong
		,Velocity = 0x3FFE20
	}
	,Status = 
	{
		CurrentDay = 0x1EF68B
		,IgTime = 0x1EF67C
	}
};

MM.Dictionnary =
{
	Items = {};
};

--[[
Init table of items and masks
Each values is the previous one + 1
So, if you need to update, change change the ocarina/postman address
and the rest will follow magically
]]
local tmp = 0;
for key, value in pairs(MM.Watch.Inventory.Items) do
	if (tmp == 0) then
		tmp = value;
	end
	if (value == 0) then
		value = tmp;
	end
	tmp = tmp + 1;
end
for i = 0, 23 do
	if i == 0 then
		MM.Watch.Inventory.ItemsBySlotID[i] = MM.Watch.Inventory.Items.Ocarina;
	else
		MM.Watch.Inventory.ItemsBySlotID[i] = MM.Watch.Inventory.ItemsBySlotID[i - 1] + 1;
	end
end
tmp = 0;
for key, value in pairs(MM.Watch.Inventory.Masks) do
	if (tmp == 0) then
		tmp = value;
	end
	if (value == 0) then
		value = tmp;
	end
	tmp = tmp + 1;
end
for i = 0, 23 do
	if i == 0 then
		MM.Watch.Inventory.MasksBySlotId[i] = MM.Watch.Inventory.Masks.Postman;
	else
		MM.Watch.Inventory.MasksBySlotId[i] = MM.Watch.Inventory.MasksBySlotId[i - 1] + 1;
	end
end

--Fill the dictionnary
MM.Dictionnary.Items[0x00] = "Ocarina of Time";
MM.Dictionnary.Items[0x01] = "Hero's Bow";
MM.Dictionnary.Items[0x02] = "Fire Arrow";
MM.Dictionnary.Items[0x03] = "Ice Arrow";
MM.Dictionnary.Items[0x04] = "Light Arrow";
MM.Dictionnary.Items[0x05] = "JP Text: Fairy's Ocarina";
MM.Dictionnary.Items[0x06] = "Bomb";
MM.Dictionnary.Items[0x07] = "Bombchu";
MM.Dictionnary.Items[0x08] = "Deku Stick";
MM.Dictionnary.Items[0x09] = "Deku Nut";
MM.Dictionnary.Items[0x0A] = "Magic Beans";
MM.Dictionnary.Items[0x0B] = "JP Text: Longshot";
MM.Dictionnary.Items[0x0C] = "Powder Keg";
MM.Dictionnary.Items[0x0D] = "Pictograph Box";
MM.Dictionnary.Items[0x0E] = "Lens of Truth";
MM.Dictionnary.Items[0x0F] = "Hookshot";
MM.Dictionnary.Items[0x10] = "Great Fairy's Sword";
MM.Dictionnary.Items[0x11] = "JP Text: Fairy's Slingshot";
MM.Dictionnary.Items[0x12] = "Empty Bottle";
MM.Dictionnary.Items[0x13] = "Red Potion";
MM.Dictionnary.Items[0x14] = "Green Potion";
MM.Dictionnary.Items[0x15] = "Blue Potion";
MM.Dictionnary.Items[0x16] = "Fairy";
MM.Dictionnary.Items[0x17] = "Deku Princess";
MM.Dictionnary.Items[0x18] = "Milk";
MM.Dictionnary.Items[0x19] = "Milk (1/2)";
MM.Dictionnary.Items[0x1A] = "Fish";
MM.Dictionnary.Items[0x1B] = "Bug";
MM.Dictionnary.Items[0x1C] = "Blue Fire";
MM.Dictionnary.Items[0x1D] = "Poe";
MM.Dictionnary.Items[0x1E] = "Big Poe";
MM.Dictionnary.Items[0x1F] = "Spring Water";
MM.Dictionnary.Items[0x20] = "Hot Spring Water";
MM.Dictionnary.Items[0x21] = "Zora Egg";
MM.Dictionnary.Items[0x22] = "Gold Dust";
MM.Dictionnary.Items[0x23] = "Magical Mushroom";
MM.Dictionnary.Items[0x24] = "Sea Horse";
MM.Dictionnary.Items[0x25] = "Chateau Romani";
MM.Dictionnary.Items[0x26] = "JP Text: Hylian Loach";
MM.Dictionnary.Items[0x27] = "JP Text: Obaba's Drink";
MM.Dictionnary.Items[0x28] = "Moon's Tear";
MM.Dictionnary.Items[0x29] = "Land Title Deed";
MM.Dictionnary.Items[0x2A] = "Swamp Title Deed";
MM.Dictionnary.Items[0x2B] = "Mountain Title Deed";
MM.Dictionnary.Items[0x2C] = "Ocean Title Deed";
MM.Dictionnary.Items[0x2D] = "Room Key";
MM.Dictionnary.Items[0x2E] = "Special Delivery to Mama";
MM.Dictionnary.Items[0x2F] = "Letter to Kafei";
MM.Dictionnary.Items[0x30] = "Pendant of Memories";
MM.Dictionnary.Items[0x31] = "JP Text: Moon's Stone";
MM.Dictionnary.Items[0x32] = "Deku Mask";
MM.Dictionnary.Items[0x33] = "Goron Mask";
MM.Dictionnary.Items[0x34] = "Zora Mask";
MM.Dictionnary.Items[0x35] = "Fierce Deity's Mask";
MM.Dictionnary.Items[0x36] = "Mask of Truth";
MM.Dictionnary.Items[0x37] = "Kafei's Mask";
MM.Dictionnary.Items[0x38] = "All-Night Mask";
MM.Dictionnary.Items[0x39] = "Bunny Hood";
MM.Dictionnary.Items[0x3A] = "Keaton Mask";
MM.Dictionnary.Items[0x3B] = "Garo's Mask";
MM.Dictionnary.Items[0x3C] = "Romani's Mask";
MM.Dictionnary.Items[0x3D] = "Circus Leader's Mask";
MM.Dictionnary.Items[0x3E] = "Postman's Hat";
MM.Dictionnary.Items[0x3F] = "Couple's Mask";
MM.Dictionnary.Items[0x40] = "Great Fairy's Mask";
MM.Dictionnary.Items[0x41] = "Gibdo's Mask";
MM.Dictionnary.Items[0x42] = "Don Gero's Mask";
MM.Dictionnary.Items[0x43] = "Kamaro's Mask";
MM.Dictionnary.Items[0x44] = "Captain's Hat";
MM.Dictionnary.Items[0x45] = "Stone Mask";
MM.Dictionnary.Items[0x46] = "Bremen Mask";
MM.Dictionnary.Items[0x47] = "Blast Mask";
MM.Dictionnary.Items[0x48] = "Mask of Scents";
MM.Dictionnary.Items[0x49] = "Giant's Mask";
MM.Dictionnary.Items[0x4A] = "JP Text: Wind Medallion";
MM.Dictionnary.Items[0x4B] = "JP Text: Fire Medallion";
MM.Dictionnary.Items[0x4C] = "JP Text: Ice Medallion";
MM.Dictionnary.Items[0x4D] = "Kokiri Sword";
MM.Dictionnary.Items[0x4E] = "Razor Sword";
MM.Dictionnary.Items[0x4F] = "Gilded Sword";
MM.Dictionnary.Items[0x50] = "JP Text: Broken Giant's Knife";
MM.Dictionnary.Items[0x51] = "Hero's Shield";
MM.Dictionnary.Items[0x52] = "Mirror Shield";
MM.Dictionnary.Items[0x53] = "Quiver [30]";
MM.Dictionnary.Items[0x54] = "Quiver [40]";
MM.Dictionnary.Items[0x55] = "Quiver [50]";
MM.Dictionnary.Items[0x56] = "Bomb Bag [20]";
MM.Dictionnary.Items[0x57] = "Bomb Bag [30]";
MM.Dictionnary.Items[0x58] = "Bomb Bag [40]";
MM.Dictionnary.Items[0x59] = "JP Text: Boss Key";
MM.Dictionnary.Items[0x5A] = "JP Text: Boss Key";
MM.Dictionnary.Items[0x5B] = "JP Text: Boss Key";
MM.Dictionnary.Items[0x5C] = "JP Text: Boss Key";
MM.Dictionnary.Items[0x5D] = "Odolwa's Remains";
MM.Dictionnary.Items[0x5E] = "Goht's Remains";
MM.Dictionnary.Items[0x5F] = "Gyorg's Remains";
MM.Dictionnary.Items[0x60] = "Twinmold's Remains";
MM.Dictionnary.Items[0x61] = "Sonata of Awakening";
MM.Dictionnary.Items[0x62] = "Goron Lullaby";
MM.Dictionnary.Items[0x63] = "New Wave Bossa Nova";
MM.Dictionnary.Items[0x64] = "Elegy of Emptiness";
MM.Dictionnary.Items[0x65] = "Oath to Order";
MM.Dictionnary.Items[0x66] = "JP Text: Nocturne of Shadow";
MM.Dictionnary.Items[0x67] = "Song of Time";
MM.Dictionnary.Items[0x68] = "Song of Healing";
MM.Dictionnary.Items[0x69] = "Epona's Song";
MM.Dictionnary.Items[0x6A] = "Song of Soaring";
MM.Dictionnary.Items[0x6B] = "Song of Storms";
MM.Dictionnary.Items[0x6C] = "JP Text: Sun's Song";
MM.Dictionnary.Items[0x6D] = "Bomber's Notebook";
MM.Dictionnary.Items[0x6E] = "JP Text: Gold Skulltula";
MM.Dictionnary.Items[0x6F] = "Piece of Heart";
MM.Dictionnary.Items[0x70] = "JP Text: Piece of Heart";
MM.Dictionnary.Items[0x71] = "JP Text: Sun's Song";
MM.Dictionnary.Items[0x72] = "JP Text: Song of Time";
MM.Dictionnary.Items[0x73] = "Lullaby Intro";
MM.Dictionnary.Items[0x74] = "Big Key";
MM.Dictionnary.Items[0x75] = "Compass";
MM.Dictionnary.Items[0x76] = "Dungeon Map";
MM.Dictionnary.Items[0x77] = "Stray Fairies";
MM.Dictionnary.Items[0x78] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x79] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x7A] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x7B] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x7C] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x7D] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x7E] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x7F] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x80] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x81] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x82] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x83] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x84] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x85] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x86] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x87] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x88] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x89] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x8A] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x8B] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x8C] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x8D] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x8E] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x8F] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x90] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x91] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x92] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x93] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x94] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x95] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x96] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x97] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x98] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x99] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x9A] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x9B] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x9C] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x9D] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x9E] = "Unreadable Fuzz";
MM.Dictionnary.Items[0x9F] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA0] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA1] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA2] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA3] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA4] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA5] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA6] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA7] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA8] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xA9] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xAA] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xAB] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xAC] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xAD] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xAE] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xAF] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB0] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB1] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB2] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB3] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB4] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB5] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB6] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB7] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB8] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xB9] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xBA] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xBB] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xBC] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xBD] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xBE] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xBF] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC0] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC1] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC2] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC3] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC4] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC5] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC6] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC7] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC8] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xC9] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xCA] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xCB] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xCC] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xCD] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xCE] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xCF] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD0] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD1] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD2] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD3] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD4] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD5] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD6] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD7] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD8] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xD9] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xDA] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xDB] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xDC] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xDD] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xDE] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xDF] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE0] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE1] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE2] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE3] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE4] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE5] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE6] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE7] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE8] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xE9] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xEA] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xEB] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xEC] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xED] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xEE] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xEF] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF0] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF1] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF2] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF3] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF4] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF5] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF6] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF7] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF8] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xF9] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xFA] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xFB] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xFC] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xFD] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xFE] = "Unreadable Fuzz";
MM.Dictionnary.Items[0xFF] = "Empty Slot";