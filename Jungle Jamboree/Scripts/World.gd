extends Node3D

@onready var player = $Player
signal collected(collectable)

func _physics_process(_adelta):
	get_tree().call_group('Enemy','update_target_location', player.global_transform.origin)

func collect(collectable):
	collected.emit(collectable)
