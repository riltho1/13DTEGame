extends CharacterBody3D

@export var SPEED = 5
@export var JUMP_VELOCITY = 4.5
@export var DOUBLE_JUMP_VELOCITY = 3.0
@export var sensivity = 1000
@export var friction = 600

@onready var camera = $SpringArm3D/Camera3D

var DOUBLE_JUMP : bool = false

signal collected(collectable)
#var camera_rotation:Vector3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Movement Code, copied from previous game
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

#Jump and Double Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if DOUBLE_JUMP == false:
			DOUBLE_JUMP = true
			velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		if DOUBLE_JUMP == true:
			DOUBLE_JUMP = false
			velocity.y = DOUBLE_JUMP_VELOCITY
	


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector( "left", "right","up","down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func collect(collectable):
	collected.emit(collectable)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP, event.relative.x * 0.0005)
