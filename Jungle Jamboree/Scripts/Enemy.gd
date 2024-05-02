extends CharacterBody3D

var player = null

const SPEED = 4.0

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D

func _ready():
	player = get_node(player_path)

func _process(delta: float) -> void:
	var velocity: Vector3 = Vector3.ZERO

	#Navigation
	if player:
		var new_nav_point: Vector3 = nav_agent.get_next_path_position()
		velocity = (new_nav_point - global_transform.origin).normalized() * SPEED
		
		move_and_slide()
