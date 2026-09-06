eqp_accessories.craftMaterials = {
	copper = "default:copper_ingot",
	steel = "default:steel_ingot",
	gold = "default:gold_ingot",
	wool = "wool:",
	diamond = "default:diamond",
	leather = "mobs:leather",
	string = "farming:string",
	paper = "default:paper",
	glassPane = "xpanes:pane_flat",
	dye = "dye:",
	obsidian = "default:obsidian",
	obsShard = "default:obsidian_shard",
	meseFrag = "default:mese_crystal_fragment",
	meseLamp = "default:meselamp",
	mese = "default:mese_crystal",
	steelBlock = "default:steelblock",
	meseBlock = "default:mese",
	diamondBlock = "default:diamondblock",
	bottle = "vessels:glass_bottle",
}

local crMats = eqp_accessories.craftMaterials

eqp_accessories.SilverIngots = {}
if core.get_modpath("silver") then
table.insert(eqp_accessories.SilverIngots,"silver:silver_ingot")
end
if core.get_modpath("moreores") then
table.insert(eqp_accessories.SilverIngots,"moreores:silver_ingot")
end


if core.get_modpath("mcl_copper") then
	crMats.copper = "mcl_copper:copper_ingot"
end
if core.get_modpath("mcl_core") then
	crMats.meseBlock = "mcl_nether:netherite_ingot"
	crMats.mese = "mcl_redstone_torch:redstoneblock"
	crMats.meseLamp = "mcl_nether:glowstone"
	crMats.steelBlock = "mcl_core:ironblock"
	crMats.diamondBlock = "mcl_core:diamondblock"
	crMats.steel = "mcl_core:iron_ingot"
	crMats.gold = "mcl_core:gold_ingot"
	crMats.diamond = "mcl_core:diamond"
	crMats.paper = "mcl_core:paper"
	crMats.meseFrag = "mcl_redstone:redstone"
	crMats.obsShard = "mcl_amethyst:amethyst_shard"
	crMats.obsidian = "mcl_core:obsidian"
	crMats.bottle = "mcl_potions:glass_bottle"
end
if core.get_modpath("mcl_wool") then
	crMats.wool = "mcl_wool:"
end
if core.get_modpath("mcl_mobitems") then
	crMats.string = "mcl_mobitems:string"
	crMats.leather = "mcl_mobitems:leather"
end
if core.get_modpath("mcl_panes") then
	crMats.glassPane = "mcl_panes:pane_natural_flat"
end
if core.get_modpath("mcl_dyes") then
	crMats.dye = "mcl_dyes:"
end