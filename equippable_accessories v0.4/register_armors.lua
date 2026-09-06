
if eqp_accessories.settings.UseArmor == true then




---
--- wooden
---

core.register_tool("equippable_accessories:wooden_helmet", {
	description = ("Wooden Helmet"),
	inventory_image = "accessories_wooden_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 96,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=1}},
		visual = {
	["Head"]={mesh = "simple_helmet_cuboid.obj",size={x=9.5,y=9.5},textures = {"accessories_wooden_helmet.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:wooden_armor", {
	description = ("Wooden Armor"),
	inventory_image = "accessories_wooden_armor_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 144,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=2}},
		visual = {
	["Body"]={mesh = "simple_body.obj",size={x=9.5,y=9.5},textures = {"accessories_wooden_armor.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:wooden_leggings", {
	description = ("Wooden Leggings"),
	inventory_image = "accessories_wooden_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 120,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=1}},
		visual = {
	["Leg_Left"]={mesh = "simple_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_wooden_leg.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "simple_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_wooden_leg.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:wooden_helmet",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
	}
})
core.register_craft({
	output = "equippable_accessories:wooden_armor",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})
core.register_craft({
	output = "equippable_accessories:wooden_leggings",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "", "group:wood"},
	}
})

---
--- cactus
---

local Cactus = "default:cactus"


---
--- Cactus
---

core.register_tool("equippable_accessories:cactus_helmet", {
	description = ("Cactus Helmet"),
	inventory_image = "accessories_cactus_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 96,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=1},["attack"]={add=2}},
		visual = {
	["Head"]={mesh = "simple_helmet_cuboid.obj",size={x=9.5,y=9.5},textures = {"accessories_cactus_helmet.png"},overlay = {"accessories_cactus_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:cactus_armor", {
	description = ("Cactus Armor"),
	inventory_image = "accessories_cactus_armor_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 144,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=2},["attack"]={add=3}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_cactus_arm.png"},overlay = {"accessories_cactus_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_cactus_arm.png"},overlay = {"accessories_cactus_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_cactus_armor.png"},overlay = {"accessories_cactus_armor_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:cactus_leggings", {
	description = ("Cactus Leggings"),
	inventory_image = "accessories_cactus_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 120,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=1},["attack"]={add=2}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_cactus_leg.png"},overlay = {"accessories_cactus_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_cactus_leg.png"},overlay = {"accessories_cactus_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:cactus_helmet",
	recipe = {
		{Cactus, Cactus, Cactus},
		{Cactus, "", Cactus},
	}
})
core.register_craft({
	output = "equippable_accessories:cactus_armor",
	recipe = {
		{Cactus, "", Cactus},
		{Cactus, Cactus, Cactus},
		{Cactus, Cactus, Cactus},
	}
})
core.register_craft({
	output = "equippable_accessories:cactus_leggings",
	recipe = {
		{Cactus, Cactus, Cactus},
		{Cactus, "", Cactus},
		{Cactus, "", Cactus},
	}
})


---
--- Copper
---

core.register_tool("equippable_accessories:copper_helmet", {
	description = ("Copper Helmet"),
	inventory_image = "accessories_copper_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 256,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=2}},
		visual = {
	["Head"]={mesh = "helmet_2.obj",size={x=9.5,y=9.5},textures = {"accessories_copper_helmet.png"},overlay = {"accessories_copper_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:copper_chainmail", {
	description = ("Copper Chainmail"),
	inventory_image = "accessories_copper_chainmail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 384,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=3}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_copper_l_arm.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_copper_r_arm.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_copper_chainmail.png"},overlay = {"accessories_copper_chainmail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:copper_leggings", {
	description = ("Copper Leggings"),
	inventory_image = "accessories_copper_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 320,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=2}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_copper_leg.png"},overlay = {"accessories_copper_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_copper_leg.png"},overlay = {"accessories_copper_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:copper_helmet",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:copper_chainmail",
	recipe = {
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:copper_leggings",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"},
		{"default:copper_ingot", "", "default:copper_ingot"},
	}
})

---
--- tin
---

core.register_tool("equippable_accessories:tin_helmet", {
	description = ("Tin Helmet"),
	inventory_image = "accessories_tin_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 288,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=3}},
		visual = {
	["Head"]={mesh = "helmet_2.obj",size={x=9.5,y=9.5},textures = {"accessories_tin_helmet.png"},overlay = {"accessories_tin_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:tin_chainmail", {
	description = ("Tin Chainmail"),
	inventory_image = "accessories_tin_chainmail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 432,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=3}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_tin_l_arm.png"},overlay = {"accessories_tin_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_tin_r_arm.png"},overlay = {"accessories_tin_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_tin_chainmail.png"},overlay = {"accessories_tin_chainmail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:tin_leggings", {
	description = ("Tin Leggings"),
	inventory_image = "accessories_tin_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 360,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=3}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_tin_leg.png"},overlay = {"accessories_tin_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_tin_leg.png"},overlay = {"accessories_tin_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:tin_helmet",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "", "default:tin_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:tin_chainmail",
	recipe = {
		{"default:tin_ingot", "", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:tin_leggings",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "", "default:tin_ingot"},
		{"default:tin_ingot", "", "default:tin_ingot"},
	}
})


---
--- bronze
---

core.register_tool("equippable_accessories:bronze_helmet", {
	description = ("Bronze Helmet"),
	inventory_image = "accessories_bronze_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 384,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=3},["attack"]={add=4}},
		visual = {
	["Head"]={mesh = "spartan_helmet.obj",size={x=9.5,y=9.5},textures = {"accessories_bronze_helmet.png"},overlay = {"accessories_bronze_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:bronze_scalemail", {
	description = ("Bronze Scalemail"),
	inventory_image = "accessories_bronze_scalemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 576,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=4},["attack"]={add=5}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_bronze_l_arm.png"},overlay = {"accessories_bronze_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_bronze_r_arm.png"},overlay = {"accessories_bronze_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_bronze_scalemail.png"},overlay = {"accessories_bronze_scalemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:bronze_leggings", {
	description = ("Bronze Leggings"),
	inventory_image = "accessories_bronze_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 480,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=3},["attack"]={add=4}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_bronze_leg.png"},overlay = {"accessories_bronze_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_bronze_leg.png"},overlay = {"accessories_bronze_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:bronze_helmet",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:bronze_scalemail",
	recipe = {
		{"default:bronze_ingot", "", "default:bronze_ingot"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:bronze_leggings",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
	}
})


---
--- Steel
---

core.register_tool("equippable_accessories:steel_helmet", {
	description = ("Steel Helmet"),
	inventory_image = "accessories_steel_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 512,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=4}},
		visual = {
	["Head"]={mesh = "simple_helmet_cuboid.obj",size={x=9.5,y=9.5},textures = {"accessories_steel_helmet.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:steel_scalemail", {
	description = ("Steel Scalemail"),
	inventory_image = "accessories_steel_scalemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 768,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=5}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_steel_l_arm.png"},overlay={"accessories_steel_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_steel_r_arm.png"},overlay={"accessories_steel_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_steel_scalemail.png"},overlay={"accessories_steel_scalemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:steel_leggings", {
	description = ("Steel Leggings"),
	inventory_image = "accessories_steel_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 640,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=4}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_steel_leg.png"},overlay={"accessories_steel_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_steel_leg.png"},overlay={"accessories_steel_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:steel_helmet",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:steel_scalemail",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:steel_leggings",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})

---
--- Gold
---

core.register_tool("equippable_accessories:golden_helmet", {
	description = ("Golden Helmet"),
	inventory_image = "accessories_golden_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 640,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=6}},
		visual = {
	["Head"]={mesh = "simple_winged_helmet.obj",size={x=9.5,y=9.5},textures = {"accessories_golden_helmet.png"},overlay = {"accessories_golden_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:golden_platemail", {
	description = ("Golden Platemail"),
	inventory_image = "accessories_golden_platemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 960,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=7}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_golden_l_arm.png"},overlay = {"accessories_golden_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_golden_r_arm.png"},overlay = {"accessories_golden_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_golden_platemail.png"},overlay = {"accessories_golden_platemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:golden_leggings", {
	description = ("Golden Leggings"),
	inventory_image = "accessories_golden_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 800,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=6}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_golden_leg.png"},overlay = {"accessories_golden_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_golden_leg.png"},overlay = {"accessories_golden_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:golden_helmet",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "", "default:gold_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:golden_platemail",
	recipe = {
		{"default:gold_ingot", "", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:golden_leggings",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "", "default:gold_ingot"},
		{"default:gold_ingot", "", "default:gold_ingot"},
	}
})






---
--- brass
---
if core.get_modpath("basic_materials") then
core.register_tool("equippable_accessories:brass_helmet", {
	description = ("Brass Helmet"),
	inventory_image = "accessories_brass_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 480,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=3},["attack"]={add=4}},
		visual = {
	["Head"]={mesh = "spartan_helmet.obj",size={x=9.5,y=9.5},textures = {"accessories_brass_helmet.png"},overlay = {"accessories_brass_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:brass_scalemail", {
	description = ("Brass Scalemail"),
	inventory_image = "accessories_brass_scalemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 720,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=4},["attack"]={add=4}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_brass_l_arm.png"},overlay = {"accessories_brass_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_brass_r_arm.png"},overlay = {"accessories_brass_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_brass_scalemail.png"},overlay = {"accessories_brass_scalemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:brass_leggings", {
	description = ("Brass Leggings"),
	inventory_image = "accessories_brass_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 600,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=3},["attack"]={add=4}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_brass_leg.png"},overlay = {"accessories_brass_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_brass_leg.png"},overlay = {"accessories_brass_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:brass_helmet",
	recipe = {
		{"basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot"},
		{"basic_materials:brass_ingot", "", "basic_materials:brass_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:brass_scalemail",
	recipe = {
		{"basic_materials:brass_ingot", "", "basic_materials:brass_ingot"},
		{"basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot"},
		{"basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:brass_leggings",
	recipe = {
		{"basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot"},
		{"basic_materials:brass_ingot", "", "basic_materials:brass_ingot"},
		{"basic_materials:brass_ingot", "", "basic_materials:brass_ingot"},
	}
})
end





if core.get_modpath("moreores") then
---
--- mithril
---
core.register_tool("equippable_accessories:mithril_helmet", {
	description = ("Mithril Helmet"),
	inventory_image = "accessories_mithril_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 2560,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=13},["max_hp"]={add=4}},
		visual = {
	["Head"]={mesh = "horned_helmet_1.obj",size={x=9.5,y=9.5},textures = {"accessories_mithril_helmet.png"},overlay = {"accessories_mithril_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:mithril_platemail", {
	description = ("Mithril Platemail"),
	inventory_image = "accessories_mithril_platemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 3840,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=16},["attack"]={add=7}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_mithril_l_arm.png"},overlay = {"accessories_mithril_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_mithril_r_arm.png"},overlay = {"accessories_mithril_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_mithril_platemail.png"},overlay = {"accessories_mithril_platemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:mithril_leggings", {
	description = ("Mithril Leggings"),
	inventory_image = "accessories_mithril_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 3200,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=11},["speed"]={add=0.15}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_mithril_leg.png"},overlay = {"accessories_mithril_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_mithril_leg.png"},overlay = {"accessories_mithril_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:mithril_helmet",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:mithril_platemail",
	recipe = {
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
	}
})
core.register_craft({
	output = "equippable_accessories:mithril_leggings",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
	}
})
end

local SilverIngots = eqp_accessories.SilverIngots
if core.get_modpath("silver") then
table.insert(SilverIngots,"silver:silver_ingot")
end
if core.get_modpath("moreores") then
table.insert(SilverIngots,"moreores:silver_ingot")
end

if #SilverIngots > 0 then
---
--- Silver
---
core.register_tool("equippable_accessories:silver_helmet", {
	description = ("Silver Helmet"),
	inventory_image = "accessories_silver_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 640,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=5}},
		visual = {
	["Head"]={mesh = "helmet_1.obj",size={x=9.5,y=9.5},textures = {"accessories_silver_helmet.png"},overlay = {"accessories_silver_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:silver_platemail", {
	description = ("Silver Platemail"),
	inventory_image = "accessories_silver_platemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 960,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=6}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_silver_l_arm.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_silver_r_arm.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_silver_platemail.png"},overlay = {"accessories_silver_platemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:silver_leggings", {
	description = ("Silver Leggings"),
	inventory_image = "accessories_silver_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 800,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=5}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_silver_leg.png"},overlay = {"accessories_silver_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_silver_leg.png"},overlay = {"accessories_silver_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
for _,agIngt in ipairs(SilverIngots) do
core.register_craft({
	output = "equippable_accessories:silver_helmet",
	recipe = {
		{agIngt, agIngt, agIngt},
		{agIngt, "", agIngt},
	}
})
core.register_craft({
	output = "equippable_accessories:silver_platemail",
	recipe = {
		{agIngt, "", agIngt},
		{agIngt, agIngt, agIngt},
		{agIngt, agIngt, agIngt},
	}
})
core.register_craft({
	output = "equippable_accessories:silver_leggings",
	recipe = {
		{agIngt, agIngt, agIngt},
		{agIngt, "", agIngt},
		{agIngt, "", agIngt},
	}
})
end
end


---
--- Dungeon
---

core.register_tool("equippable_accessories:dungeon_helmet", {
	description = ("Dungeon Warrior Helmet"),
	inventory_image = "accessories_dungeon_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 1920,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=10},["attack"]={add=8}},
		visual = {
	["Head"]={mesh = "horned_helmet_1.obj",size={x=9.5,y=9.5},textures = {"accessories_dungeon_helmet.png"},overlay = {"accessories_dungeon_helmet_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:dungeon_platemail", {
	description = ("Dungeon Warrior Platemail"),
	inventory_image = "accessories_dungeon_platemail_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 2880,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=12},["attack"]={add=11}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_dungeon_l_arm.png"},overlay = {"accessories_dungeon_l_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_dungeon_r_arm.png"},overlay = {"accessories_dungeon_r_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_dungeon_platemail.png"},overlay = {"accessories_dungeon_platemail_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:dungeon_leggings", {
	description = ("Dungeon Warrior Leggings"),
	inventory_image = "accessories_dungeon_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 2400,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=8},["attack"]={add=6}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_dungeon_leg.png"},overlay = {"accessories_dungeon_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_dungeon_leg.png"},overlay = {"accessories_dungeon_leg_overlay.png"},position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})


---
--- Molten
---

core.register_tool("equippable_accessories:molten_helmet", {
	description = ("Molten Helmet"),
	inventory_image = "accessories_molten_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 1920,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=12},["attack"]={add=9}},
		visual = {
	["Head"]={mesh = "horned_helmet_1.obj",size={x=9.5,y=9.5},textures = {"accessories_molten_helmet.png"},overlay = {"accessories_molten_helmet_overlay.png"},glow = 7,position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:molten_armor", {
	description = ("Molten Armor"),
	inventory_image = "accessories_molten_armor_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 2880,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=14},["attack"]={add=11}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_molten_arm.png"},overlay = {"accessories_molten_arm_overlay.png"},glow = 7,position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.75,y=9.75},textures = {"accessories_molten_arm.png"},overlay = {"accessories_molten_arm_overlay.png"},glow = 7,position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.5,y=9.5},textures = {"accessories_molten_armor.png"},overlay = {"accessories_molten_armor_overlay.png"},glow = 7,position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:molten_leggings", {
	description = ("Molten Leggings"),
	inventory_image = "accessories_molten_leggings_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		durability = 2400,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=9},["speed"]={add=0.15}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_molten_leg.png"},overlay = {"accessories_molten_leg_overlay.png"},glow = 7,position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_molten_leg.png"},overlay = {"accessories_molten_leg_overlay.png"},glow = 7,position = {x=0,y=5.0,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:molten_helmet",
	recipe = {
		{"bucket:bucket_lava", "default:mese", "bucket:bucket_lava"},
		{"default:obsidian", "", "default:obsidian"},
	}
})
core.register_craft({
	output = "equippable_accessories:molten_armor",
	recipe = {
		{"default:obsidian", "", "default:obsidian"},
		{"bucket:bucket_lava", "default:mese", "bucket:bucket_lava"},
		{"default:obsidian", "default:obsidian", "default:obsidian"},
	}
})
core.register_craft({
	output = "equippable_accessories:molten_leggings",
	recipe = {
		{"default:obsidian", "default:mese", "default:obsidian"},
		{"bucket:bucket_lava", "", "bucket:bucket_lava"},
		{"default:obsidian", "", "default:obsidian"},
	}
})

---
--- ancient
---

core.register_tool("equippable_accessories:ancient_hat", {
	description = ("Ancient Adventurerer's Hat"),
	inventory_image = "accessories_ancient_hat_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		extraAccDesc = core.colorize("#888888","Forgotten, yet oddly familiar..."),
		durability = 4096,
		equipSlots = {["helmet"]=1},
		stats = {["defense"]={add=3},["attack"]={add=15},["speed"]={add=0.05},["digSpeed"]={add=10}},
		visual = {
	["Head"]={mesh = "accessory_ancient_hat.obj",size={x=10.75,y=10.75},textures = {"accessories_ancient_hat.png"},position = {x=0,y=-1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:ancient_robe", {
	description = ("Ancient Adventurerer's Robe"),
	inventory_image = "accessories_ancient_robe_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1},
	equipParams = {
		extraAccDesc = core.colorize("#888888","Forgotten, yet oddly familiar..."),
		durability = 4096,
		equipSlots = {["breastplate"]=1},
		stats = {["defense"]={add=4},["attack"]={add=10},["speed"]={add=0.10},["digSpeed"]={add=10}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_ancient_robe_arm.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_ancient_robe_arm.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "accessories_long_body.obj",size={x=10.75,y=10.0},textures = {"accessories_ancient_robe.png"},overlay = {"accessories_ancient_robe_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
	["Head"]={mesh = "helmet_1.obj",size={x=8.5,y=8.5},textures = {"accessories_ancient_robe_hood.png"},position = {x=0,y=0.5,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:ancient_pants", {
	description = ("Ancient Adventurerer's Pants"),
	inventory_image = "accessories_ancient_pants_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,eqp_acc_armor = 1},
	equipParams = {
		extraAccDesc = core.colorize("#888888","Forgotten, yet oddly familiar..."),
		durability = 4096,
		equipSlots = {["leggings"]=1},
		stats = {["defense"]={add=3},["attack"]={add=5},["speed"]={add=0.15},["digSpeed"]={add=10}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=8.5,y=8.5},textures = {"accessories_ancient_robe_arm.png"},position = {x=0,y=4.5,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=8.5,y=8.5},textures = {"accessories_ancient_robe_arm.png"},position = {x=0,y=4.5,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})

if core.get_modpath("dungeon_loot") then
	dungeon_loot.register({
		{name = "equippable_accessories:ancient_hat", chance = 0.02, count = {1, 1}},
		{name = "equippable_accessories:ancient_robe", chance = 0.02, count = {1, 1}},
		{name = "equippable_accessories:ancient_pants", chance = 0.02, count = {1, 1}},
	})
end

end