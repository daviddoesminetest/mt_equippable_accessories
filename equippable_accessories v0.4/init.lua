
local modpath = core.get_modpath(core.get_current_modname())
local S = core.get_translator("equippable_accessories")

local ExtraAccCols = 0
local StatIcnMoveAdd = 0

eqp_accessories = {}
eqp_accessories.LastWields = {}
eqp_accessories.pageTitle = "Equipment"
eqp_accessories.visuals = {}
eqp_accessories.pages = {}
eqp_accessories.InvDatas = {}
eqp_accessories.RegInvSlots = {}
eqp_accessories.PlayerStats = {}
eqp_accessories.UsedPhysicsMod = ""
eqp_accessories.UsedInvMod = ""
eqp_accessories.PhysicsConflictMods = {}
eqp_accessories.sounds = {
	wood=function(table) table = table or {} return table end,
}
eqp_accessories.treasureTab = {
	["common"]={},
	["uncommon"]={},
	["rare"]={},
	["epic"]={},
	["legendary"]={},
}

	if core.get_modpath("default") then
		if default.node_sound_wood_defaults then eqp_accessories.sounds.wood = default.node_sound_wood_defaults end
	end
	if core.get_modpath("mcl_sounds") then
		if mcl_sounds.node_sound_wood_defaults then eqp_accessories.sounds.wood = mcl_sounds.node_sound_wood_defaults end
	end


eqp_accessories.AnyAccExceptions = {["helmet"]=true,["breastplate"]=true,["leggings"]=true,["hat"]=true,["shirt"]=true,["pants"]=true}
eqp_accessories.settings = {
	UseArmor = true,
	UseHealthBoost = true,
	durability = 2,
	AccColumns = 0,
	preset = 1,
	defPerDMG = 5,
	defType = 1,
	deathDrop = 0,
	min_damage = 0.4,
	expandBones = true,
	InitMaxHP = 20,
	HPnumDisplay = true,
	UseExtendedDesc = true,
	EnableFlight = true,
	SaveInterval = 20,
	DynamicDyes = false,
	CrativeDoubleDyes = true,
}
local accSetts = eqp_accessories.settings 
if core.settings:get("eqp_acc_inv_preset") then accSetts.preset = tonumber(core.settings:get("eqp_acc_inv_preset")) end
if core.settings:get("eqp_acc_armor") and core.settings:get("eqp_acc_armor")=="false" then accSetts.UseArmor = false end
if core.settings:get("eqp_acc_health") and core.settings:get("eqp_acc_health")=="false" then accSetts.UseHealthBoost = false end
if core.settings:get("eqp_acc_durability") then accSetts.durability = tonumber(core.settings:get("eqp_acc_durability")) end
if core.settings:get("eqp_acc_def_per_dmg") then accSetts.defPerDMG = tonumber(core.settings:get("eqp_acc_def_per_dmg")) end
if core.settings:get("eqp_acc_deftype") then accSetts.defType = tonumber(core.settings:get("eqp_acc_deftype")) end
if core.settings:get("eqp_acc_mindmg") then accSetts.min_damage = tonumber(core.settings:get("eqp_acc_mindmg")) end
if core.settings:get("eqp_acc_expandbones") and core.settings:get("eqp_acc_expandbones")=="false" then accSetts.expandBones = false end
if core.settings:get("eqp_acc_deathdrop") then
	local ddrop = core.settings:get("eqp_acc_deathdrop")
	if ddrop == "optional" then accSetts.deathDrop = 0 end
	if ddrop == "forced" then accSetts.deathDrop = 1 end
	if ddrop == "disabled" then accSetts.deathDrop = 2 end
end
if core.settings:get("eqp_acc_initMaxHP") then accSetts.InitMaxHP = tonumber(core.settings:get("eqp_acc_initMaxHP")) end
if core.settings:get("eqp_acc_exdesc") and core.settings:get("eqp_acc_exdesc")=="false" then accSetts.UseExtendedDesc = false end
if core.settings:get("eqp_acc_flight") and core.settings:get("eqp_acc_flight")=="false" then accSetts.EnableFlight = false end
if core.settings:get("eqp_acc_saveInt") then accSetts.SaveInterval = tonumber(core.settings:get("eqp_acc_saveInt")) end
if core.settings:get("eqp_acc_dynamic_dyes") and core.settings:get("eqp_acc_dynamic_dyes")=="true" then accSetts.DynamicDyes = true end
if core.settings:get("eqp_acc_creative_double_dyes") and core.settings:get("eqp_acc_creative_double_dyes")=="false" then accSetts.CrativeDoubleDyes = false end

eqp_accessories.plrTempData = {}
eqp_accessories.plrSteps = {}
eqp_accessories.callBacks = {
	RefreshingStats = {},
	OnRefreshStats = {},
}
eqp_accessories.StatMetaToCheck = {"testing"}

eqp_accessories.BonusSets = {
["equippable_accessories:wooden_helmet"]={
	["breastplate"]="equippable_accessories:wooden_armor",
	["leggings"]="equippable_accessories:wooden_leggings",
	["setBonus"]={stats={["defense"]={add=1}},desc="Inceased defense by 1" },
},
["equippable_accessories:cactus_helmet"]={
	["breastplate"]="equippable_accessories:cactus_armor",
	["leggings"]="equippable_accessories:cactus_leggings",
	["setBonus"]={stats={["defense"]={add=1},["attack"]={add=3},["thorns"]={add=25}},desc="Inceased defense by 1, Attack by 3% and Thorns by 25%" },
},
["equippable_accessories:copper_helmet"]={
	["breastplate"]="equippable_accessories:copper_chainmail",
	["leggings"]="equippable_accessories:copper_leggings",
	["setBonus"]={stats={["defense"]={add=2}},desc="Inceased defense by 2" },
},
["equippable_accessories:tin_helmet"]={
	["breastplate"]="equippable_accessories:tin_chainmail",
	["leggings"]="equippable_accessories:tin_leggings",
	["setBonus"]={stats={["defense"]={add=3}},desc="Inceased defense by 3" },
},
["equippable_accessories:steel_helmet"]={
	["breastplate"]="equippable_accessories:steel_scalemail",
	["leggings"]="equippable_accessories:steel_leggings",
	["setBonus"]={stats={["defense"]={add=5}},desc="Inceased defense by 5" },
},
["equippable_accessories:silver_helmet"]={
	["breastplate"]="equippable_accessories:silver_platemail",
	["leggings"]="equippable_accessories:silver_leggings",
	["setBonus"]={stats={["defense"]={add=4},["regen"]={add=0.1}},desc="Inceased defense by 4 and Regeneration by 0.1" },
},
["equippable_accessories:golden_helmet"]={
	["breastplate"]="equippable_accessories:golden_platemail",
	["leggings"]="equippable_accessories:golden_leggings",
	["setBonus"]={stats={["defense"]={add=6}},desc="Inceased defense by 6"},
},
["equippable_accessories:bronze_helmet"]={
	["breastplate"]="equippable_accessories:bronze_scalemail",
	["leggings"]="equippable_accessories:bronze_leggings",
	["setBonus"]={stats={["defense"]={add=4},["attack"]={add=8}},desc="Inceased defense by 4 and attack by 8%" },
},
["equippable_accessories:brass_helmet"]={
	["breastplate"]="equippable_accessories:brass_scalemail",
	["leggings"]="equippable_accessories:brass_leggings",
	["setBonus"]={stats={["defense"]={add=4},["attack"]={add=8}},desc="Inceased defense by 4 and attack by 8%" },
},
["equippable_accessories:mithril_helmet"]={
	["breastplate"]="equippable_accessories:mithril_platemail",
	["leggings"]="equippable_accessories:mithril_leggings",
	["setBonus"]={stats={["defense"]={add=10},["attack"]={add=13}},desc="Inceased defense by 10 and attack by 13%" },
},
["equippable_accessories:dungeon_helmet"]={
	["breastplate"]="equippable_accessories:dungeon_platemail",
	["leggings"]="equippable_accessories:dungeon_leggings",
	["setBonus"]={stats={["max_hp"]={add=5},["attack"]={add=15}},desc="Inceased Max HP by 5 and attack by 15%" },
},
["equippable_accessories:molten_helmet"]={
	["breastplate"]="equippable_accessories:molten_armor",
	["leggings"]="equippable_accessories:molten_leggings",
	["setBonus"]={stats={["FireRes"]={add=10},["speed"]={add=0.25}},desc="Inceased Walking Speed by 0.25\nGranted 10 seconds of immunity to fire blocks." },
},

["equippable_accessories:menacing_student_hat"]={
	["breastplate"]="equippable_accessories:menacing_student_jacket",
	["leggings"]="equippable_accessories:menacing_student_pants",
	["setBonus"]={stats={["defense"]={add=1},["attack"]={add=15},["speed"]={add=0.3},["jump"]={add=0.4}},desc="Inceased defense by 1, Attack damage by 15%,\n Walking speed by 0.3 and Jump force by 0.4",
	stepFunc=function(player,dtime)
		local pos = player:getpos()
		local pName = player:get_player_name()
		local tData = eqp_accessories.plrTempData[pName]
		if tData.MenacingPartTime==nil then tData.MenacingPartTime=0 end
		if tData.MenacingPartTime<os.clock() then
		tData.MenacingPartTime = os.clock() + 0.5
		core.add_particle({
			pos = {x=pos.x+math.random(-3,3),y=pos.y+math.random(1,4),z=pos.z+math.random(-3,3)},
			velocity = {x=0, y=0, z=0},
          		acceleration = {x=0, y=0, z=0},
			expirationtime = 2, 
			size = 8, 
			collisiondetection = false,
			collision_removal = false,
			vertical = false,
			texture = "accessories_menacing.png",
        		animation = {type="vertical_frames", aspect_w=8, aspect_h=8, length = 0.25,},
		glow = 10,})
		end
	end},
},
["equippable_accessories:mining_helmet"]={
	["breastplate"]="equippable_accessories:safety_vest",
	["leggings"]="equippable_accessories:overalls",
	["setBonus"]={stats={["digSpeed"]={add=20},["defense"]={add=1}},desc="Inceased Digging Speed by 25% and defense by 1" },
},
["equippable_accessories:ancient_hat"]={
	["breastplate"]="equippable_accessories:ancient_robe",
	["leggings"]="equippable_accessories:ancient_pants",
	["setBonus"]={stats={["digSpeed"]={add=10},["defense"]={add=5},["speed"]={add=0.1},["attack"]={add=10}},desc="Inceased Digging Speed, attack, walking speed by 10% and defense by 5" },
},
}

	if core.get_modpath("hudbars") then
		eqp_accessories.settings.HPnumDisplay=false
	end
	if core.get_modpath("3d_armor") then
		eqp_accessories.settings.UseArmor = false
		table.insert(eqp_accessories.PhysicsConflictMods,"3d_armor")
		ExtraAccCols = 2
	end
	if core.get_modpath("mcl_armor") then
		eqp_accessories.settings.UseArmor = false
		ExtraAccCols = 3
		StatIcnMoveAdd = 3
	end
	--if core.get_modpath("unified_inventory") then
	--	ExtraAccCols = ExtraAccCols + 1
	--end
	if core.get_modpath("stamina") then
		table.insert(eqp_accessories.PhysicsConflictMods,"stamina")
	end
	if core.get_modpath("hbsprint") then
		table.insert(eqp_accessories.PhysicsConflictMods,"hbsprint")
	end

	if core.get_modpath("player_monoids") then
		eqp_accessories.UsedPhysicsMod = "player_monoids"
	end
	if core.get_modpath("pova") then
		eqp_accessories.UsedPhysicsMod = "pova"
	end
	if core.get_modpath("playerphysics") then
		eqp_accessories.UsedPhysicsMod = "playerphysics"
	end

if eqp_accessories.settings.UseArmor == false then
eqp_accessories.pageTitle = "Accessories"
end

