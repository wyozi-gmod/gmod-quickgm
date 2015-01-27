include( 'player_class/player.lua' )

local basefol = GM.FolderName.."/gamemode/gm-modules/"

local function LoadModuleFolder(modulenm)

	local full_folder = basefol
	if modulenm and modulenm ~= "" then
		full_folder = full_folder .. modulenm .. "/"
	end

	local files, folders = file.Find(full_folder .. "*", "LUA")

	-- Recursive file search
	for _, ifolder in pairs(folders) do
		LoadModuleFolder(modulenm .. "/" .. ifolder .. "/")
	end

	for _, shfile in pairs(file.Find(full_folder .. "sh_*.lua", "LUA")) do
		GM.Debug("Loading sh module " .. shfile)
		if SERVER then AddCSLuaFile(full_folder .. shfile) end
		include(full_folder .. shfile)
	end

	if SERVER then
		for _, svfile in pairs(file.Find(full_folder .. "sv_*.lua", "LUA")) do
			GM.Debug("Loading sv module " .. svfile)
			include(full_folder .. svfile)
		end
	end

	for _, clfile in pairs(file.Find(full_folder .. "cl_*.lua", "LUA")) do
		GM.Debug("Loading cl module " .. clfile)
		if SERVER then AddCSLuaFile(full_folder .. clfile) end
		if CLIENT then include(full_folder .. clfile) end
	end

end

GM.ShortName = "GMBASE"
GM.Name = "Gamemode Base"
GM.Author = "Wyozi"

GM.IsDebug = true

function GM.Debug(...)
	if not GM.IsDebug then return end
	MsgN("[" .. GM.ShortName .. " Debug] ", ...)
end
function GM.Log(...)
	MsgN("[" .. GM.ShortName .. "] ", ...)
end

LoadModuleFolder("")
