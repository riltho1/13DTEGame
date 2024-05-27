extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
var SPEED = 6.0
var gravity_force = 9.8

func _process(delta):
	var gravity_vector = Vector3(0, -gravity_force, 0)
	if not is_on_floor():
		velocity += gravity_vector * delta
	else:
		velocity.y = 0
	
	var next_location = nav_agent.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, delta * 4)
	move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location