eqp_accessories.RegisteredStats = {
	["defense"] = {default=0,numType="flat",name="Defense"},
	["attack"] = {default=0,numType="percent",name="Attack Damage"},
	["reduction"] = {default=0,max=(eqp_accessories.settings.defType==2 and 90 or nil),numType=(eqp_accessories.settings.defType==2 and "percent" or "flat"),name="Damage Reduction"},
	["max_hp"]={default=0,name="Health Bonus"},
	["dodge"] = {default=0,max=90,numType="percent",name="Dodge Chance"},
	["regen"] = {default=0,name="Regeneration"},
	["speed"] = {default=1,numType="flat",name="Walking Speed"},
	["gravity"] = {default=1},
	["jump"] = {default=1},
	["digSpeed"] = {default=0,numType="percent",name="Digging Speed"},
	["FlyTime"] = {default=0,name="Flight Duration"},
	["FireRes"] = {default=0,name="Fire Ressistance"},
	["thorns"] = {default=0,numType="percent",name="Thorns"},
}

if core.get_modpath("mcl_damage") then
 eqp_accessories.RegisteredStats["thorns"] = nil
end

if eqp_accessories.settings.UseHealthBoost==false then
	eqp_accessories.RegisteredStats["max_hp"] = nil
end



function eqp_accessories.DefenseFormula(def)
	if def>=0 then
	return math.floor( (def / (def+(4*eqp_accessories.settings.defPerDMG)))*10000 ) / 10000
	else
	return	math.floor( (def / (4*eqp_accessories.settings.defPerDMG))*10000) / 10000
	end
end





core.register_node("equippable_accessories:glowAir_strong", {
		light_source = 12,
		selection_box = {
			type = "fixed",
			fixed = {0,0,0,0,0,0}
		},
		drawtype = "airlike",
		walkable = false,
		buildable_to = true,
		pointable = false,
		paramtype = "light",
		on_timer = function(pos, elapsed, node, timeout)
			core.remove_node(pos)
		end
})
core.register_node("equippable_accessories:glowAir_weak", {
		light_source = 8,
		selection_box = {
			type = "fixed",
			fixed = {0,0,0,0,0,0}
		},
		drawtype = "airlike",
		walkable = false,
		buildable_to = true,
		pointable = false,
		paramtype = "light",
		on_timer = function(pos, elapsed, node, timeout)
			core.remove_node(pos)
		end
})


function eqp_accessories.LightCast(player)
		local name = player:get_player_name()
		if eqp_accessories.plrTempData[name].lastLightCast and eqp_accessories.plrTempData[name].lastLightCast<os.clock() then
		eqp_accessories.plrTempData[name].lastLightCast = os.clock() + 0.1

		local pPos = player:get_pos()
		local pDir = player:get_look_dir()
		pPos.y = pPos.y + 1.45
		local headNode = core.get_node(pPos)
			if headNode.name == "air" then
				core.set_node(pPos,{name="equippable_accessories:glowAir_weak"})
				core.get_node_timer(pPos):start(0.3)
			elseif headNode.name == "equippable_accessories:glowAir_weak" then
				core.get_node_timer(pPos):start(0.3)
			end
		local ePos = {x = pPos.x+(pDir.x*32),y = pPos.y+(pDir.y*32),z = pPos.z+(pDir.z*32)}
		local RC = Raycast(pPos,ePos,true,true)
			local pT = 0
			for pointed_thing in RC do
				if pT == 0 then
				if pointed_thing and pointed_thing.type=="node" then
					local ptPos = core.get_pointed_thing_position(pointed_thing,true)
					local behindNode = core.get_node(ptPos)
					if behindNode.name == "air" then
						core.set_node(ptPos,{name="equippable_accessories:glowAir_strong"})
						core.get_node_timer(ptPos):start(0.3)
					elseif behindNode.name == "equippable_accessories:glowAir_strong" then
						core.get_node_timer(ptPos):start(0.3)
					end
					pT = 1
				end
				end
			end
		end
end


core.register_on_dignode(function(pos, oldnode, digger)
	if math.random(1,10)==1 and digger and digger:is_player() then
	eqp_accessories.DamageAllAccLists(digger,{reason="digging"})
	end
end)





eqp_accessories.secTimer = 0
eqp_accessories.saveTimer = 0
eqp_accessories.UseMiningSpeedApply = true

function eqp_accessories.SecondPassed()
	eqp_accessories.saveTimer = eqp_accessories.saveTimer + 1
	for _, player in ipairs(core.get_connected_players()) do
		local name = player:get_player_name()
		local tempdata = eqp_accessories.plrTempData[name]
			tempdata.durTime = tempdata.durTime + 1
			if tempdata.durTime >= 10 then
				tempdata.durTime = tempdata.durTime-10
				eqp_accessories.DamageAllAccLists(player,{reason="time"})
			end
		if eqp_accessories.ExcessHP[name] == nil then eqp_accessories.ExcessHP[name] = 0 end
		eqp_accessories.ExcessHP[name] = eqp_accessories.ExcessHP[name] + eqp_accessories.GetPlayerStat(name,"regen")
		if eqp_accessories.ExcessHP[name]>=1 then
			local addedHP = math.floor(eqp_accessories.ExcessHP[name])
			eqp_accessories.ExcessHP[name] = eqp_accessories.ExcessHP[name] - addedHP

			local maxHP = player:get_properties().hp_max
			local currHP = player:get_hp()
			local setHP = currHP+addedHP
			if setHP>maxHP then setHP=maxHP end
				if maxHP~=currHP then
				player:set_hp(setHP,{source="regen"})
				end
		end
		if eqp_accessories.ExcessHP[name]<=-1 then
			local addedHP = math.ceil(eqp_accessories.ExcessHP[name])
			eqp_accessories.ExcessHP[name] = eqp_accessories.ExcessHP[name] - addedHP
			player:set_hp(player:get_hp()+addedHP,{source="regen"})
		end
			if eqp_accessories.UseMiningSpeedApply then
			eqp_accessories.ApplyMiningSpeed(player)
			end

		local tempdata = eqp_accessories.plrTempData[name] 
		if tempdata.fResLeft and tempdata.fResLeft < eqp_accessories.GetPlayerStat(name,"FireRes") then
			if tempdata.fResDelay and tempdata.fResDelay > 0 then
				tempdata.fResDelay =  tempdata.fResDelay -1
			else
				eqp_accessories.SetFireResTime(player,2)
			end
		end

		if eqp_accessories.saveTimer>=eqp_accessories.settings.SaveInterval then
			for l,list in pairs(eqp_accessories.InvDatas) do
				eqp_accessories.SaveEquipList(player,l) 
			end
		end
	end
	if eqp_accessories.saveTimer>=eqp_accessories.settings.SaveInterval then eqp_accessories.saveTimer = 0 end
end

core.register_globalstep(function(dtime)
	eqp_accessories.secTimer = eqp_accessories.secTimer + dtime
		if eqp_accessories.secTimer >=1 then 
			eqp_accessories.secTimer = eqp_accessories.secTimer-1 
			eqp_accessories.SecondPassed()
		end
	for _, player in ipairs(core.get_connected_players()) do
	local name = player:get_player_name()
		local controls = player:get_player_control()
		local tempdata = eqp_accessories.plrTempData[name]
		if controls.down or controls.up then
			tempdata.walkedTime = tempdata.walkedTime + dtime
			if tempdata.walkedTime >= 5 then
			tempdata.walkedTime = tempdata.walkedTime-5
			eqp_accessories.DamageAllAccLists(player,{reason="walking"})
			end
		end
		if controls.jump then
			tempdata.flownTime = tempdata.flownTime + dtime
			if tempdata.flownTime >= 3 then
			tempdata.flownTime = tempdata.flownTime-3
			eqp_accessories.DamageAllAccLists(player,{reason="flying"})
			end
		end
	if eqp_accessories.plrSteps[name] then
		for s,step in pairs(eqp_accessories.plrSteps[name]) do
		step.func(player,dtime)
		end
	end
	--core.chat_send_player(name, "test")
	end
end)








function eqp_accessories.ApplyVisual(player,listName,index)
	local pName = player:get_player_name()
		if eqp_accessories.visuals[pName] == nil then
			eqp_accessories.visuals[pName] = {}
		end
		if eqp_accessories.visuals[pName][listName]==nil then
			eqp_accessories.visuals[pName][listName] = {}
		end
		if eqp_accessories.visuals[pName][listName][index] then
			for _,vis in pairs(eqp_accessories.visuals[pName][listName][index]) do
				if vis then vis:remove() end
			end
		end
		eqp_accessories.visuals[pName][listName][index] = {}
		local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
			if inv:get_list(listName) and inv:get_stack(listName, index) then
				local tStack = inv:get_stack(listName, index)
				local stackName = tStack:get_name()
					if inv:get_list(listName.."_vanity") and inv:get_stack(listName.."_vanity", index) and 
					inv:get_stack(listName.."_vanity", index):get_name() ~= "" then
					tStack = inv:get_stack(listName.."_vanity", index)
					stackName = tStack:get_name()
					end
				if stackName~="" then
				local tAccItem = core.registered_items[stackName]
				local tAccMeta = tStack:get_meta()
					local equipVisual = nil

					if tAccItem and tAccItem.equipParams and tAccItem.equipParams.visual then
					equipVisual = tAccItem.equipParams.visual 
					end
					local tSlot = nil
					if eqp_accessories.InvDatas[listName][index]["slotID"] then
					tSlot = eqp_accessories.InvDatas[listName][index]["slotID"]
					end

					if tSlot and tAccItem and tAccItem.equipParams and tAccItem.equipParams.slotVisual and tAccItem.equipParams.slotVisual[tSlot] then
					equipVisual = tAccItem.equipParams.slotVisual[tSlot]
					end

					if equipVisual then
					local tDye = {}
							if inv:get_list(listName.."_dye") and inv:get_stack(listName.."_dye", index) and 
							inv:get_stack(listName.."_dye", index):get_name() ~= "" then
							tDye = core.registered_items[inv:get_stack(listName.."_dye", index):get_name()]
							end
					for _,vis in pairs(equipVisual) do
						local tTextures = {}
						for _,tex in ipairs(vis.textures) do tTextures[_] = vis.textures[_] end
								if tDye and tDye.equipAccDye then
								for _,dyeTex in ipairs(tTextures) do
									tTextures[_] = tTextures[_]..tDye.equipAccDye
								end end
					if vis.overlay then
					for _,ovl in ipairs(vis.overlay) do tTextures[_] = tTextures[_].."^("..ovl.."^"..(tDye and tDye.equipAccDyeOver or "")..")" end
					end
						local txOverride = tAccMeta:get_string("eqp_acc_texture")
						if txOverride ~= "" then
							tTextures[1] = txOverride
							if tDye.equipAccDye then tTextures[1] = tTextures[1]..tDye.equipAccDye end
						end
						local ovOverride = tAccMeta:get_string("eqp_acc_overlay")
						if ovOverride ~= "" then
						tTextures[1] = tTextures[1].."^("..ovOverride.."^"..(tDye and tDye.equipAccDyeOver or "")..")"
						end

						eqp_accessories.visuals[pName][listName][index][_] = core.add_entity(player:get_pos(), "equippable_accessories:equip_display")
							local eqpEnt = eqp_accessories.visuals[pName][listName][index][_]:get_luaentity()
							if eqpEnt then
								eqpEnt.OgTextures = tTextures
								if tDye and tDye.dyeStep then eqpEnt.DyeFunc = tDye.dyeStep end
							end

						eqp_accessories.visuals[pName][listName][index][_]:set_properties({
							textures = tTextures,
							mesh = vis.mesh,
							glow = vis.glow or 0,
							visual_size = vis.size or {x=1,y=1},
							})
						eqp_accessories.visuals[pName][listName][index][_]:set_attach(player,_,vis.position or {x=0,y=0,z=0},vis.rotation or {x=0,y=0,z=0} )
						if vis.anim then eqp_accessories.visuals[pName][listName][index][_]:set_animation({x=vis.anim.x,y=vis.anim.y},vis.anim.s or 24,0) end
					end
					end
				end
			end
