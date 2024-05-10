extends CharacterBody2D

@onready var player = $"/root/Main/Player"
@onready var colorRect = $"/root/Main/Area2D_test/ColorRect"

@export var current_speed = 300.0
@export var jump_velocity = -400.0
@export var walking_speed = 300.0
@export var sprinting_speed = 1000.0
@export var lerp_speed = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		
	if Input.is_action_just_pressed("debug_close"):
		get_tree().quit()
	
	if Input.is_action_pressed("sprint"):
		current_speed = sprinting_speed
	else:
		current_speed = walking_speed
	
	move_and_slide()
	
func _on_area_2d_body_entered(body):
	#TODO needs to be updated for player specific
	#TODO needs to be put into another script
	if body.name == player.name:
		#pass
		colorRect.set_color(Color.CHARTREUSE)
	if Input.is_action_just_pressed("interact"):
		pass
		#dprint("wadad")
		#colorRect.set_color(Color.YELLOW_GREEN)


func _on_area_2d_test_body_exited(body):
	#TODO needs to be updated for player specific
	#TODO needs to be put into another script
	if body.name == player.name:
		colorRect.set_color(Color.WHITE)
