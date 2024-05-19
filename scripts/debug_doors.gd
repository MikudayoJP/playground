extends Node2D

@onready var colorRect = $"Area2D/ColorRect"

#cant you do it like this @export String next_level; ?
@export var next_level : String
@export var isPointAndClick : bool = false

func _on_area_2d_body_entered(body):
	#needs to be updated for player specific --done
	#TODO needs to be put into another script
	if body.is_in_group("Player"): #and Input.is_action_pressed("interact"):
		colorRect.set_color(Color.CHARTREUSE)
		SceneManager.transitaion_to_scene(next_level, isPointAndClick)
	#if Input.is_action_just_pressed("interact"):
	#	pass
		#dprint("wadad")
		#colorRect.set_color(Color.YELLOW_GREEN)


func _on_area_2d_body_exited(body):
	#TODO needs to be updated for player specific
	#TODO needs to be put into another script
	if body.is_in_group("Player"):
		colorRect.set_color(Color.WHITE)
