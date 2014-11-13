local skutullaCode1stByte = 0x1F0665;
local bombersCode1stByte = 0x1F066B;

local xPosition = 0x3FFDD4;
local yPosition = 0x3FFDD8;
local zPosition = 0x3FFDDC;

local igTime = 0x1EF67C;

local oneSecond = 86400 / 65535; --Number of real seconds / IG seconds. FF FF (65535) is midnight
local firstLine = 110;
local spacing = 12;

local bombersCode = "";
local skulltullaCode = {};

--Init stuff. this can be called once
local function init()
	for i = 0, 5 do
		skulltullaCode[i] = memory.readbyte(skutullaCode1stByte + i);
	end
	
	bombersCode = "";
	for i = 0, 4 do
		bombersCode = string.format("%s%s", bombersCode, memory.readbyte(bombersCode1stByte + i));
	end
end

--Display several codes
local function codes()
	local color = "white";
	local tab = "";
	local jumpCount = 0;
	
	gui.text(0, firstLine, string.format("Bombers Code: %s", bombersCode));	
	for i = 0, 5 do		
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
		gui.text(250 + i * 20, firstLine + spacing, string.format("%s%i", tab, skulltullaCode[i]), _, color);
	end
	gui.text(0, firstLine + spacing, string.format("Skulltula Code (%s jumps):", jumpCount));
end

--Display coords
local function coord()
	gui.text(0, firstLine, string.format("X-position: %.3f", memory.readfloat(xPosition, true)), _, _, "topright");
	gui.text(0, firstLine + spacing, string.format("Y-position: %.3f", memory.readfloat(yPosition, true)), _, _, "topright");
	gui.text(0, firstLine + spacing * 2, string.format("Z-position: %.3f", memory.readfloat(zPosition, true)), _, _, "topright");
end

--Display accurate IG clock
local function clockDisplay()
	local hour = math.floor(memory.read_u16_be(igTime) * oneSecond / 3600);
	local decimalMinutes = (memory.read_u16_be(igTime) * oneSecond / 3600) - hour;
	gui.text(300, 3, string.format("%.0f:%.0f", hour, decimalMinutes * 60), _, _, "bottomleft");
end

--General UI call
local function ui()
	--init();
	codes();
	coord();
	clockDisplay();
end

init();

--Main loop
while true do
	--init();
	ui();
	emu.frameadvance();
end