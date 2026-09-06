local craftMat = eqp_accessories.craftMaterials
local SilverIngots = eqp_accessories.SilverIngots

local function ShieldRDC(a,b)
if eqp_accessories.settings.defType==1 then
	return a
else
	return b
end
end

eqp_accessories.CommonSizes = {
	boots = {size={x=11.0,y=11.0},position = {x=0,y=5.125,z=0}},
	ears_cat = {size={x=8.375,y=8.375},position = {x=0,y=3.625,z=0}},
	ears_bun = {size={x=8.375,y=8.375},position = {x=0,y=4.125,z=0}},
	gloves = {size={x=4.75,y=4.75},position = {x=0,y=3.5,z=0}},
	bracelet = {size={x=5.25,y=5.25},position = {x=0,y=2.0,z=0}},
	scarf = {size={x=9.75,y=9.75},position = {x=0,y=4.0,z=0}},
}

if core.get_modpath("3d_armor") then
	eqp_accessories.CommonSizes.boots = {size={x=12.125,y=11.25},position = {x=0,y=5.625,z=0}}
	eqp_accessories.CommonSizes.gloves = {size={x=5.0,y=5.0},position = {x=0,y=4.125,z=0}}
end
if core.get_modpath("mcl_core") then
	eqp_accessories.CommonSizes.ears_cat = {size={x=8.25,y=8.25},position = {x=0,y=3.125,z=0}}
	eqp_accessories.CommonSizes.ears_bun = {size={x=8.25,y=8.25},position = {x=0,y=3.625,z=0}}
	eqp_accessories.CommonSizes.gloves = {size={x=4.825,y=4.825},position = {x=0,y=3.75,z=0}}
	eqp_accessories.CommonSizes.boots = {size={x=12.125,y=11.25},position = {x=0,y=5.625,z=0}}
	eqp_accessories.CommonSizes.scarf = {size={x=9.75,y=9.75},position = {x=0,y=4.75,z=0}}
end


local sizes = eqp_accessories.CommonSizes



