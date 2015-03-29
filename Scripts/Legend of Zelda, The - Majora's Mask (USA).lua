local xPosition = 0x3FFDD4;
local yPosition = 0x3FFDD8;
local zPosition = 0x3FFDDC;
local internalSpeed = 0x3FFE20;

local igTime = 0x1EF67C;

local bombsSlot = 0x1EF716;
local magic = 0x1EF6A9;
local cLeft = 0x1EF6BD;
local cDown = 0x1EF6BE;
local cRight = 0x1EF6BF;

local oneSecond = 86400 / 65535; --Number of real seconds / IG seconds. FF FF (65535) is midnight
local firstLine = 110;
local spacing = 12;
local currentWidth = client.screenwidth();
local currentHeight = client.screenheight();



--Init stuff. this can be called once
local function init()
	console.clear();
	--loadfile("MM_MovementLibrary.lua");
	--loadfile("MM_Forms.lua");

	AdditionalWindows.InitWatches();
		
end

--Display coords
local function coord()
	gui.text(0, firstLine, string.format("X-position: %.3f", memory.readfloat(xPosition, true)), _, _, "topright");
	gui.text(0, firstLine + spacing, string.format("Y-position: %.3f", memory.readfloat(yPosition, true)), _, _, "topright");
	gui.text(0, firstLine + spacing * 2, string.format("Z-position: %.3f", memory.readfloat(zPosition, true)), _, _, "topright");
end

local function speed()
	gui.text(0, firstLine + spacing * 3, string.format("Internal speed: %.3f", memory.readfloat(internalSpeed, true)), _, _, "topright");
end

--Display accurate IG clock
local function clockDisplay()
	local hour = math.floor(memory.read_u16_be(igTime) * oneSecond / 3600);
	local decimalMinutes = (memory.read_u16_be(igTime) * oneSecond / 3600) - hour;
	gui.text(currentWidth / 2.6, 3, string.format("%02.0f:%02.0f:%02.0f (day %i)", hour, math.floor(decimalMinutes * 60), (decimalMinutes * 60 - math.floor(decimalMinutes * 60)) * 60, memory.readbyte(AdditionalWindows.currentDay)), _, _, "bottomleft");
end

--Display Items
local function items()
	gui.text(0, firstLine + spacing * 4, string.format("Bombs: %i", memory.readbyte(bombsSlot)));
	
	gui.text(80, firstLine - 35, memory.readbyte(magic));
	
	gui.text(0, 0, string.format("Cleft: %i cDown:%i cRight:%i", memory.readbyte(cLeft), memory.readbyte(cDown), memory.readbyte(cRight)), _, _, "topright");
end

local function stickAngle()
	buttons = joypad.get(1);
	local x = buttons["X Axis"];
	local y = buttons["Y Axis"];
	gui.text(0, firstLine + spacing * 5, string.format("Stick Angle: %.2f°", math.deg(math.atan2(y,x))), _, _, "topright");
end

--General UI call
local function ui()
	coord();
	speed();
	clockDisplay();
	items();
	stickAngle();
end

init();

--Main loop
while true do
	ui();
	--console.log();
	emu.frameadvance();
end