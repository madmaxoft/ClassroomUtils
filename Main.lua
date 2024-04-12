-- Main.lua

-- Implements the main entrypoint to the plugin





function Initialize(aPlugin)
	-- Load the InfoReg library file for registering the Info.lua command table:
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")

	-- Register commands:
	RegisterPluginInfoCommands(gPluginInfo)
	RegisterPluginInfoConsoleCommands(gPluginInfo)
	LOG("Initialized")
	return true
end
