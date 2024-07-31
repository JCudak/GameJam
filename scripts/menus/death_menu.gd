extends Control

@onready var restart = $TextureRect/MarginContainer/VBoxContainer/VBoxContainer2/Restart/NinePatchRect/Label
@onready var quit = $TextureRect/MarginContainer/VBoxContainer/VBoxContainer2/Quit/NinePatchRect/Label

func _ready():
	restart.text = "restart"
	quit.text = "quit"
	
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://assets/scenes/dungeon/level_manager.tscn")

func _on_quit_pressed():
	get_tree().quit()


