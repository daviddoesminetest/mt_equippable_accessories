local craftMat = eqp_accessories.craftMaterials
local accSetts = eqp_accessories.settings 


eqp_accessories.RainbowDyeColors = {
-170,-160,-150,-140,-130,-120,-110,-100,-90,-80,-70,-60,-50,-40,-30,-20,-10,
0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180
}

if accSetts.DynamicDyes == true then

core.register_craftitem("equippable_accessories:colorshifting_dye", {
	description = ("Colorshifting Dye\n"..core.colorize("#00ff88","Goes through all the colors of a rainbow over time.")),
	inventory_image = "eq_acc_dye_inside.png^[mask:accessories_rainbow.png^eq_acc_dye_top_special.png",
	equipAccDye = "^[hsl:0:-100:0",
	dyeStep = function(self,dtime)
		self.timer = self.timer + dtime
		if self.timer > 0.05 then
		if self.dyeInd == nil or self.dyeInd == #eqp_accessories.RainbowDyeColors then self.dyeInd = 0 end
		self.timer = 0	
		self.dyeInd = self.dyeInd+1	
		if self and self.OgTextures and eqp_accessories.RainbowDyeColors[self.dyeInd] then
			local stepTextures = {}
			local dPar = eqp_accessories.RainbowDyeColors[self.dyeInd]
			for _,tex in ipairs(self.OgTextures) do
				 stepTextures[_] = self.OgTextures[_].."^[colorizehsl:"..(dPar)..":100:0^[makealpha:0,0,0"
			end
			self.object:set_properties({textures = stepTextures})
		end
		end
	end
})

end

eqp_accessories.dyeInit = {
{name="redgreen",main="^[colorizehsl:0:100:0^[makealpha:0,0,0",overlay="^[colorizehsl:90:100:0^[makealpha:0,0,0"},
}

for _,dye in ipairs(eqp_accessories.dyeInit) do
	local invIMG = "eq_acc_dye_inside.png"..dye.main

	if dye.overlay then invIMG = invIMG.."^("..(dye.overTex or "eq_acc_dye_over.png")..""..dye.overlay..")" end


local dyedef = {
	description = (dye.name.." accessory dye"),
	inventory_image = invIMG.."^eq_acc_dye_top.png",
	equipAccDye = dye.main}
	if dye.overlay then dyedef.equipAccDyeOver = dye.overlay end
	core.register_craftitem("equippable_accessories:dye_"..dye.name.."",dyedef)
end



eqp_accessories.SimpleDyeInit = {
{name="black",clr="0:0:-75"},
{name="dark_grey",clr="0:0:-50"},
{name="grey",clr="0:0:0"},
{name="white",clr="0:0:50",alpha="128,128,128"},
{name="red",clr="0:100:0"},
{name="blue",clr="-120:100:0"},
{name="cyan",clr="180:100:0"},
{name="brown",clr="20:50:-30"},
{name="green",clr="90:100:0"},
{name="dark_green",clr="90:100:-50"},
{name="yellow",clr="60:100:0"},
{name="orange",clr="30:100:0"},
{name="magenta",clr="-45:100:0"},
{name="violet",clr="-75:100:0"},
{name="pink",clr="-30:100:50",alpha="255,0,127"},
}

for _,dye in ipairs(eqp_accessories.SimpleDyeInit) do
	core.register_craftitem("equippable_accessories:dye_"..dye.name.."",{
		description = (dye.name.." accessory dye"),
		inventory_image = "eq_acc_dye_inside.png^[colorizehsl:"..(dye.clr).."^[makealpha:"..(dye.alpha or "0,0,0").."^eq_acc_dye_top.png",
		equipAccDye = "^[colorizehsl:"..dye.clr.."^[makealpha:"..(dye.alpha or "0,0,0")
	})

core.register_craft({
	output = "equippable_accessories:dye_"..dye.name.."",
	recipe = {
		{craftMat.meseFrag, craftMat.dye..dye.name, craftMat.meseFrag},
		{craftMat.dye..dye.name, craftMat.bottle,craftMat.dye..dye.name},
	}
})


	for d,ddye in ipairs(eqp_accessories.SimpleDyeInit) do
	local ddgroups = {}
	if accSetts.CrativeDoubleDyes == false then ddgroups.not_in_creative_inventory = 1 end
	core.register_craftitem("equippable_accessories:dye_"..dye.name.."_"..ddye.name,{
		description = (dye.name.."-"..ddye.name.." accessory dye"),
		inventory_image = "eq_acc_dye_inside.png^[colorizehsl:"..(dye.clr).."^[makealpha:"..(dye.alpha or "0,0,0").."^(eq_acc_dye_over_darker.png^[colorizehsl:"..ddye.clr.."^[makealpha:"..(ddye.alpha or "0,0,0")..")^eq_acc_dye_top_double.png",
		equipAccDye = "^[colorizehsl:"..dye.clr.."^[makealpha:"..(dye.alpha or "0,0,0"),
		equipAccDyeOver = "^[colorizehsl:"..ddye.clr.."^[makealpha:"..(ddye.alpha or "0,0,0"),
		groups = ddgroups,
	})

core.register_craft({
	output = "equippable_accessories:dye_"..dye.name.."_"..ddye.name,
	recipe = {
		{"", craftMat.mese, ""},
		{"equippable_accessories:dye_"..dye.name.."",craftMat.mese,"equippable_accessories:dye_"..ddye.name..""},
	}
})

	end
end