end
core.register_entity("equippable_accessories:equip_display",{	
	initial_properties = {
		hp_max = 69420,
		visual = "mesh",
		visual_size = {x=1, y=1},
		mesh = "simple_helmet_cuboid.obj",
		textures = {"eq_acc_slot_empty.png"},
		backface_culling = false,
		collide_with_objects = false,
		pointable = false,
		physical = false,
		collisionbox = {0, 0, 0, 0, 0, 0},
	},
	timer = 0,
	--use_texture_alpha = true,
	on_activate = function(self, staticdata) end,
	on_step = accSetts.DynamicDyes == true and function(self, dtime) 
		if self.DyeFunc then self.DyeFunc(self, dtime) end
		if self.object:get_attach() == nil then self.object:remove() end 
	end or nil
})
function eqp_accessories.MainListName(listName)
return string.gsub(string.gsub(listName,"_vanity",""),"_dye","")
end


function eqp_accessories.StatIncreasedString(stat,amount)
	local tStat = eqp_accessories.RegisteredStats[stat]
	local sName = tStat.name or stat
	local amt = amount
		if tStat.numType and tStat.numType=="percent" then
		amt = amount.."%"
		end
	local str = amt.." "..sName
	return str
end





eqp_accessories.RegisteredStatIcons = {
{["icon"] = "eq_acc_icon_defense.png",["statName"]="defense",["tooltip"] = function(player) 
local df = eqp_accessories.GetPlayerStat(player:get_player_name(),"defense")
local str =  eqp_accessories.StatIncreasedString("defense",df)
if eqp_accessories.settings.defType == 2 then
	if df>=0 then
	str = str.."\nTaken damage reduced by "..(df/eqp_accessories.settings.defPerDMG)
	else
	str = str.."\nTaken damage increased by "..(math.abs(df/eqp_accessories.settings.defPerDMG))
	end
else
	if df>=0 then
	str = str.."\nTaken damage reduced by "..(eqp_accessories.DefenseFormula(df)*100).."%"
	else
	str = str.."\nTaken damage increased by "..((math.abs(eqp_accessories.DefenseFormula(df)))*100).."%"
	end
end
return str
end},
{["icon"] = "eq_acc_icon_reduction.png",["statName"]="reduction",["tooltip"] = function(player) 
local rd = eqp_accessories.GetPlayerStat(player:get_player_name(),"reduction")
local str =  eqp_accessories.StatIncreasedString("reduction",rd)
if eqp_accessories.settings.defType == 2 then
	if rd>=0 then
	str = str.."\nTaken damage reduced by "..rd.."%"
	else
	str = str.."\nTaken damage increased by "..rd.."%"
	end
else
	if rd>=0 then
	str = str.."\nTaken damage reduced by "..rd
	else
	str = str.."\nTaken damage increased by "..math.abs(rd)
	end
end
return str
end},
{["icon"] = "eq_acc_icon_speed.png",["statName"]="speed",["tooltip"] = function(player) 
return eqp_accessories.StatIncreasedString("speed",eqp_accessories.GetPlayerStat(player:get_player_name(),"speed"))
end},
{["icon"] = "eq_acc_icon_regen.png",["statName"]="regen",["tooltip"] = function(player) 
return eqp_accessories.StatIncreasedString("regen",eqp_accessories.GetPlayerStat(player:get_player_name(),"regen"))
end},
{["icon"] = "eq_acc_icon_digging.png",["statName"]="digSpeed",["tooltip"] = function(player) 
local ds = eqp_accessories.GetPlayerStat(player:get_player_name(),"digSpeed")
	if ds>=0 then
	return ds.."% Increased digging speed"
	else
	return math.abs(ds).."% Decreased digging speed"
	end
end},
{["icon"] = "eq_acc_icon_attack.png",["statName"]="attack",["tooltip"] = function(player) 
local atk = eqp_accessories.GetPlayerStat(player:get_player_name(),"attack")
	if atk>=0 then
	return atk.."% Increased attack damage"
	else
	return math.abs(atk).."% Decreased attack damage"
	end
end},
}

if eqp_accessories.settings.UseHealthBoost==true then
table.insert(eqp_accessories.RegisteredStatIcons,{["icon"] = "eq_acc_icon_maxhp.png",["statName"]="max_hp",["tooltip"] = function(player) 
return eqp_accessories.StatIncreasedString("max_hp",eqp_accessories.GetPlayerStat(player:get_player_name(),"max_hp"))
end})
end



function eqp_accessories.SetBonusTooltip(player)
local pName = player:get_player_name()
local str = ""
if eqp_accessories.plrTempData[pName].ArmorSet then
	local aSet = eqp_accessories.plrTempData[pName].ArmorSet
	if eqp_accessories.BonusSets[aSet] and eqp_accessories.BonusSets[aSet]["setBonus"] and eqp_accessories.BonusSets[aSet]["setBonus"].desc then
	str = "\n"..core.colorize("#66ff66","Set Bonus: "..eqp_accessories.BonusSets[aSet]["setBonus"].desc)
	end
end
return str
end

function eqp_accessories.AddStatIcons(player,x,y)
	local addedIcns = ""
	local pName = player:get_player_name()
	local moveX = 0
	local moveY = 0

	local yAdd = 0
	local yAddText = 0
	local xAdd = 0
	local moveAt = (9+StatIcnMoveAdd)

if core.get_modpath("unified_inventory") or (core.get_modpath("mcl_inventory") and eqp_accessories.UsedInvForm == 1) then
x = x -0.125
y = y +0.625
yAdd = 0.125
yAddText = 0.5
xAdd = 0.25
end

if #eqp_accessories.RegisteredStatIcons <= (9+StatIcnMoveAdd) then
y = y +0.5
end
if core.get_modpath("mcl_inventory") then
	y = y - 0.5
	xAdd = 0.125
		if eqp_accessories.UsedInvForm ~= 1 then
		xAdd = -0.125
		end
end


	for _,icn in ipairs(eqp_accessories.RegisteredStatIcons) do
		moveX = _-1
		moveY = math.floor(moveX/moveAt)
		local icnNum = eqp_accessories.GetPlayerStat(pName,icn["statName"])
		if eqp_accessories.RegisteredStats[icn["statName"]] and 
			eqp_accessories.RegisteredStats[icn["statName"]].numType and 
			eqp_accessories.RegisteredStats[icn["statName"]].numType == "percent" then
			icnNum = icnNum.."%"
		end


		addedIcns = addedIcns.."image["..(x+(((_-(moveY*moveAt))*(0.825+xAdd) )-(0.825+xAdd) ))..","..(y+yAdd+(moveY*0.5))..";0.825,0.825;"..(icn["icon"]).."]"..
					"label["..(x+(((_-(moveY*moveAt))*(0.825+xAdd) )-(0.825+xAdd) ))..","..(y+yAddText+(moveY*0.75)+0.175)..";"..(icnNum).."]"
		if icn["tooltip"] then
			addedIcns = addedIcns.."tooltip["..(x+(((_-(moveY*moveAt))*(0.825+xAdd) )-(0.825+xAdd) ))..","..(y+yAdd+(moveY*0.75))..";0.825,0.825;"..icn["tooltip"](player)..eqp_accessories.SetBonusTooltip(player).."]"
		end
			
	end
	return addedIcns
end




function eqp_accessories.SaveEquipList(player,listName)
		local eqpTab = {}
		local pName = player:get_player_name()
		local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
		if inv then
			for _, EquipStack in ipairs(inv:get_list(listName)) do
			table.insert(eqpTab, EquipStack:to_string())
			end
		local meta = player:get_meta()
		meta:set_string("eqpacc_"..listName,core.serialize(eqpTab))
		end
end
function eqp_accessories.LoadEquipList(player,listName)
		local eqpTab = {}
		local pName = player:get_player_name()
		local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
		local meta = player:get_meta()
		local EquipString = meta:get_string("eqpacc_"..listName)
		if EquipString and EquipString ~= "" then
			local EquipList = {}
			for _,EquipStack in ipairs(core.deserialize(EquipString) or {}) do
				table.insert(EquipList, ItemStack(EquipStack))
			end
			inv:set_list(listName,EquipList)
		end
end
function eqp_accessories.HasExceptSlot(slotTab) 
	for _,slot in pairs(slotTab) do
		if eqp_accessories.AnyAccExceptions[_] then
		return true
		end
	end
	return false
end
function eqp_accessories.HasItemEquipped(player,itemName,listName) 
	local pName = player:get_player_name()
	local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
	for _,EquipStack in ipairs(inv:get_list(listName)) do
		if EquipStack:get_name() and EquipStack:get_name() == itemName then
		return true
		end
	end
	return false
end


function eqp_accessories.CanEquipToSlot(player,stack,listname,index)
	local tAccessory = core.registered_items[stack:get_name()]
	if tAccessory and tAccessory.equipParams and tAccessory.equipParams.equipSlots then
		local eqpParSlots = tAccessory.equipParams.equipSlots
		local tSlot = eqp_accessories.InvDatas[listname][index]["slotID"]
		if eqpParSlots[tSlot] or (tSlot=="any" and eqp_accessories.HasExceptSlot(eqpParSlots)==false and not eqp_accessories.HasItemEquipped(player,stack:get_name(),listname)) then
		return 1
		else
		return 0
		end
	else
		return 0
	end
end

function eqp_accessories.AllowPut_equip(player,listname,index,stack)
		return eqp_accessories.CanEquipToSlot(player,stack,listname,index)
end
function eqp_accessories.AllowPut_vanity(player,listname,index,stack)
	local trueName = string.gsub(listname,"_vanity","")
		return eqp_accessories.CanEquipToSlot(player,stack,trueName,index)
end
function eqp_accessories.AllowPut_dye(player,listname,index,stack)
	local trueName = string.gsub(listname,"_dye","")
		local tDye = core.registered_items[stack:get_name()]
		if tDye and tDye.equipAccDye then
		return 1
		else
		return 0
		end
end
eqp_accessories.AllowPuts = {}

local AccInv_CB = {
    allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
	return 0
	end,
    allow_put = function(inv, listname, index, stack, player)
		if eqp_accessories.AllowPuts[listname] then return eqp_accessories.AllowPuts[listname](player,listname,index,stack) end
		return 0
	end,
    allow_take = function(inv, listname, index, stack, player)
	return 1
	end,
    on_move = function(inv, from_list, from_index, to_list, to_index, count, player) end,
    	on_put = function(inv, listname, index, stack, player) 
		eqp_accessories.SaveEquipList(player,listname) 
		eqp_accessories.ApplyVisual(player,eqp_accessories.MainListName(listname),index) 
		if eqp_accessories.MainListName(listname)==listname then
			local tAccessory = core.registered_items[stack:get_name()]
			if tAccessory and tAccessory.equipParams and tAccessory.equipParams.OnEquip then
				tAccessory.equipParams.OnEquip(player,"put")
			end
			eqp_accessories.RefreshStats(player) 
			eqp_accessories.RefreshInv(player) 
		end
		
	end,
    	on_take = function(inv, listname, index, stack, player) 
		eqp_accessories.SaveEquipList(player,listname) 
		eqp_accessories.ApplyVisual(player,eqp_accessories.MainListName(listname),index) 
		if eqp_accessories.MainListName(listname)==listname then 
			local tAccessory = core.registered_items[stack:get_name()]
			if tAccessory and tAccessory.equipParams and tAccessory.equipParams.OnUnEquip then
				tAccessory.equipParams.OnUnEquip(player,"taken")
			end
			eqp_accessories.RefreshStats(player) 
			eqp_accessories.RefreshInv(player) 
		end
	end,
}

