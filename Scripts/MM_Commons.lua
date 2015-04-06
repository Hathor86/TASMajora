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
		Items = {}
		,Masks = {}
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