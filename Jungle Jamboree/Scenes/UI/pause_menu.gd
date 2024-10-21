extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resueme():
	
	$AnimationPlayer.play_backwards('blur')
	await $AnimationPlayer.animation_finished
	hide()
	get_tree().paused = false

func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play('blur')

func testEsc():
	if Input.is_action_just_pressed('escape') and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed('escape') and get_tree().paused:
		resueme()


func _on_resume_pressed() -> void:
	resueme()


func _on_restart_pressed() -> void:
	resueme()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	testEsc()