function eqp_accessories.SwapOrEquipUsed(itemstack, user, pointed_thing)
	local tItem = core.registered_items[itemstack:get_name()]
	if tItem.equipParams and tItem.equipParams.equipSlots then
		local pName = user:get_player_name()
		local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
		local tItemSlots = tItem.equipParams.equipSlots

		local oldstack = nil
		local oldslot = ""
		local oldlist = ""

		for _,invData in pairs(eqp_accessories.InvDatas) do
			for i=1,inv:get_size(_) do
			if inv:get_list(_) and inv:get_stack(_, i) then
				local tStack = inv:get_stack(_, i)
				local tStackName = tStack:get_name()
				local tInvItem = core.registered_items[tStackName]
				local tInvSlot = eqp_accessories.InvDatas[_][i].slotID
					if oldstack==nil and tStackName~="" and tItemSlots[tInvSlot] then
						oldstack = tStack
						oldslot = i
						oldlist = _
					end
					--if oldstack then core.chat_send_all("hasOldStack") end
					if tStackName=="" and tItemSlots[tInvSlot] then

			local newDef = core.registered_items[itemstack:get_name()]
			if newDef and newDef.equipParams and newDef.equipParams.OnEquip then newDef.equipParams.OnEquip(user,"useEquipped") end

						inv:set_stack(_,i,itemstack)
						itemstack:take_item()
							eqp_accessories.ApplyVisual(user,_,i) 
							eqp_accessories.RefreshStats(user)
							eqp_accessories.SaveEquipList(user,_) 
						return itemstack
					end

					--core.chat_send_all("test:".. tStack:get_name().." "..eqp_accessories.InvDatas[_][i].slotID.." aaaaaaa")

			end end
			if oldstack and itemstack:get_count() == 1 then
				local oldDef = core.registered_items[oldstack:get_name()]
				local newDef = core.registered_items[itemstack:get_name()]

			if oldDef and oldDef.equipParams and oldDef.equipParams.OnUnEquip then oldDef.equipParams.OnUnEquip(user,"swapped") end
			if newDef and newDef.equipParams and newDef.equipParams.OnEquip then newDef.equipParams.OnEquip(user,"swapped") end

				inv:set_stack(oldlist,oldslot,itemstack)
				itemstack = oldstack
					eqp_accessories.ApplyVisual(user,oldlist,oldslot) 
					eqp_accessories.RefreshStats(user)
					eqp_accessories.SaveEquipList(user,oldlist) 
				return itemstack
			end
		end
	end
end



function MakeInvDatas()
	local preInv = {}
	for _,InvSlot in ipairs(eqp_accessories.RegInvSlots) do
		if preInv[InvSlot["list"]] == nil then preInv[InvSlot["list"]] = {} end
		table.insert(preInv[InvSlot["list"]],{  
			slotID = InvSlot["slotID"] or "any",
			slotIcon = InvSlot["slotIcon"] or "eq_acc_slot_empty.png",
		})
	end
	eqp_accessories.InvDatas = preInv
end
function eqp_accessories.MakeArmorForm(playerName,params)
local gapY = 0
local sPos = {x=params.posX or 0,y=params.posY or 0}

if core.get_modpath("unified_inventory") then
gapY = 0.25
sPos.x = sPos.x + 0.25
sPos.y = sPos.y + 0.925
end

local armorForm = 
		"image["..(sPos.x*(1+gapY))..","..(sPos.y)..";1.0,1.0;eq_inv_slot_"..(params.slotName or "equip")..".png^"..(params.helmetIcon or "eq_acc_slot_helmet.png").."]"..
		"image["..(sPos.x*(1+gapY))..","..((sPos.y)+1+(gapY))..";1.0,1.0;eq_inv_slot_"..(params.slotName or "equip")..".png^"..(params.breastplateIcon or "eq_acc_slot_breastplate.png").."]"..
		"image["..(sPos.x*(1+gapY))..","..((sPos.y)+2+(gapY*2))..";1.0,1.0;eq_inv_slot_"..(params.slotName or "equip")..".png^"..(params.leggingsIcon or "eq_acc_slot_leggings.png").."]"..
		"list[detached:"..playerName.."_equip_acc;armor"..(params.invType or "")..";"..(sPos.x*(1+gapY))..","..(sPos.y)..";1,3;]"
	return armorForm
end
function eqp_accessories.MakeAccForm(playerName,params)
	local accForm = ""
		local gap = {x=0.0,y=0.0}
		local sPos = {x=params.posX or 1.0,y=params.posY or 0.0}
		local borderCLR = "#000000ff"

		if core.get_modpath("unified_inventory") or (core.get_modpath("mcl_inventory") and eqp_accessories.UsedInvForm == 1) then
		gap = {x=0.25,y=0.25}
		sPos.x = sPos.x + 0.25
		sPos.y = sPos.y + 0.925
		borderCLR = "#00000000"
		end
		if core.get_modpath("mcl_inventory") then
		sPos.x = sPos.x - 0.825
			if eqp_accessories.UsedInvForm ~= 1 then
			sPos.x = sPos.x - 0.175
			end
		end
			if core.get_modpath("3d_armor") then
			sPos.x = sPos.x - 1
			end

		local acmCol = 6 + eqp_accessories.settings.AccColumns + ExtraAccCols 
		local moveX = 0
		local moveY = 0
		local cols = 6 + eqp_accessories.settings.AccColumns + ExtraAccCols 
	local inv = core.get_inventory({type="detached", name=playerName.."_equip_acc"})
	if eqp_accessories.InvDatas and eqp_accessories.InvDatas[params.InvName] then
	for _,invData in pairs(eqp_accessories.InvDatas[params.InvName] ) do
		moveX = _-1
		moveY = math.floor(moveX/cols)
		accForm = accForm.."image["..(( (sPos.x)+moveX+ (gap.x*(_-(1+(moveY*acmCol))))  ) -(moveY*cols))..","..((sPos.y)+(moveY*(1+gap.y) ))..";1.0,1.0;eq_inv_slot_"..(params.slotName or "equip")..".png^"..(params.slotIcon or invData.slotIcon or "eq_acc_slot_empty.png").."]"
	end end
	accForm = accForm..
		"list[detached:"..playerName.."_equip_acc;"..(params.InvName or "accessories")..""..(params.invType or "")..";"..(sPos.x)..","..(sPos.y)..";"..cols..",4;]"..
		"listring[current_player;main]"..
		"listring[detached:"..playerName.."_equip_acc;"..(params.InvName or "accessories")..""..(params.invType or "").."]"
		if eqp_accessories.UsedInvForm == 0 or not core.get_modpath("mcl_inventory") then 
			accForm=accForm.."listcolors[#00000066;#ffffff44;"..borderCLR..";#114455;#ffffff]" 
		end
	return accForm
