extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var player_chase = false
@export var speed = 200
@export var player = get_tree().get_first_node_in_group("Player")

func _ready():
	nav_agent.set_velocity(Vector3.ZERO)
	if player_chase:
		velocity = (player.global_position - global_position).normalized() * speed
		move_and_slide()

func _on_area_3d_body_entered(body):
		if player:
			player_chase = true
