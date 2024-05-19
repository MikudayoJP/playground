extends Node2D

@export var cameraPath : String

@onready var colorRect = $"Area2D/ColorRect"
@onready var pcam_2d : PhantomCamera2D = get_node(cameraPath)

var cameraWasActivated : bool = false

func _on_area_2d_body_entered(body):
	#needs to be updated for player specific --done
	#TODO needs to be put into another script
	if body.is_in_group("Player"): #Dand Input.is_action_pressed("interact"):
		colorRect.set_color(Color.CHARTREUSE)
		if cameraWasActivated == false:
			pcam_2d.set_priority(2)
			await get_tree().create_timer(5.0).timeout
			cameraWasActivated = true
	#if Input.is_action_just_pressed("interact"):
	#	pass
		#dprint("wadad")
		#colorRect.set_color(Color.YELLOW_GREEN)


func _on_area_2d_body_exited(body):
	#TODO needs to be updated for player specific
	#TODO needs to be put into another script
	if body.is_in_group("Player"):
		colorRect.set_color(Color.WHITE)
		pcam_2d.set_priority(0)
