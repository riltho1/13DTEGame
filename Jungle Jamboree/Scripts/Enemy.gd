extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var chase_speed := 5.0
var player_ref: Node3D = null

func _ready():
	nav_agent.set_velocity(Vector3.ZERO)

func chase(delta):
	if player_ref:
		nav_agent.set_target_position(player_ref.global_transform.origin)
		var next_position: Vector3 = nav_agent.get_next_path_position()
		var direction: Vector3 = next_position - global_transform.origin
		if direction.length() > 1.0:
			direction = direction.normalized()
			nav_agent.set_velocity(direction * chase_speed)
	else:
		nav_agent.set_velocity(Vector3.ZERO)
		nav_agent.set_process_mode(NavigationAgent3D.PROCESS_MODE_PHYSICS)
		nav_agent.set_max_speed(chase_speed)
		nav_agent.update_navigation()
		var velocity: Vector3 = nav_agent.get_velocity()
		move_and_slide()

func _physics_process(delta:float):
	chase(delta)
	
	#var gravity_vector = Vector3(0, -gravity_force, 0)
	#if not is_on_floor():
		#velocity += gravity_vector * delta
	#else:
		#velocity.y = 0
	#
	#move_and_slide()
	#'''
	#var next_location = nav_agent.get_next_path_position()
	#var current_location = global_transform.origin
	#var new_velocity = (next_location - current_location).normalized() * SPEED
	#
	#velocity = velocity.move_toward(new_velocity, delta * 4)
	#
	#
#
#func update_target_location(target_location):
	#nav_agent.target_position = target_location
#'''



	
		


func _on_area_3d_area_entered(area):
	if body_is_in_group("Player"):
		
