	eqp_accessories.FalseArmorSlots = {
		["helmet"] = "helmet",
		["breastplate"] = "breastplate",
		["leggings"] = "leggings",
	}


if not eqp_accessories.settings.UseArmor then
	if eqp_accessories.settings.preset <= 3 then
	eqp_accessories.RegisterInvSlot({slotID="hat",slotIcon="eq_acc_slot_helmet_vanity.png"})
	eqp_accessories.RegisterInvSlot({slotID="shirt",slotIcon="eq_acc_slot_breastplate_vanity.png"})
	eqp_accessories.RegisterInvSlot({slotID="pants",slotIcon="eq_acc_slot_leggings_vanity.png"})
	end

	eqp_accessories.FalseArmorSlots["helmet"] = "hat"
	eqp_accessories.FalseArmorSlots["breastplate"] = "shirt"
	eqp_accessories.FalseArmorSlots["leggings"] = "pants"
end

local craftMat = eqp_accessories.craftMaterials
local eSlot = eqp_accessories.FalseArmorSlots

---
--- Miner set
---

core.register_tool("equippable_accessories:mining_helmet", {
	description = ("Miner's Headlamp"),
	inventory_image = "accessories_mining_helmet_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 800,
		extraAccDesc = core.colorize("#00ff88","Provides light in your looking direction"),
		OnEquip = function(player,reason) 
			local name = player:get_player_name()
			if eqp_accessories.plrTempData[name] == nil then eqp_accessories.plrTempData[name] = {} end
			eqp_accessories.plrTempData[name].lastLightCast = os.clock()
			eqp_accessories.AddPlayerStep(player,"CastLight",function(player,dtime)	eqp_accessories.LightCast(player) end)
		end,
		OnUnEquip = function(player,reason) 
			eqp_accessories.RemovePlayerStep(player,"CastLight")
		end,
		equipSlots = {[eSlot["helmet"]]=1},
		stats = {["defense"]={add=3},["digSpeed"]={add=15}},
		visual = {
	["Head"]={mesh = "accessory_mining_helmet.b3d",size={x=2.5,y=2.5},textures = {"accessories_mining_helmet.png"},overlay = {"accessories_mining_helmet_overlay.png"},position = {x=0,y=2.5,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})

core.register_tool("equippable_accessories:safety_vest", {
	description = ("Safety vest"),
	inventory_image = "accessories_safety_vest_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 480,
		equipSlots = {[eSlot["breastplate"]]=1},
		stats = {["dodge"]={add=3},["digSpeed"]={add=10}},
		visual = {
	["Body"]={mesh = "simple_body.obj",size={x=10.5,y=9.0},textures = {"accessories_safety_vest.png"},overlay = {"accessories_safety_vest_overlay.png"},position = {x=0,y=1.5,z=0},rotation={x=0,y=180,z=0},glow=3},
			},	
	},
})

core.register_tool("equippable_accessories:overalls", {
	description = ("Miner's Overalls"),
	inventory_image = "accessories_overalls_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 640,
		equipSlots = {[eSlot["leggings"]]=1},
		stats = {["defense"]={add=2},["digSpeed"]={add=15}},
		visual = {
	["Leg_Left"]={mesh = "simple_hand.obj",size={x=9.125,y=9.125},textures = {"accessories_overalls_leg.png"},position = {x=0,y=4.75,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "simple_hand.obj",size={x=9.125,y=9.125},textures = {"accessories_overalls_leg.png"},position = {x=0,y=4.75,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "simple_body.obj",size={x=10.25,y=9.5},textures = {"accessories_overalls_top.png"},position = {x=0,y=1.5,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})

core.register_craft({
	output = "equippable_accessories:mining_helmet",
	recipe = {
		{craftMat.gold, craftMat.meseLamp, craftMat.gold},
		{craftMat.gold, craftMat.meseLamp, craftMat.gold},
	}
})
core.register_craft({
	output = "equippable_accessories:safety_vest",
	recipe = {
		{craftMat.wool.."orange", "", craftMat.wool.."orange"},
		{craftMat.meseFrag, craftMat.wool.."white", craftMat.meseFrag},
		{craftMat.wool.."orange", craftMat.wool.."orange", craftMat.wool.."orange"},
	}
})
core.register_craft({
	output = "equippable_accessories:overalls",
	recipe = {
		{craftMat.string, craftMat.wool.."blue", craftMat.string},
		{craftMat.wool.."blue", craftMat.wool.."blue", craftMat.wool.."blue"},
		{craftMat.wool.."blue", "", craftMat.wool.."blue"},
	}
})

---
--- Santa's set
---

core.register_tool("equippable_accessories:santa_hat", {
	description = ("Santa's hat"),
	inventory_image = "accessories_santa_hat_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 384,
		equipSlots = {[eSlot["helmet"]]=1},
		stats = {["max_hp"]={add=2},["defense"]={add=1}},
		visual = {
	["Head"]={mesh = "accessory_santa_hat.obj",size={x=9.5,y=9.5},textures = {"accessories_santa_hat.png"},overlay = {"accessories_santa_hat_overlay.png"},position = {x=0,y=1.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})

core.register_tool("equippable_accessories:santa_robe", {
	description = ("Santa's robe"),
	inventory_image = "accessories_santa_robe_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 576,
		equipSlots = {[eSlot["breastplate"]]=1},
		stats = {["max_hp"]={add=4},["defense"]={add=1}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_santa_arm.png"},overlay = {"accessories_santa_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_santa_arm.png"},overlay = {"accessories_santa_arm_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "accessories_long_body.obj",size={x=11.25,y=10.0},textures = {"accessories_santa_robe.png"},overlay = {"accessories_santa_robe_overlay.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:santa_pants", {
	description = ("Santa's Pants"),
	inventory_image = "accessories_santa_pants_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 480,
		equipSlots = {[eSlot["leggings"]]=1},
		stats = {["max_hp"]={add=2},["defense"]={add=1}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.125,y=8.5},textures = {"accessories_santa_arm.png"},overlay = {"accessories_santa_arm_overlay.png"},position = {x=0,y=4.5,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.125,y=8.5},textures = {"accessories_santa_arm.png"},overlay = {"accessories_santa_arm_overlay.png"},position = {x=0,y=4.5,z=0},rotation={x=0,y=0,z=180}},
			},	
	},
})

core.register_craft({
	output = "equippable_accessories:santa_hat",
	recipe = {
		{"", craftMat.wool.."red", craftMat.wool.."white"},
		{craftMat.wool.."red", craftMat.wool.."red", ""},
		{craftMat.wool.."white",craftMat.wool.."white",""},
	}
})
core.register_craft({
	output = "equippable_accessories:santa_robe",
	recipe = {
		{craftMat.wool.."red", craftMat.wool.."white", craftMat.wool.."red"},
		{craftMat.wool.."red", craftMat.wool.."white", craftMat.wool.."red"},
		{craftMat.wool.."white", craftMat.gold, craftMat.wool.."white"},
	}
})
core.register_craft({
	output = "equippable_accessories:santa_pants",
	recipe = {
		{craftMat.wool.."red", craftMat.wool.."red", craftMat.wool.."red"},
		{craftMat.wool.."red", "", craftMat.wool.."red"},
		{craftMat.wool.."white", "", craftMat.wool.."white"},
	}
})

---
--- IS THIS A F***ING JoJo REFFERENCE?!!?
---

core.register_tool("equippable_accessories:menacing_student_hat", {
	description = ("Menacing student hat"),
	inventory_image = "accessories_JoJo_hat_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 256,
		equipSlots = {[eSlot["helmet"]]=1},
		stats = {["defense"]={add=2},["attack"]={add=11}},
		visual = {
	["Head"]={mesh = "accessory_cap.b3d",size={x=2.5,y=2.5},textures = {"accessories_JoJo_hat.png"},overlay = {"accessories_JoJo_hat_overlay.png"},position = {x=0,y=3.5,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:menacing_student_jacket", {
	description = ("Menacing student jacket"),
	inventory_image = "accessories_JoJo_shirt_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 384,
		equipSlots = {[eSlot["breastplate"]]=1},
		stats = {["defense"]={add=3},["attack"]={add=5}},
		visual = {
	["Arm_Left"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_JoJo_arm_a.png"},overlay = {"accessories_JoJo_arm_a_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Arm_Right"]={mesh = "double_hand.obj",size={x=9.25,y=9.25},textures = {"accessories_JoJo_arm_b.png"},overlay = {"accessories_JoJo_arm_b_overlay.png"},position = {x=0,y=3.875,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "double_body.obj",size={x=9.875,y=11.25},textures = {"accessories_JoJo_shirt.png"},overlay = {"accessories_JoJo_shirt_overlay.png"},position = {x=0,y=0.25,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:menacing_student_pants", {
	description = ("Menacing Student Pants"),
	inventory_image = "accessories_JoJo_pants_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 320,
		equipSlots = {[eSlot["leggings"]]=1},
		stats = {["defense"]={add=2},["attack"]={add=4}},
		visual = {
	["Leg_Left"]={mesh = "double_hand.obj",size={x=9.125,y=8.5},textures = {"accessories_JoJo_leg.png"},position = {x=0,y=4.5,z=0},rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "double_hand.obj",size={x=9.125,y=8.5},textures = {"accessories_JoJo_leg.png"},position = {x=0,y=4.5,z=0},rotation={x=0,y=0,z=180}},
	["Body"]={mesh = "simple_body.obj",size={x=9.5,y=9.5},textures = {"accessories_JoJo_pants_up.png"},overlay = {"accessories_JoJo_pants_up_overlay.png"},position = {x=0,y=1.825,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_craft({
	output = "equippable_accessories:menacing_student_hat",
	recipe = {
		{craftMat.gold, craftMat.wool.."black", craftMat.wool.."black"},
		{craftMat.wool.."black", craftMat.wool.."black", craftMat.wool.."black"},
		{"", craftMat.gold, ""},
	}
})
core.register_craft({
	output = "equippable_accessories:menacing_student_jacket",
	recipe = {
		{craftMat.wool.."black", craftMat.gold, craftMat.wool.."black"},
		{craftMat.wool.."black", craftMat.wool.."black", craftMat.gold},
		{craftMat.wool.."black", craftMat.wool.."black", craftMat.wool.."black"},
	}
})
core.register_craft({
	output = "equippable_accessories:menacing_student_pants",
	recipe = {
		{craftMat.wool.."blue", craftMat.wool.."yellow", craftMat.wool.."red"},
		{craftMat.wool.."black", "", craftMat.wool.."black"},
		{craftMat.wool.."black", "", craftMat.wool.."black"},
	}
})

---
--- misc
---


core.register_tool("equippable_accessories:white_baseball_cap", {
	description = ("White Baseball Cap"),
	inventory_image = "accessories_white_baseball_cap_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 256,
		equipSlots = {[eSlot["helmet"]]=1},
		stats = {["defense"]={add=1},["speed"]={add=0.05}},
		visual = {
	["Head"]={mesh = "accessory_cap.b3d",size={x=2.5,y=2.5},textures = {"accessories_white_baseball_cap.png"},position = {x=0,y=3.75,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:white_baseball_cap_back", {
	description = ("White Backwards Baseball Cap"),
	inventory_image = "accessories_white_baseball_cap_back_inv.png",
	groups = {equipment = 1,eqp_acc_armor = 1,accessory = 1,tool = 1},
	equipParams = {
		durability = 256,
		equipSlots = {[eSlot["helmet"]]=1},
		stats = {["defense"]={add=1},["speed"]={add=0.05}},
		visual = {
	["Head"]={mesh = "accessory_cap.b3d",size={x=2.5,y=2.5},textures = {"accessories_white_baseball_cap.png"},position = {x=0,y=3.75,z=0},rotation={x=0,y=0,z=0}},
			},	
	},
})

core.register_craft({
	output = "equippable_accessories:white_baseball_cap",
	recipe = {
		{"", craftMat.wool.."white", craftMat.wool.."white"},
		{craftMat.wool.."white", craftMat.wool.."white", craftMat.wool.."white"},
		{"", "", ""},
	}
})
core.register_craft({
	output = "equippable_accessories:white_baseball_cap_back",
	recipe = {
		{craftMat.wool.."white", craftMat.wool.."white",""},
		{craftMat.wool.."white", craftMat.wool.."white", craftMat.wool.."white"},
		{"", "", ""},
	}
})
