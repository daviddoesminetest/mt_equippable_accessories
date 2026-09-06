
--
-- Register a new slot for "equippable_accessories" inventory or list
--
function eqp_accessories.RegisterInvSlot(params)
	table.insert(eqp_accessories.RegInvSlots,{slotID=(params.slotID or "any"),slotIcon = (params.slotIcon or "eq_acc_slot_empty.png"),list = (params.list or "accessories") })
end
--
--params : <table> a table containing parameters for the slot :
---- slotID <string> 
-------- slot will only accept equipment containing that slot in it's 'equipParams.equipSlots'.
-------- the 'slotID' can also be set as "any". In that case it will accept any equippable item, as long as it is not a duplicate of any already worn item
--
---- slotIcon <string> 
-------- name of the image file for the slot
--
---- list <string> 
-------- name of the inventory list used for the slot
-------- the name will be "accessories" by default and slots registered under that name will be added to the standard "equippable_accessories" inventory ("<playerName>_equip_acc")
-------- if the list has any other name than that, it will still function like "accessories" list, still belong to same inventory and be saved under same circumstances as regular "accessories" list
-------- but to actually make that list accessible to a player, you'll need to put it into some sort of inventory form or make a form for it on your own
--


---
--- get value of a player's stat
---
function eqp_accessories.GetPlayerStat(playerName,statName)
	if eqp_accessories.PlayerStats[playerName] and eqp_accessories.PlayerStats[playerName][statName] and eqp_accessories.PlayerStats[playerName][statName] then
		return eqp_accessories.PlayerStats[playerName][statName]
	else
		return 0
	end
end
-- playerName <string> name of the player
-- statName <string> name of the stat
--
--eg:
-- > Be player
-- > have 2 points of regeneration
-- > have a function ran on you
-- > 'eqp_accessories.GetPlayerStat(player:get_player_name(),"regen")'
-- > number '2' is returned by the function
-- you now have the number 2 to do whatever with.


---
--- putting stat additions/overrides into item meta
---
----- if you want to add stat changes to your accessory throught enchantments.attachments,reforges,etc. 
----- this can be done by registering meta string name that needs to be checked in 'eqp_accessories.StatMetaToCheck' table
----- and putting a serialized table with stat additions into your item's metadata, under same name
--
--eg:
--
-- table.insert(eqp_accessories.StatMetaToCheck,"testing")
-- 
-- function AddOpProtection(itemstack)
-- 	itemstack:get_meta():set_string("testing",core.serialize({ ["defense"]={add=100},["regen"]={add=2.5} }))
--	return itemstack
-- end
--
----- you can also override original stats, by just putting a serialized stat table into meta, named 'eqp_acc_stats'
----- (override table name, 'eqp_acc_stats' , is built-in and DOES NOT need to be and SHOULD NOT be added to 'eqp_accessories.StatMetaToCheck')
--
--eg:
--
-- function YeeYeeAhhItemOverride(itemstack)
-- 	itemstack:get_meta():set_string("eqp_acc_stats",core.serialize({ ["defense"]={add=5},["attack"]={add=5}, }))
--	return itemstack
-- end
--


---
--- overriding textures in meta
---
----- you can change the texture of an accessory by setting it's 'eqp_acc_texture' meta string, to a texture name
----- and then you can also add an overlay by changing 'eqp_acc_overlay' meta string
-----
-----		itemstack:get_meta():set_string("eqp_acc_texture","default_dirt.png")
-----		itemstack:get_meta():set_string("eqp_acc_overlay","default_mineral_tin.png")
-----
----- both respond to dyes the same way, item's regular texture/overlay would
----- and if you want to reset the textures to original, set the respective metastrings to ""
-----
-----		itemstack:get_meta():set_string("eqp_acc_texture","")
-----		itemstack:get_meta():set_string("eqp_acc_overlay","")
-----

--
-- add a new function to run on an "equippable_accessories" callback
--
function eqp_accessories.AddCallback(callback,cbFunc)
table.insert(eqp_accessories.callBacks[callback],cbFunc)
end
--
-- callback : <string> the name of the callback
-- cbFunc : <function> the function that should run when the callback happens
--
-------- Available callbacks:
------ "RefreshingStats" 
---- happens at the start of stat referesh, when all the base stats have been prepared, but no stats from equippment were added on
---- takes 'player' <OBJref> and 'stats' <stat table generated in 'eqp_accessories.RefreshStats(player)'> as arguments
---- useful if you want to change the value of some of the initial stats using your own custom source, before stats from equipment are added.
---- must return the table from 'stats' argument
---- eg: eqp_accessories.AddCallback("RefreshingStats",function(player,stats) stats["defense"].add = stats["defense"].add+5 return stats end) -- give player 5 defense
---- 	 eqp_accessories.AddCallback("RefreshingStats",function(player,stats) stats["regen"].mult = stats["regen"].mult+0.25 return stats end) -- add a 0.25x multiplier  
---- 	 to player's regeneration
--
------ "OnRefreshStats" 
---- happens once stat refresh function is done and the function that applies refreshed stats starts.
---- takes 'player' <OBJref> and 'stats' <stat table generated in 'eqp_accessories.OnStatsRefreshed(player,statTable)'> as arguments
---- useful if you want to change the value of some of the final stats using your own custom source, after stats from equipment were added.
---- must return the table from 'stats' argument
---- eg: eqp_accessories.AddCallback("OnRefreshStats",function(player,stats) stats["defense"] = stats["defense"]*0.5 return stats end) -- cut player's defense stat in half
--

function eqp_accessories.AddPlayerStep(player,stepName,tFunc)
	local pName = player:get_player_name()
	if eqp_accessories.plrSteps[pName]==nil then eqp_accessories.plrSteps[pName]={} end
	eqp_accessories.plrSteps[pName][stepName] = {func = tFunc,timer = 0}
end
function eqp_accessories.RemovePlayerStep(player,stepName)
	local pName = player:get_player_name()
	if eqp_accessories.plrSteps[pName] and eqp_accessories.plrSteps[pName][stepName] then eqp_accessories.plrSteps[pName][stepName]=nil end
end


