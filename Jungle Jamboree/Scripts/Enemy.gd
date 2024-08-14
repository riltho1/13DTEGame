extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var player_chase = false
@export var speed = 5
@onready var player: Node3D = get_tree().get_first_node_in_group("Player")
@onready var vision_area: Area3D = $Area3D
@export var point1 : Marker3D
@export var point2 : Marker3D
var target
func _ready():
	target = point1
	nav_agent.set_velocity(Vector3.ZERO)
	

func _physics_process(delta):
	var overlapping_bodies = vision_area.get_overlapping_bodies()
		# Check if the player is inside the vision area
	if player in overlapping_bodies:
		player_chase = true
	else:
		player_chase = false
		
	if not player_chase and target:
		print("patrol")
		look_at(target.global_transform.origin)
		rotation.x = 0
		rotation.z = 0
		var direction = (target.global_transform.origin - global_transform.origin).normalized()
		nav_agent.set_velocity(direction * speed)
		if global_position.distance_to(target.global_position)<1:
			if target == point1:
				target = point2
			else:
				target = point1
		
# Check if the player is inside the vision area	
	elif player_chase and player:
		print("chase")
		look_at(player.global_transform.origin)
		rotation.x = 0
		rotation.z = 0
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		nav_agent.set_velocity(direction * speed)
		#else:
	else:
		print("stop")
		nav_agent.set_velocity(Vector3.ZERO)
	
	velocity = nav_agent.velocity
	move_and_slide()



	
	
	
