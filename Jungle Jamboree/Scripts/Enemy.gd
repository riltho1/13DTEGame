extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var player_chase = false
@export var speed = 5
@onready var player: Node3D = get_tree().get_first_node_in_group("Player")
@onready var vision_area: Area3D = $Area3D

func _ready():
	nav_agent.set_velocity(Vector3.ZERO)
	

func _physics_process(delta):
	var overlapping_bodies = vision_area.get_overlapping_bodies()
	# Check if the player is inside the vision area
	if player in overlapping_bodies:
		player_chase = true
	else:
		player_chase = false
	if player_chase and player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		nav_agent.set_velocity(direction * speed)
	else:
		nav_agent.set_velocity(Vector3.ZERO)
	
	velocity = nav_agent.velocity
	move_and_slide()



	
	
	
