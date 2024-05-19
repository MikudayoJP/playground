extends Control


func _on_start_pressed():
	SceneManager.transitaion_to_scene("main", false)

func _on_close_pressed():
	get_tree().quit()
