extends Node2D

@onready var healthBar = $CanvasLayer/healthBar
@onready var player = $Player

func _ready():
	healthBar.setMaxHealth(player.maxHealth)
	healthBar.updateHealth(player.currentHealth)
	player.healthChanged.connect(healthBar.updateHealth)

func _process(delta):
	pass
