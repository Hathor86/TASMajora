local luaPath = "C:\\Data\\Programs\\Emulators\\BizHawk-1.9.4\\Lua\\N64\\";

local bombsSlot = 0x1EF716;
local magic = 0x1EF6A9;
local cLeft = 0x1EF6BD;
local cDown = 0x1EF6BE;
local cRight = 0x1EF6BF;

local oneSecond = 86400 / 65535; --Number of real seconds / IG seconds. FF FF (65535) is midnight
local firstLine = 110;
local spacing = 12;

--Misc variables declared here to avoid memory realocation.
local x, y, hour, decimalMinutes;


--Init stuff.
local function init()
	console.clear();
	
	dofile(luaPath.."MM_Commons.lua");
	dofile(luaPath.."MM_Forms.lua");
	dofile(luaPath.."MM_MovementLibrary.lua");
	
	forms.destroyall();

	AdditionalWindows.InitWatches();
	--AdditionalWindows.InitAdvancedConrols();
end

--Display coords
local function coord()
	gui.text(0, firstLine, string.format("X-position: %.2f", memory.readfloat(MM.Watch.Link.X, true)), _, _, "topright");
	gui.text(0, firstLine + spacing, string.format("Y-position: %.2f", memory.readfloat(MM.Watch.Link.Y, true)), _, _, "topright");
	gui.text(0, firstLine + spacing * 2, string.format("Z-position: %.2f", memory.readfloat(MM.Watch.Link.Z, true)), _, _, "topright");
	--gui.text(0, firstLine + spacing * 3, string.format("Rotation: %.2f°", math.deg(memory.readfloat(MM.Watch.Link.Rotation, true))), _, _, "topright");
end

--Display Link Velocity
local function speed()
	gui.text(0, firstLine + spacing * 4, string.format("Velocity: %.2f", memory.readfloat(MM.Watch.Link.Velocity, true)), _, _, "topright");
end

--Display accurate IG clock
local function clockDisplay()
	hour = math.floor(memory.read_u16_be(MM.Watch.Status.IgTime) * oneSecond / 3600);
	decimalMinutes = (memory.read_u16_be(MM.Watch.Status.IgTime) * oneSecond / 3600) - hour;
	gui.text(client.screenwidth() / 2.6, 3, string.format("%02.0f:%02.0f:%02.0f (day %i)", hour, math.floor(decimalMinutes * 60), (decimalMinutes * 60 - math.floor(decimalMinutes * 60)) * 60, memory.readbyte(MM.Watch.Status.CurrentDay)), _, _, "bottomleft");
end

--Display Items
local function items()
	gui.text(0, firstLine + spacing * 4, string.format("Bombs: %i", memory.readbyte(bombsSlot)));	
	gui.text(80, firstLine - 35, memory.readbyte(magic));	
	gui.text(0, 0, string.format("Cleft: %i cDown:%i cRight:%i", memory.readbyte(cLeft), memory.readbyte(cDown), memory.readbyte(cRight)), _, _, "topright");
end

--Display current angle (in degree) of analog stick
local function stickAngle()
	buttons = joypad.get(1);
	x = buttons["X Axis"];
	y = buttons["Y Axis"];
	gui.text(0, firstLine + spacing * 6, string.format("Stick Angle: %.2f°", math.deg(math.atan2(y,x))), _, _, "topright");
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
	gui.cleartext();
	ui();
	AdditionalWindows.Refresh();
	emu.yield();
end