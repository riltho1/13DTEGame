extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/World/Level1.tscn")

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/Main menu.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
