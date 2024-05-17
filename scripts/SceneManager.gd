extends Node

var scenes : Dictionary = {	"Main": "res://scenes/main.tscn",
							"testScene": "res://scenes/testScene.tscn"}


func transitaion_to_scene(level : String):
	var scene_path : String = scenes.get(level)
	
	if scene_path != null:
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file(scene_path)
