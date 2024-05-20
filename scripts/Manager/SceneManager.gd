extends Node

var scenes : Dictionary = {	"main": "res://scenes/main.tscn",
							"testScene": "res://scenes/testScene.tscn",
							"pointAndClickTest": "res://scenes/pointAndClickTest.tscn"}

func transitaion_to_scene(level : String, isPointAndClick : bool):
	var scene_path : String = scenes.get(level)
	
	if scene_path != null && isPointAndClick == false:
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file(scene_path)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	elif scene_path != null && isPointAndClick == true:
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file(scene_path)
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
