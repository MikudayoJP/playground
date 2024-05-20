extends Node2D

@onready var colorRect = $"Area2D/ColorRect"
@onready var area = $"Area2D"

@export var lines : Array[String] = ["lorem ipsum", "apdjoapdj"]

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		#TODO change so only player can trigger area
		if area.get_overlapping_bodies().size() > 1:
			DialogManager.start_dialog(global_position, lines)

func _on_area_2d_body_entered(body):
	#needs to be updated for player specific --done
	#TODO needs to be put into another script
	if body.is_in_group("Player"): #and Input.is_action_pressed("interact"):
		colorRect.set_color(Color.CORAL)
	#if Input.is_action_just_pressed("interact"):
	#	pass
		#dprint("wadad")
		#colorRect.set_color(Color.YELLOW_GREEN)


func _on_area_2d_body_exited(body):
	#TODO needs to be updated for player specific
	#TODO needs to be put into another script
	if body.is_in_group("Player"):
		colorRect.set_color(Color.WHITE)
