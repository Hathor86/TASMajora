local luaPath = "C:\\Data\\Programs\\Emulators\\BizHawk\\Lua\\N64\\";

local cLeft = 0x1EF6BD;
local cDown = 0x1EF6BE;
local cRight = 0x1EF6BF;

local firstLine = 110;
local spacing = 12;

--Misc variables declared here to avoid memory realocation.
local x, y, hour, decimalMinutes;


--Init stuff.
local function init()
	console.clear();
	
	dofile(luaPath.."MM_Commons.lua");
	dofile(luaPath.."MM_MovementLibrary.lua");
	dofile(luaPath.."MM_Form_AdvancedWatch.lua");
	dofile(luaPath.."MM_Form_AdvancedControl.lua");
	dofile(luaPath.."ContextualUI.lua");
	
	forms.destroyall();

	AdditionalWindows.Watches.Init();
	AdditionalWindows.AdvancedConrols.Init();
end

--Display coords
local function coord()
	gui.text(0, firstLine, string.format("X-position: %.2f", memory.readfloat(MM.Watch.Link.X, true)), _, _, "topright");
	gui.text(0, firstLine + spacing, string.format("Y-position: %.2f", memory.readfloat(MM.Watch.Link.Y, true)), _, _, "topright");
	gui.text(0, firstLine + spacing * 2, string.format("Z-position: %.2f", memory.readfloat(MM.Watch.Link.Z, true)), _, _, "topright");
	gui.text(0, firstLine + spacing * 3, string.format("Rotation: %.2f°", MM.Helper.Z64AngleToDegree(memory.read_u16_be(MM.Watch.Link.YRotation))), _, _, "topright");
end

--Display Link Velocity
local function speed()
	gui.text(0, firstLine + spacing * 4, string.format("Velocity: %.2f", memory.readfloat(MM.Watch.Link.Velocity, true)), _, _, "topright");
end

--Display accurate IG clock
local function clockDisplay()
	hour = math.floor(memory.read_u16_be(MM.Watch.Status.IgTime) * MM.Helper.Constant.OneGameSecond / 3600);
	decimalMinutes = (memory.read_u16_be(MM.Watch.Status.IgTime) * MM.Helper.Constant.OneGameSecond / 3600) - hour;
	gui.text(client.screenwidth() / 2.6, 3, string.format("%02.0f:%02.0f:%02.0f (day %i)", hour, math.floor(decimalMinutes * 60), (decimalMinutes * 60 - math.floor(decimalMinutes * 60)) * 60, memory.readbyte(MM.Watch.Status.CurrentDay)), _, _, "bottomleft");
end

--Display Items
local function items()
	if(memory.read_s16_be(MM.Watch.Inventory.Quests.HeartContainer) > 161) then
		gui.text(20, firstLine - 20, memory.readbyte(MM.Watch.Link.MagicAmount));
	else
		gui.text(20, firstLine - 35, memory.readbyte(MM.Watch.Link.MagicAmount));
	end
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
	gui.clearGraphics();
	ui();
	AdditionalWindows.Watches.Refresh();
	AdditionalWindows.AdvancedConrols.Refresh();
	ContextualUI.Refresh();
	emu.yield();
end