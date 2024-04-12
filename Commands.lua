-- Commands.lua

-- Implements the command handlers for the in-game commands





--- Map of lowercase kind (as given by the user in the /killentities command) to the Cuberite EMobType enum
local gKindToMonsterType =
{
	["bat"] = mtBat,
	["blaze"] = mtBlaze,
	["caveSpider"] = mtCaveSpider,
	["chicken"] = mtChicken,
	["cow"] = mtCow,
	["creeper"] = mtCreeper,
	["enderDragon"] = mtEnderDragon,
	["enderman"] = mtEnderman,
	["ghast"] = mtGhast,
	["giant"] = mtGiant,
	["guardian"] = mtGuardian,
	["horse"] = mtHorse,
	["ironGolem"] = mtIronGolem,
	["magmaCube"] = mtMagmaCube,
	["mooshroom"] = mtMooshroom,
	["ocelot"] = mtOcelot,
	["pig"] = mtPig,
	["piglin"] = mtPiglin,
	["piglinBrute"] = mtPiglinBrute,
	["rabbit"] = mtRabbit,
	["sheep"] = mtSheep,
	["silverfish"] = mtSilverfish,
	["skeleton"] = mtSkeleton,
	["skeletonHorse"] = mtSkeletonHorse,
	["slime"] = mtSlime,
	["snowGolem"] = mtSnowGolem,
	["spider"] = mtSpider,
	["squid"] = mtSquid,
	["villager"] = mtVillager,
	["witch"] = mtWitch,
	["wither"] = mtWither,
	["witherSkeleton"] = mtWitherSkeleton,
	["wolf"] = mtWolf,
	["zombie"] = mtZombie,
	["zombieHorse"] = mtZombieHorse,
	["zombiePigman"] = mtZombiePigman,
	["zombieVillager"] = mtZombieVillager,
}





--- Map of lowercase gamemode (as given to the /allgm command) to the Cuberite EGameMode enum
local gGameModeToGM =
{
	["0"] = gmSurvival,
	["1"] = gmCreative,
	["2"] = gmAdventure,
	["3"] = gmSpectator,
	survival = gmSurvival,
	creative = gmCreative,
	adventure = gmAdventure,
	spectator = gmSpectator,
}





--- Handler for the "/killentities" command
-- Command usage: "/killentities <kind>"
function handleKillEntities(aSplit, aPlayer)
	if not(aSplit[2]) then
		-- Kill everything but players:
		local numKilled = 0
		aPlayer:GetWorld():ForEachEntity(
			function (aCBEntity)
				if not(aCBEntity:IsPlayer()) then
					aCBEntity:Destroy()
					numKilled = numKilled + 1
				end
			end
		)
		aPlayer:SendMessageSuccess(string.format("Killed %d entities", numKilled))
		return true
	end

	-- Convert the given kind to a mob type:
	local mobType = gKindToMonsterType[string.lower(aSplit[2])]
	if not(mobType) then
		aPlayer:SendMessageFailure(string.format("Unknown entity monster kind: '%s'", aSplit[2]))
		return true
	end

	-- Kill everything of the specified mob type
	local numKilled = 0
	aPlayer:GetWorld():ForEachEntity(
		function (aCBEntity)
			if not(aCBEntity:IsMob()) then
				return
			end
			if (aCBEntity:GetMobType() ~= mobType) then
				return
			end
			aCBEntity:Destroy()
			numKilled = numKilled + 1
		end
	)
	aPlayer:SendMessageSuccess(string.format("Killed %d entities", numKilled))
	return true
end





--- Handler for the "/alltome" command
function handleAllToMe(aSplit, aPlayer)
	local world = aPlayer:GetWorld()

	-- Get the number of players in this world:
	local numPlayers = 0
	world:ForEachPlayer(
		function()
			numPlayers = numPlayers + 1
		end
	)
	numPlayers = numPlayers - 1  -- exclude aPlayer

	-- Teleport each player except aPlayer:
	local centerPos = aPlayer:GetPosition()
	local twopi = 2 * math.pi
	local idx = 0
	world:ForEachPlayer(
		function (aCBPlayer)
			if (aCBPlayer == aPlayer) then
				return
			end
			local x = centerPos.x + math.sin(twopi * idx / numPlayers)
			local z = centerPos.z + math.cos(twopi * idx / numPlayers)
			aCBPlayer:TeleportToCoords(x, centerPos.y, z)
			idx = idx + 1
		end
	)

	return true
end





--- Handler for the "/allgm" command
-- Usage: "/allgm <gamemode>"
function handleAllGm(aSplit, aPlayer)
	-- Check the param:
	local gm = gGameModeToGM[string.lower(aSplit[2])]
	if not(gm) then
		aPlayer:SendMessageFailure(string.format("Unknown gamemode: '%s'", aSplit[2]))
		return true
	end

	-- Set the gamemode:
	aPlayer:GetWorld():ForEachPlayer(
		function (aCBPlayer)
			if (aCBPlayer == aPlayer) then
				return
			end
			aCBPlayer:SetGameMode(gm)
		end
	)
	aPlayer:SendMessageSuccess("All gamemodes set")
	return true
end