core.register_tool("equippable_accessories:hermes_boots", {
	description = ("Hermes boots"),
	inventory_image = "accessories_hermes_boots_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
	OnEquip = function(player,reason) 
		local name = player:get_player_name()
		if eqp_accessories.plrTempData[name].BootRunTime==nil then eqp_accessories.plrTempData[name].BootRunTime=0 end
		if eqp_accessories.plrTempData[name].LastBootPuff==nil then eqp_accessories.plrTempData[name].LastBootPuff=0 end
	eqp_accessories.AddPlayerStep(player,"BootRun",
	function(player,dtime)
		local name = player:get_player_name()
		local controls = player:get_player_control()
		local vel = player:get_velocity()
		local pos = player:get_pos()
		local plrTemp = eqp_accessories.plrTempData[name]
			if controls.up and vel and (math.abs(vel.x)+math.abs(vel.z)) > 2.0  then
				if plrTemp.BootRunTime < 6 then
					plrTemp.BootRunTime = plrTemp.BootRunTime + dtime
					eqp_accessories.AddTempSpeed(player,plrTemp.BootRunTime/2,"acc_boot_run")
				end
				if plrTemp.BootRunTime > 4 and pos and plrTemp.LastBootPuff<os.clock() then
					plrTemp.LastBootPuff = os.clock() + 0.125
					core.add_particle({
						pos = {x=pos.x + (math.random(-20,20)/20),y=pos.y + (math.random(15,20)/40),z=pos.z + (math.random(-20,20)/20) },
						velocity = {x=0, y=0, z=0},
          					acceleration = {x=math.random(-15,15)/10, y=math.random(20,30)/10, z=math.random(-15,15)/10},
						expirationtime = 1.0, 
						size = math.random(24,32), 
						texture = "accessories_dodgepuff.png",
          					animation = {type="vertical_frames", aspect_w=8, aspect_h=8, length = 1.0,},
						glow = 1,
					})
					core.sound_play("swing",{pos = pos, max_hear_distance = 24, gain = 0.25}, true)
				end
			else
				if plrTemp.BootRunTime > 0 then
					plrTemp.BootRunTime = plrTemp.BootRunTime - (dtime*10)
					if plrTemp.BootRunTime < 0 then plrTemp.BootRunTime = 0 end
					eqp_accessories.AddTempSpeed(player,plrTemp.BootRunTime/2,"acc_boot_run")
				end
			end
	end)
	end,
	OnUnEquip = function(player,reason) 
		local name = player:get_player_name()
		eqp_accessories.RemovePlayerStep(player,"BootRun")
		eqp_accessories.plrTempData[name].BootRunTime=0
		eqp_accessories.plrTempData[name].LastBootPuff=0
		eqp_accessories.AddTempSpeed(player,0,"acc_boot_run")
	end,
		WearReasons = {["walking"]=true},
		durability = 1280,
		equipSlots = {["feet"]=1},
		extraAccDesc = core.colorize("#00ff88","Speeds up as you keep walking forward."),
		stats = {},
		visual = {
	["Leg_Left"]={mesh = "hermes_boot.obj",size=sizes.boots.size,textures = {"accessories_hermes_boot.png"},overlay={"accessories_hermes_boot_overlay.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "hermes_boot.obj",size=sizes.boots.size,textures = {"accessories_hermes_boot.png"},overlay={"accessories_hermes_boot_overlay.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
			},	
	},
})
table.insert(eqp_accessories.treasureTab["uncommon"],"equippable_accessories:hermes_boots")
core.register_tool("equippable_accessories:facemask", {
	description = ("Facemask"),
	inventory_image = "accessories_facemask_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 256,
		equipSlots = {["face"]=1},
		stats = {["defense"]={add=1}},
		visual = {
	["Head"]={mesh = "simple_helmet_cuboid.obj",size={x=9.125,y=9.125},textures = {"accessories_facemask.png"},overlay = {"accessories_facemask_overlay.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:goggles", {
	description = ("Goggles"),
	inventory_image = "accessories_goggles_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 256,
		equipSlots = {["eyes"]=1},
		stats = {["defense"]={add=1}},
		visual = {
	["Head"]={mesh = "simple_helmet_cuboid.obj",size={x=9.275,y=9.275},textures = {"accessories_goggles.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:sunglasses", {
	description = ("Sunglasses"),
	inventory_image = "accessories_sunglasses_inv.png",
	groups = {accessory = 1,tool = 1},
	on_use = function(itemstack, player, pointed_thing)
		--itemstack:get_meta():set_string("eqp_acc_stats",core.serialize({ ["defense"]={add=5},["attack"]={add=5}, }))
		--itemstack:get_meta():set_string("testing",core.serialize({ ["defense"]={add=100},["regen"]={add=2.5}, }))

		itemstack:get_meta():set_string("eqp_acc_texture","")
		itemstack:get_meta():set_string("eqp_acc_overlay","")

		return itemstack
	end,
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 256,
		equipSlots = {["eyes"]=1},
		stats = {["defense"]={add=1},["attack"]={add=2}},
		visual = {
	["Head"]={mesh = "simple_helmet_cuboid.obj",size={x=9.175,y=9.175},textures = {"accessories_sunglasses.png"},position = {x=0,y=0.375,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:white_scarf", {
	description = ("Wool Scarf"),
	inventory_image = "accessories_white_scarf_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 384,
		equipSlots = {["neck"]=1},
		stats = {["defense"]={add=1},["max_hp"]={add=2}},
		visual = {
	["Body"]={mesh = "accessory_scarf.obj",size=sizes.scarf.size,textures = {"accessories_white_scarf.png"},position = sizes.scarf.position,rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:striped_scarf", {
	description = ("Striped Scarf"),
	inventory_image = "accessories_striped_scarf_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 384,
		equipSlots = {["neck"]=1},
		stats = {["defense"]={add=1},["max_hp"]={add=2}},
		visual = {
	["Body"]={mesh = "accessory_scarf.obj",size=sizes.scarf.size,textures = {"accessories_striped_scarf.png"},overlay = {"accessories_striped_scarf_overlay.png"},position = sizes.scarf.position,rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:cat_ears", {
	description = ("Cat Ears"),
	inventory_image = "accessories_cat_ears_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 256,
		equipSlots = {["head"]=1},
		stats = {["dodge"]={add=1},["speed"]={add=0.10}},
		visual = {
	["Head"]={mesh = "accessory_cat_ears.obj",size = sizes.ears_cat.size,textures = {"accessories_cat_ears.png"},overlay = {"accessories_cat_ears_overlay.png"},position = sizes.ears_cat.position,rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:bnuuy_ears", {
	description = ("Bunny Ears"),
	inventory_image = "accessories_bnuuy_ears_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 256,
		equipSlots = {["head"]=1},
		stats = {["dodge"]={add=1},["jump"]={add=0.2}},
		visual = {
	["Head"]={mesh = "accessory_bnuuy_ears.obj",size=sizes.ears_bun.size,textures = {"accessories_bnuuy_ears.png"},overlay = {"accessories_bnuuy_ears_overlay.png"},position = sizes.ears_bun.position,rotation={x=0,y=180,z=0}},
			},	
	},
})
core.register_tool("equippable_accessories:mining_glove", {
	description = ("Mining Glove"),
	inventory_image = "accessories_mining_glove_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["digging"]=true,["hurt"]=true},
		durability = 384,
		equipSlots = {["left_hand"]=1,["right_hand"]=1},
		stats = {["defense"]={add=1},["digSpeed"]={add=12}},
		slotVisual = {
			["left_hand"]={
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_mining_glove.png"},overlay = {"accessories_mining_glove_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=181,z=0}},
			},
			["right_hand"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_mining_glove.png"},overlay = {"accessories_mining_glove_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
			},
			["any"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_mining_glove.png"},overlay = {"accessories_mining_glove_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_mining_glove.png"},overlay = {"accessories_mining_glove_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
			}
		}
	},	
})

core.register_tool("equippable_accessories:golden_bracelet", {
	description = ("Golden bracelet"),
	inventory_image = "accessories_golden_bracelet_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 960,
		equipSlots = {["left_hand"]=1,["right_hand"]=1},
		stats = {["defense"]={add=3},["max_hp"]={add=3}},
		slotVisual = {
			["left_hand"]={
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.bracelet.size,textures = {"accessories_golden_bracelet.png"},position = sizes.bracelet.position,rotation={x=0,y=181,z=0}},
			},
			["right_hand"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.bracelet.size,textures = {"accessories_golden_bracelet.png"},position = sizes.bracelet.position,rotation={x=0,y=180,z=0}},
			},
			["any"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.bracelet.size,textures = {"accessories_golden_bracelet.png"},position = sizes.bracelet.position,rotation={x=0,y=180,z=0}},
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.bracelet.size,textures = {"accessories_golden_bracelet.png"},position = sizes.bracelet.position,rotation={x=0,y=180,z=0}},
			}
		}
	},	
})

core.register_tool("equippable_accessories:dark_horns", {
	description = ("Dark Horns"),
	inventory_image = "accessories_dark_horns_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 1024,
		equipSlots = {["head"]=1},
		stats = {["attack"]={add=12},["speed"]={add=0.05}},
		visual = {
	["Head"]={mesh = "accessory_horns_1.b3d",size = {x=2.25,y=2.25},textures = {"accessories_dark_horns.png"},overlay = {"accessories_dark_horns_overlay.png"},position = {x=0,y=2.0,z=0},rotation={x=0,y=180,z=0},glow=4},
			},	
	},
})

core.register_tool("equippable_accessories:steel_gauntlet", {
	description = ("Steel Gauntlet"),
	inventory_image = "accessories_steel_gauntlet_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 512,
		equipSlots = {["left_hand"]=1,["right_hand"]=1},
		stats = {["defense"]={add=2},["attack"]={add=4}},
		slotVisual = {
			["left_hand"]={
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_steel_gauntlet.png"},position = sizes.gloves.position,rotation={x=0,y=181,z=0}},
			},
			["right_hand"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_steel_gauntlet.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
			},
			["any"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_steel_gauntlet.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_steel_gauntlet.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
			}
		}
	},	
})

core.register_tool("equippable_accessories:enchanted_stone_gauntlet", {
	description = ("Enchanted Stone Gauntlet"),
	inventory_image = "accessories_enchanted_stone_gauntlet_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 1024,
		equipSlots = {["left_hand"]=1,["right_hand"]=1},
		stats = {["defense"]={add=4},["attack"]={add=8}},
		slotVisual = {
			["left_hand"]={
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_enchanted_stone_gauntlet.png"},overlay = {"accessories_enchanted_stone_gauntlet_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=181,z=0}},
			},
			["right_hand"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_enchanted_stone_gauntlet.png"},overlay = {"accessories_enchanted_stone_gauntlet_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
			},
			["any"]={
		["Arm_Right"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_enchanted_stone_gauntlet.png"},overlay = {"accessories_enchanted_stone_gauntlet_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
		["Arm_Left"]={mesh = "simple_helmet_cuboid.obj",size=sizes.gloves.size,textures = {"accessories_enchanted_stone_gauntlet.png"},overlay = {"accessories_enchanted_stone_gauntlet_overlay.png"},position = sizes.gloves.position,rotation={x=0,y=180,z=0}},
			}
		}
	},	
})
table.insert(eqp_accessories.treasureTab["uncommon"],"equippable_accessories:enchanted_stone_gauntlet")

core.register_tool("equippable_accessories:cloud_bottle", {
	description = ("Cloud In A Bottle"),
	inventory_image = "eq_acc_cloudbottle_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		--noUseEquip = true,
		extraAccDesc = core.colorize("#00ff88","Grants double-jump"),
		WearReasons = {["doubleJump"]=true},
		durability = 2000,
		equipSlots = {["belt"]=1},
		OnEquip = function(player,reason) 
			eqp_accessories.AddDoubleJump(player,"CloudBottle",{
				func = function(player) 
					local pos = player:get_pos()
					local puffDir={{x=3,z=0},{x=-3,z=0},{x=0,z=3},{x=0,z=-3},{x=2,z=2},{x=-2,z=-2},{x=-2,z=2},{x=2,z=-2}}
					for i = 1,#puffDir do
						core.add_particle({
						pos = {x=pos.x+math.random(-5,5)/20,y=pos.y+math.random(5,5)/20,z=pos.z+math.random(-5,5)/20},
						velocity = {x=puffDir[i].x, y=math.random(-8,-4)/20, z=puffDir[i].z},
          					acceleration = {x=math.random(-15,15)/10, y=math.random(-15,15)/10, z=math.random(-15,15)/10},
						expirationtime = 0.9, 
						size = 12, 
						collisiondetection = true,
						collision_removal = false,
						texture = "accessories_dodgepuff.png",
          				animation = {type="vertical_frames", aspect_w=8, aspect_h=8, length = 1.0,},
					glow = 1,
					})
					end
					core.sound_play("swing",{pos = pos, max_hear_distance = 24, gain = 0.25}, true)
				end	
			})
		end,
		OnUnEquip = function(player,reason) 
			eqp_accessories.RemoveDoubleJump(player,"CloudBottle")
		end,
	},
})
table.insert(eqp_accessories.treasureTab["uncommon"],"equippable_accessories:cloud_bottle")
core.register_tool("equippable_accessories:angel_wings", {
	description = ("Angel Wings"),
	inventory_image = "accessories_angel_wings_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["flying"]=true},
		durability = 2000,
		extraAccDesc = (eqp_accessories.settings.EnableFlight == true and eqp_accessories.FlightItemDesc or nil),
		equipSlots = {["back"]=1},
		OnEquip = function(player,reason) 
			if eqp_accessories.settings.EnableFlight == true then
			eqp_accessories.AddFlight(player,"Wings",{maxVelocity=10,acceleration=25,flightTime=3})
			end
		end,
		OnUnEquip = function(player,reason) 
			if eqp_accessories.settings.EnableFlight == true then
			eqp_accessories.RemoveFlight(player,"Wings")
			end
		end,
		stats = {["speed"]={add=0.1},["regen"]={add=0.1}},
		tags = {["SlowFall"]=1},
		visual = {
	["Body"]={mesh = "wings.glb",size={x=15.0,y=15.0},textures = {"accessories_angel_wings.png"},position = {x=0,y=2.375,z=1.625},rotation={x=0,y=180,z=0},anim={x=1,y=30,s=8}},
			},	
	},
})
core.register_tool("equippable_accessories:dark_wings", {
	description = ("Dark Wings"),
	inventory_image = "accessories_dark_wings_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["flying"]=true},
		durability = 2750,
		extraAccDesc = (eqp_accessories.settings.EnableFlight == true and eqp_accessories.FlightItemDesc or nil),
		equipSlots = {["back"]=1},
		OnEquip = function(player,reason) 
			if eqp_accessories.settings.EnableFlight == true then
			eqp_accessories.AddFlight(player,"Wings",{maxVelocity=10,acceleration=25,flightTime=3})
			end
		end,
		OnUnEquip = function(player,reason) 
			if eqp_accessories.settings.EnableFlight == true then
			eqp_accessories.RemoveFlight(player,"Wings")
			end
		end,
		stats = {["speed"]={add=0.16},["attack"]={add=10}},
		tags = {["SlowFall"]=1},
		visual = {
	["Body"]={mesh = "wings.glb",size={x=12.0,y=12.0},textures = {"accessories_dark_wings.png"},overlay = {"accessories_dark_wings_overlay.png"},position = {x=0,y=4.275,z=1.625},rotation={x=0,y=180,z=0},anim={x=1,y=30,s=8},glow=4},
			},	
	},
})
table.insert(eqp_accessories.treasureTab["rare"],"equippable_accessories:dark_wings")

core.register_tool("equippable_accessories:golden_halo", {
	description = ("Golden Halo"),
	inventory_image = "accessories_golden_halo_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 768,
		equipSlots = {["head"]=1},
		stats = {["max_hp"]={add=5},["regen"]={add=0.1}},
		visual = {
	["Head"]={mesh = "accessory_golden_halo.b3d",size = {x=2.25,y=2.25},textures = {"accessories_golden_halo.png"},position = {x=0,y=5.50,z=0},rotation={x=0,y=180,z=0},glow=10},
			},	
	},
})

core.register_tool("equippable_accessories:leather_boots", {
	description = ("Leather Boots"),
	inventory_image = "accessories_leather_boots_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["walking"]=true,["hurt"]=true},
		durability = 512,
		equipSlots = {["feet"]=1},
		stats = {["speed"]={add=0.25},["defense"]={add=1}},
		visual = {
	["Leg_Left"]={mesh = "accessory_boot.obj",size=sizes.boots.size,textures = {"accessories_leather_boot.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "accessory_boot.obj",size=sizes.boots.size,textures = {"accessories_leather_boot.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
			},	
	},
})

core.register_tool("equippable_accessories:armored_boots", {
	description = ("Armored Boots"),
	inventory_image = "accessories_armored_boots_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["walking"]=true,["hurt"]=true},
		durability = 1024,
		equipSlots = {["feet"]=1},
		stats = {["speed"]={add=0.20},["defense"]={add=4}},
		visual = {
	["Leg_Left"]={mesh = "accessory_boot.obj",size=sizes.boots.size,textures = {"accessories_armored_boot.png"},overlay = {"accessories_armored_boot_overlay.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "accessory_boot.obj",size=sizes.boots.size,textures = {"accessories_armored_boot.png"},overlay = {"accessories_armored_boot_overlay.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
			},	
	},
})

core.register_tool("equippable_accessories:running_shoes", {
	description = ("Running Shoes"),
	inventory_image = "accessories_running_shoes_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["walking"]=true},
		durability = 768,
		equipSlots = {["feet"]=1},
		stats = {["speed"]={add=0.5}},
		visual = {
	["Leg_Left"]={mesh = "accessory_boot.obj",size=sizes.boots.size,textures = {"accessories_running_shoe.png"},overlay = {"accessories_running_shoe_overlay.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
	["Leg_Right"]={mesh = "accessory_boot.obj",size=sizes.boots.size,textures = {"accessories_running_shoe.png"},overlay = {"accessories_running_shoe_overlay.png"},position=sizes.boots.position,rotation={x=0,y=0,z=180}},
			},	
	},
})

core.register_tool("equippable_accessories:white_headband", {
	description = ("White Headband"),
	inventory_image = "accessories_white_headband_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 384,
		equipSlots = {["forehead"]=1},
		stats = {["dodge"]={add=2},["attack"]={add=5},["digSpeed"]={add=5}},
		visual = {
	["Head"]={mesh = "accessory_headband.b3d",size = {x=2.8,y=2.8},textures = {"accessories_white_headband.png"},position = {x=0,y=1.0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})

core.register_tool("equippable_accessories:gaming_headphones", {
	description = ("Gaming Headphones"),
	inventory_image = "accessories_gaming_headphones_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 640,
		equipSlots = {["ears"]=1},
		stats = {["speed"]={add=0.12},["attack"]={add=5},["digSpeed"]={add=5}},
		visual = {
	["Head"]={mesh = "accessory_headphones.b3d",size = {x=2.175,y=2.175},textures = {"accessories_gaming_headphones.png"},overlay = {"accessories_gaming_headphones_overlay.png"},position = {x=0,y=2,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})

core.register_tool("equippable_accessories:heart_amulet", {
	description = ("Heart Amulet"),
	inventory_image = "accessories_heart_amulet_inv.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["time"]=true},
		durability = 1024,
		equipSlots = {["chest"]=1},
		stats = {["max_hp"]={add=4},["regen"]={add=0.15}},
		visual = {
	["Body"]={mesh = "simple_body.obj",size={x=12.0,y=11.25},textures = {"accessories_heart_amulet.png"},overlay = {"accessories_heart_amulet_overlay.png"},position = {x=0,y=0,z=0},rotation={x=0,y=180,z=0}},
			},	
	},
})
table.insert(eqp_accessories.treasureTab["uncommon"],"equippable_accessories:heart_amulet")

core.register_tool("equippable_accessories:diamond_ring", {
	description = ("Diamond Ring"),
	inventory_image = "accessories_diamond_ring.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 2048,
		equipSlots = {["left_ring"]=1,["right_ring"]=1},
		stats = {["defense"]={add=3}},
	},
})
core.register_tool("equippable_accessories:drill_ring", {
	description = ("Drill Ring"),
	inventory_image = "accessories_drill_ring.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["digging"]=true},
		durability = 4096,
		equipSlots = {["left_ring"]=1,["right_ring"]=1},
		stats = {["digSpeed"]={add=25}},
	},
})
core.register_tool("equippable_accessories:silver_ring", {
	description = ("Silver Ring"),
	inventory_image = "accessories_silver_ring.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["time"]=true},
		durability = 1536,
		equipSlots = {["left_ring"]=1,["right_ring"]=1},
		stats = {["regen"]={add=0.05}},
	},
})
core.register_tool("equippable_accessories:ring_of_power", {
	description = ("Ring Of Power"),
	inventory_image = "accessories_ring_of_power.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["time"]=true,["digging"]=true,["walking"]=true,["hurt"]=true,["attacking"]=true},
		durability = 16384,
		equipSlots = {["left_ring"]=1,["right_ring"]=1},
		stats = {["digSpeed"]={add=16},["defense"]={add=2},["attack"]={add=6},["max_hp"]={add=3},["speed"]={add=0.15}},
	},
})
core.register_tool("equippable_accessories:spikey_ring", {
	description = ("Spikey Ring"),
	inventory_image = "accessories_spikey_ring.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["time"]=true,["digging"]=true,["walking"]=true,["hurt"]=true,["attacking"]=true},
		durability = 1024,
		equipSlots = {["left_ring"]=1,["right_ring"]=1},
		stats = {["attack"]={add=7},["thorns"]={add=10}},
	},
})

core.register_tool("equippable_accessories:protection_ring", {
	description = ("Ring Of Protection"),
	inventory_image = "accessories_protection_ring.png",
	groups = {accessory = 1,tool = 1},
	equipParams = {
		WearReasons = {["hurt"]=true},
		durability = 1024,
		equipSlots = {["left_ring"]=1,["right_ring"]=1},
		stats = {["defense"]={add=2},["reduction"]={add=ShieldRDC(0.5,6)}},
	},
})
table.insert(eqp_accessories.treasureTab["common"],"equippable_accessories:protection_ring")


core.register_craftitem("equippable_accessories:wing_base", {
	description = ("Wing base \n" ..core.colorize("#aaaaaa","A sturdy skeleton for a wings \n").. "" ..core.colorize("#aaaaaa","used for crafting wearable wings").. ""),
	inventory_image = "accessories_wing_base.png",
})
core.register_craft({
	output = "equippable_accessories:wing_base 1",
	recipe = {
		{craftMat.steel, craftMat.diamondBlock, craftMat.steel},
		{craftMat.meseBlock, craftMat.steel, craftMat.meseBlock},
		{craftMat.steel, craftMat.diamondBlock, craftMat.steel},
	}
})



core.register_craft({
	output = "equippable_accessories:facemask",
	recipe = {
		{craftMat.string, "", craftMat.string},
		{"", craftMat.paper, ""},
	}
})
core.register_craft({
	output = "equippable_accessories:goggles",
	recipe = {
		{"group:stick", "", "group:stick"},
		{craftMat.glassPane, "group:stick", craftMat.glassPane},
	}
})
core.register_craft({
	output = "equippable_accessories:sunglasses",
	recipe = {
		{"group:stick", "", "group:stick"},
		{craftMat.glassPane, "group:stick", craftMat.glassPane},
		{craftMat.dye.."black", "", craftMat.dye.."black"},
	}
})
core.register_craft({
	output = "equippable_accessories:white_scarf",
	recipe = {
		{craftMat.wool.."white", craftMat.wool.."white", craftMat.wool.."white"},
		{craftMat.wool.."white", craftMat.string, craftMat.wool.."white"},
		{craftMat.string, craftMat.wool.."white", craftMat.string},
	}
})
core.register_craft({
	output = "equippable_accessories:striped_scarf",
	recipe = {
		{craftMat.wool.."green", craftMat.wool.."red", craftMat.wool.."green"},
		{craftMat.wool.."red", craftMat.string, craftMat.wool.."red"},
		{craftMat.string, craftMat.wool.."green", craftMat.string},
	}
})
core.register_craft({
	output = "equippable_accessories:cat_ears",
	recipe = {
		{craftMat.wool.."grey", "", craftMat.wool.."grey"},
		{craftMat.wool.."grey", craftMat.string, craftMat.wool.."grey"},
	}
})
core.register_craft({
	output = "equippable_accessories:bnuuy_ears",
	recipe = {
		{craftMat.wool.."grey", "", craftMat.wool.."grey"},
		{craftMat.wool.."grey", "", craftMat.wool.."grey"},
		{craftMat.wool.."grey", craftMat.string, craftMat.wool.."grey"},
	}
})
core.register_craft({
	output = "equippable_accessories:mining_glove",
	recipe = {
		{craftMat.wool.."orange", "", craftMat.wool.."orange"},
		{craftMat.wool.."grey", "", craftMat.wool.."grey"},
		{craftMat.leather, "", craftMat.leather},
	}
})
core.register_craft({
	output = "equippable_accessories:golden_bracelet",
	recipe = {
		{craftMat.gold, craftMat.string},
		{craftMat.string, craftMat.gold},
		{craftMat.gold, craftMat.string},
	}
})

core.register_craft({
	output = "equippable_accessories:dark_horns",
	recipe = {
		{craftMat.obsShard, "", craftMat.obsShard},
		{craftMat.diamond, "",craftMat.diamond},
		{craftMat.obsidian, "",craftMat.obsidian},
	}
})

core.register_craft({
	output = "equippable_accessories:steel_gauntlet",
	recipe = {
		{craftMat.steel, craftMat.steel, ""},
		{craftMat.steel, craftMat.steel, ""},
		{"group:wool", "", ""},
	}
})

core.register_craft({
	output = "equippable_accessories:angel_wings",
	recipe = {
		{craftMat.wool.."white", craftMat.wool.."white", craftMat.wool.."white"},
		{craftMat.wool.."white", "equippable_accessories:wing_base", craftMat.wool.."white"},
		{craftMat.wool.."white", craftMat.wool.."white", ""},
	}
})

core.register_craft({
	output = "equippable_accessories:dark_wings",
	recipe = {
		{craftMat.obsShard, craftMat.obsidian, ""},
		{craftMat.obsidian, "equippable_accessories:wing_base", craftMat.obsidian},
		{craftMat.obsidian, "", ""},
	}
})

core.register_craft({
	output = "equippable_accessories:golden_halo",
	recipe = {
		{craftMat.mese, craftMat.gold,craftMat.mese},
		{craftMat.gold, "",craftMat.gold},
		{craftMat.mese, craftMat.gold,craftMat.mese},
	}
})

core.register_craft({
	output = "equippable_accessories:leather_boots",
	recipe = {
		{craftMat.leather, "", craftMat.leather},
		{craftMat.leather, "", craftMat.leather},
		{"group:wood", "", "group:wood"},
	}
})

core.register_craft({
	output = "equippable_accessories:running_shoes",
	recipe = {
		{craftMat.wool.."red", "", craftMat.wool.."red"},
		{craftMat.mese, "", craftMat.mese},
		{craftMat.leather, craftMat.wool.."white", craftMat.leather},
	}
})

core.register_craft({
	output = "equippable_accessories:armored_boots",
	recipe = {
		{"", craftMat.steel, ""},
		{craftMat.steel, "equippable_accessories:leather_boots", craftMat.steel},
		{"", craftMat.steel, ""},
	}
})

core.register_craft({
	output = "equippable_accessories:white_headband",
	recipe = {
		{craftMat.string,craftMat.wool.."white", craftMat.string},
		{craftMat.wool.."white",craftMat.wool.."white",craftMat.wool.."white"},
	}
})

core.register_craft({
	output = "equippable_accessories:gaming_headphones",
	recipe = {
		{craftMat.mese, craftMat.steel, craftMat.mese},
		{craftMat.steel, craftMat.dye.."black", craftMat.steel},
		{craftMat.dye.."red", craftMat.meseFrag,craftMat.dye.."red"},
	}
})

core.register_craft({
	output = "equippable_accessories:armored_boots",
	recipe = {
		{"", craftMat.steel, ""},
		{craftMat.steel, "equippable_accessories:leather_boots", craftMat.steel},
		{"", craftMat.steel, ""},
	}
})



core.register_craft({
	output = "equippable_accessories:spikey_ring",
	recipe = {
		{craftMat.meseFrag, craftMat.steel, craftMat.meseFrag},
		{craftMat.steel, "", craftMat.steel},
		{craftMat.meseFrag, craftMat.steel, craftMat.meseFrag},
	}
})
core.register_craft({
	output = "equippable_accessories:diamond_ring",
	recipe = {
		{"", craftMat.gold, craftMat.diamond},
		{craftMat.gold, "", craftMat.gold},
		{"", craftMat.gold, ""},
	}
})
core.register_craft({
	output = "equippable_accessories:drill_ring",
	recipe = {
		{"", craftMat.steelBlock, craftMat.diamondBlock},
		{craftMat.gold, "", craftMat.steelBlock},
		{"", craftMat.gold, ""},
	}
})


if #SilverIngots > 0 then
for _,agIngt in ipairs(SilverIngots) do
core.register_craft({
	output = "equippable_accessories:silver_ring",
	recipe = {
		{"", agIngt, ""},
		{agIngt, "", agIngt},
		{"", agIngt, ""},
	}
})
end end
core.register_craft({
	output = "equippable_accessories:ring_of_power",
	recipe = {
		{"", craftMat.diamondBlock, craftMat.meseBlock},
		{craftMat.copper, craftMat.steelBlock, craftMat.diamondBlock},
		{craftMat.copper, craftMat.copper, ""},
	}
})

core.register_alias("equippable_accessories:steel_gauntlets", "equippable_accessories:steel_gauntlet")
core.register_alias("equippable_accessories:gold_bracelets", "equippable_accessories:gold_bracelet")