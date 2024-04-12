-- Info.lua

-- Provides the gPluginInfo - the standard plugin information metadata





gPluginInfo =
{
	Description =
[[
Plugin for the [Cuberite](https://cuberite.org) Minecraft server that implements commands useful when using
Cuberite within a classroom. These allow for quick actions when "herding the cats", as students usually are.
]],
	Commands =
	{
		["/allgm"] =
		{
			Handler = handleAllGm,
			HelpString = "Sets the gamemode for all other players in this world",
			Permission = "Classroom.Admin.AllGm",
			ParameterCombinations =
			{
				{
					Params = "gamemode",
				}
			},  -- ParameterCombinations
		},  -- "/allgm"

		["/alltome"] =
		{
			Handler = handleAllToMe,
			HelpString = "Teleports all other players in this world to a circle centered around you",
			Permission = "Classroom.Admin.AllToMe",
		},  -- "/alltome"

		["/killentities"] =
		{
			Alias = {"/ke"},
			Handler = handleKillEntities,
			HelpString = "Kills all entities of the specified kind in all the loaded chunks",
			Permission = "Classroom.Admin.KillEntities",
			ParameterCombinations =
			{
				{
					Params = "kind",
				}
			},  -- ParameterCombinations
		},  -- "/killentities"
	},  -- Commands
}
