if not core.get_modpath("mcl_inventory") then

if eqp_accessories.settings.preset == 1 then
	eqp_accessories.RegisterInvSlot({slotID="shield",slotIcon="eq_acc_slot_shield.png"})
end


local function ShieldRDC(a,b)
if eqp_accessories.settings.defType==1 then
	return a
else
	return b
end
end


core.register_tool("equippable_accessories:bronze_shield", {
	description = ("Bronze Shield"),
	inventory_image = "accessories_bronze_shield_inv.png",
	groups = {shield = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 384,
		equipSlots = {["shield"]=1},
		stats = {["attack"]={add=4},["reduction"]={add=ShieldRDC(1.0,10)}},
		visual = {
	["Arm_Left"]={mesh = "simple_layered_shield.b3d",size={x=2.0,y=2.0},textures = {"accessories_bronze_shield.png"},overlay = {"accessories_bronze_shield_overlay.png"},position = {x=1.375,y=3.875,z=1.5},rotation={x=-5,y=175,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:bronze_shield",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", ""},
		{"default:bronze_ingot", "group:stick", "default:bronze_ingot"},
		{"", "default:bronze_ingot", "default:bronze_ingot"},
	}
})


core.register_tool("equippable_accessories:steel_shield", {
	description = ("Steel Shield"),
	inventory_image = "accessories_steel_shield_inv.png",
	groups = {shield = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 512,
		equipSlots = {["shield"]=1},
		stats = {["reduction"]={add=ShieldRDC(1.5,18)}},
		visual = {
	["Arm_Left"]={mesh = "simple_layered_shield.b3d",size={x=2.0,y=2.0},textures = {"accessories_steel_shield.png"},overlay = {"accessories_steel_shield_overlay.png"},position = {x=1.375,y=3.875,z=1.5},rotation={x=-5,y=175,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:steel_shield",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "group:stick", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
	}
})


core.register_tool("equippable_accessories:skull_shield", {
	description = ("Skull Shield"),
	inventory_image = "accessories_skull_shield_inv.png",
	groups = {shield = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 1024,
		equipSlots = {["shield"]=1},
		stats = {["reduction"]={add=ShieldRDC(2.5,25)}},
		visual = {
	["Arm_Left"]={mesh = "simple_layered_shield.b3d",size={x=2.0,y=2.0},textures = {"accessories_skull_shield.png"},overlay = {"accessories_skull_shield_overlay.png"},position = {x=1.375,y=3.875,z=1.5},rotation={x=-5,y=175,z=180}},
			},	
	},
})

core.register_tool("equippable_accessories:obsidian_shield", {
	description = ("Obsidian Shield"),
	inventory_image = "accessories_obsidian_shield_inv.png",
	groups = {shield = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 1536,
		equipSlots = {["shield"]=1},
		stats = {["FireRes"]={add=4},["reduction"]={add=ShieldRDC(3.0,27.5)}},
		visual = {
	["Arm_Left"]={mesh = "simple_layered_shield.b3d",size={x=2.0,y=2.0},textures = {"accessories_obsidian_shield.png"},overlay = {"accessories_obsidian_shield_overlay.png"},position = {x=1.375,y=3.875,z=1.5},rotation={x=-5,y=175,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:obsidian_shield",
	recipe = {
		{"default:obsidian", "default:diamond", "default:obsidian"},
		{"default:mese", "equippable_accessories:skull_shield", "default:mese"},
		{"", "default:obsidian", ""},
	}
})

if core.get_modpath("basic_materials") then
core.register_tool("equippable_accessories:brass_shield", {
	description = ("Brass Shield"),
	inventory_image = "accessories_brass_shield_inv.png",
	groups = {shield = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 480,
		equipSlots = {["shield"]=1},
		stats = {["attack"]={add=4},["reduction"]={add=ShieldRDC(1.0,12)}},
		visual = {
	["Arm_Left"]={mesh = "simple_layered_shield.b3d",size={x=2.0,y=2.0},textures = {"accessories_brass_shield.png"},overlay = {"accessories_brass_shield_overlay.png"},position = {x=1.375,y=3.875,z=1.5},rotation={x=-5,y=175,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:brass_shield",
	recipe = {
		{"basic_materials:brass_ingot", "basic_materials:brass_ingot", ""},
		{"basic_materials:brass_ingot", "group:stick", "basic_materials:brass_ingot"},
		{"", "basic_materials:brass_ingot", "basic_materials:brass_ingot"},
	}
})
end


core.register_tool("equippable_accessories:enchanted_stone_shield", {
	description = ("Enchanted Stone Shield"),
	inventory_image = "accessories_enchanted_stone_shield_inv.png",
	groups = {shield = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 1440,
		equipSlots = {["shield"]=1},
		stats = {["attack"]={add=7},["reduction"]={add=ShieldRDC(3.5,30)}},
		visual = {
	["Arm_Left"]={mesh = "simple_layered_shield.b3d",size={x=2.0,y=2.0},textures = {"accessories_enchanted_stone_shield.png"},overlay = {"accessories_enchanted_stone_shield_overlay.png"},position = {x=1.375,y=3.875,z=1.5},rotation={x=-5,y=175,z=180},glow=4},
			},	
	},
})
table.insert(eqp_accessories.treasureTab["uncommon"],"equippable_accessories:enchanted_stone_shield")

end