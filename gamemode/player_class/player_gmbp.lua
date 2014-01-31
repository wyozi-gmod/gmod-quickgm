AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DisplayName	= "Player Class"

PLAYER.WalkSpeed = 200	-- How fast to move when not running
PLAYER.RunSpeed	= 300	-- How fast to move when running
PLAYER.CrouchedWalkSpeed = 0.2	-- Multiply move speed by this when crouching
PLAYER.DuckSpeed	= 0.3	-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed	= 0.3	-- How fast to go from ducking, to not ducking
PLAYER.JumpPower	= 120	-- How powerful our jump should be
PLAYER.CanUseFlashlight = true	-- Can we use the flashlight
PLAYER.MaxHealth	= 100	-- Max health we can have
PLAYER.StartHealth	= 100	-- How much health we start with
PLAYER.StartArmor	= 0	-- How much armour we start with
PLAYER.DropWeaponOnDie	= false	-- Do we drop our weapon when we die
PLAYER.TeammateNoCollide = true	-- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers	= false	-- Automatically swerves around other players

function PLAYER:SetupDataTables()
	BaseClass.SetupDataTables( self )
end

function PLAYER:Spawn()
	BaseClass.Spawn( self )
end

function PLAYER:Loadout()
end

player_manager.RegisterClass( "player_gmbp", PLAYER, "player_default" )