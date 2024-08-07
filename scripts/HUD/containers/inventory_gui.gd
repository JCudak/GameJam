class_name InventoryGui extends SlotsContainerGui

func _ready():
	containerType = 1
	slots = $NinePatchRect/GridContainer.get_children()
	connect_slots()
	inventory.updated.connect(update)
	update()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemGui: ItemGui = slots[i].itemGui
		if !itemGui:
			itemGui = ItemGuiClass.instantiate()
			slots[i].insert(itemGui)
		
		itemGui.inventorySlot = inventorySlot
		itemGui.update()
