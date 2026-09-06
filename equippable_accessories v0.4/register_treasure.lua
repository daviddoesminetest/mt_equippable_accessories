local tresTab = eqp_accessories.treasureTab
eqp_accessories.tresStones = {"default:stone","group:stone","mcl_core:stone","mcl_nether:netherrack","mcl_deepslate:deepslate","mcl_blackstone:blackstone","mcl_blackstone:basalt"}

local MineCrapDepth = false
if core.get_modpath("mcl_core") then
	MineCrapDepth = true
end

function eqp_accessories.GiveTreasureAcc(player,rarity)
	local trTab =  eqp_accessories.treasureTab[rarity]
	if trTab then
		local gotten_acc = ItemStack({name = trTab[math.random(#trTab)]})
		local inv = player:get_inventory()
			if inv:room_for_item("main",gotten_acc) then
			inv:add_item("main",gotten_acc)
			else
			if player:get_pos() then core.add_item(player:get_pos(),gotten_acc) end
			end
	end
end

if #tresTab["common"] > 0 then
core.register_node("equippable_accessories:acc_chect_common", {
	description = ("Accessory Chest - Common \n" ..core.colorize("#00ff88","Use it to get 1 random common accessory \n").. "" ..(MineCrapDepth and core.colorize("#00aa66","can sometimes be found underground") or core.colorize("#00aa66","can sometimes be found 256 nodes deep underground") ).. ""),
	tiles = {
		"accessories_chest_common_top.png","accessories_chest_common_top.png",
		"accessories_chest_common_side.png","accessories_chest_common_side.png",
		"accessories_chest_common_side.png","accessories_chest_common_front.png"
	},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 3},
	sounds = eqp_accessories.sounds.wood(),
	on_use = function(itemstack, player, pointed_thing)
		eqp_accessories.GiveTreasureAcc(player,"common")
		itemstack:take_item()
		return itemstack
	end
})
	core.register_ore({
		ore_type       = "scatter",
		ore            = "equippable_accessories:acc_chect_common",
		wherein        = eqp_accessories.tresStones,
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 1,
		clust_size     = 1,
		y_max          = MineCrapDepth and -8 or -256,
		y_min          = MineCrapDepth and -28900 or -31000,
	})
end
if #tresTab["uncommon"] > 0 then
core.register_node("equippable_accessories:acc_chect_uncommon", {
	description = ("Accessory Chest - UnCommon \n" ..core.colorize("#00ff88","Use it to get 1 random common accessory \n").. "" ..(MineCrapDepth and core.colorize("#00aa66","can sometimes be found underground, at deepslate layer") or core.colorize("#00aa66","can sometimes be found 2048 nodes deep underground") ).. ""),
	tiles = {
		"accessories_chest_uncommon_top.png","accessories_chest_uncommon_top.png",
		"accessories_chest_uncommon_side.png","accessories_chest_uncommon_side.png",
		"accessories_chest_uncommon_side.png","accessories_chest_uncommon_front.png"
	},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 3},
	sounds = eqp_accessories.sounds.wood(),
	on_use = function(itemstack, player, pointed_thing)
		eqp_accessories.GiveTreasureAcc(player,"uncommon")
		itemstack:take_item()
		return itemstack
	end
})
	core.register_ore({
		ore_type       = "scatter",
		ore            = "equippable_accessories:acc_chect_uncommon",
		wherein        = eqp_accessories.tresStones,
		clust_scarcity = 40 * 40 * 40,
		clust_num_ores = 1,
		clust_size     = 1,
		y_max          = MineCrapDepth and -64 or -2048,
		y_min          = MineCrapDepth and -28900 or -31000,
	})
end
if #tresTab["rare"] > 0 then
core.register_node("equippable_accessories:acc_chect_rare", {
	description = ("Accessory Chest - rare \n" ..core.colorize("#00ff88","Use it to get 1 random common accessory \n").. "" ..(MineCrapDepth and core.colorize("#00aa66","can sometimes be found in the nether") or core.colorize("#00aa66","can sometimes be found 8192 nodes deep underground") ).. ""),
	tiles = {
		"accessories_chest_rare_top.png","accessories_chest_rare_top.png",
		"accessories_chest_rare_side.png","accessories_chest_rare_side.png",
		"accessories_chest_rare_side.png","accessories_chest_rare_front.png"
	},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 3},
	sounds = eqp_accessories.sounds.wood(),
	on_use = function(itemstack, player, pointed_thing)
		eqp_accessories.GiveTreasureAcc(player,"rare")
		itemstack:take_item()
		return itemstack
	end
})
	core.register_ore({
		ore_type       = "scatter",
		ore            = "equippable_accessories:acc_chect_rare",
		wherein        = eqp_accessories.tresStones,
		clust_scarcity = 48 * 48 * 48,
		clust_num_ores = 1,
		clust_size     = 1,
		y_max          = MineCrapDepth and -28900 or -8192,
		y_min          = -31000,
	})
end