return {
	{
		"norcalli/nvim-colorizer.lua",
		cmd = {
			"ColorizerAttachToBuffer",
			"ColorizerToggle",
		},
		-- #661
    -- Blue
		config = function()
			require("colorizer").setup(nil, {names = false})
		end,
	},
}
