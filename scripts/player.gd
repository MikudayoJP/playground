extends CharacterBody3D

# Player nodes
# another test commit for git

@onready var head = $"head (pivot)2"
@onready var standing_collison_shape = $standing_collison_shape2
@onready var crouching_collison_shape = $crouching_collison_shape2
@onready var ray_cast_3D = $RayCast3D2

# Speed and mouse_sens vars

@export var walking_speed = 5.0
@export var sprinting_speed = 8.0
@export var crouching_speed = 3.0
@export var lerp_speed = 10.0
@export var mouse_sens = 0.4

# Input vars

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed = 5.0
var crouching_depth = 0
var camera_height = 1.0
var direction = Vector3.ZERO

const jump_velocity = 4.5

func _ready():
	
	#Responsible for mouse not leaving game windwos
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	
	#moving the camera
	
	if event is InputEventMouseMotion:
		#rotates head on y axis on player node?
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		
		#rotates head on x axis via head var
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		
		#player not being able to rotate head 360 deg on x axis
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	
	#crouching
	
	if Input.is_action_pressed("crouch"):
		#updates speed for crouching
		current_speed = crouching_speed
		
		#changes camera position on y axis to represent crouching; lerp for smoother change
		head.position.y = lerp(head.position.y,camera_height * crouching_depth, delta * lerp_speed)
		
		#updates collison to represent camera change
		standing_collison_shape.disabled = true
		crouching_collison_shape.disabled = false
		
	#raycast checks if collison is above player
	elif not ray_cast_3D.is_colliding():
	
	#standing
	
		#updates collison to represent camera change
		standing_collison_shape.disabled = false
		crouching_collison_shape.disabled = true
		
		#changes camera position on y axis to represent standing; lerp for smoother change
		head.position.y = lerp(head.position.y,camera_height, delta * lerp_speed)
		
		#sprinting; carefull this if is in another if and needs to be there for player could sprint while crouching (change if other effect is wanted)
		if Input.is_action_pressed("sprint"):
			current_speed = sprinting_speed
		else:
			current_speed = walking_speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# closes game
	if Input.is_action_just_pressed("open_menu"):
		get_tree().quit()
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	#added lerp for smoother transition
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*lerp_speed)
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