end
function eqp_accessories.MakeInventories(player)
	local inv = core.create_detached_inventory(player:get_player_name().."_equip_acc", AccInv_CB, player:get_player_name())
		for _,invData in pairs(eqp_accessories.InvDatas) do
			inv:set_size(_,#invData)
			inv:set_size(_.."_vanity",#invData)
			inv:set_size(_.."_dye",#invData)
			eqp_accessories.AllowPuts[_] = eqp_accessories.AllowPut_equip
			eqp_accessories.AllowPuts[_.."_vanity"] = eqp_accessories.AllowPut_vanity
			eqp_accessories.AllowPuts[_.."_dye"] = eqp_accessories.AllowPut_dye
		end
end

eqp_accessories.HandlePhysOverride = {
	["standard"] = function(player,pTab) player:set_physics_override({speed=pTab["speed"],gravity=pTab["gravity"],jump=pTab["jump"]}) end,
	["pova"] = function(player,pTab) 
		local regStats = eqp_accessories.RegisteredStats
		pova.add_override(player:get_player_name(), "eqp_acc", {
			speed = pTab["speed"] - (regStats["speed"].default or 1), 
			jump = pTab["jump"] - (regStats["jump"].default or 1), 
			gravity = pTab["gravity"] - (regStats["gravity"].default or 1)
		})
		pova.do_override(player)
	end,
	["player_monoids"] = function(player,pTab) 
		player_monoids.speed:add_change(player,pTab["speed"],
			"eqp_acc")
		player_monoids.jump:add_change(player,pTab["jump"],
			"eqp_acc")
		player_monoids.gravity:add_change(player,pTab["gravity"],
			"eqp_acc")
	end,
	["playerphysics"] = function(player,pTab) 
		playerphysics.add_physics_factor(player, "speed", "eqp_acc",pTab["speed"])
		playerphysics.add_physics_factor(player, "gravity", "eqp_acc",pTab["gravity"])
		playerphysics.add_physics_factor(player, "jump", "eqp_acc",pTab["jump"])
	end,
}

eqp_accessories.TempSpeeds = {}
eqp_accessories.tempSpeedTab = {
	["standard"] = function(player,extraspeed,speedname) 
		local pName = player:get_player_name()
		if eqp_accessories.TempSpeeds[pName] == nil then eqp_accessories.TempSpeeds[pName] = {} end
		eqp_accessories.TempSpeeds[pName][speedname] = extraspeed	
		local totalExtra = 0
		for _,xSpeed in pairs(eqp_accessories.TempSpeeds[pName]) do
			totalExtra = totalExtra + xSpeed
		end

	player:set_physics_override({speed=eqp_accessories.GetPlayerStat(player:get_player_name(),"speed")+totalExtra}) 
	end,
	["pova"] = function(player,extraspeed,speedname) 
		pova.add_override(player:get_player_name(),speedname,{speed = extraspeed})
		pova.do_override(player)
	end,
	["player_monoids"] = function(player,extraspeed,speedname) 
		player_monoids.speed:add_change(player,extraspeed+1,speedname)
	end,
	["playerphysics"] = function(player,extraspeed,speedname) 
		playerphysics.add_physics_factor(player, "speed", speedname,extraspeed+1)
	end,
}
function eqp_accessories.AddTempSpeed(player,extraspeed,speedname)
	eqp_accessories.tempSpeedTab[eqp_accessories.UsedPhysicsMod~="" and eqp_accessories.UsedPhysicsMod or "standard"](player,extraspeed,speedname)
end


function eqp_accessories.UseHPnumberHud(player)
	local pName = player:get_player_name()
	local maxHP = player:get_properties().hp_max 
	local currHP = player:get_hp()
	if maxHP~=20 then
		if eqp_accessories.plrTempData[pName]["HPhud"]==nil then
		eqp_accessories.plrTempData[pName]["HPhud"] = player:hud_add({
					type = "text",
					position = {x=0.5, y=1.0},
					offset = {x=-144, y=-92},
					name = "HP",
					number = 0xFFAADD,
					text = ""..currHP.." / "..maxHP.."",
					})
		else
			player:hud_change(eqp_accessories.plrTempData[pName]["HPhud"], "text", currHP.." / "..maxHP)
		end
	end
		if maxHP==20 and eqp_accessories.plrTempData[pName]["HPhud"] then
			player:hud_remove(eqp_accessories.plrTempData[pName]["HPhud"])
			eqp_accessories.plrTempData[pName]["HPhud"] = nil
		end
end

function eqp_accessories.OnStatsRefreshed(player,statTable)
	local playerName = player:get_player_name()
	local RegStats = eqp_accessories.RegisteredStats
	local tempdata = eqp_accessories.plrTempData[playerName]
	local playerTags = tempdata.tags
	if eqp_accessories.PlayerStats[playerName] == nil then eqp_accessories.PlayerStats[playerName] = {} end
	for _,stat in pairs(statTable) do
		eqp_accessories.PlayerStats[playerName][_] = (stat.add * stat.mult)
		if RegStats[_].max and eqp_accessories.PlayerStats[playerName][_]>RegStats[_].max then eqp_accessories.PlayerStats[playerName][_]=RegStats[_].max end
		if RegStats[_].min and eqp_accessories.PlayerStats[playerName][_]<RegStats[_].min then eqp_accessories.PlayerStats[playerName][_]=RegStats[_].min end
	end
	for i,CBfunc in ipairs(eqp_accessories.callBacks.OnRefreshStats) do
		eqp_accessories.PlayerStats[playerName] = CBfunc(player,eqp_accessories.PlayerStats[playerName])
	end
	if playerTags["SlowFall"] then
		eqp_accessories.AddPlayerStep(player,"SlowFall",
		function(player,dtime)
			local plrVel = player:get_velocity()
			local controls = player:get_player_control()
			if controls.jump then
			if plrVel.y < -2 then
				player:add_velocity({x=0,y=-plrVel.y/5,z=0})
			end
			end
		end)
	else
		eqp_accessories.RemovePlayerStep(player,"SlowFall")
	end
	local pStats = eqp_accessories.PlayerStats[playerName]
		local physTable = {speed=pStats["speed"] or 1,gravity=pStats["gravity"] or 1,jump=pStats["jump"] or 1}
		if eqp_accessories.UsedPhysicsMod == "" then
			eqp_accessories.HandlePhysOverride["standard"](player,physTable)
		else
			eqp_accessories.HandlePhysOverride[eqp_accessories.UsedPhysicsMod](player,physTable)
		end
	--core.chat_send_all(core.serialize(eqp_accessories.PlayerStats[playerName]))
		if eqp_accessories.settings.UseHealthBoost == true then
		player:set_properties({ hp_max = eqp_accessories.settings.InitMaxHP+eqp_accessories.GetPlayerStat(playerName,"max_hp") })
		end


	if eqp_accessories.settings.HPnumDisplay == true then
		eqp_accessories.UseHPnumberHud(player)
	end
	
	if tempdata.fResLeft == nil then tempdata.fResLeft=0 end
	if tempdata.fResLeft>eqp_accessories.GetPlayerStat(playerName,"FireRes") then eqp_accessories.SetFireResTime(player,0) end
		if eqp_accessories.UsedInvMod == "sfinv" then
		sfinv.set_player_inventory_formspec(player)
		end
end
function eqp_accessories.RefreshStats(player)

	local tStats = {}
	local playerName = player:get_player_name()
	local inv = core.get_inventory({type="detached", name=playerName.."_equip_acc"})
	for _,stat in pairs(eqp_accessories.RegisteredStats) do
		tStats[_]={add = stat.default, mult = 1.0}
	end
	for i,CBfunc in ipairs(eqp_accessories.callBacks.RefreshingStats) do
		tStats = CBfunc(player,tStats)
	end
	--core.chat_send_all(core.serialize(initStats))
	eqp_accessories.plrTempData[playerName].tags = {}
	for d,invData in pairs(eqp_accessories.InvDatas) do
			for _,listItem in pairs(inv:get_list(d)) do
			local tItem = core.registered_items[listItem:get_name()]
			local tMeta = listItem:get_meta()
			if tItem and tItem.equipParams then
				local itmTags = tItem.equipParams.tags
				if itmTags then
				for t,tag in pairs(itmTags) do
				eqp_accessories.plrTempData[playerName].tags[t] = tag
				end end
				local itmStats = tMeta:get_string("eqp_acc_stats")~="" and core.deserialize(tMeta:get_string("eqp_acc_stats")) or tItem.equipParams.stats
				if itmStats then
					for n,sVal in pairs(itmStats) do
					if tStats[n] then 
						tStats[n].add = tStats[n].add + (sVal.add or 0)
						tStats[n].mult = tStats[n].mult * (sVal.mult or 1.0)
					end
					end
				end
				local metaStatNames = eqp_accessories.StatMetaToCheck
				for msK,MSName in ipairs(metaStatNames) do
					if tMeta:get_string(MSName) ~= "" then
						local mStats = core.deserialize(tMeta:get_string(MSName))
						if mStats then
							for n,sVal in pairs(mStats) do
								if tStats[n] then 
									tStats[n].add = tStats[n].add + (sVal.add or 0)
									tStats[n].mult = tStats[n].mult * (sVal.mult or 1.0)
								end
								end
						end
					end
				end

			end end
	end
	if inv:get_list("armor") then   
		eqp_accessories.RemovePlayerStep(player,"SetBonusStep")
			if eqp_accessories.plrTempData[playerName].ArmorSet then
			eqp_accessories.plrTempData[playerName].ArmorSet = ""
			end
		local helmStack = inv:get_stack("armor",1)
		if helmStack:get_name() and eqp_accessories.BonusSets[helmStack:get_name()] then
			local bSet = eqp_accessories.BonusSets[helmStack:get_name()]
				local bPlate = inv:get_stack("armor",2):get_name()
				local leggings = inv:get_stack("armor",3):get_name()
			if (bSet["breastplate"]==nil or bSet["breastplate"]==bPlate) and (bSet["leggings"]==nil or bSet["leggings"]==leggings) then
			--core.chat_send_all("hasSet")

				eqp_accessories.plrTempData[playerName].ArmorSet = helmStack:get_name()
				if bSet["setBonus"] then
				local sBonus = bSet["setBonus"]
					if sBonus.stats then
					for _,bstat in pairs(sBonus.stats) do
						tStats[_]={add = tStats[_].add+(bstat.add or 0), mult = tStats[_].mult+(bstat.mult or 0)}
					end end
					if sBonus.stepFunc then eqp_accessories.AddPlayerStep(player,"SetBonusStep",sBonus.stepFunc) end
				end 
			end
		end
	end
	eqp_accessories.OnStatsRefreshed(player,tStats)
end


function eqp_accessories.PhysicConflictWarn(pName)
	local warn = 
		core.colorize("#ff0000","[WARNING!]")..
		core.colorize("#ffff00"," You are using 'equippable accessories' mod, alongside the following player physics altering mods:\n")..
		core.colorize("#ff8800","("..(table.concat(eqp_accessories.PhysicsConflictMods,","))..")\n")..
		core.colorize("#ffff00"," To avoid potential conflicts in player physics overrides, install one of the following physics-handling mods:\n")..
		core.colorize("#88ff00","(pova, player_monoids)")
		
	core.chat_send_player(pName,warn)
end

core.register_on_joinplayer(function(player)
	eqp_accessories.MakeInventories(player)
	local pName = player:get_player_name()
	eqp_accessories.plrTempData[pName] = {walkedTime = 0,flownTime = 0,durTime = 0}
	local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
	core.after(0.25,function()
		for _,eqpList in pairs(inv:get_lists()) do
			eqp_accessories.LoadEquipList(player,_)
			--core.chat_send_all("list: ".._)
		end
		for _,invData in pairs(eqp_accessories.InvDatas) do
			for n,invSlot in ipairs(invData) do
			eqp_accessories.ApplyVisual(player,_,n)
			if eqp_accessories.MainListName(_)==_ then 
				local tStack = inv:get_stack(_,n)
				if tStack and core.registered_items[tStack:get_name()] then
					local tAccessory = core.registered_items[tStack:get_name()]
					if tAccessory and tAccessory.equipParams and tAccessory.equipParams.OnEquip then tAccessory.equipParams.OnEquip(player,"loaded") end
				end 
			end
		end end
		eqp_accessories.RefreshStats(player)
			if #eqp_accessories.PhysicsConflictMods > 0 and eqp_accessories.UsedPhysicsMod == "" then
			eqp_accessories.PhysicConflictWarn(pName)
			end

------
--eqp_accessories.RemovePlayerStep(player,"DoubleJump")
-----

	end)

end)



function eqp_accessories.SetFireResTime(player,time)
	local name = player:get_player_name()
		local tempdata = eqp_accessories.plrTempData[name] 
		if tempdata.fResLeft then
			if core.get_modpath("mcl_damage") and time<0 then 
			tempdata.fResLeft = tempdata.fResLeft + (time/2)
			else
			tempdata.fResLeft = tempdata.fResLeft + time
			end
		end
	if time <0 then
		tempdata.fResDelay = 3
	end
	local fResStat = eqp_accessories.GetPlayerStat(name,"FireRes")
		if tempdata.fResLeft >= fResStat then 
			tempdata.fResLeft = fResStat 
			if eqp_accessories.plrTempData[name].fireHud then player:hud_remove(eqp_accessories.plrTempData[name].fireHud) eqp_accessories.plrTempData[name].fireHud=nil end
		end
		if tempdata.fResLeft < 0 then tempdata.fResLeft = 0 end

	local fResStat = eqp_accessories.GetPlayerStat(name,"FireRes")
	local fResToDisp = tempdata.fResLeft
	if fResStat > 20 then
		fResToDisp = math.floor(fResToDisp * (20/fResStat))
	end


	if tempdata.fResLeft~=fResStat and eqp_accessories.plrTempData[name].fireHud == nil then
	eqp_accessories.plrTempData[name].fireHud = player:hud_add({
					type = "statbar",
					position = {x=0.5, y=1.0},
					offset = {x=-192, y=-160},
					name = "FireRes",
					size = {x = 24, y = 24},
					text = "eq_acc_fireres.png",
					number = math.floor(fResToDisp),
					})
	end
	if eqp_accessories.plrTempData[name].fireHud then player:hud_change(eqp_accessories.plrTempData[name].fireHud,"number",math.floor(fResToDisp)) end
end





function eqp_accessories.JumpStep(player)
eqp_accessories.AddPlayerStep(player,"DoubleJump",
function(player,dtime)
	local name = player:get_player_name()
	local pos = player:get_pos()
	local controls = player:get_player_control()

	if eqp_accessories.plrTempData[name].jumped==nil then eqp_accessories.plrTempData[name].jumped=0 end
	local plrTemp = eqp_accessories.plrTempData[name]
	if pos then
		local resetJump = false
		local RC = core.raycast(pos,{x=pos.x,y=pos.y-0.175,z=pos.z}, true, true)
		for InWay in RC do
			if InWay.type=="object" then 
				local eprops = InWay.ref:get_properties() 
				if (not core.is_player(InWay.ref)) and eprops.physical==true and eprops.collide_with_objects==true then
				resetJump = true
				--core.chat_send_all(InWay.ref:get_luaentity().name)
			end end
			if InWay.type=="node" then
				local belownode = core.get_node(core.get_pointed_thing_position(InWay,true))
				local belowNodeDef = core.registered_nodes[belownode.name]
				if belowNodeDef and belowNodeDef.walkable==true then
				resetJump = true
				end
			end
		end
		local plrVel = player:get_velocity()
		if resetJump==false then
			if plrTemp.jumped == 1 and not controls.jump and plrTemp.Flights[plrTemp.currFlight]==nil then
				plrTemp.jumped = 2
			end
			if controls.jump and plrTemp.jumped==2 and plrTemp.Flights[plrTemp.currFlight]==nil then
			local jumpPars = plrTemp.dJumps[plrTemp.currJump]
				if jumpPars.func then jumpPars.func(player) end
				if plrVel.y < 0 then
					player:add_velocity({x=0,y=-plrVel.y,z=0})
				end
					player:add_velocity({x=0,y=8.75,z=0})
				eqp_accessories.DamageAllAccLists(player,{reason="doubleJump"})
				plrTemp.currJump = plrTemp.currJump + 1
				if plrTemp.currJump > #plrTemp.dJumps then
					plrTemp.jumped = 0
				else
					plrTemp.jumped = 1
				end
			end 
		else	
			plrTemp.jumped = 1
			plrTemp.currJump = 1
		end
	end
end)
end

function eqp_accessories.AddDoubleJump(player,JumpName,jumpParams)
	local name = player:get_player_name()
	local plrTemp = eqp_accessories.plrTempData[name]
		plrTemp.jumped = 0
		plrTemp.currJump = 1
		if plrTemp.currFlight==nil then plrTemp.currFlight = 1 end
	if plrTemp.dJumps == nil then plrTemp.dJumps = {} end
	if plrTemp.Flights == nil then plrTemp.Flights = {} end
	for _,dJ in ipairs(plrTemp.dJumps) do
		if dJ.name == JumpName then
		table.remove(plrTemp.dJumps,_)
		break
		end
	end
	local jumpPars = jumpParams
	jumpPars.name = JumpName
	table.insert(plrTemp.dJumps,jumpPars)
	eqp_accessories.JumpStep(player)
end
function eqp_accessories.RemoveDoubleJump(player,JumpName)
	local name = player:get_player_name()	
	if eqp_accessories.plrTempData[name].dJumps then
		local plrTemp = eqp_accessories.plrTempData[name]
		for _,dJ in ipairs(plrTemp.dJumps) do
			if dJ.name == JumpName then
			table.remove(plrTemp.dJumps,_)
			break
			end
		end
		if #plrTemp.dJumps == 0 then
		eqp_accessories.RemovePlayerStep(player,"DoubleJump")
		end
	end
end

eqp_accessories.FlightItemDesc = core.colorize("#00ff88","Allows temporary flight by holding 'jump'")

function eqp_accessories.FlightStep(player)
eqp_accessories.AddPlayerStep(player,"Flight",
function(player,dtime)
	local name = player:get_player_name()
	local pos = player:get_pos()
	local controls = player:get_player_control()
	local plrTemp = eqp_accessories.plrTempData[name]
	if plrTemp.FlightUsed==nil then plrTemp.FlightUsed=0 end
		--core.chat_send_player(name,)
		local belowPos = {x=pos.x,y=pos.y-0.125,z=pos.z}
		local plrVel = player:get_velocity()
		local belownode = core.get_node(belowPos)
		local belowNodeDef = core.registered_nodes[belownode.name]
		if belowNodeDef and belowNodeDef.walkable==false then
			if controls.jump then
			if plrTemp.Flights[plrTemp.currFlight] then
				plrTemp.FlightUsed = plrTemp.FlightUsed + dtime
				if plrVel.y < (plrTemp.Flights[plrTemp.currFlight].maxVelocity or 5.0) then
				player:add_velocity({x=0,y=(plrTemp.Flights[plrTemp.currFlight].acceleration or 25.0)*dtime,z=0})
				end
				if plrTemp.FlightUsed >= ((plrTemp.Flights[plrTemp.currFlight].flightTime or 5)+eqp_accessories.GetPlayerStat(name,"FlyTime")) then
					plrTemp.FlightUsed = 0
					plrTemp.currFlight = plrTemp.currFlight + 1
				end
			end
			end
		else
			plrTemp.FlightUsed = 0
			plrTemp.currFlight = 1
		end
end)
end
function eqp_accessories.AddFlight(player,FlightName,flightParams)
	local name = player:get_player_name()
	local plrTemp = eqp_accessories.plrTempData[name]
		if plrTemp.currFlight==nil then plrTemp.currFlight = 1 end
	if plrTemp.Flights == nil then plrTemp.Flights = {} end
	for _,fl in ipairs(plrTemp.Flights) do
		if fl.name == FlightName then
		table.remove(plrTemp.Flights,_)
		break
		end
	end
	local flyPars = flightParams
	flyPars.name = FlightName
	table.insert(plrTemp.Flights,flyPars)
	eqp_accessories.FlightStep(player)
end
function eqp_accessories.RemoveFlight(player,FlightName)
	local name = player:get_player_name()	
	if eqp_accessories.plrTempData[name].Flights then
		local plrTemp = eqp_accessories.plrTempData[name]
		for _,fl in ipairs(plrTemp.Flights) do
			if fl.name == FlightName then
			table.remove(plrTemp.Flights,_)
			break
			end
		end
		if #plrTemp.Flights == 0 then
		eqp_accessories.RemovePlayerStep(player,"Flight")
		end
	end
end




function eqp_accessories.ApplyMiningSpeed(player)

	local WieldItemstack = player:get_wielded_item()
		--core.chat_send_all(WieldItemstack:get_name())
	local pName = player:get_player_name()
	local toolName = WieldItemstack:get_name()
	--if WieldItemstack:get_definition().short_description then core.chat_send_player(pName, WieldItemstack:get_definition().short_description) end
	if core.get_item_group(toolName, "digspeed_excluded")<=0 and WieldItemstack:get_tool_capabilities() ~= nil and WieldItemstack:get_definition().tool_capabilities and toolName ~= "" then
		local itmStackMeta = WieldItemstack:get_meta()
		local digSpeed = eqp_accessories.GetPlayerStat(pName,"digSpeed")
		local lsWield = eqp_accessories.LastWields[pName]
		local wIDX = player:get_wield_index()
	if lsWield==nil or lsWield.idx~=wIDX or lsWield.name ~= toolName or itmStackMeta:get_int("LastAccDigEffc") ~= digSpeed then
		eqp_accessories.LastWields[pName] = {idx = wIDX,name = toolName}
		--core.chat_send_player(pName, "dig speed applied")
		itmStackMeta:set_int("LastAccDigEffc",digSpeed)
		local OGtool = core.registered_items[toolName]
		local newCaps = {}
		for _,gcap in pairs(OGtool.tool_capabilities.groupcaps) do
			if gcap.times then
			newCaps[_] = {times={}, uses=gcap.uses or 0, maxlevel=gcap.maxlevel or 1}
				for t,gTime in pairs(gcap.times) do
				newCaps[_].times[t] = (digSpeed <= -100 and 999999 or (gTime/(1+(digSpeed/100)) ) )
				end
				--core.chat_send_player(pName, core.serialize(newCaps))
			end
		end
		itmStackMeta:set_tool_capabilities({
			full_punch_interval = OGtool.tool_capabilities.full_punch_interval or 1,
			max_drop_level = OGtool.tool_capabilities.max_drop_level or 1, 
			groupcaps = newCaps,
			damage_groups = OGtool.tool_capabilities.damage_groups or {},
		})
		player:set_wielded_item(WieldItemstack)
	end 
end
end


eqp_accessories.TagDescs = {["SlowFall"]=core.colorize("#00ffff","Allows slow fall while holding 'jump'")}


function eqp_accessories.GenerateItemDesc(tItem)
	local desc=""
	local regStats = eqp_accessories.RegisteredStats
	if tItem.equipParams then
		local eqpPars = tItem.equipParams
		if eqpPars.equipSlots then
			local SlotString = ""
			local eqpSlots = {}
			for sl,slot in pairs(eqpPars.equipSlots) do
				table.insert(eqpSlots,sl)
			end
			if #eqpSlots >= 10 then
				SlotString = core.colorize("#00ff44","Yes.")
			else
				for i=1,#eqpSlots do
					SlotString = SlotString.."'"..eqpSlots[i].."'"
					if i ~= #eqpSlots then SlotString=SlotString..", " end
				end
				SlotString = core.colorize("#ffaa00",SlotString)
			end
			desc = desc.."\n"..core.colorize("#0044ff","Equip slot: "..SlotString)
		end
		if eqpPars.stats then
			for _,stat in pairs(eqpPars.stats) do
				if regStats[_] then
				if stat.add then
				desc = desc..core.colorize("#00ccff","\n"..stat.add..((regStats[_].numType and regStats[_].numType=="percent") and "%" or "").." "..(regStats[_].name or _))
				end
				if stat.mult then
				desc = desc..core.colorize("#0088ff","\nx"..stat.mult.." "..(regStats[_].name or _))
				end
				end
			end
		end
		if eqpPars.tags then
			for _,tag in pairs(eqpPars.tags) do
				if eqp_accessories.TagDescs[_] then
				desc = desc.."\n"..eqp_accessories.TagDescs[_]
				end
			end
		end
		if eqpPars.extraAccDesc then desc = desc.."\n"..eqpPars.extraAccDesc end
	end
	

	return desc
end	


eqp_accessories.dmgBonusGroups = {["fleshy"]=true}


function eqp_accessories.InitDmgBonus()
for _,ent in pairs(core.registered_entities) do
	local OldPunch = ent.on_punch
		ent.on_punch = function(self, hitter,time_from_last_punch, tool_capabilities, direction, pos)
		if self.health ~= nil and hitter:is_player() and tool_capabilities and tool_capabilities.damage_groups then
			for g,group in pairs(tool_capabilities.damage_groups) do
			if eqp_accessories.dmgBonusGroups[g] then
				local atk_bonus = eqp_accessories.GetPlayerStat(hitter:get_player_name(),"attack")
				tool_capabilities.damage_groups[g] = tool_capabilities.damage_groups[g] * (1 + (atk_bonus/100))	
			end end 
			eqp_accessories.DamageAllAccLists(hitter,{reason="attacking"})
		end
	if OldPunch ~= nil then
	OldPunch(self, hitter, time_from_last_punch, tool_capabilities, direction, pos)
	end 
end end
end



core.register_on_mods_loaded(function()
	MakeInvDatas()
	if eqp_accessories.settings.UseExtendedDesc == true then
	local AddedDesc = ""
	for _,item in pairs(core.registered_items) do
		if item.equipParams then
			local override = {}
			if not item.equipParams.noUseEquip then
				override.on_secondary_use = function(itemstack, user, pointed_thing)
					return eqp_accessories.SwapOrEquipUsed(itemstack, user, pointed_thing)
				end
				override.on_place = function(itemstack, user, pointed_thing)
					if user and not user:get_player_control().sneak then
					return eqp_accessories.SwapOrEquipUsed(itemstack, user, pointed_thing)
					end
				end
			end
			AddedDesc = eqp_accessories.GenerateItemDesc(item)
			override.short_description = item.description
			override.description = (item.short_description or item.description)..AddedDesc

			core.override_item(_,override)
		end
	end
	end
	eqp_accessories.InitDmgBonus()
end)

-------
------- The standard equippable accessories form:
-------
if eqp_accessories.settings.preset ~= 6 then
function eqp_accessories.receive_fields(player, fields)
	local name = player:get_player_name()
	if fields.eqpacc_equip then
		eqp_accessories.pages[name]=1
	end
	if fields.eqpacc_vanity then
		eqp_accessories.pages[name]=2
	end
	if fields.eqpacc_dye then
		eqp_accessories.pages[name]=3
	end
	return true
end

eqp_accessories.MiscPartpos = {
["standard"] = {eqpBTN={x=0,y=3.0},vanBTN={x=0,y=3.65},dyeBTN={x=0,y=4.3},pLabel={x=0.75,y=3}},
["unified_inventory"] = {eqpBTN={x=4,y=0.1},vanBTN={x=4.75,y=0.1},dyeBTN={x=5.5,y=0.1},pLabel={x=6.4,y=0.325}}
}




function eqp_accessories.form(player)
	local name = player:get_player_name()
	local slotPosX = 2
	local GotArmor = eqp_accessories.settings.UseArmor
	local miscPos = eqp_accessories.MiscPartpos["standard"]
	if core.get_modpath("unified_inventory") then
		miscPos = eqp_accessories.MiscPartpos["unified_inventory"]
	end
	if core.get_modpath("mcl_inventory") and eqp_accessories.UsedInvForm == 1 then
		miscPos = eqp_accessories.MiscPartpos["unified_inventory"]
	end

	if GotArmor==false then slotPosX=1 end

	if eqp_accessories.pages[name] == nil then eqp_accessories.pages[name]=1 end
	local form = 
		"image_button["..miscPos.eqpBTN.x..","..miscPos.eqpBTN.y..";0.75,0.75;eq_acc_button_equip.png;eqpacc_equip;]"..
		"image_button["..miscPos.vanBTN.x..","..miscPos.vanBTN.y..";0.75,0.75;eq_acc_button_vanity.png;eqpacc_vanity;]"..
		"image_button["..miscPos.dyeBTN.x..","..miscPos.dyeBTN.y..";0.75,0.75;eq_acc_button_dye.png;eqpacc_dye;]"..
		"tooltip[eqpacc_equip;Equip]"..
		"tooltip[eqpacc_vanity;Vanity]"..
		"tooltip[eqpacc_dye;Dye]"

		if eqp_accessories.pages[name]==1 then
		if GotArmor == true then form = form.. eqp_accessories.MakeArmorForm(name,{slotName="equip"}) end
		form = form.. eqp_accessories.MakeAccForm(name,{slotName="equip",InvName="accessories",posX=slotPosX})..
			"label["..miscPos.pLabel.x..","..miscPos.pLabel.y..";Equip]"..
			eqp_accessories.AddStatIcons(player,0.675,3.75)
		end
		if eqp_accessories.pages[name]==2 then
		if GotArmor == true then form = form.. eqp_accessories.MakeArmorForm(name,{slotName="vanity",invType="_vanity"}) end
		form = form.. eqp_accessories.MakeAccForm(name,{slotName="vanity",InvName="accessories",invType="_vanity",posX=slotPosX})..
			"label["..miscPos.pLabel.x..","..miscPos.pLabel.y..";Vanity]"
		end
		if eqp_accessories.pages[name]==3 then
		if GotArmor == true then form = form.. eqp_accessories.MakeArmorForm(name,{slotName="dye",invType="_dye"}) end
		form = form.. eqp_accessories.MakeAccForm(name,{slotName="dye",InvName="accessories",invType="_dye",posX=slotPosX})..
			"label["..miscPos.pLabel.x..","..miscPos.pLabel.y..";Dye]"
		end
return form
end

end
--------
--------

--------
-------- More terraria-like preset, with no specific accessory slots
--------
if eqp_accessories.settings.preset == 2 then

function eqp_accessories.receive_fields(player, fields)
	local name = player:get_player_name()
	return true
end
function eqp_accessories.form(player)
	local name = player:get_player_name()
	local slotPosX = 3.1
	local GotArmor = eqp_accessories.settings.UseArmor
	if GotArmor==false then slotPosX=1 end

	if eqp_accessories.pages[name] == nil then eqp_accessories.pages[name]=1 end
	local form = ""
		if GotArmor == true then form = form.. 
			eqp_accessories.MakeArmorForm(name,{slotName="equip",posX=-0.1,}).. 
			eqp_accessories.MakeArmorForm(name,{slotName="vanity",invType="_vanity",posX=0.75,helmetIcon="eq_acc_slot_helmet_vanity.png",breastplateIcon="eq_acc_slot_breastplate_vanity.png",leggingsIcon="eq_acc_slot_leggings_vanity.png"})..
			eqp_accessories.MakeArmorForm(name,{slotName="dye",invType="_dye",posX=1.6,helmetIcon="eq_acc_slot_dye.png",breastplateIcon="eq_acc_slot_dye.png",leggingsIcon="eq_acc_slot_dye.png"}) 

		end
		form = form.. eqp_accessories.MakeAccForm(name,{slotName="equip",InvName="accessories",posX=slotPosX})..
			eqp_accessories.MakeAccForm(name,{slotName="vanity",invType="_vanity",InvName="accessories",posX=slotPosX,posY=0.925,slotIcon="eq_acc_slot_vanity.png"})..
			eqp_accessories.MakeAccForm(name,{slotName="dye",invType="_dye",InvName="accessories",posX=slotPosX,posY=1.85,slotIcon="eq_acc_slot_dye.png"})..
			eqp_accessories.AddStatIcons(player,0.675,3.375)
return form
end
end

--------
-------- Custom form placeholder
--------
if eqp_accessories.settings.preset == 5 then

function eqp_accessories.form(player)
	local form = "label[1,0.5;Seems like 'equippable_accessories' is trying to use \na custom form that has not been implemented by any mod...\na custom accessory form can be made\nby either creating or modifying the following function:\n"..core.colorize("#00ff00", " eqp_accessories.form = function(player)\n    return <your fromspec string> \n end").."]"..
	"image_button[3.0,3.5;1.25,1.25;eq_acc_button_equip.png;eqpacc_test;]"
	return form
end
function eqp_accessories.receive_fields(player, fields)
	local name = player:get_player_name()
	if fields.eqpacc_test then
		core.chat_send_player(player:get_player_name(),"testing")
	end
	return true
end
end
-------
-------



if eqp_accessories.settings.preset ~= 6 then
if core.get_modpath("sfinv") then
	sfinv.register_page("sfinv:equip_accessories", {
	title = S(eqp_accessories.pageTitle),
	get = function(self, player, context)
		return sfinv.make_formspec(player, context, eqp_accessories.form(player), true)
	end,
	on_player_receive_fields = function(self, player, context, fields)
		if eqp_accessories.receive_fields(player, fields) then
			sfinv.set_player_inventory_formspec(player)
		end
	end
	})
eqp_accessories.UsedInvMod = "sfinv"
end
if core.get_modpath("unified_inventory") then
	local F = core.formspec_escape
	unified_inventory.register_page("equip_accessories", {
	get_formspec = function(player, perplayer_formspec)
		local player_name = player:get_player_name()
		local std_inv_x = perplayer_formspec.std_inv_x
		local formspec = {
			perplayer_formspec.standard_inv_bg,
			"label[", perplayer_formspec.form_header_x, ",",
				perplayer_formspec.form_header_y, ";", F(S(eqp_accessories.pageTitle)), "]",
			eqp_accessories.form(player),
		}
		return { formspec = table.concat(formspec) }
	end,
	})
unified_inventory.register_button("equip_accessories", {
	type = "image",
	image = "eq_acc_icon_defense.png",
	tooltip = S(eqp_accessories.pageTitle),
})
core.register_on_player_receive_fields(function(player, formname, fields)
	eqp_accessories.receive_fields(player, fields)
	unified_inventory.set_inventory_formspec(player, "equip_accessories")
end)
eqp_accessories.UsedInvMod = "unified_inventory"
end

if core.get_modpath("mcl_inventory") then


core.register_tool("equippable_accessories:acc_icon_itm", {
	description = ("Cactus Leggings"),
	inventory_image = "eq_acc_icon_defense.png",
	groups = {not_in_creative_inventory = 1}
})

	eqp_accessories.UsedInvForm = 0
	function eqp_accessories.mclAltForm(name) 
		local tForm = "size[9,10]"..
		eqp_accessories.form(core.get_player_by_name(name))..
		"list[current_player;main;0,9.0;9,1;]"..
		"list[current_player;main;0,5.75;9,3;9]"
		core.show_formspec(name, "eqp_accessories:equip_form", tForm)
	end
	core.register_on_player_receive_fields(function(player, formname, fields)
		if formname == "eqp_accessories:equip_form" and not (fields["quit"] or fields["exit"]) then
		eqp_accessories.receive_fields(player, fields)
		eqp_accessories.mclAltForm(player:get_player_name()) 
	end end)
	core.register_chatcommand("accinv", {
  	func = function(name)
		eqp_accessories.UsedInvForm = 0
		eqp_accessories.mclAltForm(name) 
    	end,
	})

mcl_inventory.register_survival_inventory_tab({
	id = "acc_inv",
	description = "Accessories",
	item_icon = "equippable_accessories:acc_icon_itm",
	show_inventory = true,
	build = function(player)
		return eqp_accessories.form(player)
	end,
	handle = function(player, fields)
		eqp_accessories.UsedInvForm = 1
		eqp_accessories.receive_fields(player, fields)
		mcl_inventory.update_inventory(player)
	end,
})

eqp_accessories.UsedInvMod = "mcl_inventory"
end


if eqp_accessories.UsedInvMod == "" then
	function eqp_accessories.homelessForm(name) 
		local tForm = "size[8,10]"..
		eqp_accessories.form(core.get_player_by_name(name))..
		"list[current_player;main;0,5.75;8,1;]"..
		"list[current_player;main;0,7.0;8,3;8]"
		core.show_formspec(name, "eqp_accessories:equip_form", tForm)
	end
	core.register_on_player_receive_fields(function(player, formname, fields)
		if formname == "eqp_accessories:equip_form" and not (fields["quit"] or fields["exit"]) then
		eqp_accessories.receive_fields(player, fields)
		eqp_accessories.homelessForm(player:get_player_name()) 
	end end)
	core.register_chatcommand("accinv", {
  	func = function(name)
		eqp_accessories.homelessForm(name) 
    	end,
	})
end
end


eqp_accessories.OnAddWear = {
	--function(player,stack,durAmt) core.chat_send_player(player:get_player_name(),stack:get_name().." added wear") return stack end
}




eqp_accessories.InvRefresh = {
	["standard"] = function(player) eqp_accessories.homelessForm(player:get_player_name())  end,
	["sfinv"] = function(player) sfinv.set_player_inventory_formspec(player) end,
	["unified_inventory"] = function(player) unified_inventory.set_inventory_formspec(player, "equip_accessories") end,
	["mcl_inventory"] = function(player)
		if eqp_accessories.UsedInvForm == 0 then eqp_accessories.mclAltForm(player:get_player_name()) end
		if eqp_accessories.UsedInvForm == 1 then mcl_inventory.update_inventory(player) end
	end,
}
function eqp_accessories.RefreshInv(player)
	if eqp_accessories.UsedInvMod ~= "" then
		eqp_accessories.InvRefresh[eqp_accessories.UsedInvMod](player)
	else
		eqp_accessories.InvRefresh["standard"](player)
	end
end


function eqp_accessories.DamageAccList(player,params)
	local pName = player:get_player_name()
	local listname = params.listname or "none"
	local amount = params.amount or 1
	local reason = params.reason or ""

	local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
		for i=1,inv:get_size(listname) do
		if inv:get_list(listname) and inv:get_stack(listname, i) then
		local tStack = inv:get_stack(listname, i)
		local stackName = tStack:get_name()
			if stackName~="" then
			local tArmorItem = core.registered_items[stackName]
			if tArmorItem and tArmorItem.equipParams and tArmorItem.equipParams.durability and tArmorItem.equipParams.durability~=0 
			and ((reason=="" or (tArmorItem.equipParams.WearReasons and tArmorItem.equipParams.WearReasons[reason])) or
			reason=="hurt" and tArmorItem.equipParams.WearReasons==nil and listname=="armor") then
				local meta = tStack:get_meta()
				local tDur = tArmorItem.equipParams.durability
				local tWear = (math.ceil(65535/tDur) * amount) + tStack:get_wear()
				if tWear >= 65535 then
					inv:remove_item(listname, tStack)
					eqp_accessories.ApplyVisual(player,listname,i) 
					eqp_accessories.RefreshStats(player)
					eqp_accessories.SaveEquipList(player,listname) 
				else
						if math.random(0,100+meta:get_int("unbreaking")) <= 100 then
						tStack:set_wear(tWear)	
						end
					for wI,wfunc in ipairs(eqp_accessories.OnAddWear) do
					tStack = wfunc(player,tStack,amount)
					end
			
					inv:set_stack(listname, i, tStack)
				end 
			end
			end
		end
		end
end


function eqp_accessories.DamageAllAccLists(player,params)
for l,list in pairs(eqp_accessories.InvDatas) do
	local pars = params
	pars.listname = l
	eqp_accessories.DamageAccList(player,pars)
end
end

eqp_accessories.ExcessHP = {}
eqp_accessories.ExcludedDamageReasons = {["set_hp"]=true,["drown"]=true}
eqp_accessories.DamageFireNodes = {["fire:basic_flame"]=true,["default:lava_source"]=true,["default:lava_flowing"]=true}
eqp_accessories.DamageMCLfireTypes = {["in_fire"]=true,["on_fire"]=true,["lava"]=true,["hot_floor"]=true}



if core.get_modpath("mcl_damage") then

mcl_damage.register_modifier(function(obj, damage, reason) 

	if damage>eqp_accessories.settings.min_damage and obj:is_player() then
		local name = obj:get_player_name()
		local tempdata = eqp_accessories.plrTempData[name] 
		local GetStat = eqp_accessories.GetPlayerStat
		local initDMG = damage

		if eqp_accessories.settings.defType == 1 then
		damage = (damage - GetStat(name,"reduction")) - (damage * eqp_accessories.DefenseFormula( GetStat(name,"defense") ))
		end
		if eqp_accessories.settings.defType == 2 then
		damage = (damage * (1 - (GetStat(name,"reduction")/100))) - (GetStat(name,"defense")/eqp_accessories.settings.defPerDMG)
		end
		if damage < eqp_accessories.settings.min_damage then damage = eqp_accessories.settings.min_damage end
	
			if eqp_accessories.settings.durability == 1 then
			for l,list in pairs(eqp_accessories.InvDatas) do
				eqp_accessories.DamageAccList(obj,{listname=l,reason="hurt"})
			end
			end
			if eqp_accessories.settings.durability == 2 then
			for l,list in pairs(eqp_accessories.InvDatas) do
				eqp_accessories.DamageAccList(obj,{listname=l,reason="hurt",amount=1+math.floor(math.abs(initDMG)/3) })
			end
			end

		if eqp_accessories.DamageMCLfireTypes[reason.type] then 
		if tempdata.fResLeft then
			eqp_accessories.SetFireResTime(obj,-1)
			if tempdata.fResLeft > 0 then
			damage = 0
			end
		end end

if reason.type == "generic" and math.random(1,10000) <= (GetStat(name,"dodge")*100) then
damage = 0
local pos = obj:get_pos()
for i = 1,math.random(8,12) do
	core.add_particle({
		pos = {x=pos.x+math.random(-1,1),y=pos.y+math.random(1,1),z=pos.z+math.random(-1,1)},
		velocity = {x=math.random(-5,5), y=math.random(-5,5), z=math.random(-5,5)},
          acceleration = {x=math.random(-5,5), y=math.random(-5,5), z=math.random(-5,5)},
		expirationtime = 0.9, 
		size = 16, 
		collisiondetection = true,
		collision_removal = false,
		vertical = false,
		texture = "accessories_dodgepuff.png",
          animation = {type="vertical_frames", aspect_w=8, aspect_h=8, length = 1.0,},
		glow = 1,
	})
end end

	end

return damage 
end, 0)

end



if not core.get_modpath("mcl_damage") then
	core.register_on_player_hpchange(function(player, hp_change, reason)
		local name = player:get_player_name()	
		local tempdata = eqp_accessories.plrTempData[name] 
		local GetStat = eqp_accessories.GetPlayerStat

		if hp_change < 0 then

		if reason.type and not eqp_accessories.ExcludedDamageReasons[reason.type] then
		-------
		if reason.object and reason.object:is_valid() and reason.object:is_player() then hp_change = hp_change * ((GetStat(reason.object:get_player_name(),"attack")/100)+1) end
		--if reason.source and reason.source == "thorns" then core.chat_send_all(reason.object:get_player_name()) end
		if GetStat(name,"thorns") > 0 and reason.object and reason.source ~= "thorns" then
			if reason.object:is_player() then
				reason.object:set_hp(reason.object:get_hp() + math.floor(hp_change*(GetStat(name,"thorns")/100)),{object=player,type="punch",source="thorns"} )
			else
				reason.object:punch(player,1.0,{full_punch_interval = 1.0,
				damage_groups = {fleshy = math.ceil(-hp_change*(GetStat(name,"thorns")/100)) },}, nil)
			end
		end
			local initDMG = hp_change
			if eqp_accessories.settings.defType == 1 then
				local reducedAMT = eqp_accessories.DefenseFormula( GetStat(name,"defense") )
					if reason.type == "fall" or reason.type == "node_damage" and eqp_accessories.DamageFireNodes[reason.node] then
					reducedAMT = reducedAMT*0.5
					end
				hp_change = (hp_change + GetStat(name,"reduction")) - (hp_change * reducedAMT)
			end
			if eqp_accessories.settings.defType == 2 then
				local reducedAMT = (GetStat(name,"defense")/eqp_accessories.settings.defPerDMG)
					if reason.type == "fall" or reason.type == "node_damage" and eqp_accessories.DamageFireNodes[reason.node] then
					reducedAMT = reducedAMT*0.5
					end
				hp_change = (hp_change * (1 - (GetStat(name,"reduction")/100))) + (GetStat(name,"defense")/eqp_accessories.settings.defPerDMG)
			end
			if hp_change > -eqp_accessories.settings.min_damage then hp_change = -eqp_accessories.settings.min_damage end

				if eqp_accessories.ExcessHP[name] == nil then eqp_accessories.ExcessHP[name] = 0 end
					eqp_accessories.ExcessHP[name] = eqp_accessories.ExcessHP[name] + hp_change
					hp_change = 0
				if eqp_accessories.ExcessHP[name] <= -1 then
					local extraDMG = math.ceil(eqp_accessories.ExcessHP[name])
					hp_change = hp_change + extraDMG
					eqp_accessories.ExcessHP[name] = eqp_accessories.ExcessHP[name] - extraDMG
				end

			if eqp_accessories.settings.durability == 1 then
			for l,list in pairs(eqp_accessories.InvDatas) do
				eqp_accessories.DamageAccList(player,{listname=l,reason="hurt"})
			end
			end
			if eqp_accessories.settings.durability == 2 then
			for l,list in pairs(eqp_accessories.InvDatas) do
				eqp_accessories.DamageAccList(player,{listname=l,reason="hurt",amount=1+math.floor(math.abs(initDMG)/3) })
			end
			end
		end	
		--------
		end

if reason.type == "punch" and math.random(1,10000) <= (GetStat(name,"dodge")*100) then
hp_change = 0
local pos = player:get_pos()
for i = 1,math.random(8,12) do
	core.add_particle({
		pos = {x=pos.x+math.random(-1,1),y=pos.y+math.random(1,1),z=pos.z+math.random(-1,1)},
		velocity = {x=math.random(-5,5), y=math.random(-5,5), z=math.random(-5,5)},
          acceleration = {x=math.random(-5,5), y=math.random(-5,5), z=math.random(-5,5)},
		expirationtime = 0.9, 
		size = 16, 
		collisiondetection = true,
		collision_removal = false,
		vertical = false,
		texture = "accessories_dodgepuff.png",
          animation = {type="vertical_frames", aspect_w=8, aspect_h=8, length = 1.0,},
		glow = 1,
	})
end end

		if reason.type == "node_damage" and eqp_accessories.DamageFireNodes[reason.node] then
		if tempdata.fResLeft then
			eqp_accessories.SetFireResTime(player,-1)
			if tempdata.fResLeft > 0 then
			hp_change = 0
			end
		end end
		if eqp_accessories.settings.HPnumDisplay == true then
			core.after(0.05,function() 
			if player and eqp_accessories.plrTempData[name] and eqp_accessories.plrTempData[name]["HPhud"] then
				local maxHP = player:get_properties().hp_max 
				local currHP = player:get_hp()
				player:hud_change(eqp_accessories.plrTempData[name]["HPhud"], "text", currHP.." / "..maxHP)
			end
			end)
		end
		return hp_change
	end,true)
end


function eqp_accessories.DropAllAccessories(player)
		local pName = player:get_player_name()
		local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
		local pos = player:get_pos()
			pos.y = pos.y + 0.5
		local toDrop = {}
		local dieSTR = {"","_vanity","_dye"}
		for _,invData in pairs(eqp_accessories.InvDatas) do
			for d,dS in ipairs(dieSTR) do
				for i=1, inv:get_size(_..dS) do
					local tStack = inv:get_stack(_..dS,i)
			if dS == "" and tStack and core.registered_items[tStack:get_name()] then
				local tAccessory = core.registered_items[tStack:get_name()]
				if tAccessory and tAccessory.equipParams and tAccessory.equipParams.OnUnEquip then tAccessory.equipParams.OnUnEquip(player,"died") end
			end 
					table.insert(toDrop, tStack)
					inv:set_stack(_..dS, i, nil)
				end
				eqp_accessories.SaveEquipList(player,_..dS) 
			end
		end
		for _,itemStack in ipairs(toDrop) do
		local drop = core.add_item(pos, itemStack)
		end
		for _,invData in pairs(eqp_accessories.InvDatas) do
			for n,invSlot in ipairs(invData) do
			eqp_accessories.ApplyVisual(player,_,n)
		end end
		eqp_accessories.RefreshStats(player)
end

function eqp_accessories.SetExpandedBoneForm(pos)
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("main", 8 * 8)
local form = "size[8,13]" ..
	"list[current_name;main;0,0.3;8,8;]" ..
	"list[current_player;main;0,8.85;8,1;]" ..
	"list[current_player;main;0,10.08;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,8.85)
	meta:set_string("formspec", form)
end



function eqp_accessories.DropAllAccessoriesToContainer(player,contNodes)
		local pName = player:get_player_name()
		local pos = player:get_pos()
	core.after(0.05, function()
		local nodes = core.find_nodes_in_area(vector.subtract(pos, 8), vector.add(pos, 8), contNodes)
		local nodeMeta = nil
		for _,nodePos in pairs(nodes) do
			local meta = core.get_meta(nodePos)
			if meta:get_string("owner") and meta:get_string("owner") == pName then nodeMeta = meta 
				if eqp_accessories.settings.expandBones == true then
				eqp_accessories.SetExpandedBoneForm(nodePos)
				end
			break end
		end
		if nodeMeta then
			local inv = core.get_inventory({type="detached", name=pName.."_equip_acc"})
			local nodeInv = nodeMeta:get_inventory()
			local toDrop = {}
			local dieSTR = {"","_vanity","_dye"}
			for _,invData in pairs(eqp_accessories.InvDatas) do
				for d,dS in ipairs(dieSTR) do
					for i=1, inv:get_size(_..dS) do
						local tStack = inv:get_stack(_..dS,i)
			if dS == "" and tStack and core.registered_items[tStack:get_name()] then
				local tAccessory = core.registered_items[tStack:get_name()]
				if tAccessory and tAccessory.equipParams and tAccessory.equipParams.OnUnEquip then tAccessory.equipParams.OnUnEquip(player,"died") end
			end 
						table.insert(toDrop, tStack)
						inv:set_stack(_..dS, i, nil)
					end
					eqp_accessories.SaveEquipList(player,_..dS) 
				end
			end
			for _,itemStack in ipairs(toDrop) do
				if nodeInv:room_for_item("main", itemStack) then
					nodeInv:add_item("main", itemStack)
				else
					local drop = core.add_item(pos, itemStack)
				end
			end
			for _,invData in pairs(eqp_accessories.InvDatas) do
				for n,invSlot in ipairs(invData) do
				eqp_accessories.ApplyVisual(player,_,n)
			end end
			eqp_accessories.RefreshStats(player)
		else
		eqp_accessories.DropAllAccessories(player)
		end
	end)
end

	
	core.register_on_dieplayer(function(player)
		if not core.is_creative_enabled(player:get_player_name()) then
		if eqp_accessories.settings.deathDrop == 0 and core.get_modpath("bones") then
			local bonesMode = core.settings:get("bones_mode") or "keep"
			if bonesMode=="bones" then
				eqp_accessories.DropAllAccessoriesToContainer(player,{"bones:bones"})
			end
			if bonesMode=="drop" then
				eqp_accessories.DropAllAccessories(player)
			end
		end
		if eqp_accessories.settings.deathDrop == 0 and core.get_modpath("mcl_core") then
			local keepInv = core.settings:get("mcl_keepInventory") or "false"
			if keepInv=="false" then
				eqp_accessories.DropAllAccessories(player)
			end
		end
		if eqp_accessories.settings.deathDrop == 1 then
			eqp_accessories.DropAllAccessories(player)
		end
		end
	end)





dofile(modpath.."/api.lua")
dofile(modpath.."/register_inv.lua")
dofile(modpath.."/register_craftmaterials.lua")
dofile(modpath.."/register_items.lua")
dofile(modpath.."/register_armors.lua")
dofile(modpath.."/register_technically_armors_but_not_quite.lua")
dofile(modpath.."/register_dyes.lua")
if (not core.get_modpath("shields")) and (not core.get_modpath("mcl_shields")) then
dofile(modpath.."/register_shields.lua")
end
dofile(modpath.."/register_treasure.lua")