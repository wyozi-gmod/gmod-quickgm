include( 'player_class/player_gmbp.lua' )

local basefol = GM.FolderName.."/gamemode/gm-modules/"

local function LoadModuleFolder(modulenm)

	local full_folder = basefol .. modulenm .. "/"

	local files, folders = file.Find(full_folder .. "*", "LUA")

	-- Uncommenting lines after will enable recursivity. Unrequired at this point and might interrupt with item systems etc
	--for _, ifolder in pairs(folders) do
	--	LoadModuleFolder(modulenm .. "/" .. ifolder .. "/")
	--end

	for _, shfile in pairs(file.Find(full_folder .. "sh_*.lua", "LUA")) do
		if SERVER then AddCSLuaFile(full_folder .. shfile) end
		include(full_folder .. shfile)
		gmbp.PersistLog("Loading sh module " .. shfile)
	end

	if SERVER then
		for _, svfile in pairs(file.Find(full_folder .. "sv_*.lua", "LUA")) do
			include(full_folder .. svfile)
			gmbp.PersistLog("Loading sv module " .. svfile)
		end
	end

	for _, clfile in pairs(file.Find(full_folder .. "cl_*.lua", "LUA")) do
		if SERVER then AddCSLuaFile(full_folder .. clfile) end
		if CLIENT then include(full_folder .. clfile) end
		gmbp.PersistLog("Loading cl module " .. clfile)
	end

end

local function LoadModules()

	local _, folders = file.Find(basefol .. "*", "LUA")

	for _, ifolder in pairs(folders) do
		MsgN("Loading module folder " .. ifolder)
		LoadModuleFolder(ifolder)
	end

end

GM.Name = "Example Gamemode"
GM.Author = "Wyozi"

local is_debug = CreateConVar("gmbp_debug", "0", FCVAR_ARCHIVE)

gmbp = gmbp or {}
function gmbp.Debug(...)
	if not is_debug:GetBool() then return end
	print("[GMBP-DEBUG] ", ...)
end
function gmbp.IsDebug() return is_debug:GetBool() end

function gmbp.PersistLog(msg)
	if not is_debug:GetBool() then return end

	local f = file.Open("gmbplog" .. tostring(SERVER and "_sv" or "_cl") .. ".txt", "a", "DATA")
	f:Write(msg .. "\n")
	f:Close()
end