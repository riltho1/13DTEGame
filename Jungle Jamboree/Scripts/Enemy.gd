extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var player_chase = false
@export var speed = 200
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	nav_agent.set_velocity(Vector3.ZERO)

func _physics_process(delta):
	if player_chase and player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		nav_agent.set_velocity(direction * speed)

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		player_chase = true

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		player_chase = false
