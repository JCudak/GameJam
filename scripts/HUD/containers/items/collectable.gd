extends Area2D

@export var itemResource: InventoryItem
@export var texture: Texture2D
@onready var inventory: SlotsContainer = preload("res://assets/resources/inventory/player_inventory.tres")
@onready var hotbar: SlotsContainer = preload("res://assets/resources/inventory/player_hotbar.tres")
@onready var label = $Label
@onready var sprite_2d = $Sprite2D

var canInteract = false
const INTERACT_KEY = 'E'

func _ready():
	set_process_input(false)
	label.text = "["+INTERACT_KEY+"]"
	label.visible = false
	if texture:
		sprite_2d.texture = texture

func _on_body_entered(body):
	if body.name == "Player":
		label.visible = true
		canInteract = true
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "Player":
		label.visible = false
		canInteract = false
		set_process_input(false)

func _input(event):
	if event.is_action_pressed("interact") and canInteract:
		if hotbar.has_space() && itemResource.type == itemResource.CollectableType.POTION:
			hotbar.insert(itemResource)
			queue_free()
		elif inventory.has_space():
			inventory.insert(itemResource)
			queue_free()
		else:
			pass
