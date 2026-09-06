---
--- preset 1 gives you the standard equippable_accessories slots and inventory.
---
if eqp_accessories.settings.preset == 1 then
if eqp_accessories.settings.UseArmor == true then
	eqp_accessories.RegisterInvSlot({slotID="helmet",slotIcon="eq_acc_slot_helmet.png",list="armor"})
	eqp_accessories.RegisterInvSlot({slotID="breastplate",slotIcon="eq_acc_slot_helmet.png",list="armor"})
	eqp_accessories.RegisterInvSlot({slotID="leggings",slotIcon="eq_acc_slot_helmet.png",list="armor"})
end
	eqp_accessories.RegisterInvSlot({slotID="head",slotIcon="eq_acc_slot_head.png"})
	eqp_accessories.RegisterInvSlot({slotID="forehead",slotIcon="eq_acc_slot_forehead.png"})
	eqp_accessories.RegisterInvSlot({slotID="face",slotIcon="eq_acc_slot_face.png"})
	eqp_accessories.RegisterInvSlot({slotID="ears",slotIcon="eq_acc_slot_ears.png"})
	eqp_accessories.RegisterInvSlot({slotID="eyes",slotIcon="eq_acc_slot_eyes.png"})
	eqp_accessories.RegisterInvSlot({slotID="neck",slotIcon="eq_acc_slot_neck.png"})
	eqp_accessories.RegisterInvSlot({slotID="chest",slotIcon="eq_acc_slot_chest.png"})
	eqp_accessories.RegisterInvSlot({slotID="left_hand",slotIcon="eq_acc_slot_hand.png"})
	eqp_accessories.RegisterInvSlot({slotID="right_hand",slotIcon="eq_acc_slot_hand.png"})
	eqp_accessories.RegisterInvSlot({slotID="left_ring",slotIcon="eq_acc_slot_ring.png"})
	eqp_accessories.RegisterInvSlot({slotID="right_ring",slotIcon="eq_acc_slot_ring.png"})
	eqp_accessories.RegisterInvSlot({slotID="back",slotIcon="eq_acc_slot_back.png"})
	eqp_accessories.RegisterInvSlot({slotID="belt",slotIcon="eq_acc_slot_belt.png"})
	eqp_accessories.RegisterInvSlot({slotID="feet",slotIcon="eq_acc_slot_feet.png"})
end
--

---
--- preset 2 makes the invontory more terraria-like, where equip/vanity/dye slots are in a single page and you have 5 slots that take ANY accessory
--- preset 3 keeps equip/vanity/dye slots in their respective pages, but gives you 5 universal accessory slots, like the terraria one.
---
if eqp_accessories.settings.preset == 2 or eqp_accessories.settings.preset == 3 then
if eqp_accessories.settings.UseArmor == true then
	eqp_accessories.RegisterInvSlot({slotID="helmet",slotIcon="eq_acc_slot_helmet.png",list="armor"})
	eqp_accessories.RegisterInvSlot({slotID="breastplate",slotIcon="eq_acc_slot_helmet.png",list="armor"})
	eqp_accessories.RegisterInvSlot({slotID="leggings",slotIcon="eq_acc_slot_helmet.png",list="armor"})
end
	eqp_accessories.RegisterInvSlot({slotID="any",slotIcon="eq_acc_slot_ring.png"})
	eqp_accessories.RegisterInvSlot({slotID="any",slotIcon="eq_acc_slot_ring.png"})
	eqp_accessories.RegisterInvSlot({slotID="any",slotIcon="eq_acc_slot_ring.png"})
	eqp_accessories.RegisterInvSlot({slotID="any",slotIcon="eq_acc_slot_ring.png"})
	eqp_accessories.RegisterInvSlot({slotID="any",slotIcon="eq_acc_slot_ring.png"})
end

---
--- preset 4 comes with no accessory slots, and only armor slots if armor is enabled. Use it if you want to add your own accessory slots, instead of built-in ones
---
if eqp_accessories.settings.preset == 4 then
if eqp_accessories.settings.UseArmor == true then
	eqp_accessories.RegisterInvSlot({slotID="helmet",slotIcon="eq_acc_slot_helmet.png",list="armor"})
	eqp_accessories.RegisterInvSlot({slotID="breastplate",slotIcon="eq_acc_slot_helmet.png",list="armor"})
	eqp_accessories.RegisterInvSlot({slotID="leggings",slotIcon="eq_acc_slot_helmet.png",list="armor"})

end
end
--

-- preset 5 is used ONLY if you are going to modify the built-in accessory inventory function to create your own inventory

-- preset 6 dose not add an inventory at all and is used if you are planning to make the whole inventory from scratch, on your own.